package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.NuevoRequerimientoDTO;
import com.hospital_lima_este.farmacia_backend.dto.RequerimientoDTO;
import com.hospital_lima_este.farmacia_backend.model.*;
import com.hospital_lima_este.farmacia_backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RequerimientoService {

    private final RequerimientoRepository requerimientoRepository;
    private final UsuarioRepository usuarioRepository;
    private final DepartamentoRepository departamentoRepository;
    private final DetalleRequerimientoRepository detalleRequerimientoRepository;
    private final ProductoRepository productoRepository;
    
    // New repositories needed for logic
    private final InventarioRepository inventarioRepository;
    private final OrdenDistribucionRepository ordenDistribucionRepository;
    private final SolicitudCompraRepository solicitudCompraRepository;
    private final DetalleSolicitudCompraRepository detalleSolicitudCompraRepository;

    @Transactional(readOnly = true)
    public List<RequerimientoDTO> listarPendientes() {
        // Use findByEstadoIgnoreCase as defined in the repository
        List<Requerimiento> requerimientos = requerimientoRepository.findByEstadoIgnoreCase("Pendiente");
        
        return requerimientos.stream().map(req -> {
            Usuario usuario = usuarioRepository.findById(req.getIdUsuarioSolicitante()).orElse(null);
            String nombreSolicitante = usuario != null ? usuario.getNombreUsuario() : "Desconocido";
            String areaDepartamento = req.getDepartamento() != null ? req.getDepartamento().getNombreDepartamento() : "Sin Departamento";
            
            String colorPrioridad = "green";
            if ("ALTA".equalsIgnoreCase(req.getPrioridad())) {
                colorPrioridad = "red";
            } else if ("MEDIA".equalsIgnoreCase(req.getPrioridad())) {
                colorPrioridad = "orange";
            }

            int cantidadItems = 0; 

            return RequerimientoDTO.builder()
                    .idRequerimiento(req.getIdRequerimiento())
                    .codigoSolicitud("REQ-" + String.format("%03d", req.getIdRequerimiento()))
                    .nombreSolicitante(nombreSolicitante)
                    .areaDepartamento(areaDepartamento)
                    .fechaSolicitud(req.getFechaSolicitud())
                    .estado(req.getEstado())
                    .prioridad(req.getPrioridad())
                    .colorPrioridad(colorPrioridad)
                    .cantidadItems(cantidadItems)
                    .build();
        }).collect(Collectors.toList());
    }

    @Transactional
    public void crearRequerimiento(NuevoRequerimientoDTO dto) {
        Departamento departamento = departamentoRepository.findById(dto.getIdDepartamento())
                .orElseThrow(() -> new RuntimeException("Departamento no encontrado"));

        Requerimiento requerimiento = new Requerimiento();
        requerimiento.setIdUsuarioSolicitante(dto.getIdUsuarioSolicitante());
        requerimiento.setDepartamento(departamento);
        requerimiento.setFechaSolicitud(LocalDate.now());
        requerimiento.setPrioridad(dto.getPrioridad());
        requerimiento.setObservacion(dto.getObservacion());
        requerimiento.setEstado("Pendiente");
        
        Requerimiento savedRequerimiento = requerimientoRepository.save(requerimiento);

        // Create Detail
        Producto producto = productoRepository.findById(dto.getIdProducto())
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        DetalleRequerimiento detalle = new DetalleRequerimiento();
        detalle.setRequerimiento(savedRequerimiento);
        detalle.setProducto(producto);
        detalle.setCantidad(dto.getCantidad());
        detalle.setCantidadAtendida(0);
        
        detalleRequerimientoRepository.save(detalle);
    }

    @Transactional
    public void atenderRequerimiento(Integer id) {
        Requerimiento requerimiento = requerimientoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Requerimiento no encontrado"));
        
        // 1. Get details
        List<DetalleRequerimiento> detalles = detalleRequerimientoRepository.findByIdRequerimiento(requerimiento.getIdRequerimiento());
        
        for (DetalleRequerimiento detalle : detalles) {
            Integer idProducto = detalle.getProducto().getIdProducto();
            Integer cantidadSolicitada = detalle.getCantidad();
            
            // 2. Check stock
            Integer stockTotal = inventarioRepository.calcularStockTotal(idProducto);
            if (stockTotal == null) stockTotal = 0;
            
            if (stockTotal >= cantidadSolicitada) {
                // 3a. Create OrdenDistribucion
                OrdenDistribucion orden = new OrdenDistribucion();
                orden.setRequerimiento(requerimiento);
                orden.setIdUsuarioCreacion(1); // Hardcoded system user or current user
                orden.setEstado("PENDIENTE_ENTREGA");
                orden.setPrioridad(requerimiento.getPrioridad());
                ordenDistribucionRepository.save(orden);
                
                // Descontar stock
                inventarioRepository.descontarStock(idProducto, cantidadSolicitada);
                
                // Optional: Reserve stock logic would go here
            } else {
                // 3b. Create SolicitudCompra
                SolicitudCompra solicitud = new SolicitudCompra();
                solicitud.setRequerimiento(requerimiento);
                // Correctly set the ID from the Requerimiento entity
                solicitud.setIdUsuarioSolicitante(requerimiento.getIdUsuarioSolicitante()); 
                solicitud.setMotivo("Stock insuficiente para producto: " + detalle.getProducto().getNombreProducto());
                solicitud.setEstado("PENDIENTE_APROBACION");
                solicitudCompraRepository.save(solicitud);

                // Create DetalleSolicitudCompra (The missing link)
                DetalleSolicitudCompra detalleSolicitud = new DetalleSolicitudCompra();
                detalleSolicitud.setSolicitudCompra(solicitud);
                detalleSolicitud.setProducto(detalle.getProducto());
                detalleSolicitud.setDetalleRequerimiento(detalle);
                detalleSolicitud.setCantidadSolicitada(cantidadSolicitada);
                detalleSolicitud.setCantidadAprobada(cantidadSolicitada); // Default to requested amount
                detalleSolicitud.setEstado("PENDIENTE");
                
                detalleSolicitudCompraRepository.save(detalleSolicitud);
            }
        }
        
        // 4. Update Requerimiento status
        requerimiento.setEstado("PROCESADO");
        requerimientoRepository.save(requerimiento);
    }
}

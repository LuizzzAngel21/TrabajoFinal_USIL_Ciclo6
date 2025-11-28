package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.OrdenCompraDTO;
import com.hospital_lima_este.farmacia_backend.model.*;
import com.hospital_lima_este.farmacia_backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CompraService {

    private final OrdenCompraRepository ordenCompraRepository;
    private final SolicitudCompraRepository solicitudCompraRepository;
    private final ProveedorRepository proveedorRepository;
    private final DetalleOrdenCompraRepository detalleOrdenCompraRepository;
    private final DetalleSolicitudCompraRepository detalleSolicitudCompraRepository;
    private final ProductoProveedorRepository productoProveedorRepository;
    private final ProductoRepository productoRepository;
    private final LoteProductoRepository loteProductoRepository;
    private final MovimientoInventarioService movimientoInventarioService;

    @Transactional(readOnly = true)
    public List<OrdenCompraDTO> listarOrdenes() {
        List<OrdenCompra> ordenes = ordenCompraRepository.findAll();
        return ordenes.stream().map(orden -> OrdenCompraDTO.builder()
                .idOrden(orden.getIdOrden())
                .numeroOrden(orden.getNumeroOrden())
                .proveedorNombre(
                        orden.getProveedor() != null ? orden.getProveedor().getNombreProveedor() : "Sin Proveedor")
                .fechaEmision(orden.getFechaEmision())
                .total(orden.getTotal())
                .estado(orden.getEstado())
                .avanceRecepcion(0.0) // Placeholder logic for now
                .build()).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<SolicitudCompra> listarSolicitudesPendientes() {
        return solicitudCompraRepository.findByEstado("PENDIENTE_APROBACION");
    }

    @Transactional(readOnly = true)
    public List<Proveedor> listarProveedores() {
        return proveedorRepository.findAll();
    }

    @Transactional
    public void generarOrdenCompra(Integer idSolicitud, Integer idProveedor, BigDecimal precioTotalIgnorado) {
        // 1. Validar IDs
        if (idSolicitud == null || idProveedor == null) {
            throw new IllegalArgumentException(
                    "IDs no pueden ser nulos. Solicitud: " + idSolicitud + ", Proveedor: " + idProveedor);
        }

        // 2. Buscar Solicitud y Proveedor
        SolicitudCompra solicitud = solicitudCompraRepository.findById(idSolicitud)
                .orElseThrow(() -> new RuntimeException("Solicitud no encontrada"));

        Proveedor proveedor = proveedorRepository.findById(idProveedor)
                .orElseThrow(() -> new RuntimeException("Proveedor no encontrado"));

        // 3. Crear Orden de Compra (Header) - Inicialmente con montos en 0
        OrdenCompra orden = new OrdenCompra();
        orden.setProveedor(proveedor);
        orden.setSolicitudCompra(solicitud);
        orden.setIdUsuarioCreacion(1); // Hardcoded por ahora
        orden.setNumeroOrden("OC-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        orden.setFechaEmision(LocalDate.now());
        orden.setEstado("EMITIDA");

        // Se guardará al final con los montos calculados
        orden = ordenCompraRepository.save(orden);

        // 4. Crear Detalle de Orden de Compra (Detalle) y Calcular Montos
        List<DetalleSolicitudCompra> detallesSolicitud = detalleSolicitudCompraRepository.findAll().stream()
                .filter(d -> d.getSolicitudCompra().getIdSolicitud().equals(idSolicitud))
                .collect(Collectors.toList());

        if (detallesSolicitud.isEmpty()) {
            throw new RuntimeException("La solicitud de compra no tiene detalles asociados. (Data inconsistente)");
        }

        BigDecimal subtotalAcumulado = BigDecimal.ZERO;

        for (DetalleSolicitudCompra detSol : detallesSolicitud) {
            // Buscar precio referencial en BD
            ProductoProveedor prodProv = productoProveedorRepository
                    .findByProductoAndProveedor(detSol.getProducto(), proveedor)
                    .orElseThrow(() -> new RuntimeException("El proveedor " + proveedor.getNombreProveedor() +
                            " no tiene registrado el producto " + detSol.getProducto().getNombreProducto()));

            BigDecimal precioUnitario = prodProv.getPrecioReferencial();
            if (precioUnitario == null)
                precioUnitario = BigDecimal.ZERO;

            DetalleOrdenCompra detOrden = new DetalleOrdenCompra();
            detOrden.setOrdenCompra(orden);
            detOrden.setProducto(detSol.getProducto());
            detOrden.setCantidad(detSol.getCantidadSolicitada());
            detOrden.setPrecioUnitario(precioUnitario);
            detOrden.setDetalleSolicitudCompra(detSol);

            detalleOrdenCompraRepository.save(detOrden);

            // Acumular subtotal: precio_unitario * cantidad
            BigDecimal subtotalItem = precioUnitario.multiply(new BigDecimal(detSol.getCantidadSolicitada()));
            subtotalAcumulado = subtotalAcumulado.add(subtotalItem);
        }

        // 5. Cálculos Finales y Actualización de Orden
        // subtotal = suma de (precio * cantidad)
        // total = subtotal * 1.18
        // igv = total - subtotal

        BigDecimal totalOrden = subtotalAcumulado.multiply(new BigDecimal("1.18")).setScale(2, RoundingMode.HALF_UP);
        BigDecimal igvOrden = totalOrden.subtract(subtotalAcumulado);

        orden.setSubtotal(subtotalAcumulado);
        orden.setIgv(igvOrden);
        orden.setTotal(totalOrden);

        ordenCompraRepository.save(orden);

        // Actualizar estado de la Solicitud
        solicitud.setEstado("APROBADO");
        solicitudCompraRepository.save(solicitud);
    }

    @Transactional(readOnly = true)
    public BigDecimal getPrecioReferencial(Integer idProducto, Integer idProveedor) {
        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        Proveedor proveedor = proveedorRepository.findById(idProveedor)
                .orElseThrow(() -> new RuntimeException("Proveedor no encontrado"));

        ProductoProveedor prodProv = productoProveedorRepository.findByProductoAndProveedor(producto, proveedor)
                .orElseThrow(() -> new RuntimeException("El proveedor no tiene precio registrado para este producto"));

        return prodProv.getPrecioReferencial() != null ? prodProv.getPrecioReferencial() : BigDecimal.ZERO;
    }

    @Transactional(readOnly = true)
    public List<DetalleSolicitudCompra> getDetallesSolicitud(Integer idSolicitud) {
        return detalleSolicitudCompraRepository.findAll().stream()
                .filter(d -> d.getSolicitudCompra().getIdSolicitud().equals(idSolicitud))
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<OrdenCompraDTO> listarOrdenesEmitidas() {
        return ordenCompraRepository.findByEstado("EMITIDA").stream().map(orden -> OrdenCompraDTO.builder()
                .idOrden(orden.getIdOrden())
                .numeroOrden(orden.getNumeroOrden())
                .proveedorNombre(
                        orden.getProveedor() != null ? orden.getProveedor().getNombreProveedor() : "Sin Proveedor")
                .fechaEmision(orden.getFechaEmision())
                .total(orden.getTotal())
                .estado(orden.getEstado())
                .avanceRecepcion(0.0)
                .build()).collect(Collectors.toList());
    }

    @Transactional
    public void recepcionarOrden(Integer idOrden) {
        OrdenCompra orden = ordenCompraRepository.findById(idOrden)
                .orElseThrow(() -> new RuntimeException("Orden de compra no encontrada"));

        if (!"EMITIDA".equals(orden.getEstado())) {
            throw new RuntimeException("La orden no está en estado EMITIDA");
        }

        List<DetalleOrdenCompra> detalles = detalleOrdenCompraRepository.findAll().stream()
                .filter(d -> d.getOrdenCompra().getIdOrden().equals(idOrden))
                .collect(Collectors.toList());

        for (DetalleOrdenCompra detalle : detalles) {
            Producto producto = detalle.getProducto();
            int cantidadRecibida = detalle.getCantidad();

            // Buscar lotes existentes para el producto
            List<LoteProducto> lotes = loteProductoRepository.findByProducto(producto);

            if (!lotes.isEmpty()) {
                // Sumar al primer lote encontrado (Simplificación)
                LoteProducto lote = lotes.get(0);
                lote.setStockActual(lote.getStockActual() + cantidadRecibida);
                loteProductoRepository.save(lote);
            } else {
                // Crear nuevo lote
                LoteProducto nuevoLote = new LoteProducto();
                nuevoLote.setProducto(producto);
                nuevoLote.setNumeroLote("LOTE-" + System.currentTimeMillis()); // Generación simple
                nuevoLote.setFechaVencimiento(LocalDate.now().plusYears(1));
                nuevoLote.setStockActual(cantidadRecibida);
                nuevoLote.setStockInicial(cantidadRecibida);
                loteProductoRepository.save(nuevoLote);
            }

            // Registrar Movimiento (ENTRADA)
            movimientoInventarioService.registrarMovimiento(producto.getIdProducto(), cantidadRecibida, "ENTRADA",
                    "Recepción Orden Compra #" + idOrden);
        }

        orden.setEstado("RECIBIDA");
        ordenCompraRepository.save(orden);
    }
}

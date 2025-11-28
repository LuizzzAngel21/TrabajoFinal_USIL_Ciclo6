package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.OrdenDistribucionDTO;
import com.hospital_lima_este.farmacia_backend.dto.VehiculoDTO;
import com.hospital_lima_este.farmacia_backend.model.OrdenDistribucion;
import com.hospital_lima_este.farmacia_backend.model.Vehiculo;
import com.hospital_lima_este.farmacia_backend.repository.OrdenDistribucionRepository;
import com.hospital_lima_este.farmacia_backend.repository.VehiculoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DistribucionService {

    private final OrdenDistribucionRepository ordenDistribucionRepository;
    private final VehiculoRepository vehiculoRepository;

    @Transactional(readOnly = true)
    public List<OrdenDistribucionDTO> listarPendientes() {
        return ordenDistribucionRepository.findByEstado("PENDIENTE_ENTREGA").stream()
                .map(orden -> OrdenDistribucionDTO.builder()
                        .idOrdenDist(orden.getIdOrdenDist())
                        .destino(orden.getRequerimiento().getDepartamento().getNombreDepartamento())
                        .fechaDistribucion(orden.getFechaDistribucion())
                        .estado(orden.getEstado())
                        .placaVehiculo(orden.getVehiculo() != null ? orden.getVehiculo().getPlaca() : "Sin Asignar")
                        .build())
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehiculoDTO> listarVehiculos() {
        return vehiculoRepository.findByEstado("Disponible").stream()
                .map(v -> VehiculoDTO.builder()
                        .idVehiculo(v.getIdVehiculo())
                        .placa(v.getPlaca())
                        .marca(v.getMarca())
                        .modelo(v.getModelo())
                        .build())
                .collect(Collectors.toList());
    }

    @Transactional
    public void asignarVehiculo(Integer idOrden, Integer idVehiculo) {
        OrdenDistribucion orden = ordenDistribucionRepository.findById(idOrden)
                .orElseThrow(() -> new RuntimeException("Orden de distribución no encontrada"));

        Vehiculo vehiculo = vehiculoRepository.findById(idVehiculo)
                .orElseThrow(() -> new RuntimeException("Vehículo no encontrado"));

        orden.setVehiculo(vehiculo);
        orden.setEstado("EN_RUTA");
        ordenDistribucionRepository.save(orden);
    }
}

package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.OrdenDistribucionDTO;
import com.hospital_lima_este.farmacia_backend.model.OrdenDistribucion;
import com.hospital_lima_este.farmacia_backend.repository.OrdenDistribucionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DistribucionService {

    private final OrdenDistribucionRepository ordenDistribucionRepository;

    @Transactional(readOnly = true)
    public List<OrdenDistribucionDTO> listarDespachos() {
        List<OrdenDistribucion> ordenes = ordenDistribucionRepository.findAll();
        return ordenes.stream().map(orden -> {
            String destino = "Desconocido";
            if (orden.getRequerimiento() != null && orden.getRequerimiento().getDepartamento() != null) {
                destino = orden.getRequerimiento().getDepartamento().getNombreDepartamento();
            }

            return OrdenDistribucionDTO.builder()
                    .idOrdenDist(orden.getIdOrdenDist())
                    .fechaSalida(orden.getFechaDistribucion())
                    .placaVehiculo("TBD") // Placeholder as vehicle is not directly linked in OrdenDistribucion entity yet, maybe via Incidencia or Detalle
                    .chofer("TBD") // Placeholder
                    .destino(destino)
                    .estadoEntrega(orden.getEstado()) // Using OrdenDistribucion state as proxy for delivery status
                    .build();
        }).collect(Collectors.toList());
    }
}

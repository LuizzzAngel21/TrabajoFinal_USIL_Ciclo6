package com.hospital_lima_este.farmacia_backend.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Builder
public class OrdenDistribucionDTO {
    private Integer idOrdenDist;
    private String destino;
    private LocalDateTime fechaDistribucion;
    private String estado;
    private String placaVehiculo;
}

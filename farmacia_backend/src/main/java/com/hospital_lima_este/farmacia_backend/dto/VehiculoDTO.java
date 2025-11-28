package com.hospital_lima_este.farmacia_backend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class VehiculoDTO {
    private Integer idVehiculo;
    private String placa;
    private String marca;
    private String modelo;
}

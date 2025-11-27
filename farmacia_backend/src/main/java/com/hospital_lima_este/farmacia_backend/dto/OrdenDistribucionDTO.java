package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrdenDistribucionDTO {
    private Integer idOrdenDist;
    private LocalDateTime fechaSalida;
    private String placaVehiculo;
    private String chofer; // Assuming we might have driver info or just use user
    private String destino; // Departamento
    private String estadoEntrega; // "En Ruta", "Entregado"
}

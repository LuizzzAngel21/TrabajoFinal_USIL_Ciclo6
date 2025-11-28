package com.hospital_lima_este.farmacia_backend.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Builder
public class MovimientoInventarioDTO {
    private LocalDateTime fecha;
    private String tipo;
    private Integer cantidad;
    private String motivo;
    private String usuario; // Placeholder for user name
}

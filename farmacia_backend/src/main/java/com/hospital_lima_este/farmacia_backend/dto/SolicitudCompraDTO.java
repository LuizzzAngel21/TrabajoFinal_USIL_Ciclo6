package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SolicitudCompraDTO {
    private Integer idSolicitud;
    private String motivo;
    private LocalDate fecha;
    private String usuarioSolicitante;
}

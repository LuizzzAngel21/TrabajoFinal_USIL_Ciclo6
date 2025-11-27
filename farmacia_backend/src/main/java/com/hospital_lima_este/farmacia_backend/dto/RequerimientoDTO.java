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
public class RequerimientoDTO {
    private Integer idRequerimiento;
    private String codigoSolicitud; // "REQ-00X"
    private String nombreSolicitante;
    private String areaDepartamento;
    private LocalDate fechaSolicitud;
    private String estado;
    private String prioridad;
    private String colorPrioridad; // Visual logic
    private Integer cantidadItems;
}

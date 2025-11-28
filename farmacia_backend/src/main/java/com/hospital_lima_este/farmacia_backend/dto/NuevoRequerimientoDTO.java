package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NuevoRequerimientoDTO {
    private Integer idUsuarioSolicitante;
    private Integer idDepartamento;
    private String prioridad;
    private String observacion;
    private Integer idProducto;
    private Integer cantidad;
}

package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DetalleRequerimientoDTO {
    private Integer idDetalle;
    private String nombreProducto;
    private Integer cantidadSolicitada;
    private String unidadMedida;
    private String estadoAtencion;
}

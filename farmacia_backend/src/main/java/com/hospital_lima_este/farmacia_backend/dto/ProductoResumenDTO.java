package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductoResumenDTO {
    private Integer idProducto;
    private String nombre;
    private String codigoDigemid;
    private String tipo;
    private String forma;
    private Integer stockTotal; // Sum of lots
    private String estado; // "Disponible"/"Agotado"
    private String colorEstado;
}

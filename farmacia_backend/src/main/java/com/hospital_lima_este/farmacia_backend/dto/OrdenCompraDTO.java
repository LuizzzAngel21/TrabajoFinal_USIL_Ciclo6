package com.hospital_lima_este.farmacia_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrdenCompraDTO {
    private Integer idOrden;
    private String numeroOrden;
    private String proveedorNombre;
    private LocalDate fechaEmision;
    private BigDecimal total;
    private String estado;
    private Double avanceRecepcion; // %
}

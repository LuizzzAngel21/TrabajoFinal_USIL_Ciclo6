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
public class LoteDTO {
    private String numeroLote;
    private LocalDate fechaVencimiento;
    private Integer stockActual;
    private Long diasParaVencer; // Calculated
}

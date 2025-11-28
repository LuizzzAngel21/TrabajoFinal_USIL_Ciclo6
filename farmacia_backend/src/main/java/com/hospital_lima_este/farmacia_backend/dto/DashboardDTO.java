package com.hospital_lima_este.farmacia_backend.dto;

import com.hospital_lima_este.farmacia_backend.model.MovimientoInventario;
import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@Builder
public class DashboardDTO {
    private Map<String, Integer> stockCritico;
    private Map<String, Long> estadoRequerimientos;
    private List<MovimientoInventario> ultimosMovimientos;
}

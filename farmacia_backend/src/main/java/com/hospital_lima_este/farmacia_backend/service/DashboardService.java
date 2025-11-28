package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.DashboardDTO;
import com.hospital_lima_este.farmacia_backend.model.LoteProducto;
import com.hospital_lima_este.farmacia_backend.model.MovimientoInventario;
import com.hospital_lima_este.farmacia_backend.repository.LoteProductoRepository;
import com.hospital_lima_este.farmacia_backend.repository.MovimientoInventarioRepository;
import com.hospital_lima_este.farmacia_backend.repository.RequerimientoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DashboardService {

        private final LoteProductoRepository loteProductoRepository;
        private final RequerimientoRepository requerimientoRepository;
        private final MovimientoInventarioRepository movimientoInventarioRepository;

        public DashboardDTO getDashboardData() {
                // 1. Stock Crítico (Top 5 con stock < 20)
                List<LoteProducto> lowStockLotes = loteProductoRepository
                                .findTop5ByStockActualGreaterThanOrderByStockActualAsc(0);

                // Filtrar solo los que tienen stock bajo (ej. < 20) para que sea "Crítico" real
                // O si prefieres mostrar siempre los 5 con menos stock, deja la consulta como
                // está.
                // Aquí aseguramos que el mapa tenga claves String y valores Integer.
                Map<String, Integer> stockCritico = new HashMap<>();
                for (LoteProducto lote : lowStockLotes) {
                        String key = lote.getProducto().getNombreProducto();
                        // Sumar stock si hay múltiples lotes del mismo producto (opcional, pero bueno
                        // para el gráfico)
                        stockCritico.merge(key, lote.getStockActual(), Integer::sum);
                }

                // 2. Estado de Requerimientos
                Map<String, Long> estadoRequerimientos = new HashMap<>();
                long pendientes = requerimientoRepository.countByEstado("PENDIENTE");
                long atendidos = requerimientoRepository.countByEstado("ATENDIDO");

                if (pendientes > 0)
                        estadoRequerimientos.put("PENDIENTE", pendientes);
                if (atendidos > 0)
                        estadoRequerimientos.put("ATENDIDO", atendidos);

                // 3. Últimos Movimientos
                List<MovimientoInventario> ultimosMovimientos = movimientoInventarioRepository
                                .findTop5ByOrderByFechaMovimientoDesc();

                return DashboardDTO.builder()
                                .stockCritico(stockCritico)
                                .estadoRequerimientos(estadoRequerimientos)
                                .ultimosMovimientos(ultimosMovimientos)
                                .build();
        }
}

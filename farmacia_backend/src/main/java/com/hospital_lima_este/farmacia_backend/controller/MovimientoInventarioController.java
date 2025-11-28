package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.MovimientoInventarioDTO;
import com.hospital_lima_este.farmacia_backend.model.MovimientoInventario;
import com.hospital_lima_este.farmacia_backend.repository.MovimientoInventarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/movimientos")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class MovimientoInventarioController {

    private final MovimientoInventarioRepository movimientoInventarioRepository;

    @GetMapping("/{idProducto}")
    public ResponseEntity<List<MovimientoInventarioDTO>> getHistorial(@PathVariable Integer idProducto) {
        List<MovimientoInventario> movimientos = movimientoInventarioRepository.findByProductoId(idProducto);

        List<MovimientoInventarioDTO> dtos = movimientos.stream().map(m -> MovimientoInventarioDTO.builder()
                .fecha(m.getFechaMovimiento())
                .tipo(m.getTipoMovimiento())
                .cantidad(m.getCantidad())
                .motivo(m.getMotivo())
                .usuario("Usuario " + m.getIdUsuarioRegistro()) // Placeholder
                .build()).collect(Collectors.toList());

        return ResponseEntity.ok(dtos);
    }
}

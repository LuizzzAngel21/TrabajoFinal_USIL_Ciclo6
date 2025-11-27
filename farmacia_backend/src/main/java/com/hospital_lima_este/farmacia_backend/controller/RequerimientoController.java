package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.NuevoRequerimientoDTO;
import com.hospital_lima_este.farmacia_backend.dto.RequerimientoDTO;
import com.hospital_lima_este.farmacia_backend.service.RequerimientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/requerimientos")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class RequerimientoController {

    private final RequerimientoService requerimientoService;

    @GetMapping("/pendientes")
    public ResponseEntity<List<RequerimientoDTO>> listarPendientes() {
        return ResponseEntity.ok(requerimientoService.listarPendientes());
    }

    @PostMapping
    public ResponseEntity<Void> crearRequerimiento(@RequestBody NuevoRequerimientoDTO dto) {
        requerimientoService.crearRequerimiento(dto);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping("/{id}/atender")
    public ResponseEntity<Void> atenderRequerimiento(@PathVariable Integer id) {
        requerimientoService.atenderRequerimiento(id);
        return ResponseEntity.ok().build();
    }
}

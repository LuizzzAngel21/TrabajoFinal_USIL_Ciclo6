package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.ProductoResumenDTO;
import com.hospital_lima_este.farmacia_backend.service.AlmacenamientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/almacen")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AlmacenController {

    private final AlmacenamientoService almacenamientoService;

    @GetMapping("/catalogo")
    public ResponseEntity<List<ProductoResumenDTO>> obtenerCatalogo() {
        return ResponseEntity.ok(almacenamientoService.obtenerCatalogo());
    }
}

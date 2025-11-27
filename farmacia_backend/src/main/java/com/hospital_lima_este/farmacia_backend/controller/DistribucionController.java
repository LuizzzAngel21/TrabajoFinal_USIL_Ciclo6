package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.OrdenDistribucionDTO;
import com.hospital_lima_este.farmacia_backend.service.DistribucionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/distribucion")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class DistribucionController {

    private final DistribucionService distribucionService;

    @GetMapping
    public ResponseEntity<List<OrdenDistribucionDTO>> listarDespachos() {
        return ResponseEntity.ok(distribucionService.listarDespachos());
    }
}

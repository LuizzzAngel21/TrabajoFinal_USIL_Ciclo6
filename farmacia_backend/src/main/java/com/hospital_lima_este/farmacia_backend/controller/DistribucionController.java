package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.OrdenDistribucionDTO;
import com.hospital_lima_este.farmacia_backend.dto.VehiculoDTO;
import com.hospital_lima_este.farmacia_backend.service.DistribucionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/distribucion")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:4200")
public class DistribucionController {

    private final DistribucionService distribucionService;

    @GetMapping("/pendientes")
    public ResponseEntity<List<OrdenDistribucionDTO>> listarPendientes() {
        return ResponseEntity.ok(distribucionService.listarPendientes());
    }

    @GetMapping("/vehiculos")
    public ResponseEntity<List<VehiculoDTO>> listarVehiculos() {
        return ResponseEntity.ok(distribucionService.listarVehiculos());
    }

    @PutMapping("/{idOrden}/asignar/{idVehiculo}")
    public ResponseEntity<Void> asignarVehiculo(@PathVariable Integer idOrden, @PathVariable Integer idVehiculo) {
        distribucionService.asignarVehiculo(idOrden, idVehiculo);
        return ResponseEntity.ok().build();
    }
}

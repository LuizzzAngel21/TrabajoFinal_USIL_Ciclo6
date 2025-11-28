package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.OrdenCompraDTO;
import com.hospital_lima_este.farmacia_backend.model.Proveedor;
import com.hospital_lima_este.farmacia_backend.model.SolicitudCompra;
import com.hospital_lima_este.farmacia_backend.service.CompraService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/v1/compras")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class CompraController {

    private final CompraService compraService;

    @GetMapping
    public ResponseEntity<List<OrdenCompraDTO>> listarOrdenes() {
        return ResponseEntity.ok(compraService.listarOrdenes());
    }

    @GetMapping("/solicitudes")
    public ResponseEntity<List<SolicitudCompra>> listarSolicitudesPendientes() {
        return ResponseEntity.ok(compraService.listarSolicitudesPendientes());
    }

    @GetMapping("/proveedores")
    public ResponseEntity<List<Proveedor>> listarProveedores() {
        return ResponseEntity.ok(compraService.listarProveedores());
    }

    @PostMapping("/generar-orden")
    public ResponseEntity<Void> generarOrdenCompra(@RequestBody GenerarOrdenRequest request) {
        compraService.generarOrdenCompra(request.getIdSolicitud(), request.getIdProveedor(), request.getPrecio());
        return ResponseEntity.ok().build();
    }

    @GetMapping("/precio/{idProducto}/{idProveedor}")
    public ResponseEntity<BigDecimal> getPrecioReferencial(@PathVariable Integer idProducto,
            @PathVariable Integer idProveedor) {
        return ResponseEntity.ok(compraService.getPrecioReferencial(idProducto, idProveedor));
    }

    @GetMapping("/solicitudes/{id}/detalles")
    public ResponseEntity<List<com.hospital_lima_este.farmacia_backend.model.DetalleSolicitudCompra>> getDetallesSolicitud(
            @PathVariable Integer id) {
        return ResponseEntity.ok(compraService.getDetallesSolicitud(id));
    }

    @GetMapping("/ordenes")
    public ResponseEntity<List<OrdenCompraDTO>> listarOrdenesEmitidas() {
        return ResponseEntity.ok(compraService.listarOrdenesEmitidas());
    }

    @PostMapping("/ordenes/{id}/recepcionar")
    public ResponseEntity<Void> recepcionarOrden(@PathVariable Integer id) {
        compraService.recepcionarOrden(id);
        return ResponseEntity.ok().build();
    }

    @Data
    public static class GenerarOrdenRequest {
        private Integer idSolicitud;
        private Integer idProveedor;
        private BigDecimal precio;
    }
}

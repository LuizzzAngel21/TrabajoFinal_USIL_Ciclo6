package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.model.Inventario;
import com.hospital_lima_este.farmacia_backend.model.MovimientoInventario;
import com.hospital_lima_este.farmacia_backend.model.Producto;
import com.hospital_lima_este.farmacia_backend.repository.InventarioRepository;
import com.hospital_lima_este.farmacia_backend.repository.MovimientoInventarioRepository;
import com.hospital_lima_este.farmacia_backend.repository.ProductoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class MovimientoInventarioService {

    private final MovimientoInventarioRepository movimientoInventarioRepository;
    private final InventarioRepository inventarioRepository;
    private final ProductoRepository productoRepository;

    @Transactional
    public void registrarMovimiento(Integer idProducto, Integer cantidad, String tipo, String motivo) {
        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        Inventario inventario = inventarioRepository.findFirstByLoteProducto_Producto_IdProducto(idProducto);

        if (inventario == null) {
            
            inventario = inventarioRepository.findAll().stream()
                    .filter(i -> i.getLoteProducto().getProducto().getIdProducto().equals(idProducto))
                    .findFirst()
                    .orElse(null);

            if (inventario == null) {
              
                System.err.println("No Inventario found for product " + idProducto + ". Skipping movement record.");
                return;
            }
        }

        MovimientoInventario movimiento = new MovimientoInventario();
        movimiento.setInventario(inventario);
        movimiento.setTipoMovimiento(tipo);
        movimiento.setCantidad(cantidad);
        movimiento.setMotivo(motivo);
        movimiento.setFechaMovimiento(LocalDateTime.now());
        movimiento.setIdUsuarioRegistro(1); 

        movimientoInventarioRepository.save(movimiento);
    }
}

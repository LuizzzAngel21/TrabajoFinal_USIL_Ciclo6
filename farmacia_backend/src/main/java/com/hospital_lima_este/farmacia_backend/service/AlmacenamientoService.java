package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.ProductoResumenDTO;
import com.hospital_lima_este.farmacia_backend.model.LoteProducto;
import com.hospital_lima_este.farmacia_backend.model.Producto;
import com.hospital_lima_este.farmacia_backend.repository.LoteProductoRepository;
import com.hospital_lima_este.farmacia_backend.repository.ProductoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AlmacenamientoService {

    private final ProductoRepository productoRepository;
    private final LoteProductoRepository loteProductoRepository;

    @Transactional(readOnly = true)
    public List<ProductoResumenDTO> obtenerCatalogo() {
        List<Producto> productos = productoRepository.findAll();
        return productos.stream().map(producto -> {
            List<LoteProducto> lotes = loteProductoRepository.findByProducto(producto);
            int stockTotal = lotes.stream().mapToInt(LoteProducto::getStockActual).sum();
            
            String estado = stockTotal > 0 ? "Disponible" : "Agotado";
            String colorEstado = stockTotal > 0 ? "green" : "red";

            return ProductoResumenDTO.builder()
                    .idProducto(producto.getIdProducto())
                    .nombre(producto.getNombreProducto())
                    .codigoDigemid(producto.getCodigoDigemid())
                    .tipo(producto.getTipoProducto() != null ? producto.getTipoProducto().getNombreTipo() : "")
                    .forma(producto.getFormaFarmaceutica() != null ? producto.getFormaFarmaceutica().getNombreForma() : "")
                    .stockTotal(stockTotal)
                    .estado(estado)
                    .colorEstado(colorEstado)
                    .build();
        }).collect(Collectors.toList());
    }
}

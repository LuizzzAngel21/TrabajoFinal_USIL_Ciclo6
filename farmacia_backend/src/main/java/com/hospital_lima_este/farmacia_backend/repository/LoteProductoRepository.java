package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.LoteProducto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoteProductoRepository extends JpaRepository<LoteProducto, Integer> {
    java.util.List<LoteProducto> findByProducto(com.hospital_lima_este.farmacia_backend.model.Producto producto);

    java.util.Optional<LoteProducto> findFirstByProductoAndStockActualGreaterThan(
            com.hospital_lima_este.farmacia_backend.model.Producto producto, Integer stock);
}

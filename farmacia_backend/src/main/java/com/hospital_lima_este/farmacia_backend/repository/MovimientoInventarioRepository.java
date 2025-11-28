package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.MovimientoInventario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovimientoInventarioRepository extends JpaRepository<MovimientoInventario, Integer> {
    @Query("SELECT m FROM MovimientoInventario m JOIN m.inventario i JOIN i.loteProducto l WHERE l.producto.idProducto = :idProducto ORDER BY m.fechaMovimiento DESC")
    List<MovimientoInventario> findByProductoId(@Param("idProducto") Integer idProducto);
}

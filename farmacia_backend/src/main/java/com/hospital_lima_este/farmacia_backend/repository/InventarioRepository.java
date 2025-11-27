package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.Inventario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InventarioRepository extends JpaRepository<Inventario, Integer> {
    @org.springframework.data.jpa.repository.Query("SELECT COALESCE(SUM(i.stockActual), 0) FROM Inventario i JOIN i.loteProducto l WHERE l.producto.idProducto = :idProducto")
    Integer calcularStockTotal(@org.springframework.data.repository.query.Param("idProducto") Integer idProducto);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("UPDATE LoteProducto l SET l.stockActual = l.stockActual - :cantidad WHERE l.producto.idProducto = :idProducto AND l.stockActual >= :cantidad")
    void descontarStock(@org.springframework.data.repository.query.Param("idProducto") Integer idProducto, @org.springframework.data.repository.query.Param("cantidad") Integer cantidad);
}

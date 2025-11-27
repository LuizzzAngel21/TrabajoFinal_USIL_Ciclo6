package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.Producto;
import com.hospital_lima_este.farmacia_backend.model.ProductoProveedor;
import com.hospital_lima_este.farmacia_backend.model.Proveedor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProductoProveedorRepository extends JpaRepository<ProductoProveedor, Integer> {
    
    Optional<ProductoProveedor> findByProductoAndProveedor(Producto producto, Proveedor proveedor);

}

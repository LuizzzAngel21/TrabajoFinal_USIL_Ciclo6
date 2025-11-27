package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.DetalleOrdenCompra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetalleOrdenCompraRepository extends JpaRepository<DetalleOrdenCompra, Integer> {
}

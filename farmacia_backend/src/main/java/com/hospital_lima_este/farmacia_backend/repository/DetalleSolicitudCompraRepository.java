package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.DetalleSolicitudCompra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetalleSolicitudCompraRepository extends JpaRepository<DetalleSolicitudCompra, Integer> {
}

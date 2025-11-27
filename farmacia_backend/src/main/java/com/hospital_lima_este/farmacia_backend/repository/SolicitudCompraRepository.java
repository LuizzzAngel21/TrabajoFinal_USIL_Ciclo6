package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.SolicitudCompra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SolicitudCompraRepository extends JpaRepository<SolicitudCompra, Integer> {
    java.util.List<SolicitudCompra> findByEstado(String estado);
}

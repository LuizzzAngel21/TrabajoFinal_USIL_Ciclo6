package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.TipoProducto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TipoProductoRepository extends JpaRepository<TipoProducto, Integer> {
}

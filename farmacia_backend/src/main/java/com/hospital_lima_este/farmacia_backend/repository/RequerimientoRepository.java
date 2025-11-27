package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.Requerimiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RequerimientoRepository extends JpaRepository<Requerimiento, Integer> {
    List<Requerimiento> findByEstadoIgnoreCase(String estado);
}

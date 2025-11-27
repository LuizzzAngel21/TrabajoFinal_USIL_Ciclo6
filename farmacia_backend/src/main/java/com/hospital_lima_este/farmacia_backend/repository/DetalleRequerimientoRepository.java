package com.hospital_lima_este.farmacia_backend.repository;

import com.hospital_lima_este.farmacia_backend.model.DetalleRequerimiento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetalleRequerimientoRepository extends JpaRepository<DetalleRequerimiento, Integer> {
    @org.springframework.data.jpa.repository.Query("SELECT d FROM DetalleRequerimiento d WHERE d.requerimiento.idRequerimiento = :idRequerimiento")
    java.util.List<DetalleRequerimiento> findByIdRequerimiento(@org.springframework.data.repository.query.Param("idRequerimiento") Integer idRequerimiento);
}

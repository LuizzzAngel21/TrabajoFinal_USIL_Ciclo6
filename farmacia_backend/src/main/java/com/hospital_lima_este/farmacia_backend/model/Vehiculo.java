package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "vehiculos", schema = "farmacia")
public class Vehiculo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idVehiculo;

    @Column(nullable = false, unique = true, length = 20)
    private String placa;

    @Column(length = 50)
    private String marca;

    @Column(length = 50)
    private String modelo;

    @Column(name = "capacidad_carga", precision = 10, scale = 2)
    private BigDecimal capacidadCarga;

    @Column(length = 20)
    private String estado = "Disponible";

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

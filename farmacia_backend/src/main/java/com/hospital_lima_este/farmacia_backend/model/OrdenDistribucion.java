package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "ordenes_distribucion", schema = "farmacia")
public class OrdenDistribucion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idOrdenDist;

    @ManyToOne
    @JoinColumn(name = "id_requerimiento", nullable = false)
    private Requerimiento requerimiento;

    @Column(name = "id_usuario_creacion", nullable = false)
    private Integer idUsuarioCreacion; // Logical reference

    @ManyToOne
    @JoinColumn(name = "id_vehiculo")
    private Vehiculo vehiculo;

    @Column(name = "fecha_distribucion")
    private LocalDateTime fechaDistribucion = LocalDateTime.now();

    @Column(length = 20)
    private String estado = "PENDIENTE";

    @Column(length = 20)
    private String prioridad;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        if (fechaDistribucion == null) {
            fechaDistribucion = LocalDateTime.now();
        }
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

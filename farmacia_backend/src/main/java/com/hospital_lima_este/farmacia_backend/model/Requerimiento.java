package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "requerimientos", schema = "farmacia")
public class Requerimiento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRequerimiento;

    @Column(name = "id_usuario_solicitante", nullable = false)
    private Integer idUsuarioSolicitante; // Logical reference

    @ManyToOne
    @JoinColumn(name = "id_departamento", nullable = false)
    private Departamento departamento;

    @Column(name = "fecha_solicitud")
    private LocalDate fechaSolicitud = LocalDate.now();

    @Column(name = "fecha_limite")
    private LocalDate fechaLimite;

    @Column(length = 20)
    private String prioridad = "Media";

    @Column(length = 50)
    private String estado = "Pendiente";

    @Column(columnDefinition = "TEXT")
    private String observacion;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        if (fechaSolicitud == null) {
            fechaSolicitud = LocalDate.now();
        }
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

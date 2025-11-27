package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "solicitud_compra", schema = "farmacia")
public class SolicitudCompra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idSolicitud;

    @ManyToOne
    @JoinColumn(name = "id_requerimiento", nullable = false)
    private Requerimiento requerimiento;

    @Column(name = "id_usuario_solicitante", nullable = false)
    private Integer idUsuarioSolicitante; // Logical reference

    @Column(columnDefinition = "TEXT")
    private String motivo;

    @Column(length = 50)
    private String estado = "Pendiente";

    @Column(name = "productos_recibidos")
    private Boolean productosRecibidos = false;

    @Column(name = "fecha_solicitud")
    private LocalDate fechaSolicitud = LocalDate.now();

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

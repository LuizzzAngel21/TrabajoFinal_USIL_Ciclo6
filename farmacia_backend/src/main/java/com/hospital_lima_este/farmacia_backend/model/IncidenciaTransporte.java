package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "incidencias_transporte", schema = "farmacia")
public class IncidenciaTransporte {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idIncidenciaTransporte;

    @ManyToOne
    @JoinColumn(name = "id_vehiculo", nullable = false)
    private Vehiculo vehiculo;

    @ManyToOne
    @JoinColumn(name = "id_orden_dist")
    private OrdenDistribucion ordenDistribucion;

    @ManyToOne
    @JoinColumn(name = "id_detalle_dist")
    private DetalleOrdenDistribucion detalleOrdenDistribucion;

    @Column(name = "tipo_incidencia", nullable = false, length = 100)
    private String tipoIncidencia;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    @Column(length = 30)
    private String impacto = "Moderado";

    @Column(length = 20)
    private String estado = "Pendiente";

    @Column(name = "fecha_incidencia")
    private LocalDateTime fechaIncidencia = LocalDateTime.now();

    @Column(name = "fecha_resolucion")
    private LocalDateTime fechaResolucion;

    @Column(name = "id_usuario_reporta")
    private Integer idUsuarioReporta; // Logical reference

    @Column(columnDefinition = "TEXT")
    private String observaciones;

    @PrePersist
    protected void onCreate() {
        if (fechaIncidencia == null) {
            fechaIncidencia = LocalDateTime.now();
        }
    }
}

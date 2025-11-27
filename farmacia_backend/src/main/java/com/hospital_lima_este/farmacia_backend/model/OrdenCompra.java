package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "ordenes_compra", schema = "farmacia")
public class OrdenCompra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idOrden;

    @ManyToOne
    @JoinColumn(name = "id_solicitud", nullable = false)
    private SolicitudCompra solicitudCompra;

    @ManyToOne
    @JoinColumn(name = "id_proveedor", nullable = false)
    private Proveedor proveedor;

    @Column(name = "id_usuario_creacion", nullable = false)
    private Integer idUsuarioCreacion;

    @Column(name = "numero_orden", unique = true, length = 50)
    private String numeroOrden;

    @Column(name = "fecha_emision")
    private LocalDate fechaEmision = LocalDate.now();

    @Column(name = "fecha_entrega_estimada")
    private LocalDate fechaEntregaEstimada;

    @Column(length = 20)
    private String estado = "PENDIENTE";

    @Column(columnDefinition = "TEXT")
    private String observaciones;

    @Column(precision = 12, scale = 2)
    private BigDecimal subtotal = BigDecimal.ZERO;

    @Column(precision = 12, scale = 2)
    private BigDecimal igv = BigDecimal.ZERO;

    @Column(precision = 12, scale = 2)
    private BigDecimal total = BigDecimal.ZERO;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        if (fechaEmision == null) {
            fechaEmision = LocalDate.now();
        }
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "detalle_orden_distribucion", schema = "farmacia")
public class DetalleOrdenDistribucion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalleDist;

    @ManyToOne
    @JoinColumn(name = "id_orden_dist", nullable = false)
    private OrdenDistribucion ordenDistribucion;

    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "id_lote", nullable = false)
    private LoteProducto loteProducto;

    @Column(nullable = false)
    private Integer cantidad;

    @Column(name = "estado_entrega", length = 20)
    private String estadoEntrega = "PENDIENTE";

    @Column(name = "condiciones_transporte", length = 100)
    private String condicionesTransporte;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
    }
}

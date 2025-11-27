package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "detalle_solicitud_compra", schema = "farmacia")
public class DetalleSolicitudCompra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalleSolicitud;

    @ManyToOne
    @JoinColumn(name = "id_solicitud", nullable = false)
    private SolicitudCompra solicitudCompra;

    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "id_detalle_requerimiento")
    private DetalleRequerimiento detalleRequerimiento;

    @Column(name = "cantidad_solicitada", nullable = false)
    private Integer cantidadSolicitada;

    @Column(name = "cantidad_aprobada")
    private Integer cantidadAprobada = 0;

    @Column(length = 20)
    private String estado = "Pendiente";
}

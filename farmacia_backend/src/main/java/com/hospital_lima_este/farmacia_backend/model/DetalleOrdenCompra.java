package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "detalle_orden_compra", schema = "farmacia")
public class DetalleOrdenCompra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalleOrden;

    @ManyToOne
    @JoinColumn(name = "id_orden", nullable = false)
    private OrdenCompra ordenCompra;

    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "id_detalle_solicitud")
    private DetalleSolicitudCompra detalleSolicitudCompra;

    @Column(nullable = false)
    private Integer cantidad;

    @Column(name = "precio_unitario", nullable = false, precision = 10, scale = 2)
    private BigDecimal precioUnitario;

    @Column(precision = 12, scale = 2, insertable = false, updatable = false)
    private BigDecimal subtotal; // GENERATED ALWAYS AS (cantidad * precio_unitario) STORED

    @Column(length = 20)
    private String estado = "PENDIENTE";
}

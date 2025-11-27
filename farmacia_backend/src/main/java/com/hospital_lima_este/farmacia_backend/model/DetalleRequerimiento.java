package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "detalle_requerimiento", schema = "farmacia")
public class DetalleRequerimiento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalleRequerimiento;

    @ManyToOne
    @JoinColumn(name = "id_requerimiento", nullable = false)
    private Requerimiento requerimiento;

    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    @Column(nullable = false)
    private Integer cantidad;

    @Column(name = "cantidad_atendida")
    private Integer cantidadAtendida = 0;

    @Column(columnDefinition = "TEXT")
    private String observacion;
}

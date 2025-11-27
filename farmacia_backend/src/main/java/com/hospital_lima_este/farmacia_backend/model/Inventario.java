package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "inventario", schema = "farmacia", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "id_almacen", "id_lote" })
})
public class Inventario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idInventario;

    @ManyToOne
    @JoinColumn(name = "id_almacen", nullable = false)
    private Almacen almacen;

    @ManyToOne
    @JoinColumn(name = "id_lote", nullable = false)
    private LoteProducto loteProducto;

    @Column(name = "stock_actual", nullable = false)
    private Integer stockActual;

    @Column(name = "stock_minimo")
    private Integer stockMinimo = 0;

    @Column(name = "stock_maximo")
    private Integer stockMaximo;

    @Column(name = "ubicacion_especifica", length = 100)
    private String ubicacionEspecifica;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

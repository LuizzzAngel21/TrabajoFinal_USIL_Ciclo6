package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "lotes_producto", schema = "farmacia", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "id_producto", "numero_lote" })
})
public class LoteProducto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idLote;

    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    @Column(name = "numero_lote", nullable = false, length = 50)
    private String numeroLote;

    @Column(name = "fecha_fabricacion")
    private LocalDate fechaFabricacion;

    @Column(name = "fecha_vencimiento", nullable = false)
    private LocalDate fechaVencimiento;

    @Column(name = "stock_inicial", nullable = false)
    private Integer stockInicial;

    @Column(name = "stock_actual", nullable = false)
    private Integer stockActual;

    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean estado = true;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
}

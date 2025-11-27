package com.hospital_lima_este.farmacia_backend.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "productos", schema = "farmacia")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idProducto;

    @Column(nullable = false, unique = true, length = 150)
    private String nombreProducto;

    @Column(name = "descripcion_producto", columnDefinition = "TEXT")
    private String descripcionProducto;

    @Column(name = "codigo_digemid", unique = true, length = 50)
    private String codigoDigemid;

    @Column(name = "registro_sanitario", unique = true, length = 50)
    private String registroSanitario;

    @ManyToOne
    @JoinColumn(name = "id_tipo")
    private TipoProducto tipoProducto;

    @ManyToOne
    @JoinColumn(name = "id_forma")
    private FormaFarmaceutica formaFarmaceutica;

    @Column(name = "condiciones_almacenamiento", length = 100)
    private String condicionesAlmacenamiento = "Ambiente";

    @Column(name = "condiciones_transporte", length = 100)
    private String condicionesTransporte = "Estándar";

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

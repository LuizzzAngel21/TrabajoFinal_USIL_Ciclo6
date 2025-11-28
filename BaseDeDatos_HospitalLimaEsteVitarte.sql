--
-- PostgreSQL database dump
--

\restrict YunnUpAUNhKsyj8Ft3NHbcAT3oc0PXYg4nmkzFSZ4Q0oF0HIZDCUOu2NdKdURl0

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-28 06:21:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 35892)
-- Name: farmacia; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA farmacia;


ALTER SCHEMA farmacia OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 288 (class 1259 OID 35971)
-- Name: almacenes; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.almacenes (
    id_almacen integer NOT NULL,
    nombre_almacen character varying(100) NOT NULL,
    ubicacion character varying(255),
    capacidad integer,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.almacenes OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 35970)
-- Name: almacenes_id_almacen_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.almacenes_id_almacen_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.almacenes_id_almacen_seq OWNER TO postgres;

--
-- TOC entry 5503 (class 0 OID 0)
-- Dependencies: 287
-- Name: almacenes_id_almacen_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.almacenes_id_almacen_seq OWNED BY farmacia.almacenes.id_almacen;


--
-- TOC entry 280 (class 1259 OID 35909)
-- Name: areas; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.areas (
    id_area integer NOT NULL,
    nombre_area character varying(100) NOT NULL,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.areas OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 35908)
-- Name: areas_id_area_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.areas_id_area_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.areas_id_area_seq OWNER TO postgres;

--
-- TOC entry 5504 (class 0 OID 0)
-- Dependencies: 279
-- Name: areas_id_area_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.areas_id_area_seq OWNED BY farmacia.areas.id_area;


--
-- TOC entry 294 (class 1259 OID 36021)
-- Name: departamentos; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.departamentos (
    id_departamento integer NOT NULL,
    nombre_departamento character varying(100) NOT NULL,
    id_area integer,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.departamentos OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 36020)
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.departamentos_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.departamentos_id_departamento_seq OWNER TO postgres;

--
-- TOC entry 5505 (class 0 OID 0)
-- Dependencies: 293
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.departamentos_id_departamento_seq OWNED BY farmacia.departamentos.id_departamento;


--
-- TOC entry 322 (class 1259 OID 36373)
-- Name: detalle_orden_compra; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.detalle_orden_compra (
    id_detalle_orden integer NOT NULL,
    id_orden integer NOT NULL,
    id_producto integer NOT NULL,
    id_detalle_solicitud integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(12,2) GENERATED ALWAYS AS (((cantidad)::numeric * precio_unitario)) STORED,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying
);


ALTER TABLE farmacia.detalle_orden_compra OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 36372)
-- Name: detalle_orden_compra_id_detalle_orden_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.detalle_orden_compra_id_detalle_orden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.detalle_orden_compra_id_detalle_orden_seq OWNER TO postgres;

--
-- TOC entry 5506 (class 0 OID 0)
-- Dependencies: 321
-- Name: detalle_orden_compra_id_detalle_orden_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.detalle_orden_compra_id_detalle_orden_seq OWNED BY farmacia.detalle_orden_compra.id_detalle_orden;


--
-- TOC entry 316 (class 1259 OID 36291)
-- Name: detalle_orden_distribucion; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.detalle_orden_distribucion (
    id_detalle_dist integer NOT NULL,
    id_orden_dist integer NOT NULL,
    id_producto integer NOT NULL,
    id_lote integer NOT NULL,
    cantidad integer NOT NULL,
    estado_entrega character varying(20) DEFAULT 'PENDIENTE'::character varying,
    condiciones_transporte character varying(100),
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.detalle_orden_distribucion OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 36290)
-- Name: detalle_orden_distribucion_id_detalle_dist_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.detalle_orden_distribucion_id_detalle_dist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.detalle_orden_distribucion_id_detalle_dist_seq OWNER TO postgres;

--
-- TOC entry 5507 (class 0 OID 0)
-- Dependencies: 315
-- Name: detalle_orden_distribucion_id_detalle_dist_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.detalle_orden_distribucion_id_detalle_dist_seq OWNED BY farmacia.detalle_orden_distribucion.id_detalle_dist;


--
-- TOC entry 306 (class 1259 OID 36167)
-- Name: detalle_requerimiento; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.detalle_requerimiento (
    id_detalle_requerimiento integer NOT NULL,
    id_requerimiento integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    cantidad_atendida integer DEFAULT 0,
    observacion text
);


ALTER TABLE farmacia.detalle_requerimiento OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 36166)
-- Name: detalle_requerimiento_id_detalle_requerimiento_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.detalle_requerimiento_id_detalle_requerimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.detalle_requerimiento_id_detalle_requerimiento_seq OWNER TO postgres;

--
-- TOC entry 5508 (class 0 OID 0)
-- Dependencies: 305
-- Name: detalle_requerimiento_id_detalle_requerimiento_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.detalle_requerimiento_id_detalle_requerimiento_seq OWNED BY farmacia.detalle_requerimiento.id_detalle_requerimiento;


--
-- TOC entry 312 (class 1259 OID 36232)
-- Name: detalle_solicitud_compra; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.detalle_solicitud_compra (
    id_detalle_solicitud integer NOT NULL,
    id_solicitud integer NOT NULL,
    id_producto integer NOT NULL,
    id_detalle_requerimiento integer,
    cantidad_solicitada integer NOT NULL,
    cantidad_aprobada integer DEFAULT 0,
    estado character varying(20) DEFAULT 'Pendiente'::character varying
);


ALTER TABLE farmacia.detalle_solicitud_compra OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 36231)
-- Name: detalle_solicitud_compra_id_detalle_solicitud_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.detalle_solicitud_compra_id_detalle_solicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.detalle_solicitud_compra_id_detalle_solicitud_seq OWNER TO postgres;

--
-- TOC entry 5509 (class 0 OID 0)
-- Dependencies: 311
-- Name: detalle_solicitud_compra_id_detalle_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.detalle_solicitud_compra_id_detalle_solicitud_seq OWNED BY farmacia.detalle_solicitud_compra.id_detalle_solicitud;


--
-- TOC entry 284 (class 1259 OID 35939)
-- Name: formas_farmaceuticas; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.formas_farmaceuticas (
    id_forma integer NOT NULL,
    nombre_forma character varying(100) NOT NULL,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.formas_farmaceuticas OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 35938)
-- Name: formas_farmaceuticas_id_forma_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.formas_farmaceuticas_id_forma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.formas_farmaceuticas_id_forma_seq OWNER TO postgres;

--
-- TOC entry 5510 (class 0 OID 0)
-- Dependencies: 283
-- Name: formas_farmaceuticas_id_forma_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.formas_farmaceuticas_id_forma_seq OWNED BY farmacia.formas_farmaceuticas.id_forma;


--
-- TOC entry 318 (class 1259 OID 36320)
-- Name: incidencias_transporte; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.incidencias_transporte (
    id_incidencia_transporte integer NOT NULL,
    id_vehiculo integer NOT NULL,
    id_orden_dist integer,
    id_detalle_dist integer,
    tipo_incidencia character varying(100) NOT NULL,
    descripcion text,
    impacto character varying(30) DEFAULT 'Moderado'::character varying,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    fecha_incidencia timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion timestamp without time zone,
    id_usuario_reporta integer,
    observaciones text
);


ALTER TABLE farmacia.incidencias_transporte OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 36319)
-- Name: incidencias_transporte_id_incidencia_transporte_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.incidencias_transporte_id_incidencia_transporte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.incidencias_transporte_id_incidencia_transporte_seq OWNER TO postgres;

--
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 317
-- Name: incidencias_transporte_id_incidencia_transporte_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.incidencias_transporte_id_incidencia_transporte_seq OWNED BY farmacia.incidencias_transporte.id_incidencia_transporte;


--
-- TOC entry 304 (class 1259 OID 36142)
-- Name: inventario; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.inventario (
    id_inventario integer NOT NULL,
    id_almacen integer NOT NULL,
    id_lote integer NOT NULL,
    stock_actual integer NOT NULL,
    stock_minimo integer DEFAULT 0,
    stock_maximo integer,
    ubicacion_especifica character varying(100),
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.inventario OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 36141)
-- Name: inventario_id_inventario_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.inventario_id_inventario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.inventario_id_inventario_seq OWNER TO postgres;

--
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 303
-- Name: inventario_id_inventario_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.inventario_id_inventario_seq OWNED BY farmacia.inventario.id_inventario;


--
-- TOC entry 298 (class 1259 OID 36071)
-- Name: lotes_producto; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.lotes_producto (
    id_lote integer NOT NULL,
    id_producto integer NOT NULL,
    numero_lote character varying(50) NOT NULL,
    fecha_fabricacion date,
    fecha_vencimiento date NOT NULL,
    stock_inicial integer NOT NULL,
    stock_actual integer NOT NULL,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.lotes_producto OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 36070)
-- Name: lotes_producto_id_lote_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.lotes_producto_id_lote_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.lotes_producto_id_lote_seq OWNER TO postgres;

--
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 297
-- Name: lotes_producto_id_lote_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.lotes_producto_id_lote_seq OWNED BY farmacia.lotes_producto.id_lote;


--
-- TOC entry 320 (class 1259 OID 36355)
-- Name: movimiento_inventario; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.movimiento_inventario (
    id_movimiento integer NOT NULL,
    id_inventario integer NOT NULL,
    tipo_movimiento character varying(50) NOT NULL,
    cantidad integer NOT NULL,
    motivo character varying(255),
    fecha_movimiento timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_usuario_registro integer NOT NULL
);


ALTER TABLE farmacia.movimiento_inventario OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 36354)
-- Name: movimiento_inventario_id_movimiento_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.movimiento_inventario_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.movimiento_inventario_id_movimiento_seq OWNER TO postgres;

--
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 319
-- Name: movimiento_inventario_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.movimiento_inventario_id_movimiento_seq OWNED BY farmacia.movimiento_inventario.id_movimiento;


--
-- TOC entry 314 (class 1259 OID 36260)
-- Name: ordenes_compra; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.ordenes_compra (
    id_orden integer NOT NULL,
    id_solicitud integer NOT NULL,
    id_proveedor integer NOT NULL,
    numero_orden character varying(50),
    fecha_emision date DEFAULT CURRENT_DATE,
    fecha_entrega_estimada date,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    observaciones text,
    subtotal numeric(12,2) DEFAULT 0,
    igv numeric(12,2) DEFAULT 0,
    total numeric(12,2) DEFAULT 0,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_usuario_creacion integer NOT NULL
);


ALTER TABLE farmacia.ordenes_compra OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 36259)
-- Name: ordenes_compra_id_orden_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.ordenes_compra_id_orden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.ordenes_compra_id_orden_seq OWNER TO postgres;

--
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 313
-- Name: ordenes_compra_id_orden_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.ordenes_compra_id_orden_seq OWNED BY farmacia.ordenes_compra.id_orden;


--
-- TOC entry 310 (class 1259 OID 36213)
-- Name: ordenes_distribucion; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.ordenes_distribucion (
    id_orden_dist integer NOT NULL,
    id_requerimiento integer NOT NULL,
    id_usuario_creacion integer NOT NULL,
    fecha_distribucion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    prioridad character varying(20),
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_vehiculo integer
);


ALTER TABLE farmacia.ordenes_distribucion OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 36212)
-- Name: ordenes_distribucion_id_orden_dist_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.ordenes_distribucion_id_orden_dist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.ordenes_distribucion_id_orden_dist_seq OWNER TO postgres;

--
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 309
-- Name: ordenes_distribucion_id_orden_dist_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.ordenes_distribucion_id_orden_dist_seq OWNED BY farmacia.ordenes_distribucion.id_orden_dist;


--
-- TOC entry 300 (class 1259 OID 36094)
-- Name: producto_proveedor; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.producto_proveedor (
    id_producto_proveedor integer NOT NULL,
    id_producto integer NOT NULL,
    id_proveedor integer NOT NULL,
    precio_referencial numeric(10,2),
    moneda character varying(10) DEFAULT 'PEN'::character varying,
    tiempo_entrega_dias integer,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.producto_proveedor OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 36093)
-- Name: producto_proveedor_id_producto_proveedor_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.producto_proveedor_id_producto_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.producto_proveedor_id_producto_proveedor_seq OWNER TO postgres;

--
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 299
-- Name: producto_proveedor_id_producto_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.producto_proveedor_id_producto_proveedor_seq OWNED BY farmacia.producto_proveedor.id_producto_proveedor;


--
-- TOC entry 296 (class 1259 OID 36039)
-- Name: productos; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.productos (
    id_producto integer NOT NULL,
    nombre_producto character varying(150) NOT NULL,
    descripcion_producto text,
    codigo_digemid character varying(50),
    registro_sanitario character varying(50),
    id_tipo integer,
    id_forma integer,
    condiciones_almacenamiento character varying(100) DEFAULT 'Ambiente'::character varying,
    condiciones_transporte character varying(100) DEFAULT 'Estándar'::character varying,
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.productos OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 36038)
-- Name: productos_id_producto_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.productos_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.productos_id_producto_seq OWNER TO postgres;

--
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 295
-- Name: productos_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.productos_id_producto_seq OWNED BY farmacia.productos.id_producto;


--
-- TOC entry 286 (class 1259 OID 35954)
-- Name: proveedores; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.proveedores (
    id_proveedor integer NOT NULL,
    nombre_proveedor character varying(150) NOT NULL,
    ruc character varying(20) NOT NULL,
    direccion character varying(255),
    telefono character varying(20),
    correo character varying(100),
    estado boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.proveedores OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 35953)
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.proveedores_id_proveedor_seq OWNER TO postgres;

--
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 285
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.proveedores_id_proveedor_seq OWNED BY farmacia.proveedores.id_proveedor;


--
-- TOC entry 302 (class 1259 OID 36120)
-- Name: requerimientos; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.requerimientos (
    id_requerimiento integer NOT NULL,
    id_usuario_solicitante integer NOT NULL,
    id_departamento integer NOT NULL,
    fecha_solicitud date DEFAULT CURRENT_DATE,
    fecha_limite date,
    prioridad character varying(20) DEFAULT 'Media'::character varying,
    estado character varying(50) DEFAULT 'Pendiente'::character varying,
    observacion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.requerimientos OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 36119)
-- Name: requerimientos_id_requerimiento_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.requerimientos_id_requerimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.requerimientos_id_requerimiento_seq OWNER TO postgres;

--
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 301
-- Name: requerimientos_id_requerimiento_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.requerimientos_id_requerimiento_seq OWNED BY farmacia.requerimientos.id_requerimiento;


--
-- TOC entry 278 (class 1259 OID 35894)
-- Name: roles; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.roles (
    id_rol integer NOT NULL,
    nombre_rol character varying(50) NOT NULL,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.roles OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 35893)
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.roles_id_rol_seq OWNER TO postgres;

--
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 277
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.roles_id_rol_seq OWNED BY farmacia.roles.id_rol;


--
-- TOC entry 308 (class 1259 OID 36191)
-- Name: solicitud_compra; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.solicitud_compra (
    id_solicitud integer NOT NULL,
    id_requerimiento integer NOT NULL,
    id_usuario_solicitante integer NOT NULL,
    motivo text,
    estado character varying(50) DEFAULT 'Pendiente'::character varying,
    productos_recibidos boolean DEFAULT false,
    fecha_solicitud date DEFAULT CURRENT_DATE,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.solicitud_compra OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 36190)
-- Name: solicitud_compra_id_solicitud_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.solicitud_compra_id_solicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.solicitud_compra_id_solicitud_seq OWNER TO postgres;

--
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 307
-- Name: solicitud_compra_id_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.solicitud_compra_id_solicitud_seq OWNED BY farmacia.solicitud_compra.id_solicitud;


--
-- TOC entry 282 (class 1259 OID 35924)
-- Name: tipos_producto; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.tipos_producto (
    id_tipo integer NOT NULL,
    nombre_tipo character varying(100) NOT NULL,
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.tipos_producto OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 35923)
-- Name: tipos_producto_id_tipo_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.tipos_producto_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.tipos_producto_id_tipo_seq OWNER TO postgres;

--
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 281
-- Name: tipos_producto_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.tipos_producto_id_tipo_seq OWNED BY farmacia.tipos_producto.id_tipo;


--
-- TOC entry 292 (class 1259 OID 35997)
-- Name: usuarios; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.usuarios (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(100) NOT NULL,
    contrasena character varying(255) NOT NULL,
    correo character varying(150),
    id_rol integer,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.usuarios OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 35996)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 291
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.usuarios_id_usuario_seq OWNED BY farmacia.usuarios.id_usuario;


--
-- TOC entry 290 (class 1259 OID 35983)
-- Name: vehiculos; Type: TABLE; Schema: farmacia; Owner: postgres
--

CREATE TABLE farmacia.vehiculos (
    id_vehiculo integer NOT NULL,
    placa character varying(20) NOT NULL,
    marca character varying(50),
    modelo character varying(50),
    capacidad_carga numeric(10,2),
    estado character varying(20) DEFAULT 'Disponible'::character varying,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE farmacia.vehiculos OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 35982)
-- Name: vehiculos_id_vehiculo_seq; Type: SEQUENCE; Schema: farmacia; Owner: postgres
--

CREATE SEQUENCE farmacia.vehiculos_id_vehiculo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE farmacia.vehiculos_id_vehiculo_seq OWNER TO postgres;

--
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 289
-- Name: vehiculos_id_vehiculo_seq; Type: SEQUENCE OWNED BY; Schema: farmacia; Owner: postgres
--

ALTER SEQUENCE farmacia.vehiculos_id_vehiculo_seq OWNED BY farmacia.vehiculos.id_vehiculo;


--
-- TOC entry 5110 (class 2604 OID 35974)
-- Name: almacenes id_almacen; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.almacenes ALTER COLUMN id_almacen SET DEFAULT nextval('farmacia.almacenes_id_almacen_seq'::regclass);


--
-- TOC entry 5097 (class 2604 OID 35912)
-- Name: areas id_area; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.areas ALTER COLUMN id_area SET DEFAULT nextval('farmacia.areas_id_area_seq'::regclass);


--
-- TOC entry 5122 (class 2604 OID 36024)
-- Name: departamentos id_departamento; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.departamentos ALTER COLUMN id_departamento SET DEFAULT nextval('farmacia.departamentos_id_departamento_seq'::regclass);


--
-- TOC entry 5182 (class 2604 OID 36376)
-- Name: detalle_orden_compra id_detalle_orden; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra ALTER COLUMN id_detalle_orden SET DEFAULT nextval('farmacia.detalle_orden_compra_id_detalle_orden_seq'::regclass);


--
-- TOC entry 5173 (class 2604 OID 36294)
-- Name: detalle_orden_distribucion id_detalle_dist; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_distribucion ALTER COLUMN id_detalle_dist SET DEFAULT nextval('farmacia.detalle_orden_distribucion_id_detalle_dist_seq'::regclass);


--
-- TOC entry 5149 (class 2604 OID 36170)
-- Name: detalle_requerimiento id_detalle_requerimiento; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_requerimiento ALTER COLUMN id_detalle_requerimiento SET DEFAULT nextval('farmacia.detalle_requerimiento_id_detalle_requerimiento_seq'::regclass);


--
-- TOC entry 5162 (class 2604 OID 36235)
-- Name: detalle_solicitud_compra id_detalle_solicitud; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_solicitud_compra ALTER COLUMN id_detalle_solicitud SET DEFAULT nextval('farmacia.detalle_solicitud_compra_id_detalle_solicitud_seq'::regclass);


--
-- TOC entry 5103 (class 2604 OID 35942)
-- Name: formas_farmaceuticas id_forma; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.formas_farmaceuticas ALTER COLUMN id_forma SET DEFAULT nextval('farmacia.formas_farmaceuticas_id_forma_seq'::regclass);


--
-- TOC entry 5176 (class 2604 OID 36323)
-- Name: incidencias_transporte id_incidencia_transporte; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte ALTER COLUMN id_incidencia_transporte SET DEFAULT nextval('farmacia.incidencias_transporte_id_incidencia_transporte_seq'::regclass);


--
-- TOC entry 5146 (class 2604 OID 36145)
-- Name: inventario id_inventario; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario ALTER COLUMN id_inventario SET DEFAULT nextval('farmacia.inventario_id_inventario_seq'::regclass);


--
-- TOC entry 5131 (class 2604 OID 36074)
-- Name: lotes_producto id_lote; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.lotes_producto ALTER COLUMN id_lote SET DEFAULT nextval('farmacia.lotes_producto_id_lote_seq'::regclass);


--
-- TOC entry 5180 (class 2604 OID 36358)
-- Name: movimiento_inventario id_movimiento; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.movimiento_inventario ALTER COLUMN id_movimiento SET DEFAULT nextval('farmacia.movimiento_inventario_id_movimiento_seq'::regclass);


--
-- TOC entry 5165 (class 2604 OID 36263)
-- Name: ordenes_compra id_orden; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_compra ALTER COLUMN id_orden SET DEFAULT nextval('farmacia.ordenes_compra_id_orden_seq'::regclass);


--
-- TOC entry 5157 (class 2604 OID 36216)
-- Name: ordenes_distribucion id_orden_dist; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_distribucion ALTER COLUMN id_orden_dist SET DEFAULT nextval('farmacia.ordenes_distribucion_id_orden_dist_seq'::regclass);


--
-- TOC entry 5135 (class 2604 OID 36097)
-- Name: producto_proveedor id_producto_proveedor; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor ALTER COLUMN id_producto_proveedor SET DEFAULT nextval('farmacia.producto_proveedor_id_producto_proveedor_seq'::regclass);


--
-- TOC entry 5125 (class 2604 OID 36042)
-- Name: productos id_producto; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos ALTER COLUMN id_producto SET DEFAULT nextval('farmacia.productos_id_producto_seq'::regclass);


--
-- TOC entry 5106 (class 2604 OID 35957)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('farmacia.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 5140 (class 2604 OID 36123)
-- Name: requerimientos id_requerimiento; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.requerimientos ALTER COLUMN id_requerimiento SET DEFAULT nextval('farmacia.requerimientos_id_requerimiento_seq'::regclass);


--
-- TOC entry 5094 (class 2604 OID 35897)
-- Name: roles id_rol; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.roles ALTER COLUMN id_rol SET DEFAULT nextval('farmacia.roles_id_rol_seq'::regclass);


--
-- TOC entry 5151 (class 2604 OID 36194)
-- Name: solicitud_compra id_solicitud; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.solicitud_compra ALTER COLUMN id_solicitud SET DEFAULT nextval('farmacia.solicitud_compra_id_solicitud_seq'::regclass);


--
-- TOC entry 5100 (class 2604 OID 35927)
-- Name: tipos_producto id_tipo; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.tipos_producto ALTER COLUMN id_tipo SET DEFAULT nextval('farmacia.tipos_producto_id_tipo_seq'::regclass);


--
-- TOC entry 5118 (class 2604 OID 36000)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('farmacia.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5114 (class 2604 OID 35986)
-- Name: vehiculos id_vehiculo; Type: DEFAULT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.vehiculos ALTER COLUMN id_vehiculo SET DEFAULT nextval('farmacia.vehiculos_id_vehiculo_seq'::regclass);


--
-- TOC entry 5463 (class 0 OID 35971)
-- Dependencies: 288
-- Data for Name: almacenes; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.almacenes (id_almacen, nombre_almacen, ubicacion, capacidad, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Almacén Central	Sótano 1	10000	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Almacén Satélite	Piso 3	2000	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5455 (class 0 OID 35909)
-- Dependencies: 280
-- Data for Name: areas; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.areas (id_area, nombre_area, descripcion, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Asistencial	Áreas de atención a pacientes	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Administrativa	Áreas de gestión	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5469 (class 0 OID 36021)
-- Dependencies: 294
-- Data for Name: departamentos; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.departamentos (id_departamento, nombre_departamento, id_area, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Farmacia Central	1	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Urgencias	1	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
3	Logística	2	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5497 (class 0 OID 36373)
-- Dependencies: 322
-- Data for Name: detalle_orden_compra; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.detalle_orden_compra (id_detalle_orden, id_orden, id_producto, id_detalle_solicitud, cantidad, precio_unitario, estado) FROM stdin;
1	1	2	\N	50	3.00	PENDIENTE
2	2	3	\N	100	2.00	PENDIENTE
6	7	2	1	200	0.59	PENDIENTE
7	8	2	3	2000	3.60	PENDIENTE
8	9	2	4	122	3.50	PENDIENTE
9	10	2	10	90	3.50	PENDIENTE
10	11	2	12	12	3.50	PENDIENTE
11	12	3	13	100	2.15	PENDIENTE
12	13	2	14	100	3.50	PENDIENTE
13	14	3	15	100	2.15	PENDIENTE
14	15	2	11	90	3.50	PENDIENTE
15	16	3	9	200	2.15	PENDIENTE
16	17	2	8	45	3.60	PENDIENTE
17	18	2	16	50	3.60	PENDIENTE
18	19	3	19	100	2.15	PENDIENTE
19	20	3	20	200	2.15	PENDIENTE
20	21	3	7	31	2.15	PENDIENTE
21	22	3	21	100	2.15	PENDIENTE
22	23	2	22	150	3.50	PENDIENTE
23	24	2	18	10	3.50	PENDIENTE
24	25	2	23	500	3.60	PENDIENTE
\.


--
-- TOC entry 5491 (class 0 OID 36291)
-- Dependencies: 316
-- Data for Name: detalle_orden_distribucion; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.detalle_orden_distribucion (id_detalle_dist, id_orden_dist, id_producto, id_lote, cantidad, estado_entrega, condiciones_transporte, fecha_creacion) FROM stdin;
1	7	2	2	10	PENDIENTE_ENTREGA	\N	2025-11-27 18:25:06.982587
2	8	2	2	10	PENDIENTE_ENTREGA	\N	2025-11-27 18:25:53.524281
3	9	1	1	100	PENDIENTE_ENTREGA	\N	2025-11-27 18:45:24.738148
4	10	2	2	10	PENDIENTE_ENTREGA	\N	2025-11-27 18:53:21.050808
5	11	1	1	10	PENDIENTE_ENTREGA	\N	2025-11-27 18:58:08.390794
6	12	3	3	200	PENDIENTE_ENTREGA	\N	2025-11-27 19:12:59.280525
7	13	3	3	100	PENDIENTE_ENTREGA	\N	2025-11-27 19:24:14.40096
8	14	3	3	200	PENDIENTE_ENTREGA	\N	2025-11-27 19:24:52.284641
9	15	2	2	10	PENDIENTE	\N	2025-11-27 19:37:20.85317
10	16	2	2	100	PENDIENTE	\N	2025-11-27 21:41:14.848078
\.


--
-- TOC entry 5481 (class 0 OID 36167)
-- Dependencies: 306
-- Data for Name: detalle_requerimiento; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.detalle_requerimiento (id_detalle_requerimiento, id_requerimiento, id_producto, cantidad, cantidad_atendida, observacion) FROM stdin;
1	1	1	100	0	Reponer stock diario
2	1	3	200	0	Urgente por falta de stock
3	3	1	50	0	\N
4	4	2	50	0	\N
5	6	2	50	0	\N
6	7	2	50	0	\N
7	8	2	50	0	\N
8	9	3	50	0	\N
9	10	1	100	0	\N
10	11	3	100	0	\N
11	12	3	50	0	\N
12	13	2	200	0	\N
13	14	3	100	0	\N
14	15	2	2000	0	\N
15	16	2	122	0	\N
16	17	2	100	0	\N
17	18	3	21	0	\N
18	19	3	31	0	\N
19	20	2	45	0	\N
20	21	3	200	0	\N
21	22	2	90	0	\N
22	23	2	90	0	\N
23	24	2	12	0	\N
24	25	3	100	0	\N
25	26	1	100	0	\N
26	27	2	100	0	\N
27	28	3	100	0	\N
28	29	2	50	0	\N
29	30	2	95	0	\N
30	31	2	10	0	\N
31	32	2	10	0	\N
32	33	2	10	0	\N
33	34	1	100	0	\N
34	35	2	10	0	\N
35	36	1	10	0	\N
36	37	3	100	0	\N
37	38	3	200	0	\N
38	39	3	200	0	\N
39	40	3	100	0	\N
40	41	3	200	0	\N
41	42	2	10	0	\N
42	43	3	100	0	\N
43	44	2	150	0	\N
44	45	2	100	0	\N
45	46	2	500	0	\N
\.


--
-- TOC entry 5487 (class 0 OID 36232)
-- Dependencies: 312
-- Data for Name: detalle_solicitud_compra; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.detalle_solicitud_compra (id_detalle_solicitud, id_solicitud, id_producto, id_detalle_requerimiento, cantidad_solicitada, cantidad_aprobada, estado) FROM stdin;
1	5	2	12	200	200	PENDIENTE
2	6	3	13	100	100	PENDIENTE
3	7	2	14	2000	2000	PENDIENTE
4	8	2	15	122	122	PENDIENTE
5	9	2	16	100	100	PENDIENTE
6	10	3	17	21	21	PENDIENTE
7	11	3	18	31	31	PENDIENTE
8	12	2	19	45	45	PENDIENTE
9	13	3	20	200	200	PENDIENTE
10	14	2	21	90	90	PENDIENTE
11	15	2	22	90	90	PENDIENTE
12	16	2	23	12	12	PENDIENTE
13	17	3	24	100	100	PENDIENTE
14	18	2	26	100	100	PENDIENTE
15	19	3	27	100	100	PENDIENTE
16	20	2	28	50	50	PENDIENTE
17	21	2	29	95	95	PENDIENTE
18	22	2	30	10	10	PENDIENTE
19	23	3	36	100	100	PENDIENTE
20	24	3	37	200	200	PENDIENTE
21	25	3	42	100	100	PENDIENTE
22	26	2	43	150	150	PENDIENTE
23	27	2	45	500	500	PENDIENTE
\.


--
-- TOC entry 5459 (class 0 OID 35939)
-- Dependencies: 284
-- Data for Name: formas_farmaceuticas; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.formas_farmaceuticas (id_forma, nombre_forma, descripcion, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Tableta	Sólido oral	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Jarabe	Líquido oral	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
3	Inyectable	Solución parenteral	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5493 (class 0 OID 36320)
-- Dependencies: 318
-- Data for Name: incidencias_transporte; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.incidencias_transporte (id_incidencia_transporte, id_vehiculo, id_orden_dist, id_detalle_dist, tipo_incidencia, descripcion, impacto, estado, fecha_incidencia, fecha_resolucion, id_usuario_reporta, observaciones) FROM stdin;
\.


--
-- TOC entry 5479 (class 0 OID 36142)
-- Dependencies: 304
-- Data for Name: inventario; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.inventario (id_inventario, id_almacen, id_lote, stock_actual, stock_minimo, stock_maximo, ubicacion_especifica, fecha_actualizacion) FROM stdin;
1	1	1	1000	100	5000	Estante A-1	2025-11-26 11:32:20.2132
2	1	2	0	50	2000	Estante B-2	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5473 (class 0 OID 36071)
-- Dependencies: 298
-- Data for Name: lotes_producto; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.lotes_producto (id_lote, id_producto, numero_lote, fecha_fabricacion, fecha_vencimiento, stock_inicial, stock_actual, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	1	LOTE-P001	2024-01-01	2026-01-01	1000	690	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
3	3	LOTE-1764288308440	\N	2026-11-27	100	131	t	2025-11-27 19:05:08.440281	2025-11-27 19:40:08.312885
2	2	LOTE-I001	2024-02-01	2025-06-01	500	705	t	2025-11-26 11:32:20.2132	2025-11-27 21:46:37.26273
\.


--
-- TOC entry 5495 (class 0 OID 36355)
-- Dependencies: 320
-- Data for Name: movimiento_inventario; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.movimiento_inventario (id_movimiento, id_inventario, tipo_movimiento, cantidad, motivo, fecha_movimiento, id_usuario_registro) FROM stdin;
1	1	SALIDA	100	Despacho Requerimiento #34	2025-11-27 18:45:24.728917	1
2	2	SALIDA	10	Despacho Requerimiento #35	2025-11-27 18:53:21.040927	1
3	1	SALIDA	10	Despacho Requerimiento #36	2025-11-27 18:58:08.386766	1
4	2	ENTRADA	90	Recepción Orden Compra #15	2025-11-27 19:12:03.067806	1
5	2	SALIDA	10	Despacho Req #42	2025-11-27 19:37:20.871261	1
6	2	ENTRADA	150	Recepción Orden Compra #23	2025-11-27 19:41:36.304478	1
7	2	SALIDA	100	Despacho Req #45	2025-11-27 21:41:14.890116	1
8	2	ENTRADA	10	Recepción Orden Compra #24	2025-11-27 21:45:43.632743	1
9	2	ENTRADA	500	Recepción Orden Compra #25	2025-11-27 21:46:37.271699	1
\.


--
-- TOC entry 5489 (class 0 OID 36260)
-- Dependencies: 314
-- Data for Name: ordenes_compra; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.ordenes_compra (id_orden, id_solicitud, id_proveedor, numero_orden, fecha_emision, fecha_entrega_estimada, estado, observaciones, subtotal, igv, total, fecha_creacion, fecha_actualizacion, id_usuario_creacion) FROM stdin;
1	1	2	OC-38651EEA	2025-11-27	\N	EMITIDA	\N	0.00	0.00	150.00	2025-11-27 01:19:48.03755	2025-11-27 01:19:48.03755	1
2	3	1	OC-7EDC3EE2	2025-11-27	\N	EMITIDA	\N	169.49	30.51	200.00	2025-11-27 01:27:15.011557	2025-11-27 01:27:15.011557	1
7	5	2	OC-0F16479C	2025-11-27	\N	EMITIDA	\N	118.64	21.36	140.00	2025-11-27 01:52:56.306306	2025-11-27 01:52:56.306306	1
8	7	2	OC-F021B145	2025-11-27	\N	EMITIDA	\N	7200.00	1296.00	8496.00	2025-11-27 02:08:10.495707	2025-11-27 02:08:10.557606	1
9	8	1	OC-6B0AC67A	2025-11-27	\N	EMITIDA	\N	427.00	76.86	503.86	2025-11-27 02:20:22.697993	2025-11-27 02:20:22.748018	1
10	14	1	OC-0D9F18D7	2025-11-27	\N	EMITIDA	\N	315.00	56.70	371.70	2025-11-27 02:57:12.665514	2025-11-27 02:57:12.759044	1
11	16	1	OC-A6E70B6D	2025-11-27	\N	EMITIDA	\N	42.00	7.56	49.56	2025-11-27 03:11:25.656225	2025-11-27 03:11:25.708931	1
12	17	2	OC-284FA2B7	2025-11-27	\N	EMITIDA	\N	215.00	38.70	253.70	2025-11-27 03:16:35.572752	2025-11-27 03:16:35.664576	1
13	18	1	OC-6228A337	2025-11-27	\N	EMITIDA	\N	350.00	63.00	413.00	2025-11-27 17:55:53.586101	2025-11-27 17:55:53.679344	1
14	19	2	OC-A7F51532	2025-11-27	\N	EMITIDA	\N	215.00	38.70	253.70	2025-11-27 18:05:20.869254	2025-11-27 18:05:21.01341	1
17	12	2	OC-75FA3F1F	2025-11-27	\N	RECIBIDA	\N	162.00	29.16	191.16	2025-11-27 18:06:13.543937	2025-11-27 18:06:23.622668	1
18	20	2	OC-F94A1112	2025-11-27	\N	RECIBIDA	\N	180.00	32.40	212.40	2025-11-27 18:08:16.22234	2025-11-27 18:08:20.459058	1
19	23	2	OC-5C26AC4B	2025-11-27	\N	RECIBIDA	\N	215.00	38.70	253.70	2025-11-27 19:00:40.698369	2025-11-27 19:05:08.45315	1
20	24	2	OC-2593B5C9	2025-11-27	\N	RECIBIDA	\N	430.00	77.40	507.40	2025-11-27 19:10:37.576469	2025-11-27 19:10:41.044917	1
16	13	2	OC-F3667EF7	2025-11-27	\N	RECIBIDA	\N	430.00	77.40	507.40	2025-11-27 18:05:56.741359	2025-11-27 19:11:39.148258	1
15	15	1	OC-A2B25CD9	2025-11-27	\N	RECIBIDA	\N	315.00	56.70	371.70	2025-11-27 18:05:38.654663	2025-11-27 19:12:03.070834	1
21	11	2	OC-6AC3385D	2025-11-27	\N	RECIBIDA	\N	66.65	12.00	78.65	2025-11-27 19:37:47.853483	2025-11-27 19:37:51.872774	1
22	25	2	OC-6C62E064	2025-11-27	\N	RECIBIDA	\N	215.00	38.70	253.70	2025-11-27 19:40:04.445054	2025-11-27 19:40:08.319624	1
23	26	1	OC-EE59B79C	2025-11-27	\N	RECIBIDA	\N	525.00	94.50	619.50	2025-11-27 19:41:32.88559	2025-11-27 19:41:36.306991	1
24	22	1	OC-42A15E83	2025-11-27	\N	RECIBIDA	\N	35.00	6.30	41.30	2025-11-27 21:44:05.661509	2025-11-27 21:45:43.636324	1
25	27	2	OC-BFC239BF	2025-11-27	\N	RECIBIDA	\N	1800.00	324.00	2124.00	2025-11-27 21:46:29.068928	2025-11-27 21:46:37.277055	1
\.


--
-- TOC entry 5485 (class 0 OID 36213)
-- Dependencies: 310
-- Data for Name: ordenes_distribucion; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.ordenes_distribucion (id_orden_dist, id_requerimiento, id_usuario_creacion, fecha_distribucion, estado, prioridad, fecha_creacion, fecha_actualizacion, id_vehiculo) FROM stdin;
1	3	1	2025-11-26 23:16:29.351168	PENDIENTE_ENTREGA	ALTA	2025-11-26 23:16:29.356732	2025-11-26 23:16:29.356732	\N
2	4	1	2025-11-26 23:16:33.007886	PENDIENTE_ENTREGA	ALTA	2025-11-26 23:16:33.007886	2025-11-26 23:16:33.007886	\N
3	6	1	2025-11-26 23:42:21.174358	PENDIENTE_ENTREGA	ALTA	2025-11-26 23:42:21.174358	2025-11-26 23:42:21.174358	\N
4	7	1	2025-11-26 23:45:31.415495	PENDIENTE_ENTREGA	ALTA	2025-11-26 23:45:31.416004	2025-11-26 23:45:31.416004	\N
8	33	1	2025-11-27 18:25:53.51529	EN_RUTA	MEDIA	2025-11-27 18:25:53.51529	2025-11-27 18:33:47.845338	1
7	32	1	2025-11-27 18:25:06.943539	EN_RUTA	MEDIA	2025-11-27 18:25:06.944551	2025-11-27 18:33:52.191388	2
6	26	1	2025-11-27 03:18:01.695015	EN_RUTA	ALTA	2025-11-27 03:18:01.696038	2025-11-27 18:37:24.54753	2
5	10	1	2025-11-26 23:56:31.929246	EN_RUTA	MEDIA	2025-11-26 23:56:31.930245	2025-11-27 18:37:29.25565	2
9	34	1	2025-11-27 18:45:24.693706	EN_RUTA	MEDIA	2025-11-27 18:45:24.694707	2025-11-27 18:45:50.178633	2
10	35	1	2025-11-27 18:53:21.010476	PENDIENTE_ENTREGA	MEDIA	2025-11-27 18:53:21.011736	2025-11-27 18:53:21.011736	\N
11	36	1	2025-11-27 18:58:08.373924	PENDIENTE_ENTREGA	ALTA	2025-11-27 18:58:08.374933	2025-11-27 18:58:08.374933	\N
12	39	1	2025-11-27 19:12:59.257175	PENDIENTE_ENTREGA	MEDIA	2025-11-27 19:12:59.257175	2025-11-27 19:12:59.257175	\N
13	40	1	2025-11-27 19:24:14.390711	PENDIENTE_ENTREGA	MEDIA	2025-11-27 19:24:14.390711	2025-11-27 19:24:14.390711	\N
14	41	1	2025-11-27 19:24:52.28014	PENDIENTE_ENTREGA	MEDIA	2025-11-27 19:24:52.28014	2025-11-27 19:24:52.28014	\N
15	42	1	2025-11-27 19:37:20.841142	PENDIENTE_ENTREGA	MEDIA	2025-11-27 19:37:20.841142	2025-11-27 19:37:20.841142	\N
16	45	1	2025-11-27 21:41:14.820176	EN_RUTA	ALTA	2025-11-27 21:41:14.820176	2025-11-27 21:42:11.526317	1
\.


--
-- TOC entry 5475 (class 0 OID 36094)
-- Dependencies: 300
-- Data for Name: producto_proveedor; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.producto_proveedor (id_producto_proveedor, id_producto, id_proveedor, precio_referencial, moneda, tiempo_entrega_dias, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	2	1	3.50	PEN	7	t	2025-11-27 02:00:48.49207	2025-11-27 02:00:48.49207
2	3	2	2.15	PEN	5	t	2025-11-27 02:00:48.49207	2025-11-27 02:00:48.49207
3	2	2	3.60	PEN	10	t	2025-11-27 02:00:48.49207	2025-11-27 02:00:48.49207
\.


--
-- TOC entry 5471 (class 0 OID 36039)
-- Dependencies: 296
-- Data for Name: productos; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.productos (id_producto, nombre_producto, descripcion_producto, codigo_digemid, registro_sanitario, id_tipo, id_forma, condiciones_almacenamiento, condiciones_transporte, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Paracetamol 500mg	Tableta recubierta para el dolor y fiebre	DIG-001	RS-001	1	1	Ambiente	Estándar	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Ibuprofeno 400mg	Antiinflamatorio no esteroideo	DIG-002	RS-002	1	1	Ambiente	Estándar	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
3	Amoxicilina 500mg	Antibiótico de amplio espectro	DIG-003	RS-003	1	1	Fresco	Estándar	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5461 (class 0 OID 35954)
-- Dependencies: 286
-- Data for Name: proveedores; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.proveedores (id_proveedor, nombre_proveedor, ruc, direccion, telefono, correo, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Farmaindustria S.A.	20100100100	Av. Industrial 123	555-0101	contacto@farmaindustria.com	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Medifarma Global	20200200200	Calle Salud 456	555-0202	ventas@medifarma.com	t	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5477 (class 0 OID 36120)
-- Dependencies: 302
-- Data for Name: requerimientos; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.requerimientos (id_requerimiento, id_usuario_solicitante, id_departamento, fecha_solicitud, fecha_limite, prioridad, estado, observacion, fecha_creacion, fecha_actualizacion) FROM stdin;
2	1	1	2025-11-26	\N	ALTA	Pendiente	Requerimiento de Prueba	2025-11-26 21:49:54.884303	2025-11-26 21:49:54.884303
1	2	2	2025-11-26	2025-12-03	ALTA	ATENDIDO	Requerimiento urgente para urgencias	2025-11-26 11:32:20.2132	2025-11-26 22:50:42.335475
3	1	1	2025-11-26	\N	ALTA	PROCESADO	Caso A: Hay Stock (Paracetamol)	2025-11-26 23:14:34.368365	2025-11-26 23:16:29.401553
4	1	1	2025-11-26	\N	ALTA	PROCESADO	Caso B: Falta Stock (Ibuprofeno)	2025-11-26 23:15:01.788356	2025-11-26 23:16:33.012757
6	1	1	2025-11-26	\N	ALTA	PROCESADO	Falta de Stock	2025-11-26 23:42:10.173574	2025-11-26 23:42:21.181129
7	1	1	2025-11-26	\N	ALTA	PROCESADO	stock	2025-11-26 23:45:22.473038	2025-11-26 23:45:31.418834
8	1	1	2025-11-26	\N	ALTA	PROCESADO	stock	2025-11-26 23:50:45.332589	2025-11-26 23:50:49.422586
9	1	1	2025-11-26	\N	ALTA	PROCESADO	stock	2025-11-26 23:52:05.413935	2025-11-26 23:52:08.333393
10	1	1	2025-11-26	\N	MEDIA	PROCESADO	venta a la farmacia de al lado	2025-11-26 23:56:25.898468	2025-11-26 23:56:31.959582
11	1	1	2025-11-27	\N	ALTA	PROCESADO	Falta de Stock	2025-11-27 01:26:57.95876	2025-11-27 01:27:01.412546
12	1	1	2025-11-27	\N	MEDIA	PROCESADO	jnkml	2025-11-27 01:36:38.125062	2025-11-27 01:36:48.564875
13	1	1	2025-11-27	\N	MEDIA	PROCESADO	mkk	2025-11-27 01:52:15.256667	2025-11-27 01:52:30.131898
14	1	1	2025-11-27	\N	ALTA	PROCESADO	lmkml	2025-11-27 02:06:51.107694	2025-11-27 02:06:54.767371
15	1	1	2025-11-27	\N	MEDIA	PROCESADO	lkmklm\n	2025-11-27 02:07:47.218746	2025-11-27 02:07:51.550438
16	1	1	2025-11-27	\N	MEDIA	PROCESADO	km	2025-11-27 02:20:01.050193	2025-11-27 02:20:05.117137
17	1	1	2025-11-27	\N	MEDIA	PROCESADO	mnb	2025-11-27 02:30:48.51066	2025-11-27 02:30:52.046215
18	1	1	2025-11-27	\N	MEDIA	PROCESADO	jk	2025-11-27 02:35:20.656808	2025-11-27 02:35:23.63496
19	1	1	2025-11-27	\N	MEDIA	PROCESADO	as	2025-11-27 02:35:47.727027	2025-11-27 02:35:51.406948
20	1	1	2025-11-27	\N	MEDIA	PROCESADO	jn	2025-11-27 02:42:29.792561	2025-11-27 02:42:34.275772
21	1	1	2025-11-27	\N	ALTA	PROCESADO	mn	2025-11-27 02:50:11.325792	2025-11-27 02:50:14.842409
22	1	1	2025-11-27	\N	MEDIA	PROCESADO	jh	2025-11-27 02:56:50.859481	2025-11-27 02:56:54.389487
23	1	1	2025-11-27	\N	MEDIA	PROCESADO	kjjk	2025-11-27 03:03:40.982482	2025-11-27 03:03:45.106197
24	1	1	2025-11-27	\N	MEDIA	PROCESADO	j	2025-11-27 03:09:44.655205	2025-11-27 03:09:50.456409
25	1	1	2025-11-27	\N	ALTA	PROCESADO	a	2025-11-27 03:14:48.006288	2025-11-27 03:15:27.396207
26	1	1	2025-11-27	\N	ALTA	PROCESADO	farmacia 1	2025-11-27 03:17:56.788814	2025-11-27 03:18:01.733832
27	1	1	2025-11-27	\N	ALTA	PROCESADO	Falta de STOCK	2025-11-27 17:55:25.199267	2025-11-27 17:55:41.952327
28	1	1	2025-11-27	\N	BAJA	PROCESADO	afnaiusfnaiu	2025-11-27 18:04:07.753061	2025-11-27 18:04:12.960694
29	1	1	2025-11-27	\N	MEDIA	PROCESADO	hjbhj	2025-11-27 18:07:59.603047	2025-11-27 18:08:02.77795
30	1	1	2025-11-27	\N	MEDIA	PROCESADO	asfa	2025-11-27 18:18:18.912205	2025-11-27 18:18:22.838334
31	1	1	2025-11-27	\N	MEDIA	PROCESADO	sskanv	2025-11-27 18:20:40.098374	2025-11-27 18:20:43.279198
32	1	1	2025-11-27	\N	MEDIA	PROCESADO	sdfsdf	2025-11-27 18:25:02.85059	2025-11-27 18:25:06.991016
33	1	1	2025-11-27	\N	MEDIA	PROCESADO	asasfa	2025-11-27 18:25:50.858709	2025-11-27 18:25:53.526878
34	1	1	2025-11-27	\N	MEDIA	PROCESADO	asdad	2025-11-27 18:45:21.424875	2025-11-27 18:45:24.742352
35	1	1	2025-11-27	\N	MEDIA	PROCESADO	asda	2025-11-27 18:53:18.081722	2025-11-27 18:53:21.05491
36	1	1	2025-11-27	\N	ALTA	PROCESADO	adabhda	2025-11-27 18:58:05.52111	2025-11-27 18:58:08.393718
37	1	1	2025-11-27	\N	MEDIA	PROCESADO	kjsnfkjab	2025-11-27 19:00:30.553756	2025-11-27 19:00:33.334587
38	1	1	2025-11-27	\N	MEDIA	PROCESADO	asf akjf	2025-11-27 19:10:28.200708	2025-11-27 19:10:31.096838
39	1	1	2025-11-27	\N	MEDIA	PROCESADO	Falta de productos en la farmacia a	2025-11-27 19:12:56.079671	2025-11-27 19:12:59.281995
40	1	1	2025-11-27	\N	MEDIA	PROCESADO	anjajofns	2025-11-27 19:24:11.49874	2025-11-27 19:24:14.430556
41	1	1	2025-11-27	\N	MEDIA	PROCESADO	safakjsfn	2025-11-27 19:24:48.98034	2025-11-27 19:24:52.295243
42	1	1	2025-11-27	\N	MEDIA	PROCESADO	AFSKJFNAK	2025-11-27 19:37:17.542463	2025-11-27 19:37:20.875981
43	1	1	2025-11-27	\N	MEDIA	PROCESADO	JASDAY	2025-11-27 19:39:51.488268	2025-11-27 19:39:55.479085
44	1	1	2025-11-27	\N	MEDIA	PROCESADO	FJNFL	2025-11-27 19:41:23.196119	2025-11-27 19:41:26.34249
45	1	1	2025-11-27	\N	ALTA	PROCESADO	Requerimiento de el punto de venta interno a	2025-11-27 21:41:02.913808	2025-11-27 21:41:14.895829
46	1	1	2025-11-27	\N	ALTA	PROCESADO	falta de stock	2025-11-27 21:42:58.150702	2025-11-27 21:46:20.702924
\.


--
-- TOC entry 5453 (class 0 OID 35894)
-- Dependencies: 278
-- Data for Name: roles; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.roles (id_rol, nombre_rol, descripcion, fecha_creacion, fecha_actualizacion) FROM stdin;
1	ADMIN	Acceso Total	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
2	SOLICITANTE	Solo crea requerimientos	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
3	ALMACEN	Gestiona stock y distribución	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
4	COMPRAS	Gestiona proveedores y órdenes	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
\.


--
-- TOC entry 5483 (class 0 OID 36191)
-- Dependencies: 308
-- Data for Name: solicitud_compra; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.solicitud_compra (id_solicitud, id_requerimiento, id_usuario_solicitante, motivo, estado, productos_recibidos, fecha_solicitud, fecha_creacion, fecha_actualizacion) FROM stdin;
2	9	1	Stock insuficiente para producto: Amoxicilina 500mg	PENDIENTE_APROBACION	f	2025-11-26	2025-11-26 23:52:08.327229	2025-11-26 23:52:08.327229
1	8	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-26	2025-11-26 23:50:49.417586	2025-11-27 01:19:48.086293
3	11	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 01:27:01.40804	2025-11-27 01:27:15.025095
4	12	1	Stock insuficiente para producto: Amoxicilina 500mg	PENDIENTE_APROBACION	f	2025-11-27	2025-11-27 01:36:48.559207	2025-11-27 01:36:48.559207
5	13	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 01:52:30.117394	2025-11-27 01:52:56.325743
6	14	1	Stock insuficiente para producto: Amoxicilina 500mg	PENDIENTE_APROBACION	f	2025-11-27	2025-11-27 02:06:54.759282	2025-11-27 02:06:54.759282
7	15	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 02:07:51.543996	2025-11-27 02:08:10.557606
8	16	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 02:20:05.106413	2025-11-27 02:20:22.748018
9	17	1	Stock insuficiente para producto: Ibuprofeno 400mg	PENDIENTE_APROBACION	f	2025-11-27	2025-11-27 02:30:52.035223	2025-11-27 02:30:52.035223
10	18	1	Stock insuficiente para producto: Amoxicilina 500mg	PENDIENTE_APROBACION	f	2025-11-27	2025-11-27 02:35:23.624392	2025-11-27 02:35:23.624392
14	22	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 02:56:54.375784	2025-11-27 02:57:12.759044
16	24	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 03:09:50.448267	2025-11-27 03:11:25.708418
17	25	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 03:15:27.381035	2025-11-27 03:16:35.664576
18	27	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 17:55:41.942362	2025-11-27 17:55:53.679344
19	28	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 18:04:12.951605	2025-11-27 18:05:21.01341
15	23	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 03:03:45.096117	2025-11-27 18:05:38.721982
13	21	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 02:50:14.829694	2025-11-27 18:05:56.813687
12	20	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 02:42:34.265345	2025-11-27 18:06:13.601445
20	29	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 18:08:02.772405	2025-11-27 18:08:16.27201
21	30	1	Stock insuficiente para producto: Ibuprofeno 400mg	PENDIENTE_APROBACION	f	2025-11-27	2025-11-27 18:18:22.829379	2025-11-27 18:18:22.829379
23	37	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 19:00:33.329322	2025-11-27 19:00:40.748933
24	38	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 19:10:31.090824	2025-11-27 19:10:37.635699
11	19	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 02:35:51.400205	2025-11-27 19:37:47.925735
25	43	1	Stock insuficiente para producto: Amoxicilina 500mg	APROBADO	f	2025-11-27	2025-11-27 19:39:55.475329	2025-11-27 19:40:04.499801
26	44	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 19:41:26.340986	2025-11-27 19:41:32.935017
22	31	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 18:20:43.269374	2025-11-27 21:44:05.856322
27	46	1	Stock insuficiente para producto: Ibuprofeno 400mg	APROBADO	f	2025-11-27	2025-11-27 21:46:20.693948	2025-11-27 21:46:29.192953
\.


--
-- TOC entry 5457 (class 0 OID 35924)
-- Dependencies: 282
-- Data for Name: tipos_producto; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.tipos_producto (id_tipo, nombre_tipo, descripcion, fecha_creacion, fecha_actualizacion) FROM stdin;
1	Medicamento	Fármacos generales	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	Insumo Médico	Material descartable	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5467 (class 0 OID 35997)
-- Dependencies: 292
-- Data for Name: usuarios; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.usuarios (id_usuario, nombre_usuario, contrasena, correo, id_rol, activo, fecha_creacion, fecha_actualizacion) FROM stdin;
1	admin	123	admin@hospital.com	1	t	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
2	doc.juan	123	juan@hospital.com	2	t	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
3	jefe.almacen	123	almacen@hospital.com	3	t	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
4	jefe.compras	123	compras@hospital.com	4	t	2025-11-27 20:17:28.25562	2025-11-27 20:17:28.25562
\.


--
-- TOC entry 5465 (class 0 OID 35983)
-- Dependencies: 290
-- Data for Name: vehiculos; Type: TABLE DATA; Schema: farmacia; Owner: postgres
--

COPY farmacia.vehiculos (id_vehiculo, placa, marca, modelo, capacidad_carga, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
1	ABC-123	Toyota	HiAce	1000.00	Disponible	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
2	XYZ-789	Hyundai	H1	800.00	Disponible	2025-11-26 11:32:20.2132	2025-11-26 11:32:20.2132
\.


--
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 287
-- Name: almacenes_id_almacen_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.almacenes_id_almacen_seq', 2, true);


--
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 279
-- Name: areas_id_area_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.areas_id_area_seq', 2, true);


--
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 293
-- Name: departamentos_id_departamento_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.departamentos_id_departamento_seq', 3, true);


--
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 321
-- Name: detalle_orden_compra_id_detalle_orden_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.detalle_orden_compra_id_detalle_orden_seq', 24, true);


--
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 315
-- Name: detalle_orden_distribucion_id_detalle_dist_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.detalle_orden_distribucion_id_detalle_dist_seq', 10, true);


--
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 305
-- Name: detalle_requerimiento_id_detalle_requerimiento_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.detalle_requerimiento_id_detalle_requerimiento_seq', 45, true);


--
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 311
-- Name: detalle_solicitud_compra_id_detalle_solicitud_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.detalle_solicitud_compra_id_detalle_solicitud_seq', 23, true);


--
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 283
-- Name: formas_farmaceuticas_id_forma_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.formas_farmaceuticas_id_forma_seq', 3, true);


--
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 317
-- Name: incidencias_transporte_id_incidencia_transporte_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.incidencias_transporte_id_incidencia_transporte_seq', 1, false);


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 303
-- Name: inventario_id_inventario_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.inventario_id_inventario_seq', 2, true);


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 297
-- Name: lotes_producto_id_lote_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.lotes_producto_id_lote_seq', 3, true);


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 319
-- Name: movimiento_inventario_id_movimiento_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.movimiento_inventario_id_movimiento_seq', 9, true);


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 313
-- Name: ordenes_compra_id_orden_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.ordenes_compra_id_orden_seq', 25, true);


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 309
-- Name: ordenes_distribucion_id_orden_dist_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.ordenes_distribucion_id_orden_dist_seq', 16, true);


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 299
-- Name: producto_proveedor_id_producto_proveedor_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.producto_proveedor_id_producto_proveedor_seq', 3, true);


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 295
-- Name: productos_id_producto_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.productos_id_producto_seq', 3, true);


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 285
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.proveedores_id_proveedor_seq', 2, true);


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 301
-- Name: requerimientos_id_requerimiento_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.requerimientos_id_requerimiento_seq', 46, true);


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 277
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.roles_id_rol_seq', 1, false);


--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 307
-- Name: solicitud_compra_id_solicitud_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.solicitud_compra_id_solicitud_seq', 27, true);


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 281
-- Name: tipos_producto_id_tipo_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.tipos_producto_id_tipo_seq', 2, true);


--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 291
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.usuarios_id_usuario_seq', 4, true);


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 289
-- Name: vehiculos_id_vehiculo_seq; Type: SEQUENCE SET; Schema: farmacia; Owner: postgres
--

SELECT pg_catalog.setval('farmacia.vehiculos_id_vehiculo_seq', 2, true);


--
-- TOC entry 5206 (class 2606 OID 35981)
-- Name: almacenes almacenes_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.almacenes
    ADD CONSTRAINT almacenes_pkey PRIMARY KEY (id_almacen);


--
-- TOC entry 5190 (class 2606 OID 35922)
-- Name: areas areas_nombre_area_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.areas
    ADD CONSTRAINT areas_nombre_area_key UNIQUE (nombre_area);


--
-- TOC entry 5192 (class 2606 OID 35920)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id_area);


--
-- TOC entry 5218 (class 2606 OID 36032)
-- Name: departamentos departamentos_nombre_departamento_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.departamentos
    ADD CONSTRAINT departamentos_nombre_departamento_key UNIQUE (nombre_departamento);


--
-- TOC entry 5220 (class 2606 OID 36030)
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id_departamento);


--
-- TOC entry 5268 (class 2606 OID 36385)
-- Name: detalle_orden_compra detalle_orden_compra_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_pkey PRIMARY KEY (id_detalle_orden);


--
-- TOC entry 5262 (class 2606 OID 36303)
-- Name: detalle_orden_distribucion detalle_orden_distribucion_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_distribucion
    ADD CONSTRAINT detalle_orden_distribucion_pkey PRIMARY KEY (id_detalle_dist);


--
-- TOC entry 5250 (class 2606 OID 36179)
-- Name: detalle_requerimiento detalle_requerimiento_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_requerimiento
    ADD CONSTRAINT detalle_requerimiento_pkey PRIMARY KEY (id_detalle_requerimiento);


--
-- TOC entry 5256 (class 2606 OID 36243)
-- Name: detalle_solicitud_compra detalle_solicitud_compra_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_solicitud_compra
    ADD CONSTRAINT detalle_solicitud_compra_pkey PRIMARY KEY (id_detalle_solicitud);


--
-- TOC entry 5198 (class 2606 OID 35952)
-- Name: formas_farmaceuticas formas_farmaceuticas_nombre_forma_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.formas_farmaceuticas
    ADD CONSTRAINT formas_farmaceuticas_nombre_forma_key UNIQUE (nombre_forma);


--
-- TOC entry 5200 (class 2606 OID 35950)
-- Name: formas_farmaceuticas formas_farmaceuticas_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.formas_farmaceuticas
    ADD CONSTRAINT formas_farmaceuticas_pkey PRIMARY KEY (id_forma);


--
-- TOC entry 5264 (class 2606 OID 36333)
-- Name: incidencias_transporte incidencias_transporte_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte
    ADD CONSTRAINT incidencias_transporte_pkey PRIMARY KEY (id_incidencia_transporte);


--
-- TOC entry 5244 (class 2606 OID 36155)
-- Name: inventario inventario_id_almacen_id_lote_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario
    ADD CONSTRAINT inventario_id_almacen_id_lote_key UNIQUE (id_almacen, id_lote);


--
-- TOC entry 5246 (class 2606 OID 36153)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);


--
-- TOC entry 5230 (class 2606 OID 36087)
-- Name: lotes_producto lotes_producto_id_producto_numero_lote_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.lotes_producto
    ADD CONSTRAINT lotes_producto_id_producto_numero_lote_key UNIQUE (id_producto, numero_lote);


--
-- TOC entry 5232 (class 2606 OID 36085)
-- Name: lotes_producto lotes_producto_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.lotes_producto
    ADD CONSTRAINT lotes_producto_pkey PRIMARY KEY (id_lote);


--
-- TOC entry 5266 (class 2606 OID 36366)
-- Name: movimiento_inventario movimiento_inventario_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.movimiento_inventario
    ADD CONSTRAINT movimiento_inventario_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 5258 (class 2606 OID 36279)
-- Name: ordenes_compra ordenes_compra_numero_orden_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_compra
    ADD CONSTRAINT ordenes_compra_numero_orden_key UNIQUE (numero_orden);


--
-- TOC entry 5260 (class 2606 OID 36277)
-- Name: ordenes_compra ordenes_compra_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_compra
    ADD CONSTRAINT ordenes_compra_pkey PRIMARY KEY (id_orden);


--
-- TOC entry 5254 (class 2606 OID 36225)
-- Name: ordenes_distribucion ordenes_distribucion_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_distribucion
    ADD CONSTRAINT ordenes_distribucion_pkey PRIMARY KEY (id_orden_dist);


--
-- TOC entry 5236 (class 2606 OID 36108)
-- Name: producto_proveedor producto_proveedor_id_producto_id_proveedor_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor
    ADD CONSTRAINT producto_proveedor_id_producto_id_proveedor_key UNIQUE (id_producto, id_proveedor);


--
-- TOC entry 5238 (class 2606 OID 36106)
-- Name: producto_proveedor producto_proveedor_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor
    ADD CONSTRAINT producto_proveedor_pkey PRIMARY KEY (id_producto_proveedor);


--
-- TOC entry 5222 (class 2606 OID 36057)
-- Name: productos productos_codigo_digemid_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_codigo_digemid_key UNIQUE (codigo_digemid);


--
-- TOC entry 5224 (class 2606 OID 36055)
-- Name: productos productos_nombre_producto_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_nombre_producto_key UNIQUE (nombre_producto);


--
-- TOC entry 5226 (class 2606 OID 36053)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 5228 (class 2606 OID 36059)
-- Name: productos productos_registro_sanitario_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_registro_sanitario_key UNIQUE (registro_sanitario);


--
-- TOC entry 5202 (class 2606 OID 35967)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 5204 (class 2606 OID 35969)
-- Name: proveedores proveedores_ruc_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.proveedores
    ADD CONSTRAINT proveedores_ruc_key UNIQUE (ruc);


--
-- TOC entry 5242 (class 2606 OID 36135)
-- Name: requerimientos requerimientos_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.requerimientos
    ADD CONSTRAINT requerimientos_pkey PRIMARY KEY (id_requerimiento);


--
-- TOC entry 5186 (class 2606 OID 35907)
-- Name: roles roles_nombre_rol_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.roles
    ADD CONSTRAINT roles_nombre_rol_key UNIQUE (nombre_rol);


--
-- TOC entry 5188 (class 2606 OID 35905)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 5252 (class 2606 OID 36206)
-- Name: solicitud_compra solicitud_compra_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.solicitud_compra
    ADD CONSTRAINT solicitud_compra_pkey PRIMARY KEY (id_solicitud);


--
-- TOC entry 5194 (class 2606 OID 35937)
-- Name: tipos_producto tipos_producto_nombre_tipo_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.tipos_producto
    ADD CONSTRAINT tipos_producto_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- TOC entry 5196 (class 2606 OID 35935)
-- Name: tipos_producto tipos_producto_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.tipos_producto
    ADD CONSTRAINT tipos_producto_pkey PRIMARY KEY (id_tipo);


--
-- TOC entry 5234 (class 2606 OID 36408)
-- Name: lotes_producto uk2pbpmvk8uq1i6gj4bwd8r2lid; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.lotes_producto
    ADD CONSTRAINT uk2pbpmvk8uq1i6gj4bwd8r2lid UNIQUE (id_producto, numero_lote);


--
-- TOC entry 5240 (class 2606 OID 36410)
-- Name: producto_proveedor uk32ev168trbwyahedpvlr5eqx3; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor
    ADD CONSTRAINT uk32ev168trbwyahedpvlr5eqx3 UNIQUE (id_producto, id_proveedor);


--
-- TOC entry 5248 (class 2606 OID 36406)
-- Name: inventario uknjh82702j9dlejg5omq2fye1b; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario
    ADD CONSTRAINT uknjh82702j9dlejg5omq2fye1b UNIQUE (id_almacen, id_lote);


--
-- TOC entry 5212 (class 2606 OID 36014)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 5214 (class 2606 OID 36012)
-- Name: usuarios usuarios_nombre_usuario_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- TOC entry 5216 (class 2606 OID 36010)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 5208 (class 2606 OID 35993)
-- Name: vehiculos vehiculos_pkey; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (id_vehiculo);


--
-- TOC entry 5210 (class 2606 OID 35995)
-- Name: vehiculos vehiculos_placa_key; Type: CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.vehiculos
    ADD CONSTRAINT vehiculos_placa_key UNIQUE (placa);


--
-- TOC entry 5270 (class 2606 OID 36033)
-- Name: departamentos departamentos_id_area_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.departamentos
    ADD CONSTRAINT departamentos_id_area_fkey FOREIGN KEY (id_area) REFERENCES farmacia.areas(id_area);


--
-- TOC entry 5297 (class 2606 OID 36396)
-- Name: detalle_orden_compra detalle_orden_compra_id_detalle_solicitud_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_id_detalle_solicitud_fkey FOREIGN KEY (id_detalle_solicitud) REFERENCES farmacia.detalle_solicitud_compra(id_detalle_solicitud);


--
-- TOC entry 5298 (class 2606 OID 36386)
-- Name: detalle_orden_compra detalle_orden_compra_id_orden_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_id_orden_fkey FOREIGN KEY (id_orden) REFERENCES farmacia.ordenes_compra(id_orden);


--
-- TOC entry 5299 (class 2606 OID 36391)
-- Name: detalle_orden_compra detalle_orden_compra_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra
    ADD CONSTRAINT detalle_orden_compra_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5289 (class 2606 OID 36314)
-- Name: detalle_orden_distribucion detalle_orden_distribucion_id_lote_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_distribucion
    ADD CONSTRAINT detalle_orden_distribucion_id_lote_fkey FOREIGN KEY (id_lote) REFERENCES farmacia.lotes_producto(id_lote);


--
-- TOC entry 5290 (class 2606 OID 36304)
-- Name: detalle_orden_distribucion detalle_orden_distribucion_id_orden_dist_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_distribucion
    ADD CONSTRAINT detalle_orden_distribucion_id_orden_dist_fkey FOREIGN KEY (id_orden_dist) REFERENCES farmacia.ordenes_distribucion(id_orden_dist);


--
-- TOC entry 5291 (class 2606 OID 36309)
-- Name: detalle_orden_distribucion detalle_orden_distribucion_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_distribucion
    ADD CONSTRAINT detalle_orden_distribucion_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5279 (class 2606 OID 36185)
-- Name: detalle_requerimiento detalle_requerimiento_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_requerimiento
    ADD CONSTRAINT detalle_requerimiento_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5280 (class 2606 OID 36180)
-- Name: detalle_requerimiento detalle_requerimiento_id_requerimiento_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_requerimiento
    ADD CONSTRAINT detalle_requerimiento_id_requerimiento_fkey FOREIGN KEY (id_requerimiento) REFERENCES farmacia.requerimientos(id_requerimiento);


--
-- TOC entry 5284 (class 2606 OID 36254)
-- Name: detalle_solicitud_compra detalle_solicitud_compra_id_detalle_requerimiento_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_solicitud_compra
    ADD CONSTRAINT detalle_solicitud_compra_id_detalle_requerimiento_fkey FOREIGN KEY (id_detalle_requerimiento) REFERENCES farmacia.detalle_requerimiento(id_detalle_requerimiento);


--
-- TOC entry 5285 (class 2606 OID 36249)
-- Name: detalle_solicitud_compra detalle_solicitud_compra_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_solicitud_compra
    ADD CONSTRAINT detalle_solicitud_compra_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5286 (class 2606 OID 36244)
-- Name: detalle_solicitud_compra detalle_solicitud_compra_id_solicitud_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_solicitud_compra
    ADD CONSTRAINT detalle_solicitud_compra_id_solicitud_fkey FOREIGN KEY (id_solicitud) REFERENCES farmacia.solicitud_compra(id_solicitud);


--
-- TOC entry 5282 (class 2606 OID 36417)
-- Name: ordenes_distribucion fkf4pdeb15esm4w4hcj2eqwghck; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_distribucion
    ADD CONSTRAINT fkf4pdeb15esm4w4hcj2eqwghck FOREIGN KEY (id_vehiculo) REFERENCES farmacia.vehiculos(id_vehiculo);


--
-- TOC entry 5300 (class 2606 OID 36412)
-- Name: detalle_orden_compra fki83njxer6avlw8r40wwvf51qh; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.detalle_orden_compra
    ADD CONSTRAINT fki83njxer6avlw8r40wwvf51qh FOREIGN KEY (id_detalle_solicitud) REFERENCES farmacia.detalle_requerimiento(id_detalle_requerimiento);


--
-- TOC entry 5292 (class 2606 OID 36344)
-- Name: incidencias_transporte incidencias_transporte_id_detalle_dist_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte
    ADD CONSTRAINT incidencias_transporte_id_detalle_dist_fkey FOREIGN KEY (id_detalle_dist) REFERENCES farmacia.detalle_orden_distribucion(id_detalle_dist);


--
-- TOC entry 5293 (class 2606 OID 36339)
-- Name: incidencias_transporte incidencias_transporte_id_orden_dist_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte
    ADD CONSTRAINT incidencias_transporte_id_orden_dist_fkey FOREIGN KEY (id_orden_dist) REFERENCES farmacia.ordenes_distribucion(id_orden_dist);


--
-- TOC entry 5294 (class 2606 OID 36349)
-- Name: incidencias_transporte incidencias_transporte_id_usuario_reporta_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte
    ADD CONSTRAINT incidencias_transporte_id_usuario_reporta_fkey FOREIGN KEY (id_usuario_reporta) REFERENCES farmacia.usuarios(id_usuario);


--
-- TOC entry 5295 (class 2606 OID 36334)
-- Name: incidencias_transporte incidencias_transporte_id_vehiculo_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.incidencias_transporte
    ADD CONSTRAINT incidencias_transporte_id_vehiculo_fkey FOREIGN KEY (id_vehiculo) REFERENCES farmacia.vehiculos(id_vehiculo);


--
-- TOC entry 5277 (class 2606 OID 36156)
-- Name: inventario inventario_id_almacen_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario
    ADD CONSTRAINT inventario_id_almacen_fkey FOREIGN KEY (id_almacen) REFERENCES farmacia.almacenes(id_almacen);


--
-- TOC entry 5278 (class 2606 OID 36161)
-- Name: inventario inventario_id_lote_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.inventario
    ADD CONSTRAINT inventario_id_lote_fkey FOREIGN KEY (id_lote) REFERENCES farmacia.lotes_producto(id_lote);


--
-- TOC entry 5273 (class 2606 OID 36088)
-- Name: lotes_producto lotes_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.lotes_producto
    ADD CONSTRAINT lotes_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5296 (class 2606 OID 36367)
-- Name: movimiento_inventario movimiento_inventario_id_inventario_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.movimiento_inventario
    ADD CONSTRAINT movimiento_inventario_id_inventario_fkey FOREIGN KEY (id_inventario) REFERENCES farmacia.inventario(id_inventario);


--
-- TOC entry 5287 (class 2606 OID 36285)
-- Name: ordenes_compra ordenes_compra_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_compra
    ADD CONSTRAINT ordenes_compra_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES farmacia.proveedores(id_proveedor);


--
-- TOC entry 5288 (class 2606 OID 36280)
-- Name: ordenes_compra ordenes_compra_id_solicitud_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_compra
    ADD CONSTRAINT ordenes_compra_id_solicitud_fkey FOREIGN KEY (id_solicitud) REFERENCES farmacia.solicitud_compra(id_solicitud);


--
-- TOC entry 5283 (class 2606 OID 36226)
-- Name: ordenes_distribucion ordenes_distribucion_id_requerimiento_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.ordenes_distribucion
    ADD CONSTRAINT ordenes_distribucion_id_requerimiento_fkey FOREIGN KEY (id_requerimiento) REFERENCES farmacia.requerimientos(id_requerimiento);


--
-- TOC entry 5274 (class 2606 OID 36109)
-- Name: producto_proveedor producto_proveedor_id_producto_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor
    ADD CONSTRAINT producto_proveedor_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES farmacia.productos(id_producto);


--
-- TOC entry 5275 (class 2606 OID 36114)
-- Name: producto_proveedor producto_proveedor_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.producto_proveedor
    ADD CONSTRAINT producto_proveedor_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES farmacia.proveedores(id_proveedor);


--
-- TOC entry 5271 (class 2606 OID 36065)
-- Name: productos productos_id_forma_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_id_forma_fkey FOREIGN KEY (id_forma) REFERENCES farmacia.formas_farmaceuticas(id_forma);


--
-- TOC entry 5272 (class 2606 OID 36060)
-- Name: productos productos_id_tipo_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.productos
    ADD CONSTRAINT productos_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES farmacia.tipos_producto(id_tipo);


--
-- TOC entry 5276 (class 2606 OID 36136)
-- Name: requerimientos requerimientos_id_departamento_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.requerimientos
    ADD CONSTRAINT requerimientos_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES farmacia.departamentos(id_departamento);


--
-- TOC entry 5281 (class 2606 OID 36207)
-- Name: solicitud_compra solicitud_compra_id_requerimiento_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.solicitud_compra
    ADD CONSTRAINT solicitud_compra_id_requerimiento_fkey FOREIGN KEY (id_requerimiento) REFERENCES farmacia.requerimientos(id_requerimiento);


--
-- TOC entry 5269 (class 2606 OID 36015)
-- Name: usuarios usuarios_id_rol_fkey; Type: FK CONSTRAINT; Schema: farmacia; Owner: postgres
--

ALTER TABLE ONLY farmacia.usuarios
    ADD CONSTRAINT usuarios_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES farmacia.roles(id_rol);


-- Completed on 2025-11-28 06:21:51

--
-- PostgreSQL database dump complete
--

\unrestrict YunnUpAUNhKsyj8Ft3NHbcAT3oc0PXYg4nmkzFSZ4Q0oF0HIZDCUOu2NdKdURl0


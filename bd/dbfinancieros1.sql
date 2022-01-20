--
-- PostgreSQL database dump
--

-- Dumped from database version 10.16
-- Dumped by pg_dump version 13.2

-- Started on 2021-04-23 21:56:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 534 (class 1247 OID 16904)
-- Name: activo_baja_motivo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.activo_baja_motivo AS ENUM (
    'DONADO',
    'DESECHADO',
    'VENDIDO'
);


ALTER TYPE public.activo_baja_motivo OWNER TO postgres;

--
-- TOC entry 537 (class 1247 OID 16912)
-- Name: credito_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.credito_estado AS ENUM (
    'POR_APROBAR',
    'EN_CURSO',
    'EN_MORA',
    'INCOBRABLE',
    'FINALIZADO',
    'REFINANCIADO'
);


ALTER TYPE public.credito_estado OWNER TO postgres;

--
-- TOC entry 719 (class 1247 OID 17325)
-- Name: credito_tipo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.credito_tipo AS ENUM (
    'HIPOTECARIO',
    'COMERCIAL',
    'CONSUMO'
);


ALTER TYPE public.credito_tipo OWNER TO postgres;

--
-- TOC entry 619 (class 1247 OID 16936)
-- Name: estado_civil; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.estado_civil AS ENUM (
    'SOLTERO',
    'CASADO',
    'VIUDO',
    'DIVORCIADO'
);


ALTER TYPE public.estado_civil OWNER TO postgres;

--
-- TOC entry 622 (class 1247 OID 16946)
-- Name: genero; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.genero AS ENUM (
    'MASCULINO',
    'FEMENINO'
);


ALTER TYPE public.genero OWNER TO postgres;

--
-- TOC entry 625 (class 1247 OID 16952)
-- Name: tipo_activo_fijo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_activo_fijo AS ENUM (
    'TERRENO',
    'SOFTWARE',
    'MAQUINARIA',
    'MOBILIARIO'
);


ALTER TYPE public.tipo_activo_fijo OWNER TO postgres;

--
-- TOC entry 628 (class 1247 OID 16962)
-- Name: tipo_adquisicion; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_adquisicion AS ENUM (
    'COMPRADO_NUEVO',
    'COMPRADO_USADO',
    'DONADO_NUEVO',
    'DONADO_USADO'
);


ALTER TYPE public.tipo_adquisicion OWNER TO postgres;

--
-- TOC entry 631 (class 1247 OID 16972)
-- Name: tipo_bien_garantia; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_bien_garantia AS ENUM (
    'TERRENO',
    'MOTOCICLETA',
    'VEHICULO',
    'MAQUINARIA'
);


ALTER TYPE public.tipo_bien_garantia OWNER TO postgres;

--
-- TOC entry 701 (class 1247 OID 17252)
-- Name: tipo_calculo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_calculo AS ENUM (
    'DEPRECIA',
    'AMORTIZA',
    'NA'
);


ALTER TYPE public.tipo_calculo OWNER TO postgres;

--
-- TOC entry 634 (class 1247 OID 16982)
-- Name: tipo_contacto; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_contacto AS ENUM (
    'CASA',
    'PERSONAL',
    'TRABAJO',
    'OTRO'
);


ALTER TYPE public.tipo_contacto OWNER TO postgres;

--
-- TOC entry 637 (class 1247 OID 16992)
-- Name: tipo_persona; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_persona AS ENUM (
    'PERSONA',
    'EMPRESA'
);


ALTER TYPE public.tipo_persona OWNER TO postgres;

--
-- TOC entry 640 (class 1247 OID 16998)
-- Name: tipo_usuario; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_usuario AS ENUM (
    'ADMINISTRADOR',
    'ASESOR',
    'COBRO',
    'ENCARGADO_ACTIVO_FIJO'
);


ALTER TYPE public.tipo_usuario OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 220 (class 1259 OID 17261)
-- Name: activo_fijo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activo_fijo (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    codigo_tipo_activo integer NOT NULL
);


ALTER TABLE public.activo_fijo OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17259)
-- Name: activo_fijo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activo_fijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activo_fijo_id_seq OWNER TO postgres;

--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 219
-- Name: activo_fijo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activo_fijo_id_seq OWNED BY public.activo_fijo.id;


--
-- TOC entry 222 (class 1259 OID 17274)
-- Name: adquisicion_activo_fijo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adquisicion_activo_fijo (
    id integer NOT NULL,
    id_activo integer NOT NULL,
    fecha date NOT NULL,
    descripcion character varying(800) NOT NULL,
    tipo_adquisicion public.tipo_adquisicion NOT NULL,
    precio_unidad double precision NOT NULL,
    codigo_unidad integer NOT NULL,
    codigo_departamento integer NOT NULL,
    nit_usuario character varying(17) NOT NULL,
    vida_util integer
);


ALTER TABLE public.adquisicion_activo_fijo OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17272)
-- Name: adquisicion_activo_fijo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adquisicion_activo_fijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adquisicion_activo_fijo_id_seq OWNER TO postgres;

--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 221
-- Name: adquisicion_activo_fijo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adquisicion_activo_fijo_id_seq OWNED BY public.adquisicion_activo_fijo.id;


--
-- TOC entry 225 (class 1259 OID 17302)
-- Name: baja_activo_fijo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.baja_activo_fijo (
    id integer NOT NULL,
    fecha date NOT NULL,
    motivo public.activo_baja_motivo NOT NULL
);


ALTER TABLE public.baja_activo_fijo OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17300)
-- Name: baja_activo_fijo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.baja_activo_fijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.baja_activo_fijo_id_seq OWNER TO postgres;

--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 224
-- Name: baja_activo_fijo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.baja_activo_fijo_id_seq OWNED BY public.baja_activo_fijo.id;


--
-- TOC entry 196 (class 1259 OID 17015)
-- Name: bien_garantia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bien_garantia (
    codigo character varying(30) NOT NULL,
    descripcion character varying(300) NOT NULL,
    valorado_en double precision,
    tipo_bien public.tipo_bien_garantia NOT NULL
);


ALTER TABLE public.bien_garantia OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 17021)
-- Name: credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credito (
    id integer NOT NULL,
    monto double precision NOT NULL,
    fecha_solicitud date NOT NULL,
    fecha_aprobacion date,
    fecha_cancelado date,
    estado public.credito_estado NOT NULL,
    nit_usuario character varying(17) NOT NULL,
    id_politica integer NOT NULL,
    para public.tipo_persona NOT NULL,
    puntos integer NOT NULL,
    tiempo integer NOT NULL
);


ALTER TABLE public.credito OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 17024)
-- Name: credito_bien_garantia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credito_bien_garantia (
    id_credito integer NOT NULL,
    codigo_bien character varying(30) NOT NULL
);


ALTER TABLE public.credito_bien_garantia OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17027)
-- Name: credito_empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credito_empresa (
    id_credito integer NOT NULL,
    nit_empresa character varying(17) NOT NULL
);


ALTER TABLE public.credito_empresa OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17030)
-- Name: credito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credito_id_seq OWNER TO postgres;

--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 201
-- Name: credito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credito_id_seq OWNED BY public.credito.id;


--
-- TOC entry 202 (class 1259 OID 17032)
-- Name: credito_persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credito_persona (
    nit_solicitante character varying(17) NOT NULL,
    id_credito integer NOT NULL
);


ALTER TABLE public.credito_persona OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 17018)
-- Name: cuota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuota (
    numero integer NOT NULL,
    id_credito integer NOT NULL,
    capital_amortizado double precision NOT NULL,
    interes double precision NOT NULL,
    mora double precision NOT NULL,
    fecha_correspondiente date NOT NULL,
    dias_antes_despues integer
);


ALTER TABLE public.cuota OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17035)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL,
    codigo_unidad integer NOT NULL
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17295)
-- Name: detalle_activo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_activo (
    id_adquisicion integer NOT NULL,
    correlativo integer NOT NULL,
    id_baja integer,
    precio double precision
);


ALTER TABLE public.detalle_activo OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17038)
-- Name: direccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direccion (
    id integer NOT NULL,
    direccion character varying(300) NOT NULL,
    codigo_ubicacion character varying(8) NOT NULL
);


ALTER TABLE public.direccion OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17041)
-- Name: direccion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.direccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.direccion_id_seq OWNER TO postgres;

--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 205
-- Name: direccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.direccion_id_seq OWNED BY public.direccion.id;


--
-- TOC entry 206 (class 1259 OID 17043)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    nit character varying(17) NOT NULL,
    nit_representante character varying(17) NOT NULL,
    nombre character varying(150) NOT NULL
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17046)
-- Name: garantia_fiador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garantia_fiador (
    id_credito_persona integer NOT NULL,
    nit_fiador character varying(17) NOT NULL,
    id_ingreso_egreso integer
);


ALTER TABLE public.garantia_fiador OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17049)
-- Name: ingreso_egreso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingreso_egreso (
    ingresos_totales double precision NOT NULL,
    otros_ingresos double precision NOT NULL,
    ocupacion character varying(30) NOT NULL,
    nota character varying(250) NOT NULL,
    id integer NOT NULL,
    egresos double precision NOT NULL
);


ALTER TABLE public.ingreso_egreso OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17052)
-- Name: ingreso_egreso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingreso_egreso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingreso_egreso_id_seq OWNER TO postgres;

--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 209
-- Name: ingreso_egreso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingreso_egreso_id_seq OWNED BY public.ingreso_egreso.id;


--
-- TOC entry 210 (class 1259 OID 17054)
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    nit character varying(17) NOT NULL,
    id_direccion integer NOT NULL,
    tipo_persona public.tipo_persona NOT NULL
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17057)
-- Name: persona_natural; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona_natural (
    dui character varying(10) NOT NULL,
    nit character varying(17) NOT NULL,
    nombres character varying(30) NOT NULL,
    apellidos character varying(30) NOT NULL,
    estado_civil public.estado_civil NOT NULL,
    genero public.genero NOT NULL,
    fecha_nacimiento date NOT NULL
);


ALTER TABLE public.persona_natural OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17060)
-- Name: politica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.politica (
    fecha_establecimiento date NOT NULL,
    tasa_interes double precision NOT NULL,
    tasa_mora double precision NOT NULL,
    dias_cobro integer NOT NULL,
    fecha_finalizacion date NOT NULL,
    id integer NOT NULL,
    monto_inferior double precision NOT NULL,
    monto_superior double precision NOT NULL,
    tiempo_inferior integer,
    gastos_tramitacion double precision NOT NULL,
    gastos_notario double precision NOT NULL,
    otras_comisiones double precision,
    tiempo_superior integer NOT NULL,
    tipo_credito public.credito_tipo NOT NULL
);


ALTER TABLE public.politica OWNER TO postgres;

--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN politica.tiempo_inferior; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.politica.tiempo_inferior IS 'el credito se otorga para determinado tiempo estipulado en meses';


--
-- TOC entry 213 (class 1259 OID 17063)
-- Name: politica_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.politica_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.politica_id_seq OWNER TO postgres;

--
-- TOC entry 3791 (class 0 OID 0)
-- Dependencies: 213
-- Name: politica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.politica_id_seq OWNED BY public.politica.id;


--
-- TOC entry 214 (class 1259 OID 17065)
-- Name: telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono (
    nit character varying(17) NOT NULL,
    tipo_contacto public.tipo_contacto NOT NULL,
    telefono character varying(9) NOT NULL
);


ALTER TABLE public.telefono OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17068)
-- Name: tipo_activo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_activo (
    codigo integer NOT NULL,
    tipo_calculo public.tipo_calculo,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.tipo_activo OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17071)
-- Name: ubicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ubicacion (
    codigo character varying(8) NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.ubicacion OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17074)
-- Name: unidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidad (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.unidad OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17077)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    tipo public.tipo_usuario NOT NULL,
    nombre character varying(30) NOT NULL,
    clave character varying(300) NOT NULL,
    nit character varying(17) NOT NULL,
    salt character varying(1024) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 3546 (class 2604 OID 17264)
-- Name: activo_fijo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activo_fijo ALTER COLUMN id SET DEFAULT nextval('public.activo_fijo_id_seq'::regclass);


--
-- TOC entry 3547 (class 2604 OID 17277)
-- Name: adquisicion_activo_fijo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_activo_fijo ALTER COLUMN id SET DEFAULT nextval('public.adquisicion_activo_fijo_id_seq'::regclass);


--
-- TOC entry 3548 (class 2604 OID 17305)
-- Name: baja_activo_fijo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baja_activo_fijo ALTER COLUMN id SET DEFAULT nextval('public.baja_activo_fijo_id_seq'::regclass);


--
-- TOC entry 3542 (class 2604 OID 17082)
-- Name: credito id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito ALTER COLUMN id SET DEFAULT nextval('public.credito_id_seq'::regclass);


--
-- TOC entry 3543 (class 2604 OID 17083)
-- Name: direccion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion ALTER COLUMN id SET DEFAULT nextval('public.direccion_id_seq'::regclass);


--
-- TOC entry 3544 (class 2604 OID 17084)
-- Name: ingreso_egreso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_egreso ALTER COLUMN id SET DEFAULT nextval('public.ingreso_egreso_id_seq'::regclass);


--
-- TOC entry 3545 (class 2604 OID 17085)
-- Name: politica id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.politica ALTER COLUMN id SET DEFAULT nextval('public.politica_id_seq'::regclass);


--
-- TOC entry 3772 (class 0 OID 17261)
-- Dependencies: 220
-- Data for Name: activo_fijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activo_fijo (id, nombre, codigo_tipo_activo) FROM stdin;
1	Silla Plastica	5
2	Escritorio	5
5	Impresora	6
6	Edificio	2
7	Computadora	6
8	Moto	7
9	Impresora	6
10	licencia de ofimatica	13
\.


--
-- TOC entry 3774 (class 0 OID 17274)
-- Dependencies: 222
-- Data for Name: adquisicion_activo_fijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adquisicion_activo_fijo (id, id_activo, fecha, descripcion, tipo_adquisicion, precio_unidad, codigo_unidad, codigo_departamento, nit_usuario, vida_util) FROM stdin;
5	1	2021-01-01	Una descripcion breve	COMPRADO_NUEVO	10	1	1	10102410961011	2
6	2	2020-11-30	Marca: Muebles Cue\nColor: Negro\nModelo: ES0053\nMaterial: Melamina\nLargo: 120 cm\nAltura*Ancho: 72 cm X 48 cm	COMPRADO_NUEVO	2000	1	2	10000904901016	60
7	2	2020-12-06	Marca: Haken Haus\nColor: Blanco\nModelo:  HH-HO-EB12060L\nMaterial: Melamina\nLargo: 120 cm\nAltura*Ancho*Profundidad: 75 cm X 120 cm X 60 cm	COMPRADO_USADO	1549	1	2	10000904901016	36
9	7	2021-01-02	Marca HP\nSistema operativo Windows® 7 Professional 32\nProcesador AMD Dual-Core E-450 (1,65 GHz, caché L2 de 1 MB)\nChipset AMD A45 FCH\nFactor de forma Todo en Uno\nMemoria, estándar SDRAM DDR3 de 2 GB, 1333 MHz\nDescripción del disco duro SATA 3.0 Gb/s de 500 GB, 7200 rpm\nUnidad óptica Grabadora SATA de DVD SuperMulti delgada\nMonitor Widescreen HD CCFL, antirreflejo con 18,5" de diagonal; ángulo de visualización: 90° horizontal, 50° vertical (1366 x 768)	COMPRADO_NUEVO	3700	1	4	10102410961011	60
12	5	2020-12-15	Wi-Fi No\nLargo del Producto Armado 13 cm\nTipo de Cartucho Tinta \nAltura del Producto Armado 43 cm\nPáginas Impresas a Color por minuto 5.00\nPáginas impresas a Blanco y Negro por minuto 8.00\nContenido del empaque 1x Impresora,1x Cable de poder,1x Manual,1x Garantía	COMPRADO_NUEVO	2999	1	2	10000904901016	60
13	2	2019-07-02	Tipo\nEscritorios\nRequiere sistema de anclaje\nNo\nHecho en\nBrasil\nDificultad de armado\nMedio\nRequiere armado\nSí\nPolítica de devolución\nFalabella\nInformación adicional\nÁrmalo como gustes y úsalo en 2 posiciones distintas.\nTemporada\nToda temporada\nDisponible en\nBlanco y Café\nInstrucciones de armado\nSí	COMPRADO_NUEVO	3500	1	4	10000904901016	60
15	10	2020-02-03	licencia\nnos permitira el manejo mas optimo de ofimatica 	COMPRADO_NUEVO	700	1	2	10102410961011	12
\.


--
-- TOC entry 3777 (class 0 OID 17302)
-- Dependencies: 225
-- Data for Name: baja_activo_fijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.baja_activo_fijo (id, fecha, motivo) FROM stdin;
1	2021-01-13	VENDIDO
2	2021-01-13	DESECHADO
3	2021-01-13	VENDIDO
4	2021-01-13	VENDIDO
5	2021-01-13	VENDIDO
6	2021-01-13	VENDIDO
7	2021-01-13	VENDIDO
9	2021-01-13	VENDIDO
10	2021-01-13	VENDIDO
11	2021-01-13	VENDIDO
12	2021-01-14	DONADO
13	2021-01-14	DONADO
14	2021-01-13	DONADO
15	2021-01-13	DONADO
16	2021-01-13	DESECHADO
17	2021-01-13	DESECHADO
18	2021-01-14	DONADO
19	2021-01-13	DONADO
20	2021-01-14	DONADO
21	2021-01-13	DONADO
22	2021-01-13	VENDIDO
23	2021-01-13	VENDIDO
24	2021-01-15	DESECHADO
25	2021-01-15	DESECHADO
26	2021-01-15	DESECHADO
27	2021-01-15	VENDIDO
28	2021-01-18	VENDIDO
\.


--
-- TOC entry 3748 (class 0 OID 17015)
-- Dependencies: 196
-- Data for Name: bien_garantia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bien_garantia (codigo, descripcion, valorado_en, tipo_bien) FROM stdin;
vehiculo01	Honda civic 2011 	6000	VEHICULO
terreno01	terreno de 4 manzanas tipo ladera	12000	TERRENO
terreno02	terreno en la ciudad de san salvador	14000	TERRENO
terreno03	terreno de 5 manzanas	12000	TERRENO
terreno04	terreno de 4 manzanas tipo ladera	12000	TERRENO
maquinaria03	Maquinaria de limpieza 	5000	MAQUINARIA
maquinaria01	maquinaria de cualquier tipo	25000	MAQUINARIA
terreno05	terreno de prueba 1	15000	TERRENO
terreno06	terreno de 1 manzana 	7000	TERRENO
trn012021	Terreno de 9 manzanas	20000	TERRENO
terreno07	terreno	10000	TERRENO
terreno08	terreno	20000	TERRENO
terreno09	terreno de 4 manzanas, con pozos	7000	TERRENO
vehiculo02	Vehiculo honda civic 2011, automatico, color rojo	5000	VEHICULO
p688-234	vehiculo color rojo	6500	VEHICULO
terreno11	terreno de 5 manzanas cerca de la ciudad.	10000	TERRENO
\.


--
-- TOC entry 3750 (class 0 OID 17021)
-- Dependencies: 198
-- Data for Name: credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credito (id, monto, fecha_solicitud, fecha_aprobacion, fecha_cancelado, estado, nit_usuario, id_politica, para, puntos, tiempo) FROM stdin;
103	5000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	17	PERSONA	100	60
108	700	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	10	PERSONA	100	7
109	800	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	10	PERSONA	100	6
110	900	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	10	PERSONA	100	8
111	6000	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	17	EMPRESA	100	7
112	4000	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	17	EMPRESA	100	12
96	10000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	18	PERSONA	92	12
107	600	2021-01-19	2021-01-19	\N	FINALIZADO	10060309961011	10	PERSONA	84	6
113	4500	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	17	PERSONA	100	36
115	5000	2021-01-19	2021-01-19	\N	EN_CURSO	10060309961011	17	EMPRESA	100	48
114	800	2021-01-19	2021-01-19	\N	FINALIZADO	10060309961011	10	PERSONA	88	8
86	600	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	100	8
84	600	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	86	7
89	1000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	100	12
82	3000	2021-01-17	2021-01-17	\N	FINALIZADO	10060309961011	16	PERSONA	96	36
87	10000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	18	EMPRESA	98	48
83	5000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	17	EMPRESA	100	36
85	1500	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	16	PERSONA	100	15
88	12000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	18	EMPRESA	98	36
90	500	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	100	6
91	1000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	84	6
93	10000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	18	PERSONA	100	6
102	6000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	17	EMPRESA	100	36
101	8000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	17	EMPRESA	100	48
97	4000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	17	EMPRESA	100	36
99	15000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	19	EMPRESA	100	84
94	1000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	10	PERSONA	100	12
105	5000	2021-01-18	2021-01-18	\N	EN_CURSO	10060309961011	17	EMPRESA	100	60
106	15000	2021-01-18	2021-01-18	\N	EN_CURSO	10060309961011	19	EMPRESA	100	108
100	2000	2021-01-18	2021-01-18	\N	FINALIZADO	10060309961011	16	PERSONA	100	36
\.


--
-- TOC entry 3751 (class 0 OID 17024)
-- Dependencies: 199
-- Data for Name: credito_bien_garantia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credito_bien_garantia (id_credito, codigo_bien) FROM stdin;
83	vehiculo01
87	terreno01
88	terreno02
93	terreno03
96	terreno04
97	maquinaria03
99	maquinaria01
101	terreno05
102	terreno06
103	trn012021
105	terreno07
106	terreno08
111	terreno09
112	vehiculo02
113	p688-234
115	terreno11
\.


--
-- TOC entry 3752 (class 0 OID 17027)
-- Dependencies: 200
-- Data for Name: credito_empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credito_empresa (id_credito, nit_empresa) FROM stdin;
83	07979123999912
87	10100507121015
88	10002003041011
97	10325454534534
99	07979123999912
101	10100507121015
102	10002003041011
105	07979123999912
106	10325454534534
111	10002003041011
112	10100507121015
115	10002403232343
\.


--
-- TOC entry 3754 (class 0 OID 17032)
-- Dependencies: 202
-- Data for Name: credito_persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credito_persona (nit_solicitante, id_credito) FROM stdin;
10060309961011	82
10042608801002	84
10062407941003	85
10060206001002	86
10060206001002	89
10082305961016	90
10060309961011	91
10102410961011	93
10060309961011	94
10062407941003	96
12312432901213	100
10101901021014	103
10102410961011	107
10102501701015	108
10061010771002	109
10060206001002	110
10101234321901	113
10060309961011	114
\.


--
-- TOC entry 3749 (class 0 OID 17018)
-- Dependencies: 197
-- Data for Name: cuota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuota (numero, id_credito, capital_amortizado, interes, mora, fecha_correspondiente, dias_antes_despues) FROM stdin;
16	82	0	0	0	2022-05-30	\N
17	82	0	0	0	2022-06-30	\N
18	82	0	0	0	2022-07-30	\N
19	82	0	0	0	2022-08-30	\N
20	82	0	0	0	2022-09-30	\N
21	82	0	0	0	2022-10-30	\N
22	82	0	0	0	2022-11-30	\N
23	82	0	0	0	2022-12-30	\N
24	82	0	0	0	2023-01-30	\N
25	82	0	0	0	2023-02-28	\N
26	82	0	0	0	2023-03-30	\N
27	82	0	0	0	2023-04-30	\N
28	82	0	0	0	2023-05-30	\N
29	82	0	0	0	2023-06-30	\N
30	82	0	0	0	2023-07-30	\N
31	82	0	0	0	2023-08-30	\N
32	82	0	0	0	2023-09-30	\N
33	82	0	0	0	2023-10-30	\N
34	82	0	0	0	2023-11-30	\N
35	82	0	0	0	2023-12-30	\N
36	82	0	0	0	2024-01-30	\N
1	82	83.3333333333333286	25	12	2021-02-28	4
4	83	0	0	0	2021-05-30	\N
5	83	0	0	0	2021-06-30	\N
6	83	0	0	0	2021-07-30	\N
7	83	0	0	0	2021-08-30	\N
8	83	0	0	0	2021-09-30	\N
9	83	0	0	0	2021-10-30	\N
10	83	0	0	0	2021-11-30	\N
11	83	0	0	0	2021-12-30	\N
12	83	0	0	0	2022-01-30	\N
13	83	0	0	0	2022-02-28	\N
14	83	0	0	0	2022-03-30	\N
15	83	0	0	0	2022-04-30	\N
16	83	0	0	0	2022-05-30	\N
17	83	0	0	0	2022-06-30	\N
18	83	0	0	0	2022-07-30	\N
19	83	0	0	0	2022-08-30	\N
20	83	0	0	0	2022-09-30	\N
21	83	0	0	0	2022-10-30	\N
22	83	0	0	0	2022-11-30	\N
23	83	0	0	0	2022-12-30	\N
24	83	0	0	0	2023-01-30	\N
25	83	0	0	0	2023-02-28	\N
26	83	0	0	0	2023-03-30	\N
27	83	0	0	0	2023-04-30	\N
28	83	0	0	0	2023-05-30	\N
29	83	0	0	0	2023-06-30	\N
30	83	0	0	0	2023-07-30	\N
31	83	0	0	0	2023-08-30	\N
32	83	0	0	0	2023-09-30	\N
33	83	0	0	0	2023-10-30	\N
34	83	0	0	0	2023-11-30	\N
35	83	0	0	0	2023-12-30	\N
36	83	0	0	0	2024-01-30	\N
2	82	83.3333333333333286	25	0	2021-03-30	-26
3	82	83.3333333333333286	25	0	2021-04-30	-57
4	82	83.3333333333333286	25	0	2021-05-30	-87
5	82	83.3333333333333286	25	0	2021-06-30	-118
6	82	83.3333333333333286	25	0	2021-07-30	-154
7	82	83.3333333333333286	25	0	2021-08-30	-185
1	83	138.888888888888886	54.1666666666666643	0	2021-02-28	-2
8	82	83.3333333333333286	25	0	2021-09-30	-210
9	82	83.3333333333333286	25	0	2021-10-30	-240
10	82	83.3333333333333286	25	0	2021-11-30	-277
4	85	0	0	0	2021-05-30	\N
5	85	0	0	0	2021-06-30	\N
6	85	0	0	0	2021-07-30	\N
7	85	0	0	0	2021-08-30	\N
8	85	0	0	0	2021-09-30	\N
9	85	0	0	0	2021-10-30	\N
10	85	0	0	0	2021-11-30	\N
11	85	0	0	0	2021-12-30	\N
12	85	0	0	0	2022-01-30	\N
13	85	0	0	0	2022-02-28	\N
14	85	0	0	0	2022-03-30	\N
15	85	0	0	0	2022-04-30	\N
10	87	0	0	0	2021-11-30	\N
11	87	0	0	0	2021-12-30	\N
12	87	0	0	0	2022-01-30	\N
13	87	0	0	0	2022-02-28	\N
14	87	0	0	0	2022-03-30	\N
15	87	0	0	0	2022-04-30	\N
2	86	75	3.5	0	2021-03-30	-59
3	86	75	3.5	0	2021-04-30	-90
4	86	75	3.5	0	2021-05-30	-120
5	86	75	3.5	0	2021-06-30	-151
6	86	75	3.5	0	2021-07-30	-181
1	85	1387.5	12.5	0	2021-02-28	0
8	86	75	3.5	0	2021-09-30	-243
1	84	85.7142857142857082	3.5	12	2021-02-28	4
1	87	8866.66666666666606	133.333333333333343	0	2021-02-28	0
3	87	208.333333333333343	133.333333333333343	0	2021-04-30	-61
2	87	208.333333333333343	133.333333333333343	0	2021-03-30	-30
4	87	208.333333333333343	133.333333333333343	0	2021-05-30	-91
5	87	208.333333333333343	133.333333333333343	0	2021-06-30	-122
6	87	299.999999999998181	133.333333333333343	0	2021-07-30	-152
7	87	208.333333333333343	133.333333333333343	0	2021-08-30	-183
8	87	208.333333333333343	133.333333333333343	0	2021-09-30	-214
12	82	83.3333333333333286	25	0	2022-01-30	-365
13	82	83.3333333333333286	25	3	2022-02-28	1
14	82	1891.66666666666652	25	0	2022-03-30	-29
15	82	25	25	0	2022-04-30	-60
9	87	-416.666666666667879	133.333333333333343	366	2021-10-30	122
2	83	4861.11111111111131	54.1666666666666643	0	2021-03-30	0
3	83	0	54.1666666666666643	0	2021-04-30	-31
2	85	112.5	12.5	0	2021-03-30	0
3	85	0	12.5	0	2021-04-30	-31
16	87	0	0	0	2022-05-30	\N
17	87	0	0	0	2022-06-30	\N
18	87	0	0	0	2022-07-30	\N
19	87	0	0	0	2022-08-30	\N
20	87	0	0	0	2022-09-30	\N
21	87	0	0	0	2022-10-30	\N
22	87	0	0	0	2022-11-30	\N
23	87	0	0	0	2022-12-30	\N
24	87	0	0	0	2023-01-30	\N
25	87	0	0	0	2023-02-28	\N
26	87	0	0	0	2023-03-30	\N
27	87	0	0	0	2023-04-30	\N
28	87	0	0	0	2023-05-30	\N
29	87	0	0	0	2023-06-30	\N
30	87	0	0	0	2023-07-30	\N
31	87	0	0	0	2023-08-30	\N
32	87	0	0	0	2023-09-30	\N
33	87	0	0	0	2023-10-30	\N
34	87	0	0	0	2023-11-30	\N
35	87	0	0	0	2023-12-30	\N
36	87	0	0	0	2024-01-30	\N
37	87	0	0	0	2024-02-28	\N
38	87	0	0	0	2024-03-30	\N
39	87	0	0	0	2024-04-30	\N
40	87	0	0	0	2024-05-30	\N
41	87	0	0	0	2024-06-30	\N
42	87	0	0	0	2024-07-30	\N
43	87	0	0	0	2024-08-30	\N
44	87	0	0	0	2024-09-30	\N
45	87	0	0	0	2024-10-30	\N
46	87	0	0	0	2024-11-30	\N
47	87	0	0	0	2024-12-30	\N
48	87	0	0	0	2025-01-30	\N
3	88	0	0	0	2021-04-30	\N
4	88	0	0	0	2021-05-30	\N
5	88	0	0	0	2021-06-30	\N
6	88	0	0	0	2021-07-30	\N
7	88	0	0	0	2021-08-30	\N
8	88	0	0	0	2021-09-30	\N
9	88	0	0	0	2021-10-30	\N
10	88	0	0	0	2021-11-30	\N
11	88	0	0	0	2021-12-30	\N
12	88	0	0	0	2022-01-30	\N
13	88	0	0	0	2022-02-28	\N
14	88	0	0	0	2022-03-30	\N
15	88	0	0	0	2022-04-30	\N
16	88	0	0	0	2022-05-30	\N
17	88	0	0	0	2022-06-30	\N
18	88	0	0	0	2022-07-30	\N
19	88	0	0	0	2022-08-30	\N
20	88	0	0	0	2022-09-30	\N
21	88	0	0	0	2022-10-30	\N
22	88	0	0	0	2022-11-30	\N
23	88	0	0	0	2022-12-30	\N
24	88	0	0	0	2023-01-30	\N
25	88	0	0	0	2023-02-28	\N
26	88	0	0	0	2023-03-30	\N
27	88	0	0	0	2023-04-30	\N
28	88	0	0	0	2023-05-30	\N
29	88	0	0	0	2023-06-30	\N
30	88	0	0	0	2023-07-30	\N
31	88	0	0	0	2023-08-30	\N
32	88	0	0	0	2023-09-30	\N
33	88	0	0	0	2023-10-30	\N
34	88	0	0	0	2023-11-30	\N
35	88	0	0	0	2023-12-30	\N
36	88	0	0	0	2024-01-30	\N
11	82	83.3333333333333286	25	0	2021-12-30	-301
1	86	75	3.5	0	2021-02-28	-29
7	86	75	3.5	0	2021-08-30	-212
2	84	85.7142857142857082	3.5	0	2021-03-30	-26
3	84	85.7142857142857082	3.5	0	2021-04-30	-57
4	84	85.7142857142857082	3.5	0	2021-05-30	-87
5	84	85.7142857142857082	3.5	0	2021-06-30	-118
6	84	85.7142857142857082	3.5	0	2021-07-30	-148
7	84	85.7142857142857792	3.5	0	2021-08-30	-179
1	89	83.3333333333333286	5.83333333333333304	0	2021-02-28	0
2	89	83.3333333333333286	5.83333333333333304	0	2021-03-30	-30
3	89	83.3333333333333286	5.83333333333333304	0	2021-04-30	-57
4	89	83.3333333333333286	5.83333333333333304	0	2021-05-30	-91
5	89	83.3333333333333286	5.83333333333333304	0	2021-06-30	-122
6	89	83.3333333333333286	5.83333333333333304	0	2021-07-30	-152
7	89	83.3333333333333286	5.83333333333333304	0	2021-08-30	-183
8	89	1	5.83333333333333304	0	2021-09-30	-214
9	89	144.166666666666657	5.83333333333333304	0	2021-10-30	-244
10	89	83.3333333333333286	5.83333333333333304	0	2021-11-30	-275
11	89	83.3333333333333286	5.83333333333333304	0	2021-12-30	-305
12	89	104.833333333333371	5.83333333333333304	0	2022-01-30	-336
3	90	0	0	0	2021-04-30	\N
4	90	0	0	0	2021-05-30	\N
5	90	0	0	0	2021-06-30	\N
6	90	0	0	0	2021-07-30	\N
1	88	12000	160	90	2021-02-28	30
2	88	0	160	0	2021-03-30	0
1	90	500	2.91666666666666652	0	2021-02-28	0
2	90	0	2.91666666666666652	0	2021-03-30	-30
3	91	0	0	0	2021-04-30	\N
4	91	0	0	0	2021-05-30	\N
5	91	0	0	0	2021-06-30	\N
6	91	0	0	0	2021-07-30	\N
3	93	0	0	0	2021-04-30	\N
4	93	0	0	0	2021-05-30	\N
5	93	0	0	0	2021-06-30	\N
6	93	0	0	0	2021-07-30	\N
1	91	932.166666666666629	5.83333333333333304	12	2021-02-28	4
2	91	67.8333333333333712	5.83333333333333304	0	2021-03-30	-26
1	93	10001	133.333333333333343	0	2021-02-28	0
4	94	0	0	0	2021-05-30	\N
5	94	0	0	0	2021-06-30	\N
6	94	0	0	0	2021-07-30	\N
7	94	0	0	0	2021-08-30	\N
8	94	0	0	0	2021-09-30	\N
9	94	0	0	0	2021-10-30	\N
10	94	0	0	0	2021-11-30	\N
11	94	0	0	0	2021-12-30	\N
2	94	916.666666666666629	5.83333333333333304	0	2021-03-30	-85
3	94	0.00666666666666060337	5.83333333333333304	0	2021-04-30	-116
12	94	0	0	0	2022-01-30	\N
5	96	0	0	0	2021-06-30	\N
6	96	0	0	0	2021-07-30	\N
7	96	0	0	0	2021-08-30	\N
8	96	0	0	0	2021-09-30	\N
9	96	0	0	0	2021-10-30	\N
10	96	0	0	0	2021-11-30	\N
11	96	0	0	0	2021-12-30	\N
12	96	0	0	0	2022-01-30	\N
4	97	0	0	0	2021-05-30	\N
5	97	0	0	0	2021-06-30	\N
6	97	0	0	0	2021-07-30	\N
7	97	0	0	0	2021-08-30	\N
8	97	0	0	0	2021-09-30	\N
9	97	0	0	0	2021-10-30	\N
10	97	0	0	0	2021-11-30	\N
11	97	0	0	0	2021-12-30	\N
12	97	0	0	0	2022-01-30	\N
13	97	0	0	0	2022-02-28	\N
14	97	0	0	0	2022-03-30	\N
15	97	0	0	0	2022-04-30	\N
16	97	0	0	0	2022-05-30	\N
17	97	0	0	0	2022-06-30	\N
18	97	0	0	0	2022-07-30	\N
19	97	0	0	0	2022-08-30	\N
20	97	0	0	0	2022-09-30	\N
21	97	0	0	0	2022-10-30	\N
22	97	0	0	0	2022-11-30	\N
23	97	0	0	0	2022-12-30	\N
24	97	0	0	0	2023-01-30	\N
25	97	0	0	0	2023-02-28	\N
26	97	0	0	0	2023-03-30	\N
27	97	0	0	0	2023-04-30	\N
28	97	0	0	0	2023-05-30	\N
29	97	0	0	0	2023-06-30	\N
30	97	0	0	0	2023-07-30	\N
31	97	0	0	0	2023-08-30	\N
32	97	0	0	0	2023-09-30	\N
33	97	0	0	0	2023-10-30	\N
34	97	0	0	0	2023-11-30	\N
35	97	0	0	0	2023-12-30	\N
36	97	0	0	0	2024-01-30	\N
3	99	0	0	0	2021-04-30	\N
4	99	0	0	0	2021-05-30	\N
5	99	0	0	0	2021-06-30	\N
6	99	0	0	0	2021-07-30	\N
7	99	0	0	0	2021-08-30	\N
8	99	0	0	0	2021-09-30	\N
9	99	0	0	0	2021-10-30	\N
10	99	0	0	0	2021-11-30	\N
11	99	0	0	0	2021-12-30	\N
12	99	0	0	0	2022-01-30	\N
13	99	0	0	0	2022-02-28	\N
14	99	0	0	0	2022-03-30	\N
15	99	0	0	0	2022-04-30	\N
16	99	0	0	0	2022-05-30	\N
17	99	0	0	0	2022-06-30	\N
18	99	0	0	0	2022-07-30	\N
19	99	0	0	0	2022-08-30	\N
20	99	0	0	0	2022-09-30	\N
21	99	0	0	0	2022-10-30	\N
22	99	0	0	0	2022-11-30	\N
23	99	0	0	0	2022-12-30	\N
24	99	0	0	0	2023-01-30	\N
25	99	0	0	0	2023-02-28	\N
26	99	0	0	0	2023-03-30	\N
27	99	0	0	0	2023-04-30	\N
28	99	0	0	0	2023-05-30	\N
29	99	0	0	0	2023-06-30	\N
30	99	0	0	0	2023-07-30	\N
31	99	0	0	0	2023-08-30	\N
32	99	0	0	0	2023-09-30	\N
33	99	0	0	0	2023-10-30	\N
34	99	0	0	0	2023-11-30	\N
35	99	0	0	0	2023-12-30	\N
36	99	0	0	0	2024-01-30	\N
37	99	0	0	0	2024-02-28	\N
38	99	0	0	0	2024-03-30	\N
39	99	0	0	0	2024-04-30	\N
40	99	0	0	0	2024-05-30	\N
41	99	0	0	0	2024-06-30	\N
42	99	0	0	0	2024-07-30	\N
43	99	0	0	0	2024-08-30	\N
44	99	0	0	0	2024-09-30	\N
45	99	0	0	0	2024-10-30	\N
46	99	0	0	0	2024-11-30	\N
47	99	0	0	0	2024-12-30	\N
48	99	0	0	0	2025-01-30	\N
49	99	0	0	0	2025-02-28	\N
50	99	0	0	0	2025-03-30	\N
51	99	0	0	0	2025-04-30	\N
52	99	0	0	0	2025-05-30	\N
53	99	0	0	0	2025-06-30	\N
54	99	0	0	0	2025-07-30	\N
55	99	0	0	0	2025-08-30	\N
56	99	0	0	0	2025-09-30	\N
57	99	0	0	0	2025-10-30	\N
58	99	0	0	0	2025-11-30	\N
59	99	0	0	0	2025-12-30	\N
60	99	0	0	0	2026-01-30	\N
61	99	0	0	0	2026-02-28	\N
62	99	0	0	0	2026-03-30	\N
63	99	0	0	0	2026-04-30	\N
64	99	0	0	0	2026-05-30	\N
65	99	0	0	0	2026-06-30	\N
66	99	0	0	0	2026-07-30	\N
67	99	0	0	0	2026-08-30	\N
68	99	0	0	0	2026-09-30	\N
69	99	0	0	0	2026-10-30	\N
70	99	0	0	0	2026-11-30	\N
71	99	0	0	0	2026-12-30	\N
2	97	3889.88888888888869	43.3333333333333357	0	2021-03-30	-59
3	97	-1	43.3333333333333357	0	2021-04-30	-90
2	99	-1	237.5	0	2021-03-30	-59
1	96	833.333333333333371	133.333333333333343	0	2021-02-28	-39
2	96	833.333333333333371	133.333333333333343	9	2021-03-30	3
3	96	8333.33333333333394	133.333333333333343	0	2021-04-30	-28
4	96	-1.81898940354585648e-12	133.333333333333343	0	2021-05-30	-130
72	99	0	0	0	2027-01-30	\N
73	99	0	0	0	2027-02-28	\N
74	99	0	0	0	2027-03-30	\N
75	99	0	0	0	2027-04-30	\N
76	99	0	0	0	2027-05-30	\N
77	99	0	0	0	2027-06-30	\N
78	99	0	0	0	2027-07-30	\N
79	99	0	0	0	2027-08-30	\N
80	99	0	0	0	2027-09-30	\N
81	99	0	0	0	2027-10-30	\N
82	99	0	0	0	2027-11-30	\N
83	99	0	0	0	2027-12-30	\N
84	99	0	0	0	2028-01-30	\N
4	100	0	0	0	2021-05-30	\N
5	100	0	0	0	2021-06-30	\N
6	100	0	0	0	2021-07-30	\N
7	100	0	0	0	2021-08-30	\N
8	100	0	0	0	2021-09-30	\N
9	100	0	0	0	2021-10-30	\N
10	100	0	0	0	2021-11-30	\N
11	100	0	0	0	2021-12-30	\N
12	100	0	0	0	2022-01-30	\N
13	100	0	0	0	2022-02-28	\N
14	100	0	0	0	2022-03-30	\N
15	100	0	0	0	2022-04-30	\N
16	100	0	0	0	2022-05-30	\N
17	100	0	0	0	2022-06-30	\N
18	100	0	0	0	2022-07-30	\N
19	100	0	0	0	2022-08-30	\N
20	100	0	0	0	2022-09-30	\N
21	100	0	0	0	2022-10-30	\N
22	100	0	0	0	2022-11-30	\N
23	100	0	0	0	2022-12-30	\N
24	100	0	0	0	2023-01-30	\N
25	100	0	0	0	2023-02-28	\N
26	100	0	0	0	2023-03-30	\N
27	100	0	0	0	2023-04-30	\N
28	100	0	0	0	2023-05-30	\N
29	100	0	0	0	2023-06-30	\N
30	100	0	0	0	2023-07-30	\N
31	100	0	0	0	2023-08-30	\N
32	100	0	0	0	2023-09-30	\N
33	100	0	0	0	2023-10-30	\N
34	100	0	0	0	2023-11-30	\N
35	100	0	0	0	2023-12-30	\N
36	100	0	0	0	2024-01-30	\N
3	101	0	0	0	2021-04-30	\N
4	101	0	0	0	2021-05-30	\N
5	101	0	0	0	2021-06-30	\N
6	101	0	0	0	2021-07-30	\N
7	101	0	0	0	2021-08-30	\N
8	101	0	0	0	2021-09-30	\N
9	101	0	0	0	2021-10-30	\N
10	101	0	0	0	2021-11-30	\N
11	101	0	0	0	2021-12-30	\N
12	101	0	0	0	2022-01-30	\N
13	101	0	0	0	2022-02-28	\N
14	101	0	0	0	2022-03-30	\N
15	101	0	0	0	2022-04-30	\N
16	101	0	0	0	2022-05-30	\N
17	101	0	0	0	2022-06-30	\N
18	101	0	0	0	2022-07-30	\N
19	101	0	0	0	2022-08-30	\N
20	101	0	0	0	2022-09-30	\N
21	101	0	0	0	2022-10-30	\N
22	101	0	0	0	2022-11-30	\N
23	101	0	0	0	2022-12-30	\N
24	101	0	0	0	2023-01-30	\N
25	101	0	0	0	2023-02-28	\N
26	101	0	0	0	2023-03-30	\N
27	101	0	0	0	2023-04-30	\N
28	101	0	0	0	2023-05-30	\N
29	101	0	0	0	2023-06-30	\N
30	101	0	0	0	2023-07-30	\N
31	101	0	0	0	2023-08-30	\N
32	101	0	0	0	2023-09-30	\N
33	101	0	0	0	2023-10-30	\N
34	101	0	0	0	2023-11-30	\N
35	101	0	0	0	2023-12-30	\N
36	101	0	0	0	2024-01-30	\N
37	101	0	0	0	2024-02-28	\N
38	101	0	0	0	2024-03-30	\N
39	101	0	0	0	2024-04-30	\N
40	101	0	0	0	2024-05-30	\N
41	101	0	0	0	2024-06-30	\N
42	101	0	0	0	2024-07-30	\N
43	101	0	0	0	2024-08-30	\N
44	101	0	0	0	2024-09-30	\N
45	101	0	0	0	2024-10-30	\N
46	101	0	0	0	2024-11-30	\N
47	101	0	0	0	2024-12-30	\N
48	101	0	0	0	2025-01-30	\N
4	102	0	0	0	2021-05-30	\N
5	102	0	0	0	2021-06-30	\N
6	102	0	0	0	2021-07-30	\N
7	102	0	0	0	2021-08-30	\N
8	102	0	0	0	2021-09-30	\N
9	102	0	0	0	2021-10-30	\N
10	102	0	0	0	2021-11-30	\N
11	102	0	0	0	2021-12-30	\N
12	102	0	0	0	2022-01-30	\N
13	102	0	0	0	2022-02-28	\N
14	102	0	0	0	2022-03-30	\N
15	102	0	0	0	2022-04-30	\N
16	102	0	0	0	2022-05-30	\N
17	102	0	0	0	2022-06-30	\N
18	102	0	0	0	2022-07-30	\N
19	102	0	0	0	2022-08-30	\N
20	102	0	0	0	2022-09-30	\N
21	102	0	0	0	2022-10-30	\N
22	102	0	0	0	2022-11-30	\N
23	102	0	0	0	2022-12-30	\N
2	102	5834.33333333333303	65	0	2021-03-30	-59
3	102	-1	65	0	2021-04-30	-90
2	101	-1	86.6666666666666714	0	2021-03-30	-59
1	100	1933.33333333333326	16.6666666666666679	0	2021-02-28	-55
2	100	58.3333333333333286	16.6666666666666679	0	2021-03-30	-85
3	100	8.33333333333348492	16.6666666666666679	0	2021-04-30	-116
24	102	0	0	0	2023-01-30	\N
25	102	0	0	0	2023-02-28	\N
26	102	0	0	0	2023-03-30	\N
27	102	0	0	0	2023-04-30	\N
28	102	0	0	0	2023-05-30	\N
29	102	0	0	0	2023-06-30	\N
30	102	0	0	0	2023-07-30	\N
31	102	0	0	0	2023-08-30	\N
32	102	0	0	0	2023-09-30	\N
33	102	0	0	0	2023-10-30	\N
34	102	0	0	0	2023-11-30	\N
35	102	0	0	0	2023-12-30	\N
36	102	0	0	0	2024-01-30	\N
2	93	-1	133.333333333333343	0	2021-03-30	-59
4	103	0	0	0	2021-05-30	\N
5	103	0	0	0	2021-06-30	\N
6	103	0	0	0	2021-07-30	\N
7	103	0	0	0	2021-08-30	\N
8	103	0	0	0	2021-09-30	\N
9	103	0	0	0	2021-10-30	\N
10	103	0	0	0	2021-11-30	\N
11	103	0	0	0	2021-12-30	\N
12	103	0	0	0	2022-01-30	\N
13	103	0	0	0	2022-02-28	\N
14	103	0	0	0	2022-03-30	\N
15	103	0	0	0	2022-04-30	\N
16	103	0	0	0	2022-05-30	\N
17	103	0	0	0	2022-06-30	\N
18	103	0	0	0	2022-07-30	\N
19	103	0	0	0	2022-08-30	\N
20	103	0	0	0	2022-09-30	\N
21	103	0	0	0	2022-10-30	\N
22	103	0	0	0	2022-11-30	\N
23	103	0	0	0	2022-12-30	\N
24	103	0	0	0	2023-01-30	\N
25	103	0	0	0	2023-02-28	\N
26	103	0	0	0	2023-03-30	\N
27	103	0	0	0	2023-04-30	\N
28	103	0	0	0	2023-05-30	\N
29	103	0	0	0	2023-06-30	\N
30	103	0	0	0	2023-07-30	\N
31	103	0	0	0	2023-08-30	\N
32	103	0	0	0	2023-09-30	\N
33	103	0	0	0	2023-10-30	\N
34	103	0	0	0	2023-11-30	\N
35	103	0	0	0	2023-12-30	\N
36	103	0	0	0	2024-01-30	\N
37	103	0	0	0	2024-02-28	\N
38	103	0	0	0	2024-03-30	\N
39	103	0	0	0	2024-04-30	\N
40	103	0	0	0	2024-05-30	\N
41	103	0	0	0	2024-06-30	\N
42	103	0	0	0	2024-07-30	\N
43	103	0	0	0	2024-08-30	\N
44	103	0	0	0	2024-09-30	\N
45	103	0	0	0	2024-10-30	\N
46	103	0	0	0	2024-11-30	\N
47	103	0	0	0	2024-12-30	\N
48	103	0	0	0	2025-01-30	\N
49	103	0	0	0	2025-02-28	\N
50	103	0	0	0	2025-03-30	\N
51	103	0	0	0	2025-04-30	\N
52	103	0	0	0	2025-05-30	\N
53	103	0	0	0	2025-06-30	\N
54	103	0	0	0	2025-07-30	\N
55	103	0	0	0	2025-08-30	\N
56	103	0	0	0	2025-09-30	\N
57	103	0	0	0	2025-10-30	\N
58	103	0	0	0	2025-11-30	\N
59	103	0	0	0	2025-12-30	\N
60	103	0	0	0	2026-01-30	\N
1	102	166.666666666666657	65	0	2021-02-28	-29
1	101	8001	86.6666666666666714	0	2021-02-28	-29
1	97	111.111111111111114	43.3333333333333357	0	2021-02-28	-29
1	99	15001	237.5	0	2021-02-28	-29
1	94	83.326666666666668	5.83333333333333304	0	2021-02-28	-55
1	105	0	0	0	2021-02-28	\N
2	105	0	0	0	2021-03-30	\N
3	105	0	0	0	2021-04-30	\N
4	105	0	0	0	2021-05-30	\N
5	105	0	0	0	2021-06-30	\N
6	105	0	0	0	2021-07-30	\N
7	105	0	0	0	2021-08-30	\N
8	105	0	0	0	2021-09-30	\N
9	105	0	0	0	2021-10-30	\N
10	105	0	0	0	2021-11-30	\N
11	105	0	0	0	2021-12-30	\N
12	105	0	0	0	2022-01-30	\N
13	105	0	0	0	2022-02-28	\N
14	105	0	0	0	2022-03-30	\N
15	105	0	0	0	2022-04-30	\N
16	105	0	0	0	2022-05-30	\N
17	105	0	0	0	2022-06-30	\N
18	105	0	0	0	2022-07-30	\N
19	105	0	0	0	2022-08-30	\N
20	105	0	0	0	2022-09-30	\N
21	105	0	0	0	2022-10-30	\N
22	105	0	0	0	2022-11-30	\N
23	105	0	0	0	2022-12-30	\N
24	105	0	0	0	2023-01-30	\N
25	105	0	0	0	2023-02-28	\N
26	105	0	0	0	2023-03-30	\N
27	105	0	0	0	2023-04-30	\N
28	105	0	0	0	2023-05-30	\N
29	105	0	0	0	2023-06-30	\N
30	105	0	0	0	2023-07-30	\N
31	105	0	0	0	2023-08-30	\N
32	105	0	0	0	2023-09-30	\N
33	105	0	0	0	2023-10-30	\N
34	105	0	0	0	2023-11-30	\N
35	105	0	0	0	2023-12-30	\N
36	105	0	0	0	2024-01-30	\N
37	105	0	0	0	2024-02-28	\N
38	105	0	0	0	2024-03-30	\N
39	105	0	0	0	2024-04-30	\N
40	105	0	0	0	2024-05-30	\N
41	105	0	0	0	2024-06-30	\N
2	103	4916.66666666666697	54.1666666666666643	0	2021-03-30	-30
3	103	0	54.1666666666666643	0	2021-04-30	-61
42	105	0	0	0	2024-07-30	\N
43	105	0	0	0	2024-08-30	\N
44	105	0	0	0	2024-09-30	\N
45	105	0	0	0	2024-10-30	\N
46	105	0	0	0	2024-11-30	\N
47	105	0	0	0	2024-12-30	\N
48	105	0	0	0	2025-01-30	\N
49	105	0	0	0	2025-02-28	\N
50	105	0	0	0	2025-03-30	\N
51	105	0	0	0	2025-04-30	\N
52	105	0	0	0	2025-05-30	\N
53	105	0	0	0	2025-06-30	\N
54	105	0	0	0	2025-07-30	\N
55	105	0	0	0	2025-08-30	\N
56	105	0	0	0	2025-09-30	\N
57	105	0	0	0	2025-10-30	\N
58	105	0	0	0	2025-11-30	\N
59	105	0	0	0	2025-12-30	\N
60	105	0	0	0	2026-01-30	\N
1	106	0	0	0	2021-02-28	\N
2	106	0	0	0	2021-03-30	\N
3	106	0	0	0	2021-04-30	\N
4	106	0	0	0	2021-05-30	\N
5	106	0	0	0	2021-06-30	\N
6	106	0	0	0	2021-07-30	\N
7	106	0	0	0	2021-08-30	\N
8	106	0	0	0	2021-09-30	\N
9	106	0	0	0	2021-10-30	\N
10	106	0	0	0	2021-11-30	\N
11	106	0	0	0	2021-12-30	\N
12	106	0	0	0	2022-01-30	\N
13	106	0	0	0	2022-02-28	\N
14	106	0	0	0	2022-03-30	\N
15	106	0	0	0	2022-04-30	\N
16	106	0	0	0	2022-05-30	\N
17	106	0	0	0	2022-06-30	\N
18	106	0	0	0	2022-07-30	\N
19	106	0	0	0	2022-08-30	\N
20	106	0	0	0	2022-09-30	\N
21	106	0	0	0	2022-10-30	\N
22	106	0	0	0	2022-11-30	\N
23	106	0	0	0	2022-12-30	\N
24	106	0	0	0	2023-01-30	\N
25	106	0	0	0	2023-02-28	\N
26	106	0	0	0	2023-03-30	\N
27	106	0	0	0	2023-04-30	\N
28	106	0	0	0	2023-05-30	\N
29	106	0	0	0	2023-06-30	\N
30	106	0	0	0	2023-07-30	\N
31	106	0	0	0	2023-08-30	\N
32	106	0	0	0	2023-09-30	\N
33	106	0	0	0	2023-10-30	\N
34	106	0	0	0	2023-11-30	\N
35	106	0	0	0	2023-12-30	\N
36	106	0	0	0	2024-01-30	\N
37	106	0	0	0	2024-02-28	\N
38	106	0	0	0	2024-03-30	\N
39	106	0	0	0	2024-04-30	\N
40	106	0	0	0	2024-05-30	\N
41	106	0	0	0	2024-06-30	\N
42	106	0	0	0	2024-07-30	\N
43	106	0	0	0	2024-08-30	\N
44	106	0	0	0	2024-09-30	\N
45	106	0	0	0	2024-10-30	\N
46	106	0	0	0	2024-11-30	\N
47	106	0	0	0	2024-12-30	\N
48	106	0	0	0	2025-01-30	\N
49	106	0	0	0	2025-02-28	\N
50	106	0	0	0	2025-03-30	\N
51	106	0	0	0	2025-04-30	\N
52	106	0	0	0	2025-05-30	\N
53	106	0	0	0	2025-06-30	\N
54	106	0	0	0	2025-07-30	\N
55	106	0	0	0	2025-08-30	\N
56	106	0	0	0	2025-09-30	\N
57	106	0	0	0	2025-10-30	\N
58	106	0	0	0	2025-11-30	\N
59	106	0	0	0	2025-12-30	\N
60	106	0	0	0	2026-01-30	\N
61	106	0	0	0	2026-02-28	\N
62	106	0	0	0	2026-03-30	\N
63	106	0	0	0	2026-04-30	\N
64	106	0	0	0	2026-05-30	\N
65	106	0	0	0	2026-06-30	\N
66	106	0	0	0	2026-07-30	\N
67	106	0	0	0	2026-08-30	\N
68	106	0	0	0	2026-09-30	\N
69	106	0	0	0	2026-10-30	\N
70	106	0	0	0	2026-11-30	\N
71	106	0	0	0	2026-12-30	\N
72	106	0	0	0	2027-01-30	\N
73	106	0	0	0	2027-02-28	\N
74	106	0	0	0	2027-03-30	\N
75	106	0	0	0	2027-04-30	\N
76	106	0	0	0	2027-05-30	\N
77	106	0	0	0	2027-06-30	\N
78	106	0	0	0	2027-07-30	\N
79	106	0	0	0	2027-08-30	\N
80	106	0	0	0	2027-09-30	\N
81	106	0	0	0	2027-10-30	\N
82	106	0	0	0	2027-11-30	\N
83	106	0	0	0	2027-12-30	\N
84	106	0	0	0	2028-01-30	\N
85	106	0	0	0	2028-02-28	\N
86	106	0	0	0	2028-03-30	\N
87	106	0	0	0	2028-04-30	\N
88	106	0	0	0	2028-05-30	\N
89	106	0	0	0	2028-06-30	\N
90	106	0	0	0	2028-07-30	\N
91	106	0	0	0	2028-08-30	\N
92	106	0	0	0	2028-09-30	\N
93	106	0	0	0	2028-10-30	\N
94	106	0	0	0	2028-11-30	\N
95	106	0	0	0	2028-12-30	\N
96	106	0	0	0	2029-01-30	\N
97	106	0	0	0	2029-02-28	\N
98	106	0	0	0	2029-03-30	\N
99	106	0	0	0	2029-04-30	\N
100	106	0	0	0	2029-05-30	\N
101	106	0	0	0	2029-06-30	\N
102	106	0	0	0	2029-07-30	\N
103	106	0	0	0	2029-08-30	\N
104	106	0	0	0	2029-09-30	\N
105	106	0	0	0	2029-10-30	\N
106	106	0	0	0	2029-11-30	\N
107	106	0	0	0	2029-12-30	\N
108	106	0	0	0	2030-01-30	\N
1	103	83.3333333333333286	54.1666666666666643	0	2021-02-28	0
4	107	0	0	0	2021-05-30	\N
5	107	0	0	0	2021-06-30	\N
6	107	0	0	0	2021-07-30	\N
1	108	0	0	0	2021-02-28	\N
2	108	0	0	0	2021-03-30	\N
3	108	0	0	0	2021-04-30	\N
4	108	0	0	0	2021-05-30	\N
5	108	0	0	0	2021-06-30	\N
6	108	0	0	0	2021-07-30	\N
7	108	0	0	0	2021-08-30	\N
1	109	0	0	0	2021-02-28	\N
2	109	0	0	0	2021-03-30	\N
3	109	0	0	0	2021-04-30	\N
4	109	0	0	0	2021-05-30	\N
5	109	0	0	0	2021-06-30	\N
6	109	0	0	0	2021-07-30	\N
1	110	0	0	0	2021-02-28	\N
2	110	0	0	0	2021-03-30	\N
3	110	0	0	0	2021-04-30	\N
4	110	0	0	0	2021-05-30	\N
5	110	0	0	0	2021-06-30	\N
6	110	0	0	0	2021-07-30	\N
7	110	0	0	0	2021-08-30	\N
8	110	0	0	0	2021-09-30	\N
1	111	0	0	0	2021-02-28	\N
2	111	0	0	0	2021-03-30	\N
3	111	0	0	0	2021-04-30	\N
4	111	0	0	0	2021-05-30	\N
5	111	0	0	0	2021-06-30	\N
6	111	0	0	0	2021-07-30	\N
7	111	0	0	0	2021-08-30	\N
1	112	0	0	0	2021-02-28	\N
2	112	0	0	0	2021-03-30	\N
3	112	0	0	0	2021-04-30	\N
4	112	0	0	0	2021-05-30	\N
5	112	0	0	0	2021-06-30	\N
6	112	0	0	0	2021-07-30	\N
7	112	0	0	0	2021-08-30	\N
8	112	0	0	0	2021-09-30	\N
9	112	0	0	0	2021-10-30	\N
10	112	0	0	0	2021-11-30	\N
11	112	0	0	0	2021-12-30	\N
12	112	0	0	0	2022-01-30	\N
1	107	100	3.5	0	2021-02-28	-39
2	107	500	3.5	0	2021-03-30	-69
3	107	0	3.5	81	2021-04-30	27
1	113	0	0	0	2021-02-28	\N
2	113	0	0	0	2021-03-30	\N
3	113	0	0	0	2021-04-30	\N
4	113	0	0	0	2021-05-30	\N
5	113	0	0	0	2021-06-30	\N
6	113	0	0	0	2021-07-30	\N
7	113	0	0	0	2021-08-30	\N
8	113	0	0	0	2021-09-30	\N
9	113	0	0	0	2021-10-30	\N
10	113	0	0	0	2021-11-30	\N
11	113	0	0	0	2021-12-30	\N
12	113	0	0	0	2022-01-30	\N
13	113	0	0	0	2022-02-28	\N
14	113	0	0	0	2022-03-30	\N
15	113	0	0	0	2022-04-30	\N
16	113	0	0	0	2022-05-30	\N
17	113	0	0	0	2022-06-30	\N
18	113	0	0	0	2022-07-30	\N
19	113	0	0	0	2022-08-30	\N
20	113	0	0	0	2022-09-30	\N
21	113	0	0	0	2022-10-30	\N
22	113	0	0	0	2022-11-30	\N
23	113	0	0	0	2022-12-30	\N
24	113	0	0	0	2023-01-30	\N
25	113	0	0	0	2023-02-28	\N
26	113	0	0	0	2023-03-30	\N
27	113	0	0	0	2023-04-30	\N
28	113	0	0	0	2023-05-30	\N
29	113	0	0	0	2023-06-30	\N
30	113	0	0	0	2023-07-30	\N
31	113	0	0	0	2023-08-30	\N
32	113	0	0	0	2023-09-30	\N
33	113	0	0	0	2023-10-30	\N
34	113	0	0	0	2023-11-30	\N
35	113	0	0	0	2023-12-30	\N
36	113	0	0	0	2024-01-30	\N
5	114	0	0	0	2021-06-30	\N
6	114	0	0	0	2021-07-30	\N
7	114	0	0	0	2021-08-30	\N
8	114	0	0	0	2021-09-30	\N
1	115	0	0	0	2021-02-28	\N
2	115	0	0	0	2021-03-30	\N
3	115	0	0	0	2021-04-30	\N
4	115	0	0	0	2021-05-30	\N
5	115	0	0	0	2021-06-30	\N
6	115	0	0	0	2021-07-30	\N
7	115	0	0	0	2021-08-30	\N
8	115	0	0	0	2021-09-30	\N
9	115	0	0	0	2021-10-30	\N
10	115	0	0	0	2021-11-30	\N
11	115	0	0	0	2021-12-30	\N
12	115	0	0	0	2022-01-30	\N
13	115	0	0	0	2022-02-28	\N
14	115	0	0	0	2022-03-30	\N
15	115	0	0	0	2022-04-30	\N
16	115	0	0	0	2022-05-30	\N
17	115	0	0	0	2022-06-30	\N
18	115	0	0	0	2022-07-30	\N
19	115	0	0	0	2022-08-30	\N
1	114	100	4.66666666666666696	0	2021-02-28	-39
2	114	100	4.66666666666666696	18	2021-03-30	6
3	114	600	4.66666666666666696	0	2021-04-30	-25
4	114	0	4.66666666666666696	0	2021-05-30	-55
20	115	0	0	0	2022-09-30	\N
21	115	0	0	0	2022-10-30	\N
22	115	0	0	0	2022-11-30	\N
23	115	0	0	0	2022-12-30	\N
24	115	0	0	0	2023-01-30	\N
25	115	0	0	0	2023-02-28	\N
26	115	0	0	0	2023-03-30	\N
27	115	0	0	0	2023-04-30	\N
28	115	0	0	0	2023-05-30	\N
29	115	0	0	0	2023-06-30	\N
30	115	0	0	0	2023-07-30	\N
31	115	0	0	0	2023-08-30	\N
32	115	0	0	0	2023-09-30	\N
33	115	0	0	0	2023-10-30	\N
34	115	0	0	0	2023-11-30	\N
35	115	0	0	0	2023-12-30	\N
36	115	0	0	0	2024-01-30	\N
37	115	0	0	0	2024-02-28	\N
38	115	0	0	0	2024-03-30	\N
39	115	0	0	0	2024-04-30	\N
40	115	0	0	0	2024-05-30	\N
41	115	0	0	0	2024-06-30	\N
42	115	0	0	0	2024-07-30	\N
43	115	0	0	0	2024-08-30	\N
44	115	0	0	0	2024-09-30	\N
45	115	0	0	0	2024-10-30	\N
46	115	0	0	0	2024-11-30	\N
47	115	0	0	0	2024-12-30	\N
48	115	0	0	0	2025-01-30	\N
\.


--
-- TOC entry 3755 (class 0 OID 17035)
-- Dependencies: 203
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamento (codigo, nombre, codigo_unidad) FROM stdin;
1	Recursos Humanos	1
2	Marketing	1
3	Control Financiero	1
4	Informatica	1
5	Operadores	1
6	Telecomunicaciones	1
6	Telecomunicaciones	2
\.


--
-- TOC entry 3775 (class 0 OID 17295)
-- Dependencies: 223
-- Data for Name: detalle_activo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_activo (id_adquisicion, correlativo, id_baja, precio) FROM stdin;
5	1	9	2
5	2	9	3
5	3	11	3.5
5	6	16	0
5	7	16	0
5	10	17	0
7	8	22	120
6	1	23	99
6	2	25	0
6	3	25	0
6	5	26	0
7	6	27	0
9	1	\N	\N
9	4	\N	\N
9	5	\N	\N
9	6	\N	\N
9	7	\N	\N
9	8	\N	\N
12	1	\N	\N
12	2	\N	\N
12	3	\N	\N
12	4	\N	\N
12	5	\N	\N
12	6	\N	\N
13	1	\N	\N
13	2	\N	\N
13	3	\N	\N
13	4	\N	\N
13	5	\N	\N
13	6	\N	\N
13	7	\N	\N
13	8	\N	\N
15	1	\N	\N
6	4	28	500
9	2	28	400
9	3	28	600
\.


--
-- TOC entry 3756 (class 0 OID 17038)
-- Dependencies: 204
-- Data for Name: direccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direccion (id, direccion, codigo_ubicacion) FROM stdin;
48	1Av norte, Bo el centro, casa #12	1006
49	1Av norte, bo el centro casa #12	1008
55	calle al Cementerio	1006
53	Canton san lorenzo	1006
74	dfgdgd	0303
75	Barrio el carmen 2 calle oriente	1006
76	Bo el centro	1006
77	Canton san lorenzo	1008
78	Bo el centro	1006
79	Canton san lorenzo	1008
80	Apopa	0602
81	Bo los angeles	1001
82	Sensuntepeque	0906
83	Bo el calvario	1006
84	bo el centro	1006
85	bo el centro, casa #12	1006
86	bo el centro, casa # 12	1006
88	Bo. el centro	1005
87	1Av norte, parque Cañas	1010
89	san salvador	0601
90	Apopa San Salvador	0602
91	Canton san lorenzo	1008
92	2da.y 4ta. Av. Sur Carretera Panamericana, Barrio el Rosario Ciudad Arce	0502
93	CANTON ISCANALES,CASERIO LA ESCUELA; SANTO DOMINGO SAN VICENTE	1005
94	Apopa San Salvador	0602
95	Barrio el centro	1002
96	frente a gasolinera puma, carretera amapulapa	1010
97	4ta. ave. sur bo. el centro casa #12	0302
98	Barrio el centro	0428
99	Soyapango city	0617
100	Soyapango city, 1 Av norte	0617
\.


--
-- TOC entry 3758 (class 0 OID 17043)
-- Dependencies: 206
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (nit, nit_representante, nombre) FROM stdin;
10002003041011	10060309961011	Tienda Melissa
10100507121015	10102410961011	Variedades Cordova
07979123999912	10000904901016	Empresa ABC S.A de CV
10325454534534	10060309961011	Las carnitas de mamacarmen
10002403232343	10100304201005	La constancia S.A de C.V
\.


--
-- TOC entry 3759 (class 0 OID 17046)
-- Dependencies: 207
-- Data for Name: garantia_fiador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garantia_fiador (id_credito_persona, nit_fiador, id_ingreso_egreso) FROM stdin;
\.


--
-- TOC entry 3760 (class 0 OID 17049)
-- Dependencies: 208
-- Data for Name: ingreso_egreso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingreso_egreso (ingresos_totales, otros_ingresos, ocupacion, nota, id, egresos) FROM stdin;
\.


--
-- TOC entry 3762 (class 0 OID 17054)
-- Dependencies: 210
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (nit, id_direccion, tipo_persona) FROM stdin;
10060309961011	49	PERSONA
10102410961011	53	PERSONA
10101901021014	75	PERSONA
10061503801011	76	PERSONA
10103001201011	77	PERSONA
10062407941003	78	PERSONA
10102501701015	79	PERSONA
10103006631005	80	PERSONA
10042608801002	81	PERSONA
10000904901016	82	PERSONA
10061010771002	83	PERSONA
10062212781015	84	PERSONA
10060206001002	85	PERSONA
10041509951003	86	PERSONA
10002003041011	87	EMPRESA
10101401031011	88	PERSONA
10100507121015	89	EMPRESA
02932110960803	90	PERSONA
10082305961016	91	PERSONA
09602101966021	92	PERSONA
11020206912347	93	PERSONA
07979123999912	94	EMPRESA
10112310961002	95	PERSONA
10325454534534	96	EMPRESA
12312432901213	97	PERSONA
10101234321901	98	PERSONA
10100304201005	99	PERSONA
10002403232343	100	EMPRESA
\.


--
-- TOC entry 3763 (class 0 OID 17057)
-- Dependencies: 211
-- Data for Name: persona_natural; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona_natural (dui, nit, nombres, apellidos, estado_civil, genero, fecha_nacimiento) FROM stdin;
053284768	10060309961011	Victor Ernesto	Acevedo Cornejo	SOLTERO	MASCULINO	1996-03-10
054026303	10102410961011	Melissa Esmeralda	Duran Cordova	SOLTERO	FEMENINO	1996-10-25
063290591	10101901021014	Cindy Yamileth	Cornejo Barahona 	SOLTERO	FEMENINO	2002-01-18
054355767	10061503801011	Maria Cecilia	Barahona Martinez	CASADO	FEMENINO	1980-03-16
023343534	10103001201011	Ian Nicolas	Duran Garcia	SOLTERO	MASCULINO	2000-01-31
433224343	10062407941003	Alexander Antonio	Acevedo Cornejo	SOLTERO	MASCULINO	1994-07-25
034355659	10102501701015	Irene Roxana	Duran Cordova	CASADO	FEMENINO	1970-01-26
023453434	10103006631005	Luis Herman	Duran	CASADO	MASCULINO	1963-07-01
323545345	10042608801002	Diego Antonio	Palacios Menjivar	SOLTERO	MASCULINO	1980-08-27
234453353	10000904901016	José Rafael	Peña Peña	SOLTERO	MASCULINO	1990-04-10
250059645	10061010771002	Fredys Antonio	Acevedo Palacios	SOLTERO	MASCULINO	1977-10-11
012344534	10062212781015	Maria Orbelina	Cornejo Martinez	SOLTERO	FEMENINO	1978-12-23
093454539	10060206001002	Guillermo Carlos	Acevedo Cornejo	SOLTERO	MASCULINO	2000-06-03
234254323	10041509951003	Manuel Adalberto	Arévalo Cornejo	CASADO	MASCULINO	1995-09-16
054125289	10101401031011	David	Rodriguez Cornejo	CASADO	MASCULINO	2003-01-13
376666767	02932110960803	Jose 	Palacio	SOLTERO	MASCULINO	2001-03-07
043456554	10082305961016	Nataly Isabel	Mendez Leonor	SOLTERO	FEMENINO	1996-05-24
096887673	09602101966021	Juan Carlos	Pocasangre	SOLTERO	MASCULINO	1990-02-26
002546798	11020206912347	Astrid Maria	Lopez	CASADO	FEMENINO	1991-06-01
030920155	10112310961002	Roxana Yamileth	Duran Escobar	SOLTERO	FEMENINO	1996-10-23
087912321	12312432901213	Juan Angel	Garcia Cubias	SOLTERO	MASCULINO	1998-06-08
023128992	10101234321901	Ana Teresa	Menjivar	CASADO	FEMENINO	1990-06-18
042334545	10100304201005	Jose Oscar	Peraza	SOLTERO	MASCULINO	1980-01-23
\.


--
-- TOC entry 3764 (class 0 OID 17060)
-- Dependencies: 212
-- Data for Name: politica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.politica (fecha_establecimiento, tasa_interes, tasa_mora, dias_cobro, fecha_finalizacion, id, monto_inferior, monto_superior, tiempo_inferior, gastos_tramitacion, gastos_notario, otras_comisiones, tiempo_superior, tipo_credito) FROM stdin;
2021-01-13	7	3	30	2026-01-13	10	500	1000	6	12	12	0	12	CONSUMO
2021-01-13	10	3	30	2026-01-13	16	1001	3000	6	12	12	0	36	CONSUMO
2021-01-13	13	3	30	2026-01-13	17	3001	8000	6	12	12	0	60	HIPOTECARIO
2021-01-13	16	3	30	2026-01-13	18	8001	13000	6	12	12	0	72	HIPOTECARIO
2021-01-13	19	3	30	2026-01-13	19	13001	20000	6	12	12	0	120	HIPOTECARIO
\.


--
-- TOC entry 3766 (class 0 OID 17065)
-- Dependencies: 214
-- Data for Name: telefono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefono (nit, tipo_contacto, telefono) FROM stdin;
10103001201011	PERSONAL	77231233
10062407941003	PERSONAL	70531623
10102501701015	PERSONAL	71115786
10103006631005	PERSONAL	60124345
10042608801002	PERSONAL	71878345
10000904901016	PERSONAL	60983535
10061010771002	PERSONAL	60786533
10062212781015	PERSONAL	77345440
10060206001002	PERSONAL	71914949
10041509951003	PERSONAL	61788343
10061503801011	CASA	23637283
10102410961011	CASA	23324323
10101901021014	PERSONAL	71128623
10101401031011	PERSONAL	61355788
10002003041011	TRABAJO	21345436
10100507121015	TRABAJO	22652342
02932110960803	PERSONAL	60457890
10082305961016	PERSONAL	67343433
09602101966021	PERSONAL	60239369
11020206912347	PERSONAL	72035504
11020206912347	CASA	22060892
10060309961011	PERSONAL	71484307
07979123999912	TRABAJO	22078923
10112310961002	PERSONAL	75228122
10325454534534	TRABAJO	22234233
12312432901213	PERSONAL	71124578
10101234321901	PERSONAL	76341221
10100304201005	PERSONAL	77434324
10002403232343	TRABAJO	22454098
\.


--
-- TOC entry 3767 (class 0 OID 17068)
-- Dependencies: 215
-- Data for Name: tipo_activo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_activo (codigo, tipo_calculo, nombre) FROM stdin;
1	\N	Terrenos y bienes naturales
2	DEPRECIA	Construcciones
3	DEPRECIA	Instalaciones técnicas
4	DEPRECIA	Maquinaria
5	DEPRECIA	Mobiliario
6	DEPRECIA	Equipos para procesos informático
7	DEPRECIA	Elementos de transporte
8	DEPRECIA	Otros
9	AMORTIZA	Marcas
10	AMORTIZA	Patentes
11	AMORTIZA	Derechos de autor
12	AMORTIZA	Franquicias
13	AMORTIZA	Licencias y permisos
\.


--
-- TOC entry 3768 (class 0 OID 17071)
-- Dependencies: 216
-- Data for Name: ubicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ubicacion (codigo, nombre) FROM stdin;
01	Ahuachapán
0101	Ahuachapán
010100	Area Urbana
010101	Ashapuco
010102	Chancuyo
010103	Chipilapa
010104	Cuyanausul
010105	El Anonal
010106	El Barro
010107	El Junquillo
010108	El Roble
010109	El Tigre
010110	La Coyotera
010111	La Danta
010112	Las Chinamas
010113	Llano De Doña Maria
010114	Llano De La Laguna
010115	Loma De La Gloria
010116	Los Huatales
010117	Los Magueyes
010118	Los Toles
010119	La Montañita
010120	Palo Pique
010121	Rio Frio
010122	San Lazaro
010123	San Ramon
010124	Santa Cruz
010125	Santa Rosa Acacalco
010126	Suntecumat
010127	Tacubita
0102	Apaneca
010200	Area Urbana
010201	El Saitillal
010202	Palo Verde
010203	Quezalapa
010204	San Ramoncito
010205	Taltapanca
010206	Tizapa
010207	Tulapa
0103	Atiquizaya
010300	Area Urbana
010301	El Chayal
010302	El Salitrero
010303	El Tortuguero
010304	El Tapacun
010305	Izcaquilio
010306	Joya Del Platanar
010307	Joya Del Zapote
010308	La Esperanza
010309	Loma De Alarcon
010310	Pepenance
010311	Rincon Grande
010312	San Juan
010313	Santa Rita
010314	Zunca
0104	Concepción De Ataco
010400	Area Urbana
010401	El Arco
010402	El Carrizal
010403	El Limo
010404	El Molino
010405	El Naranjito
010406	El Tronconal
010407	La Ceiba
010408	La Joya De Los Apantes
010409	Los Tablones
010410	San Jose
010411	Shucutitan
010412	Texusin Chirizo
0105	El Refugio
010500	Area Urbana
010501	Comapa
010502	El Rosario
010503	San Antonio
010504	San Juan
0106	Guaymango
010600	Area Urbana
010601	Cauta Abajo
010602	Cauta Arriba
010603	El Carmen
010604	El Escalon
010605	El Rosario
010606	El Zarzal
010607	Istagapan
010608	La Esperanza
010609	La Paz
010610	Los Platanares
010611	Los Puentecitos
010612	Morro Grande
010613	San Andres
010614	San Martin
0107	Jujutla
010700	Area Urbana
010701	Barra De Santiago
010702	El Diamante
010703	Faya
010704	Guayapa Abajo
010705	Guayapa Arriba
010706	Las Mesas
010707	Los Amates
010708	Rosario Abajo
010709	Rosario Arriba
010710	San Antonio
010711	San Jose El Naranjo
010712	Tihuicha
010713	Zapua
0108	San Francisco Menéndez
010800	Area Urbana
010801	Cara Sucia
010802	El Corozo
010803	El Jocotillo
010804	El Sacramento
010805	El Zapote
010806	Garita Palmera
010807	La Ceiba
010808	La Hachadura
010809	San Benito
010810	Agua Fria
0109	San Lorenzo
010900	Area Urbana
010901	El Conacaste
010902	El Jicaral
010903	El Portillo
010904	La Guascota
010905	Las Pozas
010906	San Juan Buena Vista
0110	San Pedro Puxtla
011000	Area Urbana
011001	El Cortez
011002	El Durazno
011003	El Guachipilin
011004	La Concepcion
011005	Pululapa
011006	Texispulco
0111	Tacuba
011100	Area Urbana
011101	Agua Fria
011102	El Chaguite
011103	El Jicaro
011104	El Nispero
011105	El Rodeo
011106	El Rosario
011107	El Sincuyo
011108	La Montaña
011109	La Pandeadura
011110	La Puerta
011111	Loma Larga
011112	Monte Hermoso
011113	San Juan
011114	San Rafael
0112	Turín
011200	Area Urbana
011201	El Jobo
011202	El Paraiso
011203	Santa Rita
02	Santa Ana
0201	Candelaria De La Frontera
020100	Area Urbana
020101	Barranquilla
020102	Casas De Teja
020103	El Chilamate
020104	El Jute
020105	El Paste
020106	El Zacamil
020107	La Criba
020108	La Magdalena
020109	La Parada
020110	Monte Verde
020111	Piedras Azules
020112	San Cristóbal
020113	San Jerónimo
020114	San Miguel
020115	San Vicente
020116	Santa Cruz
020117	Tierra Blanca
0202	Coatepeque
020200	Area Urbana
020201	Caña Brava
020202	Conacastes
020203	Concepción
020204	El Cerro
020205	El Güineo
020206	El Jocotón
020207	El Junquillo
020208	El Pezote
020209	El Tinteral
020210	La Joya
020211	Las Aradas
020212	Nancintepeque
020213	Palo Negro
020214	Piletas
020215	Primavera
020216	Resbaladero
020217	San Felipe
020218	San Jacinto
020219	San José Las Flores
020220	Siete Principes
020221	Solimán
020222	Zacatal
0203	Chalchuapa
020300	Area Urbana
020301	Ayutepeque
020302	Buenos Aires
020303	El Arado
020304	El Coco
020305	El Cuje
020306	El Duraznillo
020307	El Paste
020308	El Tanque
020309	El Zacamil
020310	Galeano
020311	Guachipilín
020312	La Libertad
020313	La Magdalena
020314	La Montañita
020315	Las Cruces
020316	Las Flores
020317	Los Arenales
020318	Los Huatales
020319	Ojo De Agua
020320	Piedra Rajada
020321	Porvenir Jocotillo
020322	San José
020323	San Sebastián
0204	El Congo
020400	Area Urbana
020401	El Güineo
020402	El Pezote
020403	El Rodeo
020404	La Laguna
020405	La Presa
020406	Los Pinos
020407	Montebello
020408	San José Las Flores
020409	Siete Principes
0205	El Porvenir
020500	Area Urbana
020501	El Rosario
020502	Galeano
020503	La Magdalena
020504	San Cristóbal
020505	San Juan Chiquito
020506	Santa Rosa Senca
0206	Masahuat
020600	Area Urbana
020601	Costa Rica
020602	El Carmen
020603	El Jute
020604	Honduritas
020605	La Joya
020606	La Ruda
020607	Laguna Seca
020608	San Sebastián
0207	Metapan
020700	Area Urbana
020701	Aldea  Zapote
020702	Belén Guijat
020703	Cañas Dulces
020704	Cuyuiscat
020705	El Brujo
020706	El Capulín
020707	El Carmen
020708	El Carrizalillo
020709	El Limo
020710	El Panal
020711	El Rosario
020712	El Shiste
020713	La Ceibita
020714	La Isla
020715	La Joya
020716	Lagunetas
020717	Las Pavas
020718	Las Piedras
020719	Llano De La Virgen
020720	Mal Paso
020721	Matalapa
020722	Montenegro
020723	Ostúa
020724	San Antonio La Junta
020725	San Antonio Masahuat
020726	San Jerónimo
020727	San José Camulian
020728	San José Ingenio
020729	San Juan Las Minas
020730	San Miguel Ingenio
020731	San Sebastián
020732	Santa Rita
020733	Santo Tomás
020734	Tahuilapa
020735	Tecomapa
0208	San Antonio Pajonal
020800	Area Urbana
020801	Belén Guijat
020802	El Ángel
020803	El Barrial
020804	El Mojón
020805	El Tablón
020806	La Danta
020807	La Piedrona
020808	Las Pilas
020809	San Cayetano
020810	San Miguel
0209	San Sebastián Salitrillo
020900	Area Urbana
020901	Los Amates
020902	Monte Largo
020903	San José
020904	San Luis
020905	Santa Bárbara
020906	Santa Rosa
0210	Santa Ana
021000	Area Urbana
021001	Ayuta
021002	Ayutepeque
021003	Buenos Aires
021004	Calzontes Abajo
021005	Calzontes Arriba
021006	Cantarrana
021007	Chilcuyo
021008	Chupaderos
021009	Comecayo
021010	Cujucuyo
021011	Cutumay Camones
021012	El Jute
021013	El Portezuelo
021014	Flor Amarilla Abajo
021015	Flor Amarilla Arriba
021016	La Empalizada
021017	La Montañita
021018	La Parada
021019	Las Aradas
021020	Loma Alta
021021	Lomas De San Marcelino
021022	Los Amates
021023	Los Apoyos
021024	Monte Largo
021025	Nancintepeque
021026	Natividad
021027	Ochupse Abajo
021028	Ochupse Arriba
021029	Palo De Campana
021030	Pinalito
021031	Pinalón
021032	Planes De La Laguna
021033	Potrerillos Abajo De La Laguna
021034	Potrerillos De La Laguna
021035	Potrerillos Del Matazano
021036	Potrero Grande Abajo
021037	Potrero Grande Arriba
021038	Primavera
021039	Ranchador
021040	San Juan Buena Vista
021041	Tablón Del Matazano
021042	Valle Del Matazano
0211	Santa Rosa Guachipilín
021100	Area Urbana
021101	El Despoblado
021102	El Matazano
021104	Las Piedras
021105	Llano De Las Majadas
021106	Palo Galán
021107	San Francisco Apanta
021108	San José Capulín
021109	Santa Rita Cimarrón
021110	Sunapa
0212	Santiago De La Frontera
021200	Area Urbana
021201	Barranquilla
021202	Chilamates
021203	El Flor
021204	Guacamayas
021205	La Danta
021206	Las Piletas
021207	Piedras Azules
021208	San Cayetano
021209	San Vicente
021210	Santa Cruz
0213	Texistepeque
021300	Area Urbana
021301	Chilcuyo
021302	Costa Rica
021303	Cujucuyo
021304	El Jute
021305	Pinalón
021306	San Antonio Masahuat
021307	San Jerónimo
021308	San Miguel
021309	Santo Tomás
03	Sonsonate
0301	Acajutla
030100	Area Urbana
030101	El Coyol
030102	El Salamo
030103	El Suncita
030104	Metalio
030105	Morro Grande
030106	Punta Remedios
030107	San Julian
030108	Valle Nuevo
0302	Armenia
030200	Area Urbana
030201	Azacualpa
030202	El Cerro
030203	El Guayabo
030204	El Rosario
030205	La Puerta
030206	Las Crucitas
030207	Los Mangos
030208	Tres Ceibas
030209	Valle Nuevo
0303	Caluco
030300	Area Urbana
030301	Agua Caliente
030302	Cerro Alto
030303	El Castaño
030304	El Zapote
030305	Las Flores
030306	Los Gramales
030307	Plan De Amayo
030308	Suquiat
0304	Cuisnahuat
030400	Area Urbana
030401	Agua Shuca
030402	Apancoyo
030403	Chiquihuat
030404	Coquiama
030405	Los Dos Rios
030406	El Achiotal
030407	El Balsamar
030408	Salinas De Ayacachapa
030409	San Lucas
0305	Santa Isabel Ishuatán
030500	Area Urbana
030501	Acachapa
030502	Apancoyo
030503	Atiluya
030504	El Corozal
030505	El Paraiso
030506	Las Piedras
030507	Miramar
030508	Paso De Canoas
030509	Salinas De Ayacachapa
0306	Izalco
030600	Area Urbana
030601	Cangrejera
030602	Ceiba Del Charco
030603	Chorro Abajo
030604	Chorro Arriba
030605	Cruz Grande
030606	Cuntan
030607	Cuyagualo
030608	El Sunza
030609	Huiscoyolate
030610	Joya De Ceren
030611	La Chapina
030612	Las Higueras
030613	Las Lajas
030614	Las Marías
030615	Piedras Pachas
030616	Quebrada Española
030617	San Isidro
030618	Shon Shon
030619	Talcomunca
030620	Tapalshucut
030621	Tecuma
030622	Teshcal
030623	Tres Ceibas
030624	Tunalmiles
0307	Juayua
030700	Area Urbana
030701	Buenos Aires
030702	La Puente
030703	La Unión
030704	Los Apantes
030705	Los Cañales
030706	Los Naranjos
030707	Ojo De Agua
030708	San José La Majada
030709	San Juan De Dios
030710	Valle Nuevo
0308	Nahuizalco
030800	Area Urbana
030801	Anal Abajo
030802	Anal Arriba
030803	Cusamaluco
030804	El Canelo
030805	El Carrizal
030806	El Cerrito
030807	El Chaparrón
030808	La Guacamaya
030809	Los Arenales
030810	Pushtán
030811	Sabana Grande
030812	Sabana San Juan Abajo
030813	Sabana San Juan Arriba
030814	Sisimitepec
030815	Tajcuilujlan
030816	Loma Del Muerto
030817	Los Apantes
0309	Nahulingo
030900	Area Urbana
030901	Aleman
030902	Conacaste Herrado
030903	El Guayabo
030904	Piedra De Moler
0310	Salcoatitán
031000	Area Urbana
031001	El Puente
031002	Los Anizales
0311	San Antonio Del Monte
031100	Area Urbana
031101	Agua Santa
031102	Cuyuapa Abajo
031103	Cuyuapa Arriba
031104	El Castaño
031105	Las Hojas
031106	San Ramón
0312	San Julián
031200	Area Urbana
031201	Agua Shuca
031202	Chilata
031203	El Achiotal
031204	El Bebedero
031205	Los Lagartos
031206	Palo Verde
031207	Peña Blanca
031208	Petacas
031209	San Julian
031210	Tierra Colorada
0313	Santa Catarina Masahuat
031300	Area Urbana
031301	Cuyuapa
031302	El Matazano
031303	Las Peñas
031304	San Rafael
031305	Cuyuapa Arriba
0314	Santo Domingo De Guzmán
031400	Area Urbana
031401	El Carrizal
031402	El Caulote
031403	El Zarzal
031404	El Zope
0315	Sonsonate
031500	Area Urbana
031501	Chiquihuat
031502	El Cacao
031503	El Edén
031504	El Presidio
031505	La Ensenada
031506	Las Delicias
031507	Las Tablas
031508	Loma Del Muerto
031509	Miravalle
031510	Salinas De Ayacachapa
031511	San Julián
031512	Santa Emilia
031513	Tonalá
0316	Sonzacate
031600	Area Urbana
031601	El Almendro
04	Chalatenango
0401	Agua Caliente
040100	Area Urbana
040101	Agua Fría
040102	Agua Zarca
040103	Cerro Grande
040104	Encumbrado
040105	Obrajuelo
040106	Ojos De Agua
040107	Santa Rosa
0402	Arcatao
040200	Area Urbana
040201	Cerro Grande
040203	Las Vegas
040204	Los Filos
040205	Los Sitios
040206	Teosinte
0403	Azacualpa
040300	Area Urbana
040301	Cuesta Marina
040302	El Llano
0404	Citalá
040400	Area Urbana
040401	Gualcho
040402	Lagunetas
040403	Los Planes
040404	Llano De La Virgen
040405	San Francisco
040406	San Lorenzo
040407	San Ramón
040408	Talquezalar
040409	El Rosario
0405	Comalapa
040500	Area Urbana
040501	Candelaria
040502	El Morro
040503	Guachipilín
040504	La Junta
040505	Los Achotes
0406	Concepción Quezaltepeque
040600	Area Urbana
040601	El Conacaste
040602	El Rosario
040603	Llano Grande
040604	Monte Redondo
040605	Olosingo
0407	Chalatenango
040700	Area Urbana
040701	Chiapas
040702	Guarjila
040703	Las Minas
040704	San Bartolo
040705	San José
040706	Upatoro
0408	Dulce Nombre De María
040800	Area Urbana
040801	Cuevitas
040802	Chorro Blanco
040803	El Común
040804	El Ocotal
040805	El Rosario
040806	Los Achiotes
040807	Los Encuentros
040808	Los Gutiérrez
040809	Los Sitios
0409	El Carrizal
040900	Area Urbana
040901	La Trinidad
040902	Petapa
040903	Potrerillos
040904	Vainillas
040905	La Cuchilla
0410	El Paraiso
041000	Area Urbana
041001	El Tablón
041002	Santa Bárbara
041003	Valle Nuevo
0411	La Laguna
041100	Area Urbana
041101	La Cuchilla
041102	Las Pacayas
041103	Los Prados
041104	Plan Verde
041105	San José
0412	La Palma
041200	Area Urbana
041201	El Aguacatal
041202	El Gramal
041203	El Túnel
041204	Las Granadillas
041205	Los Horcones
041206	Los Planes
041207	San José Calera
041208	San José Sacare
0413	La Reina
041300	Area Urbana
041301	El Pepeto
041302	El Tigre
041303	Las Cañas
041305	Los Tecomates
041306	Talchaluya
041307	Tilapa
0414	Las Vueltas
041400	Area Urbana
041401	Conacaste
041402	La Ceiba
041403	La Laguna
041404	Los Naranjos
041405	San José
041406	Sicahuite
0415	Nombre De Jesús
041500	Area Urbana
041501	Los Escalante
041502	Los Henríquez
041503	Patamera
041504	Plazuelas
041505	Potrerillos
041506	Quipure
0416	Nueva Concepción
041600	Area Urbana
041601	El Gavilán
041602	El Zapote
041603	Laguna Seca
041604	Las Tablas
041605	Chilamates
041606	Potenciana
041607	Potrero Sula
041608	Santa Rita Cimarrón
041609	Santa Rosa
041610	Sunapa
0417	Nueva Trinidad
041700	Area Urbana
041701	Carasque
041702	El Sitio
041703	El Zacamil
041704	Las Vegas
041705	Huizucar
041706	Jaguatalla
0418	Ojos De Agua
041800	Area Urbana
041801	Coyolar
041802	El Portillo
041803	El Sitio
041804	El Tablón
041805	El Zapotal
041806	La Montañita
041807	Yurique
0419	Potonico
041900	Area Urbana
041901	Corral Falso
041902	La Montaña
041903	Monte Redondo
041904	Plan De Las Pozas
041905	Santa Teresa
0420	San Antonio De La Cruz
042000	Area Urbana
042001	Copalío
042002	El Zapote
042003	San Benito
042004	Santa Ana
0421	San Antonio Los Ranchos
042100	Area Urbana
042101	El Gramal
0422	San Fernando
042200	Area Urbana
042201	Los Llanitos
042202	Jocotán
042203	Nuevo San Fernando Roblar
042204	San Juan De La Cruz
042205	Valle De Jesús
0423	San Francisco Lempa
042300	Area Urbana
042301	Los Menjivar
042302	Los Zepeda
0424	San Francisco Morazán
042400	Area Urbana
042401	Higueral
042402	Las Cañitas
042403	Las Parvitas
042404	Los Naranjos
042405	Plan Del Horno
042406	San Miguelito
042407	Teosinte
042408	Tremedal
042409	Sumpul De Avelar
042410	Sumpul De Chacón
042411	Río Grande De Alvarado
0425	San Ignacio
042500	Area Urbana
042501	El Carmen
042502	El Centro
042503	El Pinar
042504	El Rosario
042505	Las Pilas
042506	Río Chiquito
042507	Santa Rosa
0426	San Isidro Labrador
042600	Area Urbana
042601	Alvarenga
042602	El Mojón
042603	Los Amates
042604	San José De La Montaña
042605	El Sicahuital
0427	Cancasque
042700	Area Urbana
042701	Candelaria
042702	Concepción
042703	Los Guillen
042704	Portillo Del Norte
0428	Las Flores
042800	Area Urbana
042801	Aldea Vieja
042802	Hacienda
042803	Hacienda Vieja
042804	Lagunita
042805	Las Limas
042806	Llano Verde
0429	San Luis Del Carmen
042900	Area Urbana
042901	El Pital
042902	El Sitio
042903	Los Naranjos
042904	Santa Cruz
0430	San Miguel De Mercedes
043000	Area Urbana
043001	Cerro De La Cruz
043002	El Matazano
043003	El Salitre
043004	Los Guardado
043005	Piedras Gordas
0431	San Rafael
043100	Area Urbana
043101	Ojos De Agua
043102	Los Desamparados
043103	San Antonio Buena Vista
043104	San José Los Sitios
0432	Santa Rita
043200	Area Urbana
043201	Barillas
043202	El Chilamate
043203	San Miguel Tobías
043204	San Nicolás Piedras Gordas
0433	Tejutla
043300	Area Urbana
043301	Aguaje Escondido
043302	Aldeita
043303	Concepción
043304	El Carrizal
043305	El Cerrón
043306	El Izotal
043307	El Salitre
043308	El Transito
043309	Estanzuelas
043310	Los Aposentos
043311	Los Martínez
043312	Quitasol
043313	Río Grande De Alvarados
043314	Río Grande De Cardoza
043315	San José
05	La Libertad
0501	Antiguo Cuscatlán
050100	Area Urbana
050101	El Espino
050102	La Labranza
0502	Ciudad Arce
050200	Area Urbana
050201	El Conacaste
050202	Flor Amarilla
050203	La Esperanza
050204	La Reforma
050205	Las Cruces
050206	Lomas De Andalucía
050207	Los Acostas
050208	San Andrés
050209	San Antonio Abad
050210	Santa Lucía
050211	Santa Rosa
050212	Veracruz
050213	Zapotitán
0503	Colón
050300	Area Urbana
050301	Botoncillal
050302	El Capulín
050303	El Cobanal
050304	El Manguito
050305	Entre Ríos
050306	Las Angosturas
050307	Las Brisas
050308	Las Delicias
050309	Lourdes
050310	San José Los Sitios
050311	Victoria
0504	Comasagua
050400	Area Urbana
050401	El Conacaste
050402	El Faro
050403	El Majahual
050404	El Matazano
050405	El Peñón
050406	El Rosario
050407	La Shila
050408	Los Amates
050409	San Antonio
050410	Sana Lucia
050411	Tarpeya
0505	Chiltiupán
050500	Area Urbana
050501	Cuervo Abajo
050502	Cuervo Arriba
050503	El Zonte
050504	El Regadillo
050505	Juan Higinio O La Cumbre
050506	Julupe
050507	La Perla
050508	Las Flores
050509	Santa Lucia
050510	Santa Marta
050511	Siberia
050512	Sunzacuapa
050513	Taquillo
050514	Termopilas
0506	Huizucar
050600	Area Urbana
050601	Amaquilco
050602	Amulunca
050603	El Cedro
050604	La Lima
050605	Ojos De Agua
050606	Nazareth
050607	Tilapa
050608	San Juan Buenavista
0507	Jayaque
050700	Area Urbana
050701	Juan Higinio O La Cumbre
050702	La Labor
050703	Las Flores
050704	Las Minas
050705	Los Alpes
050706	San José Los Sitios
050707	Las Tinieblas
0508	Jicalapa
050800	Area Urbana
050801	Candelaria
050802	El Angel
050803	El Carrizo
050804	El Níspero
050805	La Argentina
050806	La Perla
050807	Metayo
050808	San Isidro
050809	San Jose El Tablon
050810	Santa Lucía
0509	La Libertad
050900	Area Urbana
050901	Cangrejera
050902	El Cimarrón
050903	El Majahual
050904	El Rosario
050905	El Palomar
050906	San Juan Buena Vista
050907	San Diego
050908	Melara
050909	San Rafael
050911	Tecualuya
0510	Nuevo Cuscatlán
051000	Area Urbana
051001	Florencia
051099	Resto De Area Rural
0511	Santa Tecla
051100	Area Urbana
051101	Álvarez
051102	Ayagualo
051103	Buena Vista
051104	El Cobanal
051105	El Limon
051106	El Matazano
051107	El Progreso
051108	El Quequeishque
051109	El Sacazil
051110	El Triunfo
051111	Las Granadillas
051112	Loma Larga
051113	Los Amates
051114	Los Pajales
051115	Victoria
0512	Quezaltepeque
051200	Area Urbana
051201	Sitio Los Nejapa
051202	El Matazano
051203	El Puente
051204	El Señor
051205	Girón
051206	Las Granadillas
051208	Las Mercedes
051209	Macance
051210	Platanillos
051211	Primavera
051212	San Francisco
051213	San Juan Los Planes
051214	Segura
051215	Tacachico
0513	Sacacoyo
051300	Area Urbana
051301	Ateos
051302	Buena Vista
051303	El Tigre
051304	El Transito
051305	La Montañita
051306	Lomas De Cerna
051307	San Antonio
051308	Tres Ceibas
051309	Zapotitan
0514	San José Villanueva
051400	Area Urbana
051401	El Escalón
051402	El Matazano
051403	El Palomar
051404	Las Dispensas
051405	Tula
0515	San Juan Opico
051500	Area Urbana
051501	Agua Escondida
051502	Barranca Honda
051503	Buena Vista
051504	Chanmico
051505	Chantusnene
051506	El Carmen
051507	El Castillo
051508	El Jabalí
051509	El Matazano
051510	Flor Amarilla
051511	Joya De Ceren
051512	La Puebla
051513	La Nueva Encarnación
051514	Las Delicias
051515	Las Granadillas
051516	Los Amates
051517	Minas De Plomo
051518	Moncagua
051519	Nombre De Dios
051520	Pitichorro
051521	Primavera
051522	San Antonio
051523	San Antonio Tehuicho
051524	San Felipe
051525	San José La Cueva
051526	San Pedro Martír
051527	San Pedro Oriente
051528	San Nicolás Encarnación
051529	San Nicolás Los Encuentros
051530	Sitio Del Niño
051531	Sitio Grande
051532	Sitio Roma
051533	Lomas De Santiago
051599	Resto De Area Rural
0516	San Matías
051600	Area Urbana
051601	El Jícaro
051602	El Jocote
051603	La Puebla
051604	Las Anonas
051605	Masajapa
051606	San Pedro Las Flores
051607	Santa Rosa
051608	Santa Teresa
0517	San Pablo Tacachico
051700	Area Urbana
051701	Atiocoyo
051702	Campana
051703	El Transito
051704	Las Anonas
051705	Las Mesas
051706	Mogotes
051707	Moncagua
051708	Obraje Nuevo
051709	San Isidro
051710	San Pedro Las Flores
0518	Tamanique
051800	Area Urbana
051801	Buenos Aires
051802	El Cuervo
051803	El Palmar
051804	El Peñón
051805	El Sunzal
051806	Juan Higinio O La Cumbre
051807	San Alfonso
051808	San Benito
051809	Santa Lucía
051810	Siberia
051811	Tarpeya
0519	Talnique
051900	Area Urbana
051901	Juan Higinio O La Cumbre
051902	Las Quebradas
051903	Loma Larga
051904	Los Amates
051905	Los Cipreses
051906	Los Laureles
051907	San Carlos
051908	San José Los Sitios
051909	Santa Lucía
0520	Teotepeque
052000	Area Urbana
052001	El Ángel
052002	El Matazano
052003	El Níspero
052004	Las Tinieblas
052005	Los Izotes
052006	San Benito
052007	San Isidro
052008	San Jose El Tablon
052009	San Marcos
052010	Santa María Mizata
052011	Sihuapilapa
0521	Tepecoyo
052100	Area Urbana
052101	El Carrizo
052102	El Guamo
052103	El Mojón
052104	El Zacamil
052105	La Javia
052106	Las Flores
052107	Los Alpes
052108	Los Laureles
052109	San Antonio
052110	Tierra Colorada
0522	Zaragoza
052200	Area Urbana
052201	El Barillo
052202	El Cimarrón
052203	El Riel
052204	Guadalupe
052205	Las Granadillas
052206	San Francisco
052207	San Sebastián
06	San Salvador
0601	Aguilares
060100	Area Urbana
060101	La Florida
060102	La Toma
060103	Pishishapa
060104	Las Tunas
060105	Los Mangos
060106	Piñalitos
0602	Apopa
060200	Area Urbana
060201	El Ángel
060202	Guadalupe
060203	Joya Galana
060204	Joya Grande
060205	Las Delicias
060206	San Nicolás
060207	Suchinango
060208	Tres Ceibas
060209	Santa Bárbara
0603	Ayutuxtepeque
060300	Area Urbana
060301	El Zapote
060302	Los Llanitos
0604	Cuscatancingo
060400	Area Urbana
060401	San Luis Mariona
0605	El Paisnal
060500	Area Urbana
060501	El Jicarón
060502	El Matazano
060503	El Tronador
060504	La Cabaña
060505	Las Delicias
060506	Las Ventanas
060507	Natividad
060508	Potrero Grande
060509	San Antonio Grande
060510	San Diego
060511	San Francisco Dos Cerros
060512	San Rafael
0606	Guazapa
060600	Area Urbana
060601	Calle Nueva
060602	Loma De Ramos
060603	Nance Verde
060604	San Cristóbal
060605	San Jerónimo
060606	San Lucas
060607	Santa Bárbara
060608	Zacamil
0607	Ilopango
060700	Area Urbana
060701	Changallo
060702	Dolores Apulo
0608	Mejicanos
060800	Area Urbana
060801	Chancala
060802	San Miguel
060803	San Roque
060804	Zacamil
0609	Nejapa
060900	Area Urbana
060901	Aldea Mercedes
060902	Camotepeque
060903	Conacaste
060904	El Bonete
060905	El Salitre
060906	Galera Quemada
060907	San Jerónimo Los Planes
060908	Tutultepeque
0610	Panchimalco
061000	Area Urbana
061001	Amayón
061002	Azacualpa
061003	El Cedro
061004	El Divisadero
061005	El Guayabo
061006	Las Crucitas
061007	Loma Y Media
061008	Los Pajales
061009	Los Palones
061010	Los Troncones
061011	Planes De Renderos
061012	Panchimalco
061013	Quezalapa
061014	San Isidro
0611	Rosario De Mora
061100	Area Urbana
061101	Cerco De Piedra
061102	El Carrizal
061103	El Jutillo
061104	Las Barrosas
061105	Palo Grande
061106	Plan Del Mango
061107	San Ramón
061108	Loma Y Media
061109	Las Margaritas
0612	San Marcos
061200	Area Urbana
061201	Ahuacatitán
061202	Casa De Piedra
061203	Cerro Amatepec
061204	Planes De Renderos
061205	Florencia
0613	San Martín
061300	Area Urbana
061301	El Rosario
061302	El Sauce
061303	La Flor
061304	La Palma
061305	Las Animas
061306	Las Delicias
061307	San José Primero
061308	San José Segundo
061309	Corinto
0614	San Salvador
061400	Area Urbana
061401	Casa De Piedra
061402	El Carmen
061403	Llanitos
061404	Lomas De Candelaria
061405	Planes De Renderos
061406	San Isidro Los Planes
061407	Cerro Amatepec O San Jacinto
0615	Santiago Texacuangos
061500	Area Urbana
061501	Asino
061502	El Morro
061503	Joya Grande
061504	La Cuchilla
061505	Shaltipa
0616	Santo Tomas
061600	Area Urbana
061601	Caña Brava
061602	Chaltepe
061603	El Ciprés
061604	El Guaje
061605	El Carmen
061606	El Porvenir
061608	Las Casitas
061609	Potrerillos
061610	Los Palones
0617	Soyapango
061700	Area Urbana
061701	Buena Vista
061702	El Cacao
061703	El Guaje
061704	El Limon
061705	El Transito
0618	Tonacatepeque
061800	Area Urbana
061801	El Rosario
061802	El Sauce
061803	El Transito
061804	La Fuente
061805	La Unión
061806	Las Flores
061807	Malacoff
061808	Veracruz
061809	Buenos Aires
0619	Delgado
061900	Area Urbana
061901	Calle Real
061902	La Cabaña
061903	Plan Del Pino
061904	San José Cortez
061905	San Laureano
061906	El Arenal
07	Cuscatlán
0701	Candelaria
070100	Area Urbana
070101	Concepción
070102	El Rosario
070103	Nance Verde
070104	San Antonio
070105	San José La Ceiba
070106	San Juan Miraflores Abajo
070107	San Juan Miraflores Arriba
070108	San Rafael La Loma
070109	La Palma
0702	Cojutepeque
070200	Area Urbana
070201	Cujuapa
070202	El Carrizal
070203	Jiñuco
070204	La Palma
070205	Los Naranjos
070206	Ojos De Agua
0703	El Carmen
070300	Area Urbana
070301	Candelaria
070302	Concepción
070303	El Carmen
070304	La Paz
070306	San Sebastián
070307	Santa Lucía
0704	El Rosario
070400	Area Urbana
070401	El Amatillo
070402	El Calvario
070403	San Martín
070404	Veracruz
0705	Monte San Juan
070500	Area Urbana
070501	Candelaria
070502	Concepción
070503	El Carmen
070504	El Rosario
070505	La Soledad
070506	San Andrés
070507	San Antonio
070508	San José
070509	San Martín
070510	San Nicolás
0706	Oratorio De Concepción
070600	Area Urbana
070601	Palacios
070602	Tacanagua
0707	San Bartolome Perulapía
070700	Area Urbana
070701	El Triunfo
070702	Las Lomas
0708	San Cristobal
070800	Area Urbana
070801	La Virgen
070802	San Antonio
070803	San Francisco
070804	San José
070805	Santa Anita
070806	Santa Cruz
0709	San José Guayabal
070900	Area Urbana
070901	Animas
070902	El Salitre
070903	La Cruz
070904	Llano Grande
070905	Los Meléndez
070906	Los Rodríguez
070907	Palacios
070908	Piedra Labrada
070909	Ramírez
070910	Montepeque
0710	San Pedro Perulapán
071000	Area Urbana
071001	Buena Vista
071002	Buenos Aires
071003	El Carmen
071004	El Espino
071005	El Limon
071006	El Paraiso
071007	El Rodeo
071008	Huisiltepeque
071009	Istagua
071010	La Cruz
071011	La Esperanza
071012	La Loma
071013	Miraflores
071014	San Agustín
071015	San Francisco
071016	Tecoluco
071017	Tecomatepe
0711	San Rafael Cedros
071100	Area Urbana
071101	Cerro Colorado
071102	Copinol
071103	El Espinal
071104	Jiboa
071105	Palacios
0712	San Ramón
071200	Area Urbana
071201	San Agustín
071202	San Pablo
071203	San Pedro
071204	Santa Isabel
0713	Santa Cruz Analquito
071300	Area Urbana
071301	Barrio Abajo
0714	Santa Cruz Michapa
071400	Area Urbana
071401	Animas
071402	Buena Vista
071403	Delicias
071404	El Centro
071405	Michapa
071406	Rosales
071407	Jiñuco
0715	Suchitoto
071500	Area Urbana
071501	Aguacayo
071502	Buena Vista
071503	Colima
071504	Consolación
071505	Copapayo
071506	Corozal
071507	El Caulote
071508	El Molino
071509	El Roble
071510	El Zapote
071511	Estanzuelas
071512	Guadalupe
071513	Haciendita
071514	Ichanquezo
071515	La Bermuda
071516	Las Delicias
071517	Milingo
071518	Mirandilla
071519	Montepeque
071521	Palo Grande
071522	Pepeshtenango
071524	San Cristóbal
071526	Tenango
0716	Tenancingo
071600	Area Urbana
071601	Ajuluco
071602	Copalchan
071603	Corral Viejo
071604	El Pepeto
071605	Huisiltepeque
071606	Jiñuco
071607	Rosario Perico
071608	Rosario Tablón
071609	Santa Anita
08	La Paz
0801	Cuyultitán
080100	Area Urbana
080101	San Antonio
080102	San Isidro
0802	El Rosario
080200	Area Urbana
080201	Amatepec
080202	El Cerro
080203	El Pedregal
080204	Tilapa
0803	Jerusalén
080300	Area Urbana
080301	El Conacaste
080302	El Espino
080303	Los Romero
080304	Veracruz
080305	San Juan Buena Vista
0804	Mercedes La Ceiba
080400	Area Urbana
080401	San Antonio
080402	San Luis
0805	Olocuilta
080500	Area Urbana
080501	Cupinco
080502	El Chilamate
080503	Los Guachipilines
080504	Joya De Girón
080505	La Esperanza
080506	Planes De Las Delicias
080507	San Antonio Girón
080508	San José Buenavista
080509	Jayuca
080510	San Sebastián
080511	Santa Fe
080512	Santa Lucía La Barranca
080513	Santo Tomás
080514	Valle Nuevo
080515	Santa Lucía Orcoyo
0806	Paraiso De Osorio
080600	Area Urbana
080601	El Copinol
080602	Los Zacatales
080603	El Rincón
0807	San Antonio Masahuat
080700	Area Urbana
080701	Belén
080702	El Socorro
080703	San Antonio La Loma
080704	San José La Instancia
080705	San José Los Solares
0808	San Emigdio
080800	Area Urbana
080801	Concepción Lourdes
080802	San José Costa Rica
0809	San Francisco Chinameca
080900	Area Urbana
080901	San Antonio Panchimilama
080902	Concepción Los Planes
080903	Candelaria
080904	Santa Cruz La Vega
080905	San José La Montaña
0810	San Juan Nonualco
081000	Area Urbana
081001	El Golfo
081002	El Pajal
081003	La Laguneta
081004	La Longaniza
081005	Las Delicias
081006	Los Zacatillos
081007	Las Piedronas
081008	El Salto
081009	El Chile
081010	Tehuiste Abajo
081011	Tehuiste Arriba
081012	Tierra Colorada
0811	San Juan Talpa
081100	Area Urbana
081101	Comalapa
081102	Tobalón
081103	Veracruz
0812	San Juan Tepezontes
081200	Area Urbana
081201	La Cruz
081202	La Esperanza
081203	Los Laureles
0813	San Luis Talpa
081300	Area Urbana
081301	Amatecampo
081302	Cuchilla De Comalapa
081303	El Pimiental
081304	El Porvenir
081305	Nuevo Edén
081306	San Francisco Amatepec
081307	Tecualuya
081308	Zambombera
0814	San Miguel Tepezontes
081400	Area Urbana
081401	San Bartolo
081402	Soledad Las Flores
0815	San Pedro Masahuat
081500	Area Urbana
081501	Barahona
081502	Buena Vista
081504	El Achiotal
081505	El Carmen
081506	El Dulce Nombre
081507	El Paredón
081509	El Porvenir
081510	El Sicahuite
081511	Las Flores
081512	Las Hojas
081513	Las Isletas
081515	Marcelino
081516	San José Luna
081517	Santa María La Sabana
0816	San Pedro Nonualco
081600	Area Urbana
081601	El Lazareto
081602	El Roble
081603	Hacienda Vieja
081604	La Carbonera
081605	La Comunidad
081606	Nahuistepeque
081607	San Ramón
0817	San Rafael Obrajuelo
081700	Area Urbana
081701	El Carao
081702	La Longaniza
081703	La Palma
081704	San Jerónimo
081705	San José Obrajuelo
081706	San Pedro Martír
081707	San Miguel Obrajuelo
0818	Santa Maria Ostuma
081800	Area Urbana
081801	Concepción
081802	El Chaperno
081803	El Transito
081804	Loma Larga
081805	San Antonio
081806	San Isidro
081807	San José Carrizal
0819	Santiago Nonualco
081900	Area Urbana
081901	Amulunco
081902	Concepción Jalponga
081904	El Sauce
081905	La Cruz Del Mojón
081906	Las Animas
081907	Las Guarumas
081909	San Antonio Abajo
081910	San Antonio Arriba
081911	San Francisco Hacienda
081912	San Francisco El Porfiado
081913	San José Loma
081914	San José Obrajito
081915	San Luis Jalponguita
081916	San Sebastián Abajo
081917	San Sebastián Arriba
081918	Santa Cruz Chacastal
081919	Santa Cruz La Loma
081920	Santa Rita Almendro
081921	Santa Teresa
081922	San José Abajo
081923	San José Arriba
0820	Tapalhuaca
082000	Area Urbana
082001	La Basa
082002	Las Lajas
082003	San Pedro La Palma
0821	Zacatecoluca
082100	Area Urbana
082101	Agua Zarca
082102	Amayo
082103	Animas Abajo
082104	Animas Arriba
082105	Azacualpa
082106	Buena Vista Abajo
082107	Buena Vista Arriba
082109	El Amate
082110	El Callejón
082111	El Carmen
082112	El Copinol
082113	El Despoblado
082114	El Espino Abajo
082115	El Espino Arriba
082116	El Meneadero
082117	El Socorro
082118	El Zapote
082119	Hatos De Los Reyes
082120	La Joya
082121	La Lucha
082122	Las Isletas
082123	Las Tablas
082124	Liévano
082125	Los Platanares
082126	Penitente Abajo
082127	Penitente Arriba
082128	Piedra Grande Abajo
082129	Piedra Grande Arriba
082130	Pineda
082131	San Francisco Los Reyes
082132	San José La Montaña
082133	San Josecito
082134	San Lucas
082135	San Marcos De La Cruz
082136	San Rafael
082138	Santa Lucía
082139	Tepechame
082140	Tierra Blanca
082141	Ulapa
0822	San Luis La Herradura
082200	Area Urbana
082201	El Cordoncillo
082202	El Llano
082203	El Zapote
082204	Guadalupe La Zorra
082205	La Anona
082206	La Calzada
082207	San Antonio Los Blancos
082208	El Escobal
082209	San Rafael Tasajera
082210	San Sebastián El Chingo
09	Cabañas
0901	Cinquera
090100	Area Urbana
090101	Dulce Nombre O La Escopeta
090102	El Cacao
090103	Huilihuiste
090104	San Antonio
090105	San Benito
090106	San José El Tule
090107	San Nicolás
090108	Valle Nuevo
090109	El Pepeto
0902	Guacotecti
090200	Area Urbana
090201	Agua Zarca
090202	El Bañadero
090203	Tempisque Abajo
090204	Pie De La Cuesta
0903	Ilobasco
090300	Area Urbana
090301	Agua Zarca
090302	Azacualpa
090303	Cerro Colorado
090305	Potrero
090306	La Labor
090307	Las Huertas
090308	Los Hoyos
090309	Los Llanitos
090310	Maquilishuat
090311	Oratorio
090312	Nanastepeque
090313	San José Calera
090314	San José
090315	San Francisco Del Monte
090316	San Francisco Iraheta
090317	Santa Cruz
090318	Sitio Viejo
0904	Jutiapa
090400	Area Urbana
090401	Caleras
090402	Carolina
090403	El Platanar
090404	Llano Largo
090405	Palacios
090406	San Sebastián
090407	Santa Bárbara
090408	El Mestizo
0905	San Isidro
090500	Area Urbana
090501	El Amate
090502	Izcatal
090503	Llano De La Hacienda
090504	Los Jobos
090505	Potrero De Batres
090506	Potrero Y Tabla
090507	San Francisco
0906	Sensuntepeque
090600	Area Urbana
090601	Copinolapa
090602	Cunchique
090603	Cuyantepeque
090604	Chunte
090605	El Aguacate
090606	El Volcán
090607	La Trinidad
090608	Las Marías
090609	Los Llanitos
090610	Llano Grande
090611	Nombre De Dios
090612	Pie De La Cuesta
090613	Río Grande
090614	Rojas
090615	San Gregorio
090616	San Lorenzo
090617	San Marcos
090618	San Matías
090619	San Nicolás
090620	Santa Rosa
090621	Tronalagua
0907	Tejutepeque
090700	Area Urbana
090701	Concepción
090702	El Zapote
090703	San Antonio Buena Vista
090704	San Francisco Echeverría
090705	Santa Olaya
090706	Santa Rita
0908	Victoria
090800	Area Urbana
090801	Azacualpa
090802	El Caracol
090803	El Zapote
090804	La Bermuda
090805	La Uvilla
090806	Paratao
090807	Peña Blanca
090808	Rojitas
090809	San Antonio
090810	San Pedro
090811	Santa Marta
0909	Villa Dolores
090900	Area Urbana
090901	Cañafistula
090902	Curaren
090903	Chapelcoro
090904	El Rincón
090905	Niqueresque
090906	San Carlos
10	San Vicente
1001	Apastepeque
100100	Area Urbana
100101	Calderas
100102	Cutumayo
100103	El Guayabo
100104	Las Minas
100105	San Felipe
100106	San Jacinto
100107	San José Los Almendros
100108	San Juan De Merino
100109	San Nicolás
100110	San Pedro
1002	Guadalupe
100200	Area Urbana
100201	Joya De Munguía
100202	San Antonio Los Ranchos
100203	San Benito
100204	San Emigdio El Tablón
100205	San Francisco Agua Agria
100206	San José Carbonera
1003	San Cayetano Istepeque
100300	Area Urbana
100301	Candelaria
100302	Cerro Grande
1004	Santa Clara
100400	Area Urbana
100401	Agua Helada
100402	El Tortuguero
100403	El Rosario
100404	San Jerónimo
100405	San Juan De Merino
100406	Santa Rosa
1005	Santo Domingo
100500	Area Urbana
100501	El Refugio
100502	Izcanales
100503	Los Rodríguez
100504	Talpetates
1006	San Esteban Catarina
100600	Area Urbana
100601	Amatitán Abajo
100602	Amatitán Arriba
100603	Cerro De San Pedro
100604	San Esteban
100605	San Ildefonso
100606	San Jacinto La Burrera
100607	Santa Catarina
1007	San Ildefonso
100700	Area Urbana
100701	Candelaria Lempa
100702	Guachipilín
100703	Lajas y Canoas
100704	San Francisco
100705	San Lorenzo
100706	San Pablo Cañales
1008	San Lorenzo
100800	Area Urbana
100801	La Cruz
100802	Las Animas
100803	San Francisco
100804	Santa Lucía
1009	San Sebastián
100900	Area Urbana
100901	El Paraiso
100902	El Porvenir Aguacayo
100903	La Esperanza
100904	Las Rosas
100905	Los Laureles
100906	San Francisco
100907	La Labor
100908	Santa Elena
100909	Santa Teresa
100910	Santa Cruz
1010	San Vicente
101000	Area Urbana
101001	Anton Flores
101002	Chucuyo
101003	Dos Quebradas
101004	El Caracol
101005	El Marquezado
101006	El Obrajuelo Lempa
101007	El Rebelde
101009	La Soledad
101010	León De Piedra
101011	Llanos De Achichilco
101012	Los Laureles
101013	Los Pozos
101014	Parras Lempa
101015	San Antonio Achichilquito
101016	San Antonio Caminos
101017	San Antonio Tras El Cerro
101018	San Bartolo Ichanmico
101019	San Diego
101020	San Francisco Chamoco
101021	San Jacinto
101022	San José Río Frío
101023	San Juan Buena Vista
101024	San Rafael San Diego
101025	Santa Gertrudis
101026	Volcán Opico
1011	Tecoluca
101100	Area Urbana
101101	Barrio Nuevo
101102	El Arco
101103	El Campanario
101104	El Carao
101105	El Coyolito
101106	El Pacun
101107	El Palomar
101108	El Perical
101109	El Puente
101110	El Socorro
101111	La Esperanza
101112	Las Anonas
101113	Las Mesas
101114	San Andrés Los Achiotes
101115	San Benito
101116	San Carlos
101117	San Fernando
101118	San Francisco Angulo
101119	San José Llano Grande
101120	San Nicolás Lempa
101121	San Ramón Grifal
101122	Santa  Cruz Porrillo
101123	Santa Bárbara
101124	Santa Cruz Paraiso
101125	San Jacinto
1012	Tepetitán
101200	Area Urbana
101201	Concepción De Cañas
101202	La Virgen
101203	Loma Alta
1013	Verapaz
101300	Area Urbana
101301	El Carmen
101302	Molineros
101303	San Antonio Jiboa
101304	San Isidro
101305	San Jerónimo Limon
101306	San José Borja
101307	San Juan Buena Vista
101308	San Pedro Agua Caliente
11	Usulután
1101	Alegría
110100	Area Urbana
110101	Apastepeque
110102	El Quebacho
110103	La Peña
110104	Las Casitas
110105	San José La Montañita
110106	San Juan
110107	Yomo
110108	Zapotillo
1102	Berlín
110200	Area Urbana
110201	Colon
110202	Concepción
110203	El Corozal
110204	El Tablón
110205	La Unión
110206	Las Delicias
110207	Las Piletas
110208	Los Talpetates
110209	San Felipe
110210	San Francisco
110211	San Isidro
110212	San José
110213	San Juan Loma Alta
110214	San Lorenzo
110215	Santa Cruz
110216	Virginia
1103	California
110300	Area Urbana
110301	El Pozón
110302	El Tigre
110303	El Volcán
110304	El Nísperal
1104	Concepción Batres
110400	Area Urbana
110401	El Cañal
110402	El Paraisal
110403	El Porvenir
110404	Hacienda Nueva
110405	La Anchila
110406	La Danta
110407	San Felipe
110408	San Ildefonso
110409	San Antonio
110410	Los Desmontes
1105	El Triunfo
110500	Area Urbana
110501	El Jícarito
110502	El Palón
110503	La Palmera
110504	San Antonio
1106	Ereguayquín
110600	Area Urbana
110601	Analco
110602	El Maculis
110603	La Ceiba
110604	Los Encuentros
110605	Piedra Ancha
1107	Estanzuelas
110700	Area Urbana
110701	Condadillo
110702	El Caragual
110703	El Escarbadero
110704	El Ojushte
110705	El Tecomatal
110706	La Cruz
110708	San Pedro
110709	Sitio San Antonio
1108	Jiquilisco
110800	Area Urbana
110801	Aguacayo
110802	Bolívar
110803	Cabos Negros
110804	California
110805	Ceiba Gacha
110806	El Carmen
110807	Elcarrizal
110808	El Castaño
110809	El Coyolito
110810	El Marillo
110811	El Paraiso
110812	El Roquinte
110813	Hule Chacho
110814	Isla De Méndez
110815	La Canoa
110816	La Concordia
110817	La Cruzadilla De San Juan
110818	La Montaña
110819	La Nuria
110820	La Tirana
110821	Las Delicias
110822	Las Flores
110823	Las Mesitas
110824	Los Campos
110825	Los Limones
110826	Los Tres Chorros
110827	Los Planes
110828	Puertos Los Avalos
110829	Salinas El Potrero
110830	Salinas De Sisiguayo
110831	San Antonio Potrerillos
110832	San José O La Carrera
110833	San Juan De Letrán
110834	San Juan Del Gozo
110835	San Judas
110836	San Marcos Lempa
110837	San Pedro
110838	Taburete Jagual
110839	Taburete Los Claros
110840	Tierra Blanca O Nueva Esperanza
110841	Zamorán
1109	Jucuapa
110900	Area Urbana
110901	El Amatón
110902	El Chagüite
110903	El Níspero
110904	Llano El Chilamate
110905	Llano Grande De Las Piedras
110906	Loma De La Cruz
110908	Tapesquillo Bajo
110909	Tapesquillo Alto
1110	Jucuarán
111000	Area Urbana
111001	El Jícaro
111002	El Jutal
111003	El Progreso
111004	El Llano
111005	El Zapote
111006	La Cruz
111007	Samuria
1111	Mercedes Umaña
111100	Area Urbana
111101	El Caulote
111102	El Jícaro
111103	El Jocotillo
111104	La Montañita
111105	La Puerta
111106	Los Horcones
111107	Los Talnetes
111108	San Benito
111109	Santa Anita
111110	El Caragual
1112	Nueva Granada
111200	Area Urbana
111201	Azacualpia De Gualcho
111202	Azacualpia De Joco
111203	El Amatillo
111204	Jocomontique
111205	La Isleta
111206	La Palomia
111207	Las Llaves
111208	Lepaz
111209	Nuevo Carrizal
111210	Potrero De Joco
111211	San José
1113	Ozatlán
111300	Area Urbana
111301	El Delirio
111302	El Palmital
111303	Joya Del Pilar
111304	La Breña
111305	La Poza
111306	Las Trancas
111307	San José O La Carrera
111308	Paso De Gualache
1114	Puerto El Triunfo
111400	Area Urbana
111401	Corral De Mulas
111402	El Espíritu Santo
111403	El Sitio Santa Lucía
111404	Madresal
111405	Chaguantique
111406	Ceiba Doblada
1115	San Agustín
111500	Area Urbana
111501	Buenos Aires
111502	El Cedro
111503	El Corozo
111504	El Jícaro
111505	El Jocote
111506	Eucaliptos
111507	Galingagua
111508	Jobal Arrozales
111509	La Ceiba
111510	La Mora
111511	La Quesera
111512	Linares Caulotal
111513	Los Arrozales
111514	Los Planes
111515	Nombre De Dios
111516	Tres Calles
111517	El Rodeo
111518	Las Delicias
1116	San Buena Ventura
111600	Area Urbana
111601	El Aceituno
111602	El Semillero
111603	La Caridad
111604	La Tronconada
111605	Las Charcas
111606	Los Espinos
111607	Llano El Chilamate
1117	San Dionisio
111700	Area Urbana
111701	Iglesia Vieja
111702	Mundo Nuevo
1118	Santa Elena
111800	Area Urbana
111801	El Nanzal
111802	El Nísperal
111803	El Rebalse
111804	El Volcán
111805	Joya Ancha Abajo
111806	Joya Ancha Arriba
111807	Las Cruces
111808	El Amate
111809	Piedra De Agua
111810	Plan Grande
1119	San Francisco Javier
111900	Area Urbana
111902	El Tablón
111903	El Zungano
111904	Jobal Hornos
111905	La Cruz
111906	La Peña
111907	Los Horcones
111908	Los Hornos
111909	Los Ríos
1120	Santa María
112000	Area Urbana
112001	Mejicapa
112002	San Francisco
112003	La Ceiba
112004	El Obrajuelo
1121	Santiago De María
112100	Area Urbana
112101	Batres
112102	El Marquezado
112103	El Tigre
112104	Las Flores
112105	Las Playitas
112106	Loma De Los González
112107	Llano Grande De Las Piedras
112108	Loma De La Cruz
1122	Tecapán
112200	Area Urbana
112201	Cerro Verde
112202	El Jícaro
112203	Paso De Gualache
112204	Los Chapetones
112205	Los Horcones
1123	Usulután
112300	Area Urbana
112301	Capitán Lazo
112302	El Cerrito
112303	El Ojushte
112304	El Trillo
112305	La Joya De Tomasito
112306	La Laguna
112307	La Peña
112308	La Presa
112309	Las Salinas
112310	Los Desmontes
112311	Obrajuelo
112312	Ojo De Agua
112313	Palo Galán
112314	Santa Bárbara
112315	Talpetate
112316	Las Trancas
112317	San Francisco
12	San Miguel
1201	Carolina
120100	Area Urbana
120101	La Ceibita
120102	La Orilla
120103	Miracapa
120104	Rosas Nacaspilo
120105	Soledad Terrero
1202	Ciudad Barrios
120200	Area Urbana
120201	Belén
120202	Guanaste
120203	La Montañita
120204	Llano El Angel
120205	Nuevo Porvenir
120206	San Cristóbal
120207	San Juan
120208	San Luisito
120209	San Matías
120210	Teponahuaste
120211	Torrecilla
1203	Comacarán
120300	Area Urbana
120301	Candelaria
120302	El Colorado
120303	El Hormiguero
120304	El Jícaral
120305	Platanarillo
1204	Chapeltique
120400	Area Urbana
120401	Cercas De Piedras
120402	Gualama
120403	La Trinidad
120404	Los Amates
120405	San Jerónimo
120406	San Pedro
1205	Chinameca
120500	Area Urbana
120501	Chambala
120502	Copinol Primero
120503	Copinol Segundo
120504	El Boquerón
120505	El Conacastal
120506	El Jocote
120507	Jocote Dulce
120508	La Cruz Primera
120509	La Cruz Segunda
120510	La Peña
120511	Las Marías
120512	Las Mesas
120513	Ojo De Agua
120514	Oromontique
120515	Planes Primero
120516	Planes Tercero
120517	San Antonio
120518	San Pedro Arenales
120519	Zaragoza
1206	Chirilagua
120600	Area Urbana
120601	Chilanguera
120602	El Capulín
120603	Guadalupe
120604	Hoja De Sal
120605	La Estrechura
120606	Nueva Concepción
120607	San José Gualozo
120608	San Pedro
120609	Tierra Blanca
120610	El Cuco
1207	El Tránsito
120700	Area Urbana
120701	Calle Nueva
120702	Llano Del Coyol
120703	Moropala
120704	Primavera
120705	El Cañal
1208	Lolotique
120800	Area Urbana
120801	Amaya
120802	Concepción
120803	El Jícaro
120804	El Nancito
120805	El Palón
120806	Las Ventas
120807	San Francisco
120808	Santa Bárbara
120809	Valencia
1209	Moncagua
120900	Area Urbana
120901	El Cerro
120902	El Jobo
120903	El Papalón
120904	El Platanar
120905	El Rodeo
120906	La Estancia
120907	La Fragua
120908	Los Ejidos
120909	Salamar
120910	Santa Bárbara
120911	Tongolona
120912	Valle Alegre
1210	Nueva Guadalupe
121000	Area Urbana
121001	Los Planes De San Sebastián
121002	Planes Primero
121003	Planes Segundo
121005	San Luis
1211	Nuevo Edén De San Juan
121100	Area Urbana
121101	Cucurucho
121102	Jardín
121103	Laureles
121104	Montecillos
121105	Ojeo
121106	Queseras
121107	San Sebastián
1212	Quelepa
121200	Area Urbana
121201	El Obrajuelo
121202	El Tamboral
121203	San Antonio
121204	San José
1213	San Antonio
121300	Area Urbana
121301	San Diego
121302	San Marcos
1214	San Gerardo
121400	Area Urbana
121401	La Joya
121402	Laguna
121403	Quebracho
121404	San Jerónimo
1215	San Jorge
121500	Area Urbana
121501	Candelaria
121502	Joya De Ventura
121503	La Ceiba
121504	La Morita
121505	San Julián
121506	Conacastal
1216	San Luis De La Reina
121600	Area Urbana
121601	El Junquillo
121602	El Ostucal
121603	San Antonio
121604	San Juan
1217	San Miguel
121700	Area Urbana
121701	Altomiro
121702	Anchico
121703	Cerro Bonito
121704	Concepción Corozal
121705	El Amate
121706	El Brazo
121707	El Delirio
121708	El Divisadero
121709	El Havillal
121710	El Jute
121711	El Niño
121712	El Papalón
121713	El Progreso
121714	El Sitio
121715	El Tecomatal
121716	El Volcán
121717	Jalacatal
121718	La Canoa
121719	La Puerta
121720	La Trinidad
121721	Las Delicias
121722	Las Lomitas
121723	Mira Flores
121724	Monte Grande
121725	San Andrés
121726	San Antonio Chávez
121727	San Antonio Silva
121728	San Carlos
121729	San Jacinto
121730	Santa Inés
1218	San Rafael Oriente
121800	Area Urbana
121801	Los Zelaya
121802	Piedra Azul
121803	Rodeo De Pedron
121804	Santa Clara
1219	Sesori
121900	Area Urbana
121901	Charlaca
121902	El Espíritu Santo
121903	El Tablón
121904	Las Mesas
121905	Managuara
121906	Mazatepeque
121907	Minitas
121908	Petacones
121909	San Jacinto
121910	San Sebastián
121911	Santa Rosa
1220	Uluazapa
122000	Area Urbana
122001	Juan Yánez
122002	Los Pilones
122003	Río Vargas
13	Morazán
1301	Arambala
130100	Area Urbana
130101	Pueblo Viejo
130102	Tierra Colorada
130103	El Carrizal
1302	Cacaopera
130200	Area Urbana
130201	Agua Blanca
130202	Calavera
130203	Guachipilín
130204	Junquillo
130205	La Estancia
130206	Ocotillo
130207	Sunsulapa
1303	Corinto
130300	Area Urbana
130301	Corralito
130302	Hondable
130303	La Laguna
130304	San Felipe
130305	Varilla Negra
1304	Chilanga
130400	Area Urbana
130401	El Chaparral
130402	El Pedernal
130403	Joya Del Matazano
130404	Lajitas
130405	Piedra Parada
1305	Delicias De Concepción
130500	Area Urbana
130501	El Volcán
130502	La Cuchilla
1306	El Divisadero
130600	Area Urbana
130601	Llano De Santiago
130602	Loma Larga
130603	Loma Tendida
130604	Nombre De Jesús
130605	San Pedro Río Seco
130606	Santa Anita
130607	Villa Modelo
1307	El Rosario
130700	Area Urbana
130701	La Laguna
130702	Ojo De Agua
1308	Gualococti
130800	Area Urbana
130801	La Joya
130802	San Lucas
1309	Guatajiaga
130900	Area Urbana
130901	El Volcán
130902	Los Abelines
130903	Manguera
130904	Pajigua
130905	San Bartolo
130906	El Sirigual
1310	Joateca
131000	Area Urbana
131001	El Zapotal
131002	Paturla
131003	Volcancillo
1311	Jocoaitique
131100	Area Urbana
131101	El Rodeo
131102	El Volcancillo
1312	Jocoro
131200	Area Urbana
131201	Flamenco
131202	Guachipilín
131203	Lagunetas
131204	Las Marías
131205	Los Laureles
131206	San Felipe
131207	San José
131208	San Juan
1313	Lolotiquillo
131300	Area Urbana
131301	Gualindo
131302	La Manzanilla
131303	Sunsulapa
1314	Meanguera
131400	Area Urbana
131401	Cerro Pando
131402	Guacamaya
131403	La Joya
131404	Soledad
1315	Osicala
131500	Area Urbana
131501	Agua Zarca
131502	Cerro Coyol
131503	Huilihuiste
131504	La Montaña
131505	Llano Alegre
1316	Perquín
131600	Area Urbana
131601	Casa Blanca
131602	Pueblo Viejo
131603	Sabanetas
1317	San Carlos
131700	Area Urbana
131701	La Jagua
131702	San Diego
131703	San Marcos
131704	Valle Nuevo
1318	San Fernando
131800	Area Urbana
131801	Azacualpa
131802	Cañaverales
1319	San Francisco Gotera
131900	Area Urbana
131901	Cacahuatalejo
131902	El Norte
131903	El Rosario
131904	El Triunfo
131905	San Francisquito
131906	San José
1320	San Isidro
132000	Area Urbana
132001	El Rosario
132002	Piedra Parada
1321	San Simón
132100	Area Urbana
132101	El Carrizal
132102	El Cerro
132103	Las Quebradas
132104	Potrero Adentro
132105	Valle Grande
1322	Sensembra
132200	Area Urbana
132201	El Limon
132202	El Rodeo
132203	Loma Del Chile
1323	Sociedad
132300	Area Urbana
132301	Animas
132302	Candelaria
132303	Calpules
132304	El Bejucal
132305	El Peñón
132306	El Tablón
132307	La Joya
132308	Labranza
1324	Torola
132400	Area Urbana
132401	Agua Zarca
132402	Cerritos
132403	El Progreso
132404	Tijeretas
1325	Yamabal
132500	Area Urbana
132501	La Isleta
132502	Loma Del Chile
132503	San Juan De La Cruz
132504	El Volcán
1326	Yoloaiquín
132600	Area Urbana
132601	El Aceituno
132602	El Volcán
14	La Unión
1401	Anamorós
140100	Area Urbana
140101	Agua Blanca
140102	Carbonal
140103	Cordoncillo
140104	El Cedro
140105	Huertas Viejas
140106	Terreritos
140107	Tizate
140108	Tulima
140109	Talpetate
140110	Calpules
1402	Bolívar
140200	Area Urbana
140201	Albornoz
140202	Candelaria Albornoz
140203	Eltransito
140204	Guadalupe
140205	La Paz
140206	La Rinconoda
140207	Nueva Guadalupe
140208	Santa Lucía
140209	Las Marías
140210	Los Hatillos
1403	Concepción De Oriente
140300	Area Urbana
140301	El Guayabo
140302	El Molino
140303	El Zapote
140304	Guaripe
1404	Conchagua
140400	Area Urbana
140401	Cerro El Jiote
140402	Conchagüita
140403	El Cacao
140404	El Ciprés
140405	El Faro
140406	El Pilón
140407	Los Angeles
140408	Güisquil
140409	Maquigue
140410	Piedra Blanca
140411	Piedra Rayada
140412	Yologual
1405	El Carmen
140500	Area Urbana
140501	Alto El Roble
140502	El Caulotillo
140503	El Gavilán
140504	El Piche
140505	El Tejar
140506	El Zapotal
140507	La Cañada
140508	Las Pitas
140509	Los Conejos
140510	Olomega
140511	Salagua
140512	Los Amates
140513	Terrero Blanco
140514	El Jícaro
140515	El Tihuilotal
140516	La Quesadilla
1406	El Sauce
140600	Area Urbana
140601	Canaire
140602	El Rincón
140603	El Talpetate
140604	San Juan Gualare
140605	Santa Rosita
140606	El Algodón
140607	Los Mojones
140608	Talpetate
140609	Boquín
1407	Intipucá
140700	Area Urbana
140701	Chichipate
140702	El Carao
140703	La Leona
140704	El Coyolito
1408	La Unión
140800	Area Urbana
140801	Agua Caliente
140802	Agua Escondida
140803	Amapalita
140804	El Jícaro
140805	Isla Chuchito
140806	Isla Ilca
140807	Isla Martín Pérez
140808	Isla Perico
140809	Isla Periquito
140810	Isla Zacatillo
140811	La Quezadilla
140812	Las Chachas
140813	Loma Larga
140814	Sirama
140815	Tihuilotal
140816	Llano De Los Patos
140817	El Tamarindo
140818	La Leona
140819	Isla Conejo
1409	Lislique
140900	Area Urbana
140901	Agua Fría
140902	El Derrumbado
140903	El Terrero
140904	Guajiniquil
140905	Higueras
140906	Las Pilas
140907	Agua Blanca
140908	Huertas Viejas
140909	El Cedro
1410	Meanguera Del Golfo
141000	Area Urbana
141001	Isla Conchagüita
141002	El Salvador
141003	Guerrero
141006	Isla Meangüerita
1411	Nueva Esparta
141100	Area Urbana
141101	El Portillo
141102	Honduritas
141103	Las Marías
141104	Monteca
141105	Ocotillo
141106	Talpetate
141107	El Cedro
141108	Agua Fría
141109	Mala Laja
1412	Pasaquina
141200	Area Urbana
141201	Cerro Pelón
141202	El Rebalse
141203	El Tablón
141204	Horcones
141205	Piedras Blancas
141206	San Eduardo
141207	San Felipe
141208	Santa Clara
141209	Valle Afuera
141210	Pasaquinita
141211	El Talpetate
1413	Polorós
141300	Area Urbana
141301	Boquín
141302	Carpintero
141303	El Pueblo
141304	El Rodeo
141305	Ocote
141306	Lajitas
141307	Mala Laja
141308	El Guayabo
141309	Honduritas
1414	San Alejo
141400	Area Urbana
141401	Agua Fría
141402	Bobadilla
141403	Ceibillas
141404	Cerco De Piedra
141405	El Caragon
141406	El Copalío
141407	El Tamarindo
141408	El Tizatillo
141409	Hato Nuevo
141410	Las Queseras
141411	Los Jiotes
141412	Mogotillo
141413	San Jerónimo
141414	Santa Cruz
141415	Terrero Blanco
141416	Los Amates
141417	Las Marías
141418	Maderas
1415	San José
141500	Area Urbana
141501	Chaguitillo
141502	El Sombrerito
141503	El Zapote
141504	La Joya
1416	Santa Rosa De Lima
141600	Area Urbana
141601	Copetillos
141602	El Algodón
141603	El Portillo
141604	La Chorrera
141605	Las Cañas
141606	Los Mojones
141607	Pasaquinita
141608	San Sebastián
141609	El Cordoncillo
141610	Candelaria Albornoz
1417	Yayantique
141700	Area Urbana
141701	Centeno
141702	El Pastor
141703	El Socorro
141704	Los Amates
1418	Yucuaiquín
141800	Area Urbana
141801	Candelaria
141802	Ciricuario
141803	El Carmen
141804	La Cañada
141805	Las Cruces
141806	Las Marías
141807	Los Hatillos
141809	Valle Nuevo
141810	El Transito
141811	Santa Lucía
\.


--
-- TOC entry 3769 (class 0 OID 17074)
-- Dependencies: 217
-- Data for Name: unidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidad (codigo, nombre) FROM stdin;
2	Unidad de Credito San Vicente
3	Unidad de Credito San Miguel
1	Unidad de Credito San Salvador
\.


--
-- TOC entry 3770 (class 0 OID 17077)
-- Dependencies: 218
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (tipo, nombre, clave, nit, salt) FROM stdin;
ENCARGADO_ACTIVO_FIJO	esme	2KNBuvFS/fLj2lxRBFUefdH2P/tyQjO2mg3wzbSUfimTmuy6DWzVU5Ebc3jCzEw9ZS4be8QtQizX9uJ/7a680Q==	10102410961011	uB9M0a1xSkWFimCygID/fvL849F69HPLNMMJj7iKM6JhLIBinYSyUmbwyG+GR3iX+SCkjD7AsKQi4rvJZ+H7LfxROrS+6yYV24zYrys3wl9bG1SdJZl3VN5twVkp3D0y7BqCzE59fNvwhNum1XmxeecSE1ToT4kkV6/toP/lR1NfEp60qo0qtX2B8MPy0pXmQa1W3YGDG51kjO00KBtlQ7tueDQ5g8OBJtsl4F+F1goHjeKZGqsktZBX5r9HQHGRbWihC8pnNUkEWaJAfC4EiDl5PN6kmNpMFkfDxFVExyLqetGXmWoLtY74bI9LEfWdlYmhJGnT9wtcbU/G3W+4VeGV7vw6a1ooF0XIDN8E4dwCLs2qdmmmDchMgiHKhnbfJYMMXyW4nhym/4grCdbLxGl2dyIv+/k+p/4O2ydSk/DHgkD7YlP+5ABASLz1+al6YgDZBp1ZyMqoojUSo5IOAtVGoultDAWKOjTEvV79N81ed4MFZJ8jeydPJlGk4kGSRiQTQO/7O1mx1clXZy/Nymdxk3dcwi/XwpncXUn0NXJw2JWcDbp6vQJ/61e+awqUtIs6RFUcOfF5DXqI6R2HaJ5xlAHklsBXpTsNxNcfpN7TYeZ5QrD+4zo7ZXlDguij03yYCcOu6/khJBhe3UmncteiZfLq8JChzmbnVWl4zzs=
ASESOR	victor	gE7jpL9dICzkv2rIBi6Lq0ZZseyOIlC3aI2CN6UVkQnCc3cNDtqw5EO1eSmD4hS2z+XPrSyk41uuhBfQ5Pdacw==	10060309961011	fC147yaJc+JqSGsknG99UZ4Ql3xKXiFyqRgx2dNbdqkB9ywZCUkUmsFWhP4WWAxFhcOl6C9teYRzfnYIj+pxGHxNp/rIjJ8SHCYZbo9MHVyOb/FH69CQF+NNTMutW/o//mdUTnXt7YkFUG85swi3Eec7ZIm62n1BUjnx25uNRi4ZQY8ayljhFpHOJDQK0V35wID/MlXQe1EwrYDq46x3VoO8yoIf7vnrgW9hsqduzVYmth8baseCHoaB6iWTIm49716KBO801pKCDa5nyl3OXBbZ6hds42hwKIjvmh0Rz0pSvShG1CjYsZfHM8FBm2CRfnn3YA3VBFc2KzEzLbQevEkksoL7AnpKahZGbhsgTHTPpK4iPpIzP584FJAuwVgGM78PzpWVQXyWPCYqsVCjI4XBDfQE/M415I21N/J3Py2YUVJQkAOAM9hL0P23g4ccpEajftIXNVBYCOfhdlmHywOIVIbQ4Nc+p22HZlj3rvQWKir08d+A9/Bduyk++xaVBIEGXyCOjbm2KNGqRvwqaUMVYcmQmZfp63m2WuUJKMnRPRQyQv4f0O5EiEmXkFE8zIj3cFOYkDJNAQdv6MHgLjRd2jZaF5bDbgjRDt3tvV0hiKJjMobMssHEs7ORYj15YQcAzc8PyQuNBIAcZFTV9vaKv93GLF3IeVv/ONBmBb4=
COBRO	diegoone	kvOTlCvr6dtOE9imF8EBddSHFQAuBFlUMmeSKHJdfPJlFWde5beILDqFRPQLFwjLzQ80mEOFA51oShvUeMRCfg==	10042608801002	qrzIsZcQYJwovsaF8fM9OH+RbdjOJEl5SI0yKr+NiCrKrxK2fWzul+eUnLtTxs+x/SOkuLagqGzkMS5S7qV/alVhj2RGSA2WZ/qpDMS2oSiq8aRGoFW2sQbBWf1E92FGn4+iy5JbeoccFg+9vOUqVQKyCcHp9Mgqakqeek6KzrUsZ9KAckD4JqVdbkLB17sFNzCAxEP0BvgDsCSEccQs2EubUrEEJbtI8Ek2Qter3ddWELeqdcnEP/dD2aGZWyREsRZvuvacpqFWPzUQhKTjERn0NMPP1cA6+hPYXOhpirkjsustHEYjh0H4W/dlTCJHzoGZc8BPQMDEPRdYiUX0PMPG4Ychve+iI7VME+C3jjaZNcYrdxL3yAxanWA6Uc+TGW5ZY4zg94BUGdJA1IJcX2+qYDUcZScSv7aHgv7KlOvWuR3wvV78iifZ4vO3FBWKP2O11Hs29wQfazkAbaN8SYcmxmw7ibmmCjCk1CNMrO5Y7jEdlzjlD8L2rrgSygVXmzFnWeU1IOvhAI9JJm09X1+SWJyFYL2SLKpYQaaSsukatwfhjbs+Z+8wp3s9/16OLUfZ7rivH43QKZTZCn8VDZ0B8tbsEUk7i1jd4eabvuU5TypjUcr9OKfjYO7Kd4BIQqdftrIXNQMlE6KE1a+0nn99CcBcr7OUvJqPsFinHRE=
ENCARGADO_ACTIVO_FIJO	peña123	d0JZ/HuMZdB8e3iPw3TnOZ+Qq19bzhpg+FCNDF4E3T/GUyjpUNYklOqZXfrX1RPtfhTymXiRr/85NkCSPZrPzw==	10000904901016	z13mY/SJgXo2/2/TRo8k21Bg838d1z84+vthvNcQt0G6ZW4a/KyCSn/IjbPTD4vlAkMXeBfJyodPbWQMnS65/BBGbhdhogfahsz7n5TAlK6kcOeE8j/6JoKdSlAjL5GHwAR8C948eS5kEur9xVHQzuddzdHflJjGvv+vq1wHwdDlTrmu/CaIClWNX49jpUEwnqqwfUiuZ9IJOVZhHsLkQV4y64tkgfTwZtyFoxBjBgjooddnBDVvvoaqhBebCc4hGxULbIwJQT+eJaGkMlqBXUI++xm2pavq3Z5wgXE24z1cqKemHuZwuqtu33mjpBWc0ZWQ4dH3eNjRMdueL0zO0k8covM3BdsvYbqvL6C+4yDKZSm1wHmKTMIkYmcD7Fb0Wrin7u/oKqK/8rDirQVDFh/ZWu6LaQo2G3z2c4RBTPKCmkrNYQPHpbbYvzvfpkVdFfR5hR0YgtwwAmpIftHptGfWEadg5GYCHrNPORTTsy31nfufjS5ONWghmnKOqOYa9TLDqsf8zL7o762Xs/d0qaEAToeHmnLxpCIYekh8imywWa2ARilmXPmDIe6KWUQ6+fJV2GU+jWRyZfdM0N43I10jFNBZO5rpZJs7mTiVS6w15DC56RIvDxl/mOHBfDuUESgfOnefpWOEQdgRisDXw69KA0yrmG+epcGbq98zPzk=
\.


--
-- TOC entry 3792 (class 0 OID 0)
-- Dependencies: 219
-- Name: activo_fijo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activo_fijo_id_seq', 10, true);


--
-- TOC entry 3793 (class 0 OID 0)
-- Dependencies: 221
-- Name: adquisicion_activo_fijo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adquisicion_activo_fijo_id_seq', 15, true);


--
-- TOC entry 3794 (class 0 OID 0)
-- Dependencies: 224
-- Name: baja_activo_fijo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.baja_activo_fijo_id_seq', 28, true);


--
-- TOC entry 3795 (class 0 OID 0)
-- Dependencies: 201
-- Name: credito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.credito_id_seq', 115, true);


--
-- TOC entry 3796 (class 0 OID 0)
-- Dependencies: 205
-- Name: direccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.direccion_id_seq', 100, true);


--
-- TOC entry 3797 (class 0 OID 0)
-- Dependencies: 209
-- Name: ingreso_egreso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingreso_egreso_id_seq', 1, false);


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 213
-- Name: politica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.politica_id_seq', 19, true);


--
-- TOC entry 3594 (class 2606 OID 17266)
-- Name: activo_fijo activo_fijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activo_fijo
    ADD CONSTRAINT activo_fijo_pkey PRIMARY KEY (id);


--
-- TOC entry 3596 (class 2606 OID 17279)
-- Name: adquisicion_activo_fijo adquisicion_activo_fijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_activo_fijo
    ADD CONSTRAINT adquisicion_activo_fijo_pkey PRIMARY KEY (id);


--
-- TOC entry 3600 (class 2606 OID 17307)
-- Name: baja_activo_fijo baja_activo_fijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.baja_activo_fijo
    ADD CONSTRAINT baja_activo_fijo_pkey PRIMARY KEY (id);


--
-- TOC entry 3550 (class 2606 OID 17091)
-- Name: bien_garantia bien_garantia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bien_garantia
    ADD CONSTRAINT bien_garantia_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3552 (class 2606 OID 17093)
-- Name: cuota cobro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuota
    ADD CONSTRAINT cobro_pkey PRIMARY KEY (numero, id_credito);


--
-- TOC entry 3557 (class 2606 OID 17095)
-- Name: credito_bien_garantia credito_bien_garantia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_bien_garantia
    ADD CONSTRAINT credito_bien_garantia_pkey PRIMARY KEY (id_credito, codigo_bien);


--
-- TOC entry 3559 (class 2606 OID 17097)
-- Name: credito_empresa credito_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_empresa
    ADD CONSTRAINT credito_empresa_pkey PRIMARY KEY (id_credito);


--
-- TOC entry 3561 (class 2606 OID 17099)
-- Name: credito_persona credito_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_persona
    ADD CONSTRAINT credito_persona_pkey PRIMARY KEY (id_credito);


--
-- TOC entry 3555 (class 2606 OID 17101)
-- Name: credito credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT credito_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 17250)
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (codigo, codigo_unidad);


--
-- TOC entry 3598 (class 2606 OID 17299)
-- Name: detalle_activo detalle_activo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_activo
    ADD CONSTRAINT detalle_activo_pkey PRIMARY KEY (id_adquisicion, correlativo);


--
-- TOC entry 3566 (class 2606 OID 17105)
-- Name: direccion direccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 17107)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (nit);


--
-- TOC entry 3570 (class 2606 OID 17109)
-- Name: garantia_fiador garantia_fiador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garantia_fiador
    ADD CONSTRAINT garantia_fiador_pkey PRIMARY KEY (id_credito_persona, nit_fiador);


--
-- TOC entry 3572 (class 2606 OID 17111)
-- Name: ingreso_egreso ingreso_egreso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingreso_egreso
    ADD CONSTRAINT ingreso_egreso_pkey PRIMARY KEY (id);


--
-- TOC entry 3576 (class 2606 OID 17323)
-- Name: persona_natural persona_natural_dui_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona_natural
    ADD CONSTRAINT persona_natural_dui_key UNIQUE (dui);


--
-- TOC entry 3578 (class 2606 OID 17113)
-- Name: persona_natural persona_natural_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona_natural
    ADD CONSTRAINT persona_natural_pkey PRIMARY KEY (nit);


--
-- TOC entry 3574 (class 2606 OID 17115)
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (nit);


--
-- TOC entry 3580 (class 2606 OID 17117)
-- Name: politica politica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.politica
    ADD CONSTRAINT politica_pkey PRIMARY KEY (id);


--
-- TOC entry 3582 (class 2606 OID 17119)
-- Name: telefono telefono_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_pkey PRIMARY KEY (nit, telefono);


--
-- TOC entry 3584 (class 2606 OID 17121)
-- Name: tipo_activo tipo_activofijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_activo
    ADD CONSTRAINT tipo_activofijo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3586 (class 2606 OID 17123)
-- Name: ubicacion ubicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ubicacion
    ADD CONSTRAINT ubicacion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3588 (class 2606 OID 17125)
-- Name: unidad unidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad
    ADD CONSTRAINT unidad_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3590 (class 2606 OID 17127)
-- Name: usuario usuario_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_nombre_key UNIQUE (nombre);


--
-- TOC entry 3592 (class 2606 OID 17129)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (nit);


--
-- TOC entry 3553 (class 1259 OID 17130)
-- Name: fki_ ; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_ " ON public.cuota USING btree (id_credito);


--
-- TOC entry 3562 (class 1259 OID 17131)
-- Name: fki_  asdf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_  asdf" ON public.credito_persona USING btree (id_credito);


--
-- TOC entry 3621 (class 2606 OID 17267)
-- Name: activo_fijo activo_fijo_codigo_tipo_activo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activo_fijo
    ADD CONSTRAINT activo_fijo_codigo_tipo_activo_fkey FOREIGN KEY (codigo_tipo_activo) REFERENCES public.tipo_activo(codigo) NOT VALID;


--
-- TOC entry 3623 (class 2606 OID 17285)
-- Name: adquisicion_activo_fijo adquisicion_activo_fijo_codigo_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_activo_fijo
    ADD CONSTRAINT adquisicion_activo_fijo_codigo_departamento_fkey FOREIGN KEY (codigo_departamento, codigo_unidad) REFERENCES public.departamento(codigo, codigo_unidad) NOT VALID;


--
-- TOC entry 3622 (class 2606 OID 17280)
-- Name: adquisicion_activo_fijo adquisicion_activo_fijo_id_activo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_activo_fijo
    ADD CONSTRAINT adquisicion_activo_fijo_id_activo_fkey FOREIGN KEY (id_activo) REFERENCES public.activo_fijo(id) NOT VALID;


--
-- TOC entry 3624 (class 2606 OID 17290)
-- Name: adquisicion_activo_fijo adquisicion_activo_fijo_nit_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adquisicion_activo_fijo
    ADD CONSTRAINT adquisicion_activo_fijo_nit_usuario_fkey FOREIGN KEY (nit_usuario) REFERENCES public.usuario(nit) NOT VALID;


--
-- TOC entry 3601 (class 2606 OID 17147)
-- Name: cuota cobro_id_credito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuota
    ADD CONSTRAINT cobro_id_credito_fkey FOREIGN KEY (id_credito) REFERENCES public.credito(id) NOT VALID;


--
-- TOC entry 3604 (class 2606 OID 17152)
-- Name: credito_bien_garantia credito_bien_garantia_codigo_bien_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_bien_garantia
    ADD CONSTRAINT credito_bien_garantia_codigo_bien_fkey FOREIGN KEY (codigo_bien) REFERENCES public.bien_garantia(codigo) NOT VALID;


--
-- TOC entry 3605 (class 2606 OID 17157)
-- Name: credito_bien_garantia credito_bien_garantia_id_credito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_bien_garantia
    ADD CONSTRAINT credito_bien_garantia_id_credito_fkey FOREIGN KEY (id_credito) REFERENCES public.credito(id) NOT VALID;


--
-- TOC entry 3606 (class 2606 OID 17162)
-- Name: credito_empresa credito_empresa_id_credito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_empresa
    ADD CONSTRAINT credito_empresa_id_credito_fkey FOREIGN KEY (id_credito) REFERENCES public.credito(id) NOT VALID;


--
-- TOC entry 3607 (class 2606 OID 17167)
-- Name: credito_empresa credito_empresa_nit_empresa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_empresa
    ADD CONSTRAINT credito_empresa_nit_empresa_fkey FOREIGN KEY (nit_empresa) REFERENCES public.empresa(nit) NOT VALID;


--
-- TOC entry 3602 (class 2606 OID 17172)
-- Name: credito credito_id_politica_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT credito_id_politica_fkey FOREIGN KEY (id_politica) REFERENCES public.politica(id) NOT VALID;


--
-- TOC entry 3603 (class 2606 OID 17177)
-- Name: credito credito_nit_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT credito_nit_usuario_fkey FOREIGN KEY (nit_usuario) REFERENCES public.usuario(nit) NOT VALID;


--
-- TOC entry 3608 (class 2606 OID 17182)
-- Name: credito_persona credito_persona_id_credito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_persona
    ADD CONSTRAINT credito_persona_id_credito_fkey FOREIGN KEY (id_credito) REFERENCES public.credito(id) NOT VALID;


--
-- TOC entry 3609 (class 2606 OID 17335)
-- Name: credito_persona credito_persona_nit_solicitante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito_persona
    ADD CONSTRAINT credito_persona_nit_solicitante_fkey FOREIGN KEY (nit_solicitante) REFERENCES public.persona_natural(nit) NOT VALID;


--
-- TOC entry 3610 (class 2606 OID 17192)
-- Name: departamento departamento_codigo_unidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_codigo_unidad_fkey FOREIGN KEY (codigo_unidad) REFERENCES public.unidad(codigo);


--
-- TOC entry 3625 (class 2606 OID 17308)
-- Name: detalle_activo detalle_activo_id_adquisicion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_activo
    ADD CONSTRAINT detalle_activo_id_adquisicion_fkey FOREIGN KEY (id_adquisicion) REFERENCES public.adquisicion_activo_fijo(id) NOT VALID;


--
-- TOC entry 3626 (class 2606 OID 17313)
-- Name: detalle_activo detalle_activo_id_baja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_activo
    ADD CONSTRAINT detalle_activo_id_baja_fkey FOREIGN KEY (id_baja) REFERENCES public.baja_activo_fijo(id) NOT VALID;


--
-- TOC entry 3611 (class 2606 OID 17197)
-- Name: direccion direccion_id_ubicacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_id_ubicacion_fkey FOREIGN KEY (codigo_ubicacion) REFERENCES public.ubicacion(codigo) NOT VALID;


--
-- TOC entry 3612 (class 2606 OID 17202)
-- Name: empresa empresa_nit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_nit_fkey FOREIGN KEY (nit) REFERENCES public.persona(nit) NOT VALID;


--
-- TOC entry 3613 (class 2606 OID 17207)
-- Name: empresa empresa_nit_representante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_nit_representante_fkey FOREIGN KEY (nit_representante) REFERENCES public.persona_natural(nit) NOT VALID;


--
-- TOC entry 3614 (class 2606 OID 17212)
-- Name: garantia_fiador garantia_fiador_id_credito_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garantia_fiador
    ADD CONSTRAINT garantia_fiador_id_credito_persona_fkey FOREIGN KEY (id_credito_persona) REFERENCES public.credito_persona(id_credito);


--
-- TOC entry 3615 (class 2606 OID 17217)
-- Name: garantia_fiador garantia_fiador_id_ingreso_egreso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garantia_fiador
    ADD CONSTRAINT garantia_fiador_id_ingreso_egreso_fkey FOREIGN KEY (id_ingreso_egreso) REFERENCES public.ingreso_egreso(id);


--
-- TOC entry 3616 (class 2606 OID 17222)
-- Name: garantia_fiador garantia_fiador_nit_fiador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garantia_fiador
    ADD CONSTRAINT garantia_fiador_nit_fiador_fkey FOREIGN KEY (nit_fiador) REFERENCES public.persona_natural(nit);


--
-- TOC entry 3617 (class 2606 OID 17227)
-- Name: persona persona_id_direccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_id_direccion_fkey FOREIGN KEY (id_direccion) REFERENCES public.direccion(id) NOT VALID;


--
-- TOC entry 3618 (class 2606 OID 17232)
-- Name: persona_natural persona_natural_nit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona_natural
    ADD CONSTRAINT persona_natural_nit_fkey FOREIGN KEY (nit) REFERENCES public.persona(nit) NOT VALID;


--
-- TOC entry 3619 (class 2606 OID 17237)
-- Name: telefono telefono_nit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_nit_fkey FOREIGN KEY (nit) REFERENCES public.persona(nit);


--
-- TOC entry 3620 (class 2606 OID 17242)
-- Name: usuario usuario_nit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_nit_fkey FOREIGN KEY (nit) REFERENCES public.persona_natural(nit) NOT VALID;


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;


-- Completed on 2021-04-23 21:56:39

--
-- PostgreSQL database dump complete
--


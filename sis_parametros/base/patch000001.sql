/***********************************I-SCP-JRR-PARAM-1-19/11/2012****************************************/

--  
-- Structure for table talarma (OID = 306277) : 
--
CREATE TABLE param.talarma (
    id_alarma serial NOT NULL,
    descripcion varchar,
    acceso_directo varchar,
    fecha date,
    id_funcionario integer,
    tipo varchar(50),
    obs varchar(300),
    clase varchar(150),
    parametros varchar DEFAULT '{}'::character varying NOT NULL,
    titulo varchar(200),
    sw_correo integer DEFAULT 0 NOT NULL
) 
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tconfig_alarma (OID = 306287) : 
--
CREATE TABLE param.tconfig_alarma (
    id_config_alarma serial NOT NULL,
    codigo varchar(50) NOT NULL,
    descripcion varchar(300),
    dias integer NOT NULL,
    id_subsistema integer NOT NULL
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tcorrelativo (OID = 306295) : 
--
CREATE TABLE param.tcorrelativo (
    id_correlativo serial NOT NULL,
    num_actual integer NOT NULL,
    num_siguiente integer NOT NULL,
    id_periodo integer,
    id_gestion integer,
    id_documento integer,
    id_uo integer,
    id_depto integer
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tdocumento (OID = 306319) : 
--
CREATE TABLE param.tdocumento (
    id_documento serial NOT NULL,
    id_subsistema integer,
    codigo varchar(10),
    descripcion varchar(200),
    periodo_gestion varchar(10) DEFAULT 'periodo'::character varying NOT NULL,
    tipo varchar(20),
    tipo_numeracion varchar(10) NOT NULL,
    formato varchar(300)
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tgestion (OID = 306331) : 
--
CREATE TABLE param.tgestion (
    id_gestion serial NOT NULL,
    gestion integer,
    estado varchar(15)
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tinstitucion (OID = 306339) : 
--
CREATE TABLE param.tinstitucion (
    id_institucion serial NOT NULL,
    doc_id varchar(50),
    nombre varchar(100) NOT NULL,
    casilla varchar(50),
    telefono1 varchar(50),
    telefono2 varchar(50),
    celular1 varchar(50),
    celular2 varchar(50),
    fax varchar(50),
    email1 varchar(100),
    email2 varchar(100),
    pag_web varchar(100),
    observaciones text,
    id_persona integer,
    direccion varchar(200),
    codigo_banco varchar(10),
    es_banco varchar(2) DEFAULT 'NO'::character varying NOT NULL,
    codigo varchar(25),
    cargo_representante varchar DEFAULT 'Representante Legal'::character varying
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tlugar (OID = 306352) : 
--
CREATE TABLE param.tlugar (
    id_lugar serial NOT NULL,
    id_lugar_fk integer,
    codigo varchar(25),
    nombre varchar(100),
    tipo varchar(25) DEFAULT 'pais'::character varying NOT NULL,
    sw_municipio varchar(2) DEFAULT 'no'::character varying NOT NULL,
    sw_impuesto varchar(2) DEFAULT 'si'::character varying NOT NULL,
    codigo_largo varchar(100)
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tmoneda (OID = 306364) : 
--
CREATE TABLE param.tmoneda (
    id_moneda serial NOT NULL,
    moneda varchar(300),
    codigo varchar(5),    
    tipo_moneda varchar(25)
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tperiodo (OID = 306372) : 
--
CREATE TABLE param.tperiodo (
    id_periodo serial NOT NULL,
    periodo integer,
    id_gestion integer,
    fecha_ini date,
    fecha_fin date
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tpm_financiador (OID = 306380) : 
--
CREATE TABLE param.tpm_financiador (
    id_financiador serial NOT NULL,
    codigo_financiador varchar(10) NOT NULL,
    nombre_financiador varchar(100),
    descripcion_financiador text,
    id_financiador_actif integer
) 
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tpm_programa (OID = 306392) : 
--
CREATE TABLE param.tpm_programa (
    id_programa serial NOT NULL,
    codigo_programa varchar(10) NOT NULL,
    nombre_programa varchar(100),
    descripcion_programa text,
    id_programa_actif integer
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tpm_proyecto (OID = 306402) : 
--
CREATE TABLE param.tpm_proyecto (
    id_proyecto serial NOT NULL,
    codigo_proyecto varchar(10) NOT NULL,
    nombre_proyecto varchar(100),
    descripcion_proyecto text,
    id_proyecto_actif integer,
    nombre_corto varchar(100),
    codigo_sisin bigint,
    hidro varchar(2) DEFAULT 'no'::character varying NOT NULL
) 
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tpm_regional (OID = 306413) : 
--
CREATE TABLE param.tpm_regional (
    id_regional serial NOT NULL,
    codigo_regional varchar(10) NOT NULL,
    nombre_regional varchar(100),
    descripcion_regional text,
    id_regional_actif integer
)
INHERITS (pxp.tbase) WITHOUT OIDS;
--
-- Structure for table tproveedor (OID = 306423) : 
--
CREATE TABLE param.tproveedor (
    id_proveedor serial NOT NULL,
    id_institucion integer,
    id_persona integer,
    tipo varchar,
    numero_sigma varchar,
    codigo varchar,
    nit varchar(100)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tunidad_medida (OID = 309525) : 
--
CREATE TABLE param.tunidad_medida (
    id_unidad_medida serial NOT NULL,
    codigo varchar(20),
    descripcion varchar
)
INHERITS (pxp.tbase) WITHOUT OIDS;

-- Table: param.tservicio

-- DROP TABLE param.tservicio;

CREATE TABLE param.tservicio(
  id_servicio serial NOT NULL,
  codigo character varying(20) NOT NULL,
  nombre character varying(100) NOT NULL,
  descripcion character varying(1000),
  CONSTRAINT tservicio_pkey PRIMARY KEY (id_servicio)
)
INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);
ALTER TABLE param.tservicio OWNER TO postgres;



--
-- Comments
--
COMMENT ON COLUMN param.tlugar.tipo IS 'El tipo puede ser : pais, departamento, provincia, localidad, zona';
COMMENT ON TABLE param.tpm_financiador IS 'sistema=parametros&codigo=FINANC&prefijo=PM&titulo=Financiadores&num_dt=2&dt_1=descripcion_financiador&dt_2=codigo_financiador&desc=Almacena los Financiadores';
COMMENT ON COLUMN param.tpm_financiador.id_financiador IS 'label=Id Financiador&disable=no';
COMMENT ON COLUMN param.tpm_financiador.codigo_financiador IS 'label=Codigo de Financiador&disable=no';
COMMENT ON COLUMN param.tpm_financiador.nombre_financiador IS 'label=Financiador&disable=no';
COMMENT ON COLUMN param.tpm_financiador.descripcion_financiador IS 'label=Descripcion&disable=no';
COMMENT ON COLUMN param.tpm_financiador.id_financiador_actif IS 'para actualización de activos fijos';
COMMENT ON TABLE param.tpm_programa IS 'sistema=parametros&codigo=PROGRA&prefijo=PM&titulo=Programas&num_dt=2&dt_1=descripcion_programa&dt_2=codigo_programa&desc=Almacena los Programas';
COMMENT ON COLUMN param.tpm_programa.id_programa IS 'label=Id Programa&disable=no';
COMMENT ON COLUMN param.tpm_programa.codigo_programa IS 'label=Código&disable=no';
COMMENT ON COLUMN param.tpm_programa.nombre_programa IS 'label=Nombre&disable=no';
COMMENT ON COLUMN param.tpm_programa.descripcion_programa IS 'label=Descripción&disable=no';
COMMENT ON COLUMN param.tpm_programa.id_programa_actif IS 'para actualización de activos fijos';
COMMENT ON TABLE param.tpm_proyecto IS 'sistema=parametros&codigo=PROYEC&prefijo=PM&titulo=Proyectos&num_dt=2&dt_1=descripcion_proyecto&dt_2=codigo_proyecto&desc=Almacena los Proyectos';
COMMENT ON COLUMN param.tpm_proyecto.id_proyecto IS 'label=Id Proyecto&disable=no';
COMMENT ON COLUMN param.tpm_proyecto.codigo_proyecto IS 'label=Código&disable=no';
COMMENT ON COLUMN param.tpm_proyecto.nombre_proyecto IS 'label=Proyecto&disable=no';
COMMENT ON COLUMN param.tpm_proyecto.descripcion_proyecto IS 'label=Descripción&disable=no';
COMMENT ON COLUMN param.tpm_proyecto.id_proyecto_actif IS 'para actualización de activos fijos';
COMMENT ON TABLE param.tpm_regional IS 'sistema=parametros&codigo=REGION&prefijo=PM&titulo=Regional&num_dt=2&dt_1=codigo_regional&dt_2=nombre_regional&desc=Almacena informacion referente a las Regionales';
COMMENT ON COLUMN param.tpm_regional.id_regional IS 'label=Id Regional&disable=no';
COMMENT ON COLUMN param.tpm_regional.codigo_regional IS 'label=Código Regional&disable=no';
COMMENT ON COLUMN param.tpm_regional.nombre_regional IS 'label=Nombre Regional&disable=no';
COMMENT ON COLUMN param.tpm_regional.descripcion_regional IS 'label=Descripción Regional&disable=no';
COMMENT ON COLUMN param.tpm_regional.id_regional_actif IS 'para actualización de activos fijos';


CREATE TABLE param.tcatalogo (
	id_catalogo serial NOT NULL,
    id_subsistema integer,
    codigo character varying(20),
    descripcion character varying(200),
    tipo varchar(15),
    CONSTRAINT pk_tcatalogo__id_catalogo PRIMARY KEY (id_catalogo)
) INHERITS (pxp.tbase)
WITH ( OIDS=TRUE );

ALTER TABLE param.tcatalogo OWNER TO postgres;

/***********************************F-SCP-JRR-PARAM-1-19/11/2012****************************************/

/***********************************I-SCP-RCM-PARAM-0-23/11/2012****************************************/
--Adding new column to table param.tproveedor
alter table param.tproveedor
add column id_lugar integer;
/***********************************F-SCP-RCM-PARAM-0-23/11/2012****************************************/

/***********************************I-SCP-RCM-PARAM-12-26/11/2012****************************************/

CREATE TABLE param.tcatalogo_tipo(
	id_catalogo_tipo SERIAL NOT NULL,
	id_subsistema integer, 
	nombre varchar(100),
	tabla varchar(100), 
	PRIMARY KEY (id_catalogo_tipo),
    CONSTRAINT uq_tcatalogo_tipo__id_subsistema__nombre UNIQUE (id_subsistema, nombre)
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);

alter table param.tcatalogo add column id_catalogo_tipo integer;

alter table param.tcatalogo drop column tipo;
alter table param.tcatalogo drop column id_subsistema;

/***********************************F-SCP-RCM-PARAM-12-26/11/2012****************************************/


/***********************************I-SCP-RCM-PARAM-0-06/12/2012****************************************/
alter table param.tunidad_medida
add column tipo varchar(50);
/***********************************F-SCP-RCM-PARAM-0-06/12/2012****************************************/


/***********************************I-SCP-RAC-PARAM-0-06/12/2012****************************************/

ALTER TABLE param.talarma
  ADD COLUMN id_usuario INTEGER;
  
/***********************************F-SCP-RAC-PARAM-0-06/12/2012****************************************/
  
/***********************************I-SCP-RAC-PARAM-21.1-10/12/2012*****************************************/
    
  ALTER TABLE param.talarma
  ADD COLUMN titulo_correo VARCHAR(500);
  
  
/***********************************F-SCP-RAC-PARAM-21.1-10/12/2012*****************************************/

/***********************************I-SCP-RAC-PARAM-0-04/01/2013*****************************************/
--adicona fila para compatibilizar con endesis

ALTER TABLE param.tmoneda
  ADD COLUMN prioridad INTEGER;

ALTER TABLE param.tmoneda
  ADD COLUMN tipo_actualizacion VARCHAR(30);  

ALTER TABLE param.tmoneda
  ADD COLUMN origen VARCHAR(30);

COMMENT ON COLUMN param.tmoneda.origen
IS 'nacional o extrajera';


--  tabla para aprobadores

CREATE TABLE param.taprobador(
    id_aprobador SERIAL NOT NULL,
    id_funcionario int4 NOT NULL,
    id_subsistema int4 NOT NULL,
    id_centro_costo int4,
    monto_min numeric(19, 0),
    monto_max numeric(19, 0),
    fecha_ini date,
    fecha_fin date,
    id_uo int4,
    
    obs varchar(255),
    PRIMARY KEY (id_aprobador)) INHERITS (pxp.tbase);
    
-- empresa

CREATE TABLE param.tempresa(
    id_empresa SERIAL NOT NULL,
    nombre varchar(150),
    logo varchar(255),
    nit VARCHAR(150),
    PRIMARY KEY (id_empresa)) INHERITS (pxp.tbase); 

--
--------------- SQL ---------------
--  filas acionales a la tabla de gestion
ALTER TABLE param.tgestion
  ADD COLUMN id_moneda_base INTEGER;
  
ALTER TABLE param.tgestion
  ADD COLUMN id_empresa INTEGER;
  
  
  
------------------------- modificaciones tablas EP

ALTER TABLE param.tpm_financiador
  RENAME TO tfinanciador;
  
  
ALTER TABLE param.tpm_programa
  RENAME TO tprograma;
  
ALTER TABLE param.tpm_proyecto
  RENAME TO tproyecto;
  
ALTER TABLE param.tpm_regional
  RENAME TO tregional;
  
  ALTER TABLE param.tproyecto
  ADD COLUMN id_proyecto_cat_prog INTEGER;
  
 
CREATE TABLE param.tactividad(
id_actividad SERIAL NOT NULL, 
codigo_actividad varchar(
    20), nombre_actividad varchar(
    100), descripcion_actividad varchar(
    255), PRIMARY KEY(
    id_actividad)) INHERITS (pxp.tbase); 
    
    
CREATE TABLE param.tprograma_proyecto_acttividad(
id_prog_pory_acti SERIAL NOT NULL, 
id_programa int4 NOT NULL, 
id_proyecto int4
 NOT NULL, 
 id_actividad int4 NOT NULL, 
 PRIMARY KEY(
    id_prog_pory_acti)) INHERITS (pxp.tbase);    


CREATE TABLE param.tep(
id_ep SERIAL NOT NULL, 
id_prog_pory_acti int4 NOT NULL, 
id_regional int4 NOT NULL, 
id_financiador int4 NOT NULL, 
sw_presto int4, 
PRIMARY KEY(id_ep)) INHERITS (pxp.tbase);


ALTER TABLE param.tcatalogo
  ADD COLUMN orden NUMERIC(3,2);
 
 ALTER TABLE param.tcatalogo_tipo
  ADD COLUMN tabla_estado VARCHAR(100); 
 
 
 ALTER TABLE param.tcatalogo_tipo
  ADD COLUMN columna_estado VARCHAR(100); 
  
  CREATE TABLE param.tcentro_costo(
	id_centro_costo SERIAL NOT NULL,
	codigo varchar(20), 
	descripcion varchar(200),
	id_ep int4 NOT NULL, 
	id_uo int4,
	id_fuente_financiammiento int4, 
	id_parametro int4, 
	id_gestion int4,
	id_concepto_colectivo int4, 
	id_categoria_prog int4, 
	nombre_agrupador varchar(150), 
	tipo_pres varchar(30), 
	estado varchar(30),   -- estado_pre en endesis
	cod_fin varchar(10), 
	cod_prg varchar(10), 
	cod_pry varchar(10), 
	cod_act varchar(10), 
	PRIMARY KEY(id_centro_costo))INHERITS (pxp.tbase);
	
	
CREATE TABLE param.testado_funcionario(
    id_estado_funcionario SERIAL NOT NULL,
    id_funcionario int4 NOT NULL,
    id_catalogo int4 NOT NULL,
    tipo varchar(15),
    tipo_funcionario varchar(25),
    condicion varchar(255),
    tiempo_estimado int4,
    id_unidad_medida int4,
    PRIMARY KEY (id_estado_funcionario)) INHERITS (pxp.tbase);

/***********************************F-SCP-RAC-PARAM-0-04/01/2013*****************************************/


/***********************************I-SCP-FRH-PARAM-0-04/02/2013****************************************/
-- Tabla tdepto_uo 

CREATE TABLE param.tdepto_uo (
    id_depto_uo serial NOT NULL,
    id_depto integer,
    id_uo integer,
    CONSTRAINT pk_tdepto_uo__id_depto_uo PRIMARY KEY (id_depto_uo)
)
INHERITS (pxp.tbase) WITH OIDS;


-- Tabla tdepto_usuario 

CREATE TABLE param.tdepto_usuario (
    id_depto_usuario serial NOT NULL,
    id_depto integer,
    id_usuario integer,
    funcion varchar(300),
    cargo varchar(80),
    CONSTRAINT pk_tdepto_usuario__id_depto_usuario PRIMARY KEY (id_depto_usuario)
)
INHERITS (pxp.tbase) WITH OIDS;


-- Tabla tdepto 

CREATE TABLE param.tdepto (
    id_depto serial NOT NULL,
    id_subsistema integer,
    codigo varchar(15),
    nombre varchar(100),
    nombre_corto varchar(100),
    CONSTRAINT pk_tdepto__id_depto PRIMARY KEY (id_depto)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

/***********************************F-SCP-FRH-PARAM-0-04/02/2013*****************************************/



/***********************************I-SCP-RAC-PARAM-0-04/02/2013*****************************************/

ALTER TABLE param.tmoneda 
  ALTER COLUMN moneda  type VARCHAR(300) COLLATE pg_catalog."default";
  

  ALTER TABLE param.tempresa
  ADD COLUMN codigo  VARCHAR(100) COLLATE pg_catalog."default";

  
/***********************************F-SCP-RAC-PARAM-0-04/02/2013*****************************************/


/***********************************I-SCP-RAC-PARAM-0-21/02/2013*****************************************/


 
--------------- SQL ---------------

ALTER TABLE param.taprobador
  ADD COLUMN id_ep INTEGER;
  
  
--------------- SQL ---------------

DROP TABLE param.tcentro_costo;  
 
CREATE TABLE param.tcentro_costo(
    id_centro_costo SERIAL NOT NULL,
    id_ep int4 NOT NULL,
    id_uo int4,
    id_gestion int4,
    PRIMARY KEY (id_centro_costo))
    INHERITS (pxp.tbase); 
    
    
--------------- SQL ---------------

--------------- SQL ---------------

ALTER TABLE param.tdocumento
  ADD CONSTRAINT tdocumento_idx 
    UNIQUE (codigo);


CREATE TABLE param.tconcepto_ingas(
    id_concepto_ingas SERIAL NOT NULL,
    tipo varchar(255),
    desc_ingas varchar(150),
    movimiento varchar(255),
    sw_tes varchar(2),
    id_oec int4,
    PRIMARY KEY (id_concepto_ingas))
    INHERITS (pxp.tbase);
  
  
CREATE TABLE param.ttipo_cambio (
  id_tipo_cambio SERIAL, 
  id_moneda INTEGER NOT NULL, 
  fecha DATE DEFAULT now() NOT NULL, 
 
  oficial NUMERIC(18,6) NOT NULL, 
  compra NUMERIC(18,6) NOT NULL, 
  venta NUMERIC(18,6) NOT NULL, 
  observaciones VARCHAR(200),
 PRIMARY KEY(id_tipo_cambio)
)  INHERITS (pxp.tbase); 
  
       
/***********************************F-SCP-RAC-PARAM-0-21/02/2013*****************************************/

/***********************************I-SCP-AAO-PARAM-62-19/03/2013*****************************************/
CREATE TABLE param.tperiodo_subsistema (
  id_periodo_subsistema SERIAL NOT NULL, 
  id_periodo INTEGER, 
  id_subsistema INTEGER, 
  estado VARCHAR(20), 
  PRIMARY KEY(id_periodo_subsistema)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE param.tperiodo_subsistema
  OWNER TO postgres;
/***********************************F-SCP-AAO-PARAM-62-19/03/2013*****************************************/


/***********************************I-SCP-JRR-PARAM-104-04/04/2013****************************************/

CREATE TABLE param.tasistente (
  id_asistente SERIAL NOT NULL, 
  id_uo INTEGER NOT NULL, 
  id_funcionario INTEGER NOT NULL, 
  PRIMARY KEY(id_asistente)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-JRR-PARAM-104-04/04/2013****************************************/

/***********************************I-SCP-GSS-PARAM-84-01/04/2013****************************************/
CREATE TABLE param.tplantilla (
  id_plantilla SERIAL,  
  nro_linea NUMERIC(2,0), 
  desc_plantilla VARCHAR(255), 
  tipo NUMERIC(1,0), 
  sw_tesoro VARCHAR(2), 
  sw_compro VARCHAR(2), 
  CONSTRAINT pk_tplantilla__id_plantilla PRIMARY KEY(id_plantilla)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE param.tplantilla OWNER TO postgres;
/***********************************F-SCP-GSS-PARAM-84-01/04/2013****************************************/

/***********************************I-SCP-RCM-PARAM-85-03/04/2013****************************************/
CREATE TABLE param.tdocumento_fiscal (  
  id_documento_fiscal serial NOT NULL,
  id_plantilla integer NOT NULL,
  nro_documento integer NOT NULL,
  fecha_doc date NOT NULL,
  razon_social varchar(150) NOT NULL,
  nit varchar(30) NOT NULL,
  nro_autorizacion varchar(30),
  codigo_control varchar(30),
  dui varchar(30),
  formulario varchar(30),
  tipo_retencion varchar(20),
  estado varchar(30) NOT NULL,
  CONSTRAINT pk_tdocumento_fiscal___id_documento_fiscal PRIMARY KEY (id_documento_fiscal)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE param.tdocumento_fiscal OWNER TO postgres;
/***********************************F-SCP-RCM-PARAM-85-03/04/2013*****************************************/

/***********************************I-SCP-RCM-PARAM-0-15/04/2013****************************************/
alter table param.tproveedor
alter column codigo set not null;
/***********************************F-SCP-RCM-PARAM-0-15/04/2013*****************************************/


/***********************************I-SCP-RAC-PARAM-0-22/04/2013****************************************/

CREATE TABLE param.tgrupo(
id_grupo SERIAL NOT NULL, 
nombre varchar(400), 
obs varchar(1000) ,
PRIMARY KEY(id_grupo)) INHERITS (pxp.tbase);


CREATE TABLE param.tgrupo_ep(
id_grupo_ep SERIAL NOT NULL, 
id_grupo integer,
id_ep integer,
PRIMARY KEY(id_grupo_ep)) INHERITS (pxp.tbase);

/***********************************F-SCP-RAC-PARAM-0-22/04/2013*****************************************/


/***********************************I-SCP-RAC-PARAM-0-26/04/2013****************************************/

CREATE TABLE param.tgenerador_alarma(
id_generador_alarma SERIAL NOT NULL, 
funcion varchar NOT NULL, 
PRIMARY KEY(id_generador_alarma)) INHERITS (pxp.tbase);

/***********************************F-SCP-RAC-PARAM-0-26/04/2013*****************************************/
/***********************************I-SCP-JRR-PARAM-0-29/04/2013*****************************************/ 

CREATE TABLE param.tdepto_ep (
  id_depto_ep SERIAL NOT NULL, 
  id_depto INTEGER NOT NULL, 
  id_ep INTEGER NOT NULL, 
  CONSTRAINT tpm_depto_ep_pkey PRIMARY KEY(id_depto_ep)  
    NOT DEFERRABLE
) INHERITS (pxp.tbase)
WITH OIDS;

CREATE UNIQUE INDEX tdepto_ep_id__id_depto_id_ep ON param.tdepto_ep
  USING btree (id_ep, id_depto)
  WHERE ((estado_reg)::text = 'activo'::text);
/***********************************F-SCP-JRR-PARAM-0-29/04/2013*****************************************/


/***********************************I-SCP-RAC-PARAM-0-30/05/2013****************************************/

ALTER TABLE param.tdepto_usuario
  ADD COLUMN sw_alerta VARCHAR(3) DEFAULT 'no' NOT NULL;

/***********************************F-SCP-RAC-PARAM-0-30/05/2013****************************************/


/***********************************I-SCP-RAC-PARAM-0-31/05/2013****************************************/

ALTER TABLE param.tgrupo_ep
 ADD COLUMN id_uo integer;
  
/***********************************F-SCP-RAC-PARAM-0-31/05/2013****************************************/


/***********************************I-SCP-RAC-PARAM-0-03/06/2013****************************************/

  CREATE TABLE param.tdepto_uo_ep(
    id_depto_uo_ep SERIAL NOT NULL,
    id_depto int4,
    id_ep int4,
    id_uo int4,
    PRIMARY KEY (id_depto_uo_ep))
    INHERITS (pxp.tbase); 
    
/***********************************F-SCP-RAC-PARAM-0-03/06/2013****************************************/
  
/***********************************I-SCP-RCM-PARAM-0-28/06/2013****************************************/
ALTER TABLE param.tcorrelativo
  ADD COLUMN tabla varchar(70);
ALTER TABLE param.tcorrelativo
  ADD COLUMN id_tabla INTEGER;
/***********************************F-SCP-RCM-PARAM-0-28/06/2013****************************************/


/***********************************I-SCP-RAC-PARAM-0-15/07/2013****************************************/

CREATE TABLE param.tfirma(
    id_firma SERIAL NOT NULL,
    id_documento int4 NOT NULL,
    id_depto int4 NOT NULL,
    id_funcionario int4,
    prioridad int4,
    monto_min numeric(19, 2),
    monto_max numeric(19, 2),
    desc_firma varchar(250),
    PRIMARY KEY (id_firma))
INHERITS (pxp.tbase);

/***********************************F-SCP-RAC-PARAM-0-15/07/2013****************************************/


/***********************************I-SCP-RCM-PARAM-0-09/07/2013****************************************/
ALTER TABLE param.talarma
  ADD CONSTRAINT chk_talarma__tipo CHECK (tipo in ('alarma','notificacion'));
/***********************************F-SCP-RCM-PARAM-0-09/07/2013****************************************/

/***********************************I-SCP-RCM-PARAM-0-26/08/2013****************************************/
alter table param.tasistente
add column recursivo varchar(2);
/***********************************F-SCP-RCM-PARAM-0-26/08/2013****************************************/

/***********************************I-SCP-RCM-PARAM-0-01/10/2013****************************************/
alter table param.tconcepto_ingas
add column activo_fijo VARCHAR(5) DEFAULT 'no';

alter table param.tconcepto_ingas
add column almacenable VARCHAR(5) DEFAULT 'no'; 
/***********************************F-SCP-RCM-PARAM-0-01/10/2013****************************************/





/***********************************I-SCP-RAC-PARAM-0-11/12/2013****************************************/

--------------- SQL ---------------

ALTER TABLE param.taprobador
  ADD COLUMN id_uo_cargo INTEGER;

COMMENT ON COLUMN param.taprobador.id_uo_cargo
IS 'identifica el cargo al del funcionario parobador,   si no hay cargo, si no hay un cargo identificado busca el funconario';

ALTER TABLE param.taprobador
  ADD COLUMN id_proceso_macro INTEGER;

COMMENT ON COLUMN param.taprobador.id_proceso_macro
IS 'ri esta definido filtra los  aprobadores por este criterio';


ALTER TABLE param.taprobador
  ALTER COLUMN id_funcionario DROP NOT NULL;

/***********************************F-SCP-RAC-PARAM-0-11/12/2013****************************************/



/***********************************I-SCP-ECR-PARAM-0-23/12/2013****************************************/


--1
CREATE TABLE param.tgrupo_archivo(
  id_grupo_archivo SERIAL NOT NULL, 
  nombre varchar(100), 
  descripcion varchar(1000), 
  CONSTRAINT pk_tgrupo_archivo__id_grupo_archivo PRIMARY KEY (id_grupo_archivo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

--2
CREATE TABLE param.textension(
  id_extension SERIAL NOT NULL, 
  extension varchar(10) NOT NULL, 
  peso_max_upload_mb numeric(18,2) DEFAULT 0, 
  CONSTRAINT pk_textension__id_extension PRIMARY KEY (id_extension)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

--3
CREATE TABLE param.textension_grupo_archivo(
  id_extension_grupo_archivo SERIAL NOT NULL, 
  id_extension INTEGER NOT NULL,
  id_grupo_archivo INTEGER NOT NULL,
  CONSTRAINT pk_textension_grupo_archivo__id_extension_grupo_archivo PRIMARY KEY (id_extension_grupo_archivo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;


/***********************************F-SCP-ECR-PARAM-0-23/12/2013****************************************/

/***********************************I-SCP-JRR-PARAM-0-08/02/2014****************************************/

ALTER TABLE param.tproveedor
  ADD COLUMN rotulo_comercial VARCHAR(150);

/***********************************F-SCP-JRR-PARAM-0-08/02/2014****************************************/


/***********************************I-SCP-RAC-PARAM-0-11/02/2014****************************************/

--------------- SQL ---------------
ALTER TABLE param.tplantilla
  ADD COLUMN sw_monto_excento VARCHAR(4) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_monto_excento
IS 'El documento requiere solictar porc_monto_excento_var,  se utiliza para factura electrica donde no se conoce el de antemano el porcentaje del monto excento de impuestos';


/***********************************F-SCP-RAC-PARAM-0-11/02/2014****************************************/


/***********************************I-SCP-JRR-PARAM-0-25/08/2014****************************************/

ALTER TABLE param.talarma
  ADD COLUMN correos TEXT;
  
ALTER TABLE param.talarma
  ADD COLUMN documentos TEXT;
  
/***********************************F-SCP-JRR-PARAM-0-25/08/2014****************************************/


/***********************************I-SCP-RAC-PARAM-09/10/2014****************************************/

--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN pago_automatico VARCHAR(5) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tconcepto_ingas.pago_automatico
IS 'cuando un concepto de gasto tiene habilitado el pago automatico, es considerado en el sistema de pagos directos para envio y alertas automatica segun fecha tentativa';

/***********************************F-SCP-RAC-PARAM-09/10/2014****************************************/


/***********************************I-SCP-RAC-PARAM-18/11/2014****************************************/


--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN sw_autorizacion VARCHAR(50)[];
  
/***********************************F-SCP-RAC-PARAM-18/11/2014****************************************/


/***********************************I-SCP-RAC-PARAM-11/12/2014****************************************/

--------------- SQL ---------------

ALTER TABLE param.tmoneda
  ADD COLUMN contabilidad VARCHAR(3) DEFAULT 'si' NOT NULL;

COMMENT ON COLUMN param.tmoneda.contabilidad
IS 'se utiliza para contabilizar en diferentes moendas si o no';

/***********************************F-SCP-RAC-PARAM-11/12/2014****************************************/


/***********************************I-SCP-RAC-PARAM-09/02/2015****************************************/

--------------- SQL ---------------

ALTER TABLE param.tdepto
  ADD COLUMN id_lugares INTEGER[];

COMMENT ON COLUMN param.tdepto.id_lugares
IS 'lugares que atiende el departamento, nulosigifica todo';

/***********************************F-SCP-RAC-PARAM-09/02/2015****************************************/



/***********************************I-SCP-RAC-PARAM-0-11/02/2015****************************************/

--------------- SQL ---------------

ALTER TABLE param.tdepto
  ADD COLUMN prioridad INTEGER DEFAULT 1 NOT NULL;

COMMENT ON COLUMN param.tdepto.prioridad
IS 'prioridad del departameto donde 0 es la mas importante';

/***********************************F-SCP-RAC-PARAM-0-11/02/2015****************************************/



/***********************************I-SCP-RAC-PARAM-0-03/03/2015****************************************/

--------------- SQL ---------------

ALTER TABLE param.tdepto
  ADD COLUMN modulo VARCHAR(100);

COMMENT ON COLUMN param.tdepto.modulo
IS 'Este campo se agrega para poder subdividir los deptos de un sistema en modulo, caso libro de banco y obligaciones de pago en tesoreria';

/***********************************F-SCP-RAC-PARAM-0-03/03/2015****************************************/



/***********************************I-SCP-RAC-PARAM-0-29/04/2015****************************************/

--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN estado_envio VARCHAR(15) DEFAULT 'exito' NOT NULL;

--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN desc_falla TEXT;

COMMENT ON COLUMN param.talarma.desc_falla
IS 'descripcion de la falla si existe';

/***********************************F-SCP-RAC-PARAM-0-29/04/2015****************************************/



/***********************************I-SCP-RAC-PARAM-1-29/04/2015****************************************/


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN id_estado_wf INTEGER;

COMMENT ON COLUMN param.talarma.id_estado_wf
IS 'indetifica el estado del wf, solo apra los correos hecho con plantilla, (especiales)';

--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN id_proceso_wf INTEGER;

COMMENT ON COLUMN param.talarma.id_proceso_wf
IS 'identifica el proceso wf que manda el correo (solo para plantillas)';


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN recibido VARCHAR(4) DEFAULT '--' NOT NULL;

COMMENT ON COLUMN param.talarma.recibido
IS 'alerta sobre el acuse de recibo, solo para plantilla preconfiguradas para recibir acuses';


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN id_plantilla_correo INTEGER;

COMMENT ON COLUMN param.talarma.id_plantilla_correo
IS 'identifica desde que plantilla se origino el correo';


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN fecha_recibido TIMESTAMP(0) WITHOUT TIME ZONE;

COMMENT ON COLUMN param.talarma.fecha_recibido
IS 'para marcar la fecha y hora del acuse de recibo';




/***********************************F-SCP-RAC-PARAM-1-29/04/2015****************************************/


/***********************************I-SCP-RAC-PARAM-1-21/08/2015****************************************/


--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_descuento VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_descuento
IS 'es para habilitar el libro de compras o ventas la la opcion deregistrar descuentos';

--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_autorizacion VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_autorizacion
IS 'habilita o el campo autorizacion en libro de compra ventas';


--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_codigo_control VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_codigo_control
IS 'habilita el campo codigo de control en libro de compra ventas';


--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN tipo_plantilla VARCHAR(15) DEFAULT 'compra' NOT NULL;

COMMENT ON COLUMN param.tplantilla.tipo_plantilla
IS 'compra o venta';

 
/***********************************F-SCP-RAC-PARAM-1-21/08/2015****************************************/

/***********************************I-SCP-RAC-PARAM-1-08/09/2015****************************************/

CREATE TABLE param.tdepto_depto (
  id_depto_depto SERIAL,
  id_depto_origen INTEGER NOT NULL,
  id_depto_destino INTEGER NOT NULL,
  obs TEXT,
  CONSTRAINT tdepto_depto_pkey PRIMARY KEY(id_depto_depto)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.tdepto_depto.id_depto_destino
IS 'es el depto que puede trabajar con depto origen, (considerar que no es comuntativo)';
/***********************************F-SCP-RAC-PARAM-1-08/09/2015****************************************/


/***********************************I-SCP-JRR-PARAM-0-20/09/2015****************************************/

CREATE TABLE param.tentidad (
    id_entidad serial NOT NULL,
    nombre varchar(150) NOT NULL,
    nit varchar(20) NOT NULL,   
    tipo_venta_producto varchar(20), 
    CONSTRAINT tentidad_pkey PRIMARY KEY(id_entidad)
    
) 
INHERITS (pxp.tbase) WITH OIDS;

/***********************************F-SCP-JRR-PARAM-0-20/09/2015****************************************/

/***********************************I-SCP-JRR-PARAM-0-03/10/2015****************************************/


ALTER TABLE param.tentidad
  ADD COLUMN estados_comprobante_venta VARCHAR(100);
  
ALTER TABLE param.tentidad
  ADD COLUMN estados_anulacion_venta VARCHAR(100);
  
ALTER TABLE param.tconcepto_ingas
  ADD COLUMN descripcion_larga TEXT;

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN id_entidad INTEGER;
  
ALTER TABLE param.tconcepto_ingas
  ADD COLUMN id_actividad_economica INTEGER;


/***********************************F-SCP-JRR-PARAM-0-03/10/2015****************************************/

/***********************************I-SCP-RAC-PARAM-1-31/08/2015****************************************/
--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_nro_dui VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_nro_dui
IS 'si o no';



ALTER TABLE param.tplantilla
  ADD COLUMN sw_ic VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_ic
IS 'si o no, si esta habilitado, es indispensable que el monto excento tambien lo este, ya que se copia el valor por que tienen el mismo comportamiento';

/***********************************F-SCP-RAC-PARAM-1-31/08/2015****************************************/





/***********************************I-SCP-RCM-PARAM-0-27/10/2015****************************************/
alter table param.tcatalogo
    add column icono varchar(100);
/***********************************F-SCP-RCM-PARAM-0-27/10/2015****************************************/


/***********************************I-SCP-GSS-PARAM-0-04/11/2015****************************************/

CREATE TABLE param.tproveedor_cta_bancaria (
  id_proveedor_cta_bancaria SERIAL,
  nro_cuenta VARCHAR(30),
  swift_big VARCHAR(10),
  fw_aba_cta VARCHAR(15),
  id_proveedor INTEGER NOT NULL,
  id_banco_beneficiario INTEGER,
  banco_intermediario VARCHAR(30),
  CONSTRAINT tproveedor_cta_bancaria_pkey PRIMARY KEY(id_proveedor_cta_bancaria),
  CONSTRAINT fk_tproveedor_cta_bancaria__id_banco_beneficiario FOREIGN KEY (id_banco_beneficiario)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-GSS-PARAM-0-04/11/2015****************************************/

/***********************************I-SCP-RAC-PARAM-0-03/12/2015****************************************/

--------------- SQL ---------------

ALTER TABLE param.tmoneda
  ADD COLUMN triangulacion VARCHAR(5) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tmoneda.triangulacion
IS 'es moneda de triangulacion';

/***********************************F-SCP-RAC-PARAM-0-03/12/2015****************************************/

/***********************************I-SCP-RAC-PARAM-0-18/12/2015****************************************/

ALTER TABLE param.tmoneda
  ADD COLUMN codigo_internacional VARCHAR(4);
  
/***********************************F-SCP-RAC-PARAM-0-18/12/2015****************************************/



/***********************************I-SCP-RAC-PARAM-0-21/12/2015****************************************/


--------------- SQL ---------------

ALTER TABLE param.tgestion
  ADD COLUMN fecha_ini DATE;
  
  --------------- SQL ---------------

ALTER TABLE param.tgestion
  ADD COLUMN fecha_fin DATE;

/***********************************F-SCP-RAC-PARAM-0-21/12/2015****************************************/





/***********************************I-SCP-FFP-PARAM-0-04/01/2016****************************************/

ALTER TABLE param.tgestion
  ADD COLUMN tipo VARCHAR(255);

/***********************************F-SCP-FFP-PARAM-0-21/12/2015****************************************/

/***********************************I-SCP-RCM-PARAM-0-05/11/2013****************************************/
CREATE TABLE param.tproveedor_item_servicio (  
  id_proveedor_item serial NOT NULL,
  id_proveedor integer NOT NULL,
  id_item integer,
  id_servicio integer,
  CONSTRAINT pk_tproveedor_item_servicio___id_proveedor_item PRIMARY KEY (id_proveedor_item),
  CONSTRAINT chk_tproveedor_item_servivio__id_item__id_servicio CHECK (id_item IS NULL AND id_servicio IS NOT NULL OR id_servicio IS NULL AND id_item IS NOT NULL)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE param.tproveedor_item_servicio OWNER TO postgres;
/***********************************F-SCP-RCM-PARAM-0-05/11/2013****************************************/

/***********************************I-SCP-JRR-PARAM-0-16/02/2016****************************************/

ALTER TABLE param.tlugar
  ADD COLUMN es_regional VARCHAR(2) DEFAULT 'no' NOT NULL;

/***********************************F-SCP-JRR-PARAM-0-16/02/2016****************************************/



/***********************************I-SCP-RAC-PARAM-0-19/02/2016****************************************/

--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN tipo_excento VARCHAR(20) DEFAULT 'variable' NOT NULL;

COMMENT ON COLUMN param.tplantilla.tipo_excento
IS 'peuden ser variable, porcentual, constante. En caso de constante o porcentual toma el valor del campo valor_excento';


--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN valor_excento NUMERIC DEFAULT 0 NOT NULL;

COMMENT ON COLUMN param.tplantilla.valor_excento
IS 'valor que se aplica al excento cuando es  porcentual o constante';

/***********************************F-SCP-RAC-PARAM-0-19/02/2016****************************************/



/***********************************I-SCP-RAC-PARAM-0-22/02/2016****************************************/
-------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN tipo_informe VARCHAR(30) DEFAULT 'lcv' NOT NULL;

COMMENT ON COLUMN param.tplantilla.tipo_informe
IS 'lcv, libro de compras estandar
retenciones,  retenciones de biene y servicios
ncd, libro de compras notas de credito y debito
otro,  otros';


--------------- SQL ---------------

ALTER TABLE param.tdepto
  ADD COLUMN id_entidad INTEGER;

COMMENT ON COLUMN param.tdepto.id_entidad
IS 'identifica a que entidad corresponde este departamento';

/***********************************F-SCP-RAC-PARAM-0-22/02/2016****************************************/

/***********************************I-SCP-JRR-PARAM-0-10/03/2016****************************************/

ALTER TABLE param.tentidad
  ADD COLUMN pagina_entidad VARCHAR(200);

/***********************************F-SCP-JRR-PARAM-0-10/03/2016****************************************/

/***********************************I-SCP-JRR-PARAM-0-11/03/2016****************************************/

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN codigo VARCHAR(30);

/***********************************F-SCP-JRR-PARAM-0-11/03/2016****************************************/




/***********************************I-SCP-RAC-PARAM-0-17/03/2016****************************************/


ALTER TABLE param.tentidad
  ADD COLUMN direccion_matriz VARCHAR;

COMMENT ON COLUMN param.tentidad.direccion_matriz
IS 'dirección fiscal que aprece en reprotes como LCV (direccion fiscal)';




/***********************************F-SCP-RAC-PARAM-0-17/03/2016****************************************/



/***********************************I-SCP-FFP-PARAM-0-28/03/2016****************************************/

ALTER TABLE param.tdocumento
  ADD COLUMN ruta_plantilla VARCHAR(255);

/***********************************F-SCP-FFP-PARAM-0-28/03/2016****************************************/


/***********************************I-SCP-FFP-PARAM-0-11/04/2016****************************************/

ALTER TABLE param.tentidad
  ADD COLUMN identificador_min_trabajo VARCHAR(50);

ALTER TABLE param.tentidad
  ADD COLUMN identificador_caja_salud VARCHAR(50);
/***********************************F-SCP-FFP-PARAM-0-11/04/2016****************************************/




/***********************************I-SCP-RAC-PARAM-0-11/04/2016****************************************/


--------------- SQL ---------------

 -- object recreation
ALTER TABLE param.talarma
  DROP CONSTRAINT chk_talarma__tipo RESTRICT;

ALTER TABLE param.talarma
  ADD CONSTRAINT chk_talarma__tipo CHECK ((tipo)::text = ANY (ARRAY[('comunicado'::character varying)::text,('alarma'::character varying)::text, ('notificacion'::character varying)::text]));



--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN id_alarma_fk INTEGER;

COMMENT ON COLUMN param.talarma.id_alarma_fk
IS 'solo para alertas del tipo comunicado hace referencia al registro original';


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN estado_comunicado VARCHAR(30);

ALTER TABLE param.talarma
  ALTER COLUMN estado_comunicado SET DEFAULT 'borrador';

COMMENT ON COLUMN param.talarma.estado_comunicado
IS 'borrado o activado, cuando esta activado se registras las alertas individuales';


--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN id_uos INTEGER[];

COMMENT ON COLUMN param.talarma.id_uos
IS 'hace referencia a las UO a las que se debe entregar el comunicado, solo en el regitro origen (tipo = comunicado) id_alarma_fk = NULL';

/***********************************F-SCP-RAC-PARAM-0-11/04/2016****************************************/


 
/***********************************I-SCP-RAC-PARAM-0-16/04/2016****************************************/
--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN id_grupo_ots INTEGER[];

COMMENT ON COLUMN param.tconcepto_ingas.id_grupo_ots
IS 'lamacena las ot que pueden relacionarce con este el concepto de gasto';


--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN id_unidad_medida INTEGER;

COMMENT ON COLUMN param.tconcepto_ingas.id_unidad_medida
IS 'unidad de medida del concepto';


--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN nandina VARCHAR(100);

COMMENT ON COLUMN param.tconcepto_ingas.nandina
IS 'coduigo partida de aduana para exportaciones';


/***********************************F-SCP-RAC-PARAM-0-16/04/2016****************************************/
/***********************************I-SCP-JRR-PARAM-0-22/04/2016****************************************/
--------------- SQL ---------------

ALTER TABLE param.talarma
  ADD COLUMN pendiente varchar(30) DEFAULT 'no';

COMMENT ON COLUMN param.talarma.pendiente
IS 'Si el mensaje esta en proceso de envio valores: no o hora en formato YYYYMMDD-HH24MISSMS la hora es la hora en la que se inicio el proceso de envio';

/***********************************F-SCP-JRR-PARAM-0-22/04/2016****************************************/




/***********************************I-SCP-RAC-PARAM-0-22/06/2016****************************************/

--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_qr VARCHAR(3) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_qr
IS 'si se habilita o no el codigo qr para llenado rapido';

--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN sw_nit VARCHAR(3) DEFAULT 'si' NOT NULL;

COMMENT ON COLUMN param.tplantilla.sw_nit
IS 'si permite o no el nro de nit';


--------------- SQL ---------------

ALTER TABLE param.tplantilla
  ADD COLUMN plantilla_qr VARCHAR;

COMMENT ON COLUMN param.tplantilla.plantilla_qr
IS 'defineel formato de lectura para el codigo qr, con os nombres de las columnas qe se llenan separados por pipe';


--------------- SQL ---------------

ALTER TABLE param.tmoneda
  ADD COLUMN show_combo VARCHAR(3) DEFAULT 'si' NOT NULL;

COMMENT ON COLUMN param.tmoneda.show_combo
IS 'si se muestra o no en combos, por ejemplo si la moneda aprace en el combo de una solicitud de comra';


/***********************************F-SCP-RAC-PARAM-0-22/06/2016****************************************/

/***********************************I-SCP-RCM-PARAM-0-24/08/2016*****************************************/
/*
 en algunas base de datos el codigo noes unico por eso lo comento
 RAC 25/05/2017
 
alter table param.tinstitucion
add constraint tinstitucion_uq_codigo unique(codigo);
*/
/***********************************F-SCP-RCM-PARAM-0-24/08/2016*****************************************/



/***********************************I-SCP-RAC-PARAM-0-27/09/2016*****************************************/

--------------- SQL ---------------

CREATE TABLE param.twidget (
  id_widget SERIAL NOT NULL,
  nombre VARCHAR,
  obs VARCHAR,
  foto VARCHAR,
  clase VARCHAR(100),
  tipo VARCHAR(30) DEFAULT 'iframe' NOT NULL,
  ruta VARCHAR,
  PRIMARY KEY(id_widget)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.twidget.tipo
IS 'iframe o objeto';

--------------- SQL ---------------

CREATE TABLE param.tdashboard (
  id_dashboard SERIAL NOT NULL,
  nombre VARCHAR,
  id_usuario INTEGER,
  PRIMARY KEY(id_dashboard)
) INHERITS (pxp.tbase)

WITH (oids = false);


--------------- SQL ---------------

CREATE TABLE param.tdashdet (
  id_dashdet SERIAL NOT NULL,
  id_dashboard INTEGER NOT NULL,
  id_widget INTEGER NOT NULL,
  columna INTEGER DEFAULT 0 NOT NULL,
  fila INTEGER,
  PRIMARY KEY(id_dashdet)
) INHERITS (pxp.tbase)

WITH (oids = false);





/***********************************F-SCP-RAC-PARAM-0-27/09/2016*****************************************/


/***********************************I-SCP-RAC-PARAM-0-06/10/2016*****************************************/

CREATE TYPE param.dashdet AS (
  id_dashboard INTEGER,
  id_dashdet INTEGER,
  id_widget INTEGER,
  fila INTEGER,
  columna INTEGER
);



/***********************************F-SCP-RAC-PARAM-0-06/10/2016*****************************************/


/***********************************I-SCP-RAC-PARAM-0-22/11/2016*****************************************/


--------------- SQL ---------------

CREATE TABLE param.tsubsistema_var (
  id_subsistema_var SERIAL NOT NULL,
  codigo VARCHAR(50) NOT NULL,
  nombre VARCHAR NOT NULL,
  descripcion VARCHAR NOT NULL,
  valor_def VARCHAR DEFAULT '' NOT NULL,
  id_subsistema INTEGER NOT NULL,
  PRIMARY KEY(id_subsistema_var)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.tsubsistema_var.valor_def
IS 'Valor por defecto';


--------------- SQL ---------------

CREATE TABLE param.tdepto_var (
  id_depto_var SERIAL NOT NULL,
  id_subsistema_var INTEGER NOT NULL,
  id_depto INTEGER NOT NULL,
  valor VARCHAR DEFAULT '' NOT NULL,
  PRIMARY KEY(id_depto_var)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.tdepto_var.id_subsistema_var
IS 'identifica la variable';

COMMENT ON COLUMN param.tdepto_var.valor
IS 'el valor asignado a la variable';

/***********************************F-SCP-RAC-PARAM-0-22/11/2016*****************************************/


/***********************************I-SCP-RAC-PARAM-0-26/10/2016*****************************************/

--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN ruta_foto VARCHAR(300);

COMMENT ON COLUMN param.tconcepto_ingas.ruta_foto
IS 'opcionalmente se permite almacenar la ruta de la foto del concepto de ingeso o gasto';

--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ALTER COLUMN codigo TYPE VARCHAR(300) COLLATE pg_catalog."default";

ALTER TABLE param.tconcepto_ingas
  ADD UNIQUE (codigo);
/***********************************F-SCP-RAC-PARAM-0-26/10/2016*****************************************/

/***********************************I-SCP-FFP-PARAM-0-05/12/2016*****************************************/


CREATE TABLE param.ttipo_archivo (
  id_tipo_archivo SERIAL,
  nombre_id VARCHAR(255) NOT NULL ,
  tipo_archivo VARCHAR(255) NOT NULL ,
  tabla VARCHAR(255) NOT NULL ,
  codigo VARCHAR(255) NOT NULL ,
  nombre VARCHAR(255) NOT NULL ,
  multiple VARCHAR(255) ,
  PRIMARY KEY(id_tipo_archivo)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE param.tarchivo (
  id_archivo SERIAL,
  id_tipo_archivo INTEGER NOT NULL ,
  id_tabla INTEGER NOT NULL ,
  extension VARCHAR(255) NOT NULL ,
  nombre_archivo VARCHAR(255) NOT NULL ,
  folder VARCHAR(255),
  PRIMARY KEY(id_archivo)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE param.tarchivo_historico (
  id_archivo_historico SERIAL,
  id_tabla INTEGER NOT NULL ,
  id_archivo VARCHAR(255) NOT NULL ,
  version INTEGER NOT NULL ,
  PRIMARY KEY(id_archivo_historico)
) INHERITS (pxp.tbase)
WITH (oids = false);


ALTER TABLE param.tarchivo ADD id_archivo_fk INTEGER NULL;

/***********************************F-SCP-FFP-PARAM-0-05/12/2016*****************************************/

/***********************************I-SCP-GSS-PARAM-0-15/12/2016*****************************************/

CREATE TABLE param.tplantilla_archivo_excel (
  id_plantilla_archivo_excel SERIAL,
  nombre VARCHAR(20) NOT NULL,
  codigo VARCHAR(10) NOT NULL,
  PRIMARY KEY(id_plantilla_archivo_excel)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.tplantilla_archivo_excel.nombre
IS 'campo que guarda el nombre de la plantilla del archivo excel';

COMMENT ON COLUMN param.tplantilla_archivo_excel.codigo
IS 'campo que guarda el codigo asignado a la plantilla del archivo excel';

CREATE TABLE param.tcolumnas_archivo_excel (
  id_columna_archivo_excel SERIAL,
  id_plantilla_archivo_excel INTEGER NOT NULL,
  nombre_columna VARCHAR(20),
  numero_columna INTEGER,
  tipo_valor VARCHAR(10),
  sw_legible VARCHAR(2),
  PRIMARY KEY(id_columna_archivo_excel)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.tcolumnas_archivo_excel.nombre_columna
IS 'campo que indica el nombre de la columna';

COMMENT ON COLUMN param.tcolumnas_archivo_excel.numero_columna
IS 'campo que indica el numero de columna';

COMMENT ON COLUMN param.tcolumnas_archivo_excel.tipo_valor
IS 'campo que indica de que tipo debera ser el valor de la columna';

COMMENT ON COLUMN param.tcolumnas_archivo_excel.sw_legible
IS 'campo que indica si la columna sera leida o no sera leida';

/***********************************F-SCP-GSS-PARAM-0-15/12/2016*****************************************/

/***********************************I-SCP-GSS-PARAM-0-20/12/2016*****************************************/

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN hoja_excel VARCHAR(40);

COMMENT ON COLUMN param.tplantilla_archivo_excel.hoja_excel
IS 'nombre de la hoja a ser leida';

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN fila_inicio INTEGER;

COMMENT ON COLUMN param.tplantilla_archivo_excel.fila_inicio
IS 'fila de inicio desde la cual se leera el archivo';

ALTER TABLE param.tcolumnas_archivo_excel
  ADD COLUMN formato_fecha VARCHAR(10);

COMMENT ON COLUMN param.tcolumnas_archivo_excel.formato_fecha
IS 'campo que indica el formato de la fecha en el archivo';

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN fila_fin INTEGER;

COMMENT ON COLUMN param.tplantilla_archivo_excel.fila_fin
IS 'fila final hasta donde se leeran las filas';

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN filas_excluidas TEXT;

COMMENT ON COLUMN param.tplantilla_archivo_excel.filas_excluidas
IS 'filas que seran excluidas de la lectura';

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN tipo_archivo VARCHAR(10);

ALTER TABLE param.tplantilla_archivo_excel
  ADD COLUMN delimitador VARCHAR(5);

ALTER TABLE param.tcolumnas_archivo_excel
  ADD COLUMN anio_fecha INTEGER;

ALTER TABLE param.tcolumnas_archivo_excel
  ADD COLUMN nombre_columna_tabla VARCHAR(20);

/***********************************F-SCP-GSS-PARAM-0-20/12/2016*****************************************/

/***********************************I-SCP-GSS-PARAM-0-03/02/2017*****************************************/

ALTER TABLE param.tplantilla
  ADD COLUMN sw_estacion VARCHAR(3) DEFAULT 'no' NOT NULL;

ALTER TABLE param.tplantilla
  ADD COLUMN sw_punto_venta VARCHAR(3) DEFAULT 'no' NOT NULL;

ALTER TABLE param.tplantilla
  ADD COLUMN sw_cod_no_iata VARCHAR(3) DEFAULT 'no' NOT NULL;

/***********************************F-SCP-GSS-PARAM-0-03/02/2017*****************************************/


/***********************************I-SCP-FFP-PARAM-0-26/02/2017*****************************************/

--------------- SQL ---------------
CREATE TABLE param.tconf_lector_mobile(
  id_conf_lector_mobile SERIAL,
  nombre VARCHAR(255),
  estado VARCHAR(255),

  CONSTRAINT pk_tconf_lector_mobile__id_conf_lector_mobile PRIMARY KEY(id_conf_lector_mobile)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE param.tconf_lector_mobile_detalle(
  id_conf_lector_mobile_detalle SERIAL,
  control VARCHAR(255),
  nombre VARCHAR(255),
  descripcion VARCHAR(255),
  activity VARCHAR(255),
  id_conf_lector_mobile INTEGER,

  CONSTRAINT pk_tconf_lector_mobile_detalle__id_conf_lector_mobile_detalle PRIMARY KEY(id_conf_lector_mobile_detalle)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-FFP-PARAM-0-26/02/2017*****************************************/


/***********************************I-SCP-FFP-PARAM-0-08/05/2017*****************************************/

ALTER TABLE param.ttipo_archivo ADD extensiones_permitidas VARCHAR(255) NULL;
ALTER TABLE param.tarchivo ADD nombre_descriptivo VARCHAR NULL;

/***********************************F-SCP-RAC-PARAM-0-08/05/2017*****************************************/


/***********************************I-SCP-FFP-PARAM-0-11/05/2017*****************************************/

ALTER TABLE param.ttipo_archivo ADD ruta_guardar VARCHAR(255) NULL;
ALTER TABLE param.ttipo_archivo ALTER COLUMN ruta_guardar SET DEFAULT '';

/***********************************F-SCP-FFP-PARAM-0-11/05/2017*****************************************/



/***********************************I-SCP-RAC-PARAM-0-26/05/2017*****************************************/


--------------- SQL ---------------

CREATE TABLE param.ttipo_cc (
  id_tipo_cc SERIAL NOT NULL,
  codigo VARCHAR NOT NULL UNIQUE,
  descripcion VARCHAR,
  movimiento VARCHAR(6) DEFAULT 'no' NOT NULL,
  tipo VARCHAR(100) DEFAULT 'centro' NOT NULL,
  mov_pres VARCHAR(50) [] NOT NULL,
  control_partida VARCHAR(5) DEFAULT 'si' NOT NULL,
  control_techo VARCHAR(4) DEFAULT 'no' NOT NULL,
  momento_pres VARCHAR(50) [] NOT NULL,
  id_ep INTEGER,
  id_tipo_cc_fk INTEGER,
  PRIMARY KEY(id_tipo_cc)
) INHERITS (pxp.tbase)

WITH (oids = false);

COMMENT ON COLUMN param.ttipo_cc.movimiento
IS 'su o no, los tipo de presupeusto son los nodos hojas, estos nodos se transforman en centro de costo';

COMMENT ON COLUMN param.ttipo_cc.tipo
IS 'centro, proyecto, orden, son clasificadores del centro de costo';

COMMENT ON COLUMN param.ttipo_cc.mov_pres
IS 'ingreso , egreso, define que movimeintos puede realizar este centro de costo';

COMMENT ON COLUMN param.ttipo_cc.control_partida
IS 'si o no, se aplica a los nodos de contrl presupeustario, indica si controla partida entonces  verifica el techo por partida';

COMMENT ON COLUMN param.ttipo_cc.control_techo
IS 'indique en que nivel se queire la verificacion presupeustaria';

COMMENT ON COLUMN param.ttipo_cc.momento_pres
IS 'que momentos presupeustarios se condideran en este nodo, comprometido, ejecutado, pagado';

COMMENT ON COLUMN param.ttipo_cc.id_ep
IS 'identifica la estructura programatica, van prevalecer las que estan en nodo de movimiento';



--------------- SQL ---------------

ALTER TABLE param.ttipo_cc
  ADD COLUMN fecha_inicio DATE NOT NULL;


--------------- SQL ---------------

ALTER TABLE param.ttipo_cc
  ADD COLUMN fecha_final DATE;

COMMENT ON COLUMN param.ttipo_cc.fecha_final
IS 'fehca de finalizacion solo es util en nodos de movimeinto';


--------------- SQL ---------------

ALTER TABLE param.ttipo_cc
  ALTER COLUMN fecha_inicio DROP NOT NULL;



/***********************************F-SCP-RAC-PARAM-0-26/05/2017*****************************************/



/***********************************I-SCP-RAC-PARAM-0-30/05/2017*****************************************/
--------------- SQL ---------------

ALTER TABLE param.tcentro_costo
  ADD COLUMN id_tipo_cc INTEGER;

COMMENT ON COLUMN param.tcentro_costo.id_tipo_cc
IS 'el tipo centro de costo propociona una estructura tipo arbol para la contabilidad analitica, un tipo_cc hoja  puede tener un centros de costo en diferetnes gestion, la EP quedara simplemente como un metodo de asignacionde permisos';


/***********************************F-SCP-RAC-PARAM-0-30/05/2017*****************************************/




/***********************************I-SCP-FFP-PARAM-0-29/05/2017*****************************************/

ALTER TABLE param.ttipo_archivo ADD tamano NUMERIC(10) NULL;

/***********************************F-SCP-FFP-PARAM-0-29/05/2017*****************************************/


/***********************************I-SCP-FFP-PARAM-0-16/06/2017*****************************************/

CREATE TABLE param.twsmensaje (
  id_wsmensaje SERIAL,
  id_usuario INTEGER,
  tipo VARCHAR(255),
  titulo VARCHAR(255),
  mensaje text,
  CONSTRAINT twsmensaje_pkey PRIMARY KEY(id_wsmensaje)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-FFP-PARAM-0-16/06/2017*****************************************/


/***********************************I-SCP-RCM-PARAM-0-08/06/2017*****************************************/
ALTER TABLE param.tcatalogo
  ALTER COLUMN orden TYPE INTEGER;
/***********************************F-SCP-RCM-PARAM-0-08/06/2017*****************************************/

/***********************************I-SCP-RCM-PARAM-0-09/07/2017*****************************************/
ALTER TABLE param.ttipo_archivo
  ADD UNIQUE (codigo); 
/***********************************F-SCP-RCM-PARAM-0-09/07/2017*****************************************/


/***********************************I-SCP-RAC-PARAM-0-11/07/2017*****************************************/

--------------- SQL ---------------

ALTER TABLE param.tmoneda
  ADD COLUMN actualizacion VARCHAR(4) DEFAULT 'no' NOT NULL;

COMMENT ON COLUMN param.tmoneda.actualizacion
IS 'moneda de actualizacion'; 


/***********************************F-SCP-RAC-PARAM-0-11/07/2017*****************************************/


/***********************************I-SCP-FFP-PARAM-0-11/07/2017*****************************************/

--------------- SQL ---------------

ALTER TABLE param.talarma ADD estado_notificacion VARCHAR(255) NULL;




/***********************************F-SCP-FFP-PARAM-0-11/07/2017*****************************************/




/***********************************I-SCP-RAC-PARAM-0-21/07/2017*****************************************/


--------------- SQL ---------------

CREATE SEQUENCE param.seq_codigo_proveedor
  INCREMENT 1 START 1;


/***********************************F-SCP-RAC-PARAM-0-21/07/2017*****************************************/



/***********************************I-SCP-FFP-PARAM-0-08/08/2017*****************************************/


--------------- SQL ---------------
CREATE TABLE param.ttipo_archivo_campo (
  id_tipo_archivo_campo SERIAL,
  nombre varchar(255),
  tipo_dato varchar(255),
  alias varchar(255),
  renombrar varchar(255),
  id_tipo_archivo INTEGER,
  CONSTRAINT ttipo_archivo_campo_pkey PRIMARY KEY(id_tipo_archivo_campo)
) INHERITS (pxp.tbase);


CREATE TABLE param.ttipo_archivo_join (
  id_tipo_archivo_join SERIAL,
  tipo varchar(255),
  tabla varchar(255),
  condicion varchar(255),
  id_tipo_archivo INTEGER,
  CONSTRAINT ttipo_archivo_join_pkey PRIMARY KEY(id_tipo_archivo_join)
) INHERITS (pxp.tbase);

ALTER TABLE param.ttipo_archivo_join ADD alias VARCHAR(255) NULL;

/***********************************F-SCP-FFP-PARAM-0-08/08/2017*****************************************/



/***********************************I-SCP-RAC-PARAM-0-02/09/2017*****************************************/

--------------- SQL ---------------

ALTER TABLE param.tperiodo
  ADD COLUMN codigo_siga VARCHAR;

COMMENT ON COLUMN param.tperiodo.codigo_siga
IS 'codigo id del periodo en sistema SIGA';



/***********************************F-SCP-RAC-PARAM-0-02/09/2017*****************************************/


/***********************************I-SCP-RAC-PARAM-0-05/09/2017*****************************************/


--------------- SQL ---------------

ALTER TABLE param.tproveedor
  ADD COLUMN estado VARCHAR;
  
--------------- SQL ---------------

ALTER TABLE param.tproveedor
  ADD COLUMN id_proceso_wf INTEGER;
  
--------------- SQL ---------------

ALTER TABLE param.tproveedor
  ADD COLUMN id_estado_wf INTEGER;
  
--------------- SQL ---------------

ALTER TABLE param.tproveedor
  ADD COLUMN nro_tramite VARCHAR;
  
    
/***********************************F-SCP-RAC-PARAM-0-05/09/2017*****************************************/
     


/***********************************I-SCP-RAC-PARAM-3-06/09/2017*****************************************/
ALTER TABLE param.tproveedor
  ALTER COLUMN estado SET DEFAULT 'borrador';

ALTER TABLE param.tproveedor
ALTER COLUMN estado SET NOT NULL;
  
ALTER TABLE param.tproveedor
  ADD COLUMN id_auxiliar INTEGER;

COMMENT ON COLUMN param.tproveedor.id_auxiliar
IS 'idenfica el auxilar contable que le correponde al proveedor, automaticamente al crear proveedores creamos auxiliares contables';
  
  
  
/***********************************F-SCP-RAC-PARAM-3-06/09/2017*****************************************/
     
  

/***********************************I-SCP-RAC-PARAM-0-04/09/2017*****************************************/

CREATE TABLE param.tcat_concepto (
  id_cat_concepto SERIAL,
  codigo VARCHAR,
  nombre VARCHAR,
  habilitado VARCHAR,
  CONSTRAINT tcat_concepto_pkey PRIMARY KEY(id_cat_concepto)
) INHERITS (pxp.tbase)

WITH (oids = false);

ALTER TABLE param.tcat_concepto
  ALTER COLUMN codigo SET STATISTICS 0;
  
--------------- SQL ---------------

ALTER TABLE param.tconcepto_ingas
  ADD COLUMN id_cat_concepto INTEGER;

/***********************************F-SCP-RAC-PARAM-0-04/09/2017*****************************************/




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
    codigo varchar(25) NOT NULL,
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
  ALTER COLUMN moneda  VARCHAR(300) COLLATE pg_catalog."default";
  
<<<<<<< HEAD
  ALTER TABLE param.tempresa
  ADD COLUMN codigo  VARCHAR(100) COLLATE pg_catalog."default";
=======
ALTER TABLE param.tempresa
  ADD COLUMN codigo VARCHAR(100) COLLATE pg_catalog."default";
>>>>>>> 1ad59aeb3af57bbe83575201ff3d29401e79001c
  
/***********************************F-SCP-RAC-PARAM-0-04/02/2013*****************************************/


/***********************************I-SCP-RAC-PARAM-0-21/02/2013*****************************************/

CREATE VIEW param.vep(
    id_ep,
    estado_reg,
    id_financiador,
    id_prog_pory_acti,
    id_regional,
    sw_presto,
    fecha_reg,
    id_usuario_reg,
    fecha_mod,
    id_usuario_mod,
    usr_reg,
    usr_mod,
    codigo_programa,
    codigo_proyecto,
    codigo_actividad,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    codigo_financiador,
    codigo_regional,
    nombre_financiador,
    nombre_regional,
    ep,
    desc_ppa)
AS
  SELECT frpp.id_ep,
         frpp.estado_reg,
         frpp.id_financiador,
         frpp.id_prog_pory_acti,
         frpp.id_regional,
         frpp.sw_presto,
         frpp.fecha_reg,
         frpp.id_usuario_reg,
         frpp.fecha_mod,
         frpp.id_usuario_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         prog.codigo_programa,
         proy.codigo_proyecto,
         act.codigo_actividad,
         prog.nombre_programa,
         proy.nombre_proyecto,
         act.nombre_actividad,
         fin.codigo_financiador,
         reg.codigo_regional,
         fin.nombre_financiador,
         reg.nombre_regional,
         (((((((fin.codigo_financiador::text || '-' ::text) ||
          reg.codigo_regional::text) || '-' ::text) ||
           prog.codigo_programa::text) || '-' ::text) ||
            proy.codigo_proyecto::text) || '-' ::text) ||
             act.codigo_actividad::text AS ep,
          prog.codigo_programa||'-'||	proy.codigo_proyecto||'-'||act.codigo_actividad as desc_ppa
  FROM param.tep frpp
       JOIN segu.tusuario usu1 ON usu1.id_usuario = frpp.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = frpp.id_usuario_mod
       JOIN param.tprograma_proyecto_acttividad ppa ON ppa.id_prog_pory_acti =
        frpp.id_prog_pory_acti
       JOIN param.tprograma prog ON prog.id_programa = ppa.id_programa
       JOIN param.tproyecto proy ON proy.id_proyecto = ppa.id_proyecto
       JOIN param.tactividad act ON act.id_actividad = ppa.id_actividad
       JOIN param.tregional reg ON reg.id_regional = frpp.id_regional
       JOIN param.tfinanciador fin ON fin.id_financiador = frpp.id_financiador;
 
 
--------------- SQL ---------------

ALTER TABLE param.taprobador
  ADD COLUMN id_ep INTEGER;
  
       
/***********************************F-SCP-RAC-PARAM-0-21/02/2013*****************************************/




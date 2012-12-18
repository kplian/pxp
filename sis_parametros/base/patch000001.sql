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
    moneda varchar(30),
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
-- Definition for view vproveedor (OID = 306454) : 
--
CREATE VIEW param.vproveedor AS
SELECT provee.id_proveedor, provee.id_persona, provee.codigo,
    provee.numero_sigma, provee.tipo, provee.id_institucion,
    pxp.f_iif((provee.id_persona IS NOT NULL),
    (person.nombre_completo1)::character varying, ((((instit.codigo)::text
    || '-'::text) || (instit.nombre)::text))::character varying) AS
    desc_proveedor, provee.nit
FROM ((param.tproveedor provee LEFT JOIN segu.vpersona person ON
    ((person.id_persona = provee.id_persona))) LEFT JOIN param.tinstitucion
    instit ON ((instit.id_institucion = provee.id_institucion)))
WHERE ((provee.estado_reg)::text = 'activo'::text);
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
-- Definition for index tinstitucion_idx (OID = 308254) : 
--
CREATE UNIQUE INDEX tinstitucion_idx ON param.tinstitucion USING btree (doc_id, estado_reg);
--
-- Definition for index tperiodo__gestion_per_estado__idx (OID = 308255) : 
--
CREATE UNIQUE INDEX tperiodo__gestion_per_estado__idx ON param.tperiodo USING btree (estado_reg, periodo, id_gestion);
--
-- Definition for index pk_pm_id_financiador (OID = 307978) : 
--
ALTER TABLE ONLY param.tpm_financiador
    ADD CONSTRAINT pk_pm_id_financiador
    PRIMARY KEY (id_financiador);
--
-- Definition for index pk_pm_id_programa (OID = 307980) : 
--
ALTER TABLE ONLY param.tpm_programa
    ADD CONSTRAINT pk_pm_id_programa
    PRIMARY KEY (id_programa);
--
-- Definition for index pk_pm_id_proyecto (OID = 307982) : 
--
ALTER TABLE ONLY param.tpm_proyecto
    ADD CONSTRAINT pk_pm_id_proyecto
    PRIMARY KEY (id_proyecto);
--
-- Definition for index pk_pm_id_regional (OID = 307984) : 
--
ALTER TABLE ONLY param.tpm_regional
    ADD CONSTRAINT pk_pm_id_regional
    PRIMARY KEY (id_regional);
--
-- Definition for index talarma_pkey (OID = 307988) : 
--
ALTER TABLE ONLY param.talarma
    ADD CONSTRAINT talarma_pkey
    PRIMARY KEY (id_alarma);
--
-- Definition for index tcorrelativo_pkey (OID = 307990) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT tcorrelativo_pkey
    PRIMARY KEY (id_correlativo);
--
-- Definition for index tdocumento_pkey (OID = 307996) : 
--
ALTER TABLE ONLY param.tdocumento
    ADD CONSTRAINT tdocumento_pkey
    PRIMARY KEY (id_documento);
--
-- Definition for index tgestion_pkey (OID = 307998) : 
--
ALTER TABLE ONLY param.tgestion
    ADD CONSTRAINT tgestion_pkey
    PRIMARY KEY (id_gestion);
--
-- Definition for index tinstitucion_codigo_key (OID = 308000) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_codigo_key
    UNIQUE (codigo);
--
-- Definition for index tinstitucion_pkey (OID = 308002) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_pkey
    PRIMARY KEY (id_institucion);
--
-- Definition for index tlugas_pkey (OID = 308004) : 
--
ALTER TABLE ONLY param.tlugar
    ADD CONSTRAINT tlugas_pkey
    PRIMARY KEY (id_lugar);
--
-- Definition for index tmoneda_pkey (OID = 308006) : 
--
ALTER TABLE ONLY param.tmoneda
    ADD CONSTRAINT tmoneda_pkey
    PRIMARY KEY (id_moneda);
--
-- Definition for index tperiodo_pkey (OID = 308008) : 
--
ALTER TABLE ONLY param.tperiodo
    ADD CONSTRAINT tperiodo_pkey
    PRIMARY KEY (id_periodo);
--
-- Definition for index tpm_financiador_codigo_financiador_key (OID = 308010) : 
--
ALTER TABLE ONLY param.tpm_financiador
    ADD CONSTRAINT tpm_financiador_codigo_financiador_key
    UNIQUE (codigo_financiador);
--
-- Definition for index tpm_programa_codigo_programa_key (OID = 308012) : 
--
ALTER TABLE ONLY param.tpm_programa
    ADD CONSTRAINT tpm_programa_codigo_programa_key
    UNIQUE (codigo_programa);
--
-- Definition for index tpm_proyecto_codigo_proyecto_key (OID = 308014) : 
--
ALTER TABLE ONLY param.tpm_proyecto
    ADD CONSTRAINT tpm_proyecto_codigo_proyecto_key
    UNIQUE (codigo_proyecto);
--
-- Definition for index tpm_regional_codigo_regional_key (OID = 308016) : 
--
ALTER TABLE ONLY param.tpm_regional
    ADD CONSTRAINT tpm_regional_codigo_regional_key
    UNIQUE (codigo_regional);
--
-- Definition for index tproveedor_idx (OID = 308018) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_idx
    UNIQUE (id_institucion, tipo, estado_reg);
--
-- Definition for index tproveedor_idx1 (OID = 308020) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_idx1
    UNIQUE (id_persona, tipo, estado_reg);
--
-- Definition for index tproveedor_pkey (OID = 308022) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_pkey
    PRIMARY KEY (id_proveedor);
--
-- Definition for index fk_tconfig_alarma__id_subsistema (OID = 308833) : 
--
ALTER TABLE ONLY param.tconfig_alarma
    ADD CONSTRAINT fk_tconfig_alarma__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);

--
-- Definition for index fk_tcorrelativo__id_documento (OID = 308843) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_documento
    FOREIGN KEY (id_documento) REFERENCES param.tdocumento(id_documento);
--
-- Definition for index fk_tcorrelativo__id_gestion (OID = 308848) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_gestion
    FOREIGN KEY (id_gestion) REFERENCES param.tgestion(id_gestion);
--
-- Definition for index fk_tcorrelativo__id_periodo (OID = 308853) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_periodo
    FOREIGN KEY (id_periodo) REFERENCES param.tperiodo(id_periodo);


--
-- Definition for index fk_tcorrelativo__id_usuario_mod (OID = 308863) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_usuario_mod
    FOREIGN KEY (id_usuario_mod) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tcorrelativo__id_usuario_reg (OID = 308868) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_usuario_reg
    FOREIGN KEY (id_usuario_reg) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tdocumento__id_subsistema (OID = 308878) : 
--
ALTER TABLE ONLY param.tdocumento
    ADD CONSTRAINT fk_tdocumento__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
--
-- Definition for index fk_tproveedor__id_institucion (OID = 308898) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT fk_tproveedor__id_institucion
    FOREIGN KEY (id_institucion) REFERENCES param.tinstitucion(id_institucion);
--
-- Definition for index fk_tproveedor__id_persona (OID = 308903) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT fk_tproveedor__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index tinstitucion_fk (OID = 308918) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_fk
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index tlugar_fk (OID = 308923) : 
--
ALTER TABLE ONLY param.tlugar
    ADD CONSTRAINT tlugar_fk
    FOREIGN KEY (id_lugar_fk) REFERENCES param.tlugar(id_lugar);
--
-- Definition for index tperiodo_fk (OID = 308928) : 
--
ALTER TABLE ONLY param.tperiodo
    ADD CONSTRAINT tperiodo_fk
    FOREIGN KEY (id_gestion) REFERENCES param.tgestion(id_gestion);
--
-- Definition for index tunidad_medida_pkey (OID = 309535) : 
--
ALTER TABLE ONLY param.tunidad_medida
    ADD CONSTRAINT tunidad_medida_pkey
    PRIMARY KEY (id_unidad_medida);
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
	CONSTRAINT fk_tcatalogo_tipo__id_subsistema FOREIGN KEY (id_subsistema)
    	REFERENCES segu.tsubsistema (id_subsistema) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT uq_tcatalogo_tipo__id_subsistema__nombre UNIQUE (id_subsistema, nombre)
)INHERITS (pxp.tbase)
WITH (
  OIDS=TRUE
);

alter table param.tcatalogo add column id_catalogo_tipo integer;
alter table param.tcatalogo 
  add constraint fk_tcatalogo__id_catalogo_tipo foreign key (id_catalogo_tipo)
  references param.tcatalogo_tipo(id_catalogo_tipo);
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



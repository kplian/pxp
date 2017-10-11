/********************************************I-SCP-JRR-ORGA-1-19/11/2012********************************************/
--
-- Structure for table tdepto (OID = 306303) : 
--
CREATE TABLE orga.tdepto (
    id_depto serial NOT NULL,
    nombre varchar(200),
    nombre_corto varchar(100),
    id_subsistema integer,
    codigo varchar(15)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tusuario_uo (OID = 306433) : 
--
CREATE TABLE orga.tusuario_uo (
    id_usuario_uo serial NOT NULL,
    id_usuario integer,
    id_uo integer
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table testructura_uo (OID = 306562) : 
--
CREATE TABLE orga.testructura_uo (
    id_estructura_uo serial NOT NULL,
    id_uo_padre integer,
    id_uo_hijo integer
)
INHERITS (pxp.tbase) WITH OIDS;

--
-- Structure for table tfuncionario (OID = 306570) : 
--
CREATE TABLE orga.tfuncionario (
	id_funcionario serial NOT NULL,
    id_persona integer NOT NULL,
    codigo varchar(20),
    email_empresa varchar(150),
    interno varchar(9),
    fecha_ingreso date DEFAULT now() NOT NULL
) 
INHERITS (pxp.tbase) WITH OIDS;

--
-- Structure for table tnivel_organizacional (OID = 306592) : 
--
CREATE TABLE orga.tnivel_organizacional (
    id_nivel_organizacional serial NOT NULL,
    nombre_nivel varchar(50) NOT NULL,
    numero_nivel integer NOT NULL
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tuo (OID = 306669) : 
--
CREATE TABLE orga.tuo (
    id_uo serial NOT NULL,
    nombre_unidad varchar(100),
    nombre_cargo varchar(150),
    cargo_individual varchar(2),
    descripcion varchar(100),
    presupuesta varchar(2),
    codigo varchar(15),
    nodo_base varchar(2) DEFAULT 'no'::character varying NOT NULL,
    gerencia varchar(2),
    correspondencia varchar(2)
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table tuo_funcionario (OID = 306676) : 
--
CREATE TABLE orga.tuo_funcionario (
    estado_reg varchar(10) NOT NULL,
    id_uo_funcionario serial NOT NULL,
    id_uo integer,
    id_funcionario integer,
    fecha_asignacion date,
    fecha_finalizacion date
)
INHERITS (pxp.tbase) WITH OIDS;
ALTER TABLE ONLY orga.tuo_funcionario ALTER COLUMN id_uo SET STATISTICS 0;



--
-- Structure for table tdepto_usuario (OID = 429265) : 
--
CREATE TABLE orga.tdepto_usuario (
    id_depto_usuario serial NOT NULL,
    id_depto integer,
    id_usuario integer,
    cargo varchar(300)
)
INHERITS (pxp.tbase) WITH OIDS;
--
-- Definition for index tdepto_pkey (OID = 307992) : 
--
ALTER TABLE ONLY orga.tdepto
    ADD CONSTRAINT tdepto_pkey
    PRIMARY KEY (id_depto);
--
-- Definition for index tusuario_uo_pkey (OID = 308024) : 
--
ALTER TABLE ONLY orga.tusuario_uo
    ADD CONSTRAINT tusuario_uo_pkey
    PRIMARY KEY (id_usuario_uo);
--
-- Definition for index testructura_uo_pkey (OID = 308036) : 
--
ALTER TABLE ONLY orga.testructura_uo
    ADD CONSTRAINT testructura_uo_pkey
    PRIMARY KEY (id_estructura_uo);
--
-- Definition for index tfuncionario_id_persona_key (OID = 308040) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT tfuncionario_id_persona_key
    UNIQUE (id_persona);
--
-- Definition for index tfuncionario_pkey (OID = 308042) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT tfuncionario_pkey
    PRIMARY KEY (id_funcionario);
--
-- Definition for index tnivel_organizacional_numero_nivel_key (OID = 308046) : 
--
ALTER TABLE ONLY orga.tnivel_organizacional
    ADD CONSTRAINT tnivel_organizacional_numero_nivel_key
    UNIQUE (numero_nivel);
--
-- Definition for index tnivel_organizacional_pk_kp_id_nivel_organizacional (OID = 308048) : 
--
ALTER TABLE ONLY orga.tnivel_organizacional
    ADD CONSTRAINT tnivel_organizacional_pk_kp_id_nivel_organizacional
    PRIMARY KEY (id_nivel_organizacional);
--
-- Definition for index tuo_funcionario_pkey (OID = 308064) : 
--
ALTER TABLE ONLY orga.tuo_funcionario
    ADD CONSTRAINT tuo_funcionario_pkey
    PRIMARY KEY (id_uo_funcionario);
--
-- Definition for index tuo_pkey (OID = 308066) : 
--
ALTER TABLE ONLY orga.tuo
    ADD CONSTRAINT tuo_pkey
    PRIMARY KEY (id_uo);

ALTER TABLE ONLY orga.tdepto_usuario
    ADD CONSTRAINT tdepto_usuario_tdepto_usuairo_pkey
    PRIMARY KEY (id_depto_usuario);
--
-- Comments
--
COMMENT ON COLUMN orga.tfuncionario.email_empresa IS 'correo corporativo  asignado por la empresa';
COMMENT ON COLUMN orga.tfuncionario.interno IS 'numero telefonico interno de la empresa';
COMMENT ON COLUMN orga.tuo.nodo_base IS 'Identifica la raiz del organigrama';
COMMENT ON COLUMN orga.tuo_funcionario.estado_reg IS 'activo :  relacion vigente
eliminado: relacion eliminada no se tiene que considerar 
finalizada: el funcionario se le cambiio el cargo, se tiene que considerar como historico 
finalizado:';

CREATE TABLE orga.ttipo_horario (
  id_tipo_horario SERIAL, 
  codigo VARCHAR(255), 
  nombre VARCHAR(255), 
  estado_reg VARCHAR(10), 
  id_usuario_reg INTEGER, 
  fecha_reg TIMESTAMP DEFAULT now() NOT NULL, 
  id_usuario_mod INTEGER, 
  fecha_mod TIMESTAMP DEFAULT now(), 
  CONSTRAINT ttipo_horario_pkey PRIMARY KEY(id_tipo_horario)
) INHERITS (pxp.tbase)
WITH OIDS;
 
CREATE TABLE orga.tespecialidad_nivel (
  id_especialidad_nivel SERIAL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(100) NOT NULL, 
  CONSTRAINT tespecialidad_nivel_pkey PRIMARY KEY(id_especialidad_nivel)
) INHERITS (pxp.tbase)
WITH OIDS;

CREATE TABLE orga.tespecialidad (
  id_especialidad serial NOT NULL,
  codigo character varying(20) NOT NULL,
  nombre character varying(150) NOT NULL,
  id_especialidad_nivel integer,
  CONSTRAINT tespecialidad_pkey PRIMARY KEY (id_especialidad)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE orga.tespecialidad OWNER TO postgres;
 
CREATE TABLE orga.tfuncionario_especialidad(
  id_funcionario_especialidad serial NOT NULL,
  id_funcionario integer NOT NULL,
  id_especialidad integer NOT NULL,
  CONSTRAINT tfuncionario_especialidad_pkey PRIMARY KEY (id_funcionario_especialidad),
  CONSTRAINT uq__id_funcionario_especialidad UNIQUE (id_funcionario, id_especialidad)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE orga.tfuncionario_especialidad OWNER TO postgres;

/********************************************F-SCP-JRR-ORGA-1-19/11/2012********************************************/

/********************************************I-SCP-RCM-ORGA-92-27/12/2012********************************************/
alter table orga.tfuncionario
drop constraint tfuncionario_id_persona_key;
/********************************************F-SCP-RCM-ORGA-92-27/12/2012********************************************/

/********************************************I-SCP-RCM-ORGA-112-06/02/2013********************************************/
alter table orga.tfuncionario
add column telefono_ofi varchar(50);
/********************************************F-SCP-RCM-ORGA-112-06/02/2013********************************************/

/*****************************I-SCP-RAC-ORGA-0-11/03/2013*************/
--cada persona puede tener un solo funcionario
ALTER TABLE orga.tfuncionario 
  ADD UNIQUE (id_persona);
/*****************************F-SCP-RAC-ORGA-0-11/03/2013*************/

/*****************************I-SCP-JRR-ORGA-0-9/01/2014*************/
CREATE TABLE orga.tcategoria_salarial (
  id_categoria_salarial SERIAL NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  PRIMARY KEY(id_categoria_salarial)
) INHERITS (pxp.tbase)
WITHOUT OIDS;


CREATE TABLE orga.tescala_salarial (
  id_escala_salarial SERIAL NOT NULL, 
  id_categoria_salarial INTEGER NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  haber_basico NUMERIC(9,2) NOT NULL, 
  fecha_ini DATE NOT NULL, 
  fecha_fin DATE, 
  PRIMARY KEY(id_escala_salarial)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.tipo_contrato (
  id_tipo_contrato SERIAL NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  PRIMARY KEY(id_tipo_contrato)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.tcargo (
  id_cargo SERIAL NOT NULL, 
  id_uo	INTEGER NOT NULL,
  id_tipo_contrato INTEGER NOT NULL, 
  id_escala_salarial INTEGER NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  PRIMARY KEY(id_cargo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.tcargo_presupuesto (
  id_cargo_presupuesto SERIAL NOT NULL, 
  id_centro_costo INTEGER NOT NULL, 
  id_cargo INTEGER NOT NULL,
  porcentaje NUMERIC(5,2) NOT NULL, 
  fecha_ini DATE NOT NULL, 
  id_gestion INTEGER NOT NULL,
  PRIMARY KEY(id_cargo_presupuesto)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.tcargo_centro_costo (
  id_cargo_centro_costo SERIAL NOT NULL, 
  id_centro_costo INTEGER NOT NULL, 
  id_cargo INTEGER NOT NULL,
  porcentaje NUMERIC(5,2) NOT NULL, 
  fecha_ini DATE NOT NULL, 
  id_gestion INTEGER NOT NULL,
  PRIMARY KEY(id_cargo_centro_costo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.ttemporal_cargo (
  id_temporal_cargo SERIAL NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  estado VARCHAR(20) NOT NULL, 
  id_temporal_jerarquia_aprobacion INTEGER NOT NULL, 
  PRIMARY KEY(id_temporal_cargo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.ttemporal_jerarquia_aprobacion (
  id_temporal_jerarquia_aprobacion SERIAL NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  numero INTEGER NOT NULL, 
  estado VARCHAR(20) NOT NULL, 
  PRIMARY KEY(id_temporal_jerarquia_aprobacion)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.toficina (
  id_oficina SERIAL NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  id_lugar INTEGER NOT NULL, 
  aeropuerto VARCHAR(2) NOT NULL, 
  PRIMARY KEY(id_oficina)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE orga.tuo_funcionario
  ADD COLUMN tipo VARCHAR(10);
  

ALTER TABLE orga.tuo_funcionario
  ADD CONSTRAINT tuo_funcionario__tipo_chk CHECK (tipo='funcional' or tipo = 'oficial');
  
ALTER TABLE orga.tuo_funcionario
  ADD COLUMN fecha_documento_asignacion DATE;

ALTER TABLE orga.tuo_funcionario
  ADD COLUMN nro_documento_asignacion VARCHAR(50);

ALTER TABLE orga.tuo_funcionario
  ADD COLUMN observaciones_finalizacion VARCHAR(50);
  
ALTER TABLE orga.tuo_funcionario
  ADD COLUMN id_cargo INTEGER;
  
ALTER TABLE orga.tescala_salarial
  ADD COLUMN aprobado VARCHAR(2) DEFAULT 'si' NOT NULL;

ALTER TABLE orga.tescala_salarial
  ADD COLUMN nro_casos INTEGER NOT NULL;
  
ALTER TABLE orga.tcargo
  ADD COLUMN nombre VARCHAR(200) NOT NULL;
  
ALTER TABLE orga.tcargo
  ADD COLUMN fecha_ini DATE NOT NULL;
  
ALTER TABLE orga.tcargo
  ADD COLUMN fecha_fin DATE;
  
ALTER TABLE orga.tcargo
  ADD COLUMN id_lugar INTEGER NOT NULL;
  
ALTER TABLE orga.tcargo
  ADD COLUMN id_temporal_cargo INTEGER NOT NULL;
  
ALTER TABLE orga.tescala_salarial
  ADD CONSTRAINT chk__tescala_salarial__aprobado CHECK (aprobado = 'si' or aprobado = 'no');
  
ALTER TABLE orga.tuo
  ADD COLUMN id_nivel_organizacional INTEGER;
  
ALTER TABLE orga.toficina
  ADD CONSTRAINT chk__toficina__aeropuerto CHECK (aeropuerto = 'si' or aeropuerto = 'no');
  
ALTER TABLE orga.tcargo
  ADD COLUMN id_oficina INTEGER NOT NULL;
  
ALTER TABLE orga.tfuncionario
  ADD COLUMN antiguedad_anterior INTEGER;
  
CREATE TABLE orga.tfuncionario_cuenta_bancaria (
  id_funcionario_cuenta_bancaria SERIAL, 
  id_funcionario INTEGER NOT NULL, 
  nro_cuenta VARCHAR NOT NULL, 
  id_institucion INTEGER NOT NULL, 
  fecha_ini DATE NOT NULL, 
  fecha_fin DATE, 
  CONSTRAINT tfuncionario_cuenta_bancaria_pkey PRIMARY KEY(id_funcionario_cuenta_bancaria) 
)INHERITS (pxp.tbase) WITH OIDS;

/*****************************F-SCP-JRR-ORGA-0-9/01/2014*************/

/*****************************I-SCP-JRR-ORGA-0-21/01/2014*************/
CREATE TABLE orga.ttipo_contrato (
  id_tipo_contrato SERIAL, 
  codigo VARCHAR NOT NULL, 
  nombre VARCHAR NOT NULL, 
  CONSTRAINT ttipo_contrato_pkey PRIMARY KEY(id_tipo_contrato) 
)INHERITS (pxp.tbase) WITH OIDS;
/*****************************F-SCP-JRR-ORGA-0-21/01/2014*************/

/*****************************I-SCP-JRR-ORGA-0-29/01/2014*************/
ALTER TABLE orga.toficina
  ADD COLUMN zona_franca VARCHAR(2);

ALTER TABLE orga.toficina
  ADD COLUMN frontera VARCHAR(2);
/*****************************F-SCP-JRR-ORGA-0-29/01/2014*************/

/*****************************I-SCP-JRR-ORGA-0-13/02/2014*************/
ALTER TABLE orga.tuo
  ADD COLUMN planilla VARCHAR(2);

ALTER TABLE orga.tuo
  ALTER COLUMN planilla SET DEFAULT 'no';
  
ALTER TABLE orga.tuo
  ADD COLUMN prioridad VARCHAR(30);

/*****************************F-SCP-JRR-ORGA-0-13/02/2014*************/


/*****************************I-SCP-RAC-ORGA-0-20/05/2014*************/


CREATE TABLE orga.tinterinato (
  id_interinato SERIAL, 
  id_cargo_titular INTEGER NOT NULL, 
  id_cargo_suplente INTEGER NOT NULL, 
  fecha_ini DATE NOT NULL, 
  fecha_fin DATE NOT NULL, 
  descripcion TEXT, 
  CONSTRAINT tinterinato_pkey PRIMARY KEY(id_interinato)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/*****************************F-SCP-RAC-ORGA-0-20/05/2014*************/


/*****************************I-SCP-RAC-ORGA-0-21/05/2014*************/

--------------- SQL ---------------
update orga.tuo_funcionario set
tipo = 'oficial';

ALTER TABLE orga.tuo_funcionario
  ALTER COLUMN tipo SET DEFAULT 'oficial';

ALTER TABLE orga.tuo_funcionario
  ALTER COLUMN tipo SET NOT NULL;


/*****************************F-SCP-RAC-ORGA-0-21/05/2014*************/



/*****************************I-SCP-JRR-ORGA-0-04/06/2014*************/
ALTER TABLE orga.tuo_funcionario
  ALTER COLUMN observaciones_finalizacion SET DEFAULT 'fin contrato';
/*****************************F-SCP-JRR-ORGA-0-04/06/2014*************/






/*****************************I-SCP-JRR-ORGA-0-31/07/2014*************/

CREATE TABLE orga.toficina_cuenta (
  id_oficina_cuenta SERIAL, 
  id_oficina INTEGER NOT NULL, 
  nro_cuenta VARCHAR (50) NOT NULL,
  nombre_cuenta VARCHAR (150) NOT NULL,
  tiene_medidor VARCHAR (2) NOT NULL,
  nro_medidor VARCHAR (150),
  descripcion TEXT, 
  CONSTRAINT toficina_cuenta_pkey PRIMARY KEY(id_oficina_cuenta)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/*****************************F-SCP-JRR-ORGA-0-31/07/2014*************/

/*****************************I-SCP-JRR-ORGA-0-01/08/2014*************/
CREATE TYPE wf.cuenta_form AS (  
  id_oficina_cuenta INTEGER,
  monto NUMERIC(18,2)
);

/*****************************F-SCP-JRR-ORGA-0-01/08/2014*************/

/*****************************I-SCP-JRR-ORGA-0-21/10/2014*************/
ALTER TABLE orga.tescala_salarial
  ADD COLUMN id_escala_padre INTEGER;

/*****************************F-SCP-JRR-ORGA-0-21/10/2014*************/

/*****************************I-SCP-JRR-ORGA-0-04/11/2014*************/
ALTER TABLE orga.tescala_salarial
  ALTER COLUMN fecha_ini DROP NOT NULL;
  
/*****************************F-SCP-JRR-ORGA-0-04/11/2014*************/


/*****************************I-SCP-JRR-ORGA-0-05/03/2015*************/
ALTER TABLE orga.ttemporal_cargo
  ADD COLUMN fecha_ini DATE;
  
ALTER TABLE orga.ttemporal_cargo
  ADD COLUMN fecha_fin DATE;
  
ALTER TABLE orga.ttemporal_cargo
  ADD COLUMN id_cargo_padre  INTEGER;
  
ALTER TABLE orga.tcargo
  ADD COLUMN id_cargo_padre  INTEGER;
  
/*****************************F-SCP-JRR-ORGA-0-05/03/2015*************/

/*****************************I-SCP-RAC-ORGA-0-05/03/2015*************/

CREATE TABLE orga.tuo_funcionario_ope (
  id_uo_funcionario_ope SERIAL,
  id_uo INTEGER,
  id_funcionario INTEGER,
  fecha_asignacion DATE,
  fecha_finalizacion DATE,
  CONSTRAINT tuo_funcionario_ope_pkey PRIMARY KEY(id_uo_funcionario_ope),
 
  CONSTRAINT fk_tuo_functionario__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
    NOT DEFERRABLE,
  CONSTRAINT fk_tuo_functionario__id_uo FOREIGN KEY (id_uo)
    REFERENCES orga.tuo(id_uo)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
    NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = true);

ALTER TABLE orga.tuo_funcionario
  ALTER COLUMN id_uo SET STATISTICS 0;
  
/*****************************F-SCP-RAC-ORGA-0-05/03/2015*************/

/*****************************I-SCP-JRR-ORGA-0-14/08/2015*************/
ALTER TABLE orga.tcargo
  ALTER COLUMN id_oficina DROP NOT NULL;

/*****************************F-SCP-JRR-ORGA-0-14/08/2015*************/

/*****************************I-SCP-JRR-ORGA-0-01/10/2015*************/

ALTER TABLE orga.tuo_funcionario
  ADD COLUMN certificacion_presupuestaria  VARCHAR;
  
/*****************************F-SCP-JRR-ORGA-0-01/10/2015*************/

/*****************************I-SCP-JRR-ORGA-0-01/02/2016*************/

ALTER TABLE orga.tcargo
  ALTER COLUMN id_temporal_cargo DROP NOT NULL;

/*****************************F-SCP-JRR-ORGA-0-01/02/2016*************/

/*****************************I-SCP-JRR-ORGA-0-13/05/2016*************/

ALTER TABLE orga.tfuncionario_especialidad
  ADD COLUMN fecha DATE;
  
ALTER TABLE orga.tfuncionario_especialidad
  ADD COLUMN numero_especialidad INTEGER;  

ALTER TABLE orga.tfuncionario_especialidad
  ADD COLUMN descripcion VARCHAR(200);  
/*****************************F-SCP-JRR-ORGA-0-13/05/2016*************/


/*****************************I-SCP-JRR-ORGA-0-19/05/2016*************/
ALTER TABLE orga.tfuncionario_especialidad
  ALTER COLUMN numero_especialidad TYPE VARCHAR(10);
  
/*****************************F-SCP-JRR-ORGA-0-19/05/2016*************/

/*****************************I-SCP-JRR-ORGA-0-13/09/2016*************/
CREATE SEQUENCE orga.rep_planilla_actualizada
  INCREMENT 1 START 1;

/*****************************F-SCP-JRR-ORGA-0-13/09/2016*************/


/*****************************I-SCP-RAC-ORGA-0-14/02/2017*************/


--------------- SQL ---------------

CREATE TABLE orga.tuo_tmp (
  nro INTEGER,
  codigo_padre VARCHAR,
  padre VARCHAR,
  codigo VARCHAR,
  unidad VARCHAR,
  estado VARCHAR DEFAULT 'activo' NOT NULL
) 
WITH (oids = false);

--------------- SQL ---------------

ALTER TABLE orga.tuo_tmp
  ADD COLUMN migrado VARCHAR(4) DEFAULT 'no' NOT NULL;
  
  
  --------------- SQL ---------------

ALTER TABLE orga.tuo
  ADD COLUMN codigo_alterno VARCHAR;

COMMENT ON COLUMN orga.tuo.codigo_alterno
IS 'este codigo se puede usar como llave de manera alterna al codigo de la UO';


--------------- SQL ---------------

CREATE TABLE orga.tcargo_tmp (
  codigo_uo VARCHAR,
  uo VARCHAR,
  item VARCHAR,
  cargo VARCHAR,
  migrado VARCHAR(1) DEFAULT 'no' NOT NULL,
  id_cargo INTEGER
) 
WITH (oids = false);

--------------- SQL ---------------

ALTER TABLE orga.tcargo_tmp
  ADD COLUMN individual VARCHAR;
  
  --------------- SQL ---------------

COMMENT ON COLUMN orga.tcargo_tmp.individual
IS 'si cargo individual se lo asgina a la gerencia, si no crea una uo que depende de la gerencia antes de asociar el cargo';

--------------- SQL ---------------

ALTER TABLE orga.tcargo_tmp
  ADD COLUMN contrato VARCHAR DEFAULT 'planta' NOT NULL;

COMMENT ON COLUMN orga.tcargo_tmp.contrato
IS 'planta, eventual';

--------------- SQL ---------------

ALTER TABLE orga.tcargo_tmp
  ADD COLUMN lugar VARCHAR DEFAULT 'BOLIVIA' NOT NULL;

COMMENT ON COLUMN orga.tcargo_tmp.lugar
IS 'lugar donde desarrolla funciones';


--------------- SQL ---------------

CREATE TABLE orga.tescala_salarial_tmp (
  codigo VARCHAR,
  nombre VARCHAR,
  id_escala_salarial INTEGER,
  migrado VARCHAR DEFAULT 'no'::character varying NOT NULL,
  monto NUMERIC
) 
WITH (oids = false);



--------------- SQL ---------------
CREATE TABLE orga.tfuncionario_tmp (
  nombre VARCHAR,
  nombre2 VARCHAR,
  paterno VARCHAR,
  materno VARCHAR,
  item VARCHAR,
  fecha_nac DATE,
  nua VARCHAR,
  ci VARCHAR,
  exp VARCHAR,
  domicilio VARCHAR,
  telefono VARCHAR,
  celular VARCHAR,
  sangre VARCHAR,
  sexo VARCHAR,
  estado_civil VARCHAR,
  profesion VARCHAR,
  cd_cargo VARCHAR,
  fecha_ingreso DATE,
  estado VARCHAR,
  codigo_escala VARCHAR,
  nombre_escala VARCHAR,
  lugar_pago VARCHAR,
  forma_pago VARCHAR,
  cuenta_banco VARCHAR,
  aporte_cacsel VARCHAR,
  afp VARCHAR,
  nacionalidad VARCHAR,
  correo_empresa VARCHAR,
  sindicato VARCHAR,
  calsel VARCHAR,
  id_persona INTEGER,
  id_funcionario INTEGER,
  migrado VARCHAR DEFAULT 'no'::character varying NOT NULL,
  banco VARCHAR,
  distrito_trabajo VARCHAR,
  matricula_seguro VARCHAR
) 
WITH (oids = false);

/*****************************F-SCP-RAC-ORGA-0-14/02/2017*************/

/*****************************I-SCP-FFP-ORGA-0-06/03/2016*************/
ALTER TABLE orga.toficina ADD direccion VARCHAR(255) NULL;


/*****************************F-SCP-FFP-ORGA-0-06/03/2016*************/

/*****************************I-SCP-FFP-ORGA-1-06/03/2016*************/
CREATE TABLE orga.tlog_generacion_firma_correo (
  id_log_generacion_firma_correo SERIAL,
  id_funcionario         INTEGER,
  nombre                    VARCHAR(255),
  cargo                     VARCHAR(255),
  cargo_ingles              VARCHAR(255),
  direccion                 VARCHAR(255),
  telefono_interno                VARCHAR(255),
  telefono_corporativo            VARCHAR(255),
  telefono_personal                    VARCHAR(255),
  PRIMARY KEY(id_log_generacion_firma_correo)
) INHERITS (pxp.tbase)
WITH (oids = false);

/*****************************F-SCP-FFP-ORGA-1-06/03/2016*************/

/***********************************I-SCP-JRR-ORGA-0-02/05/2017****************************************/
ALTER TABLE orga.tcargo_centro_costo
  ADD COLUMN id_ot INTEGER;

ALTER TABLE orga.tcargo_presupuesto
  ADD COLUMN id_ot INTEGER;

/***********************************F-SCP-JRR-ORGA-0-02/05/2017****************************************/


/*****************************I-SCP-RAC-ORGA-1-23/03/2017*************/

--------------- SQL ---------------

--algun chapulin se  puso   esta columna en la 
--consulta y se ovlido poner el scrip para la columna en la tabla

ALTER TABLE orga.toficina
  ADD COLUMN correo_oficina VARCHAR;
  
  
  --------------- SQL ---------------

ALTER TABLE orga.toficina
  ADD COLUMN telefono VARCHAR(50);
  
  
  --------------- SQL ---------------

ALTER TABLE orga.toficina
  ADD COLUMN orden NUMERIC(100,2);

/*****************************F-SCP-RAC-ORGA-1-23/03/2017*************/


/*****************************I-SCP-FEA-ORGA-0-20/09/2017*************/

--------------- SQL ---------------
CREATE SEQUENCE orga.tfuncionario_id_biometrico_seq
INCREMENT 1 MINVALUE 1
MAXVALUE 9223372036854775807 START 1
CACHE 1;

ALTER TABLE orga.tfuncionario
  ADD COLUMN id_oficina INTEGER,
  ADD COLUMN id_biometrico INTEGER;
/*****************************F-SCP-FEA-ORGA-0-20/09/2017*************/






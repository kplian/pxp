/********************************************I-SCP-JRR-ORGA-1-19/11/2012********************************************/
--
-- Structure for table tdepto (OID = 306303) : 
--
CREATE TABLE orga.tdepto (
    id_depto serial NOT NULL,
    nombre varchar(200),
    nombre_corto varchar(100),
    id_subsistema integer,
    codigo varchar(15),
    CONSTRAINT tdepto_pkey PRIMARY KEY (id_depto)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tusuario_uo (OID = 306433) : 
--
CREATE TABLE orga.tusuario_uo (
    id_usuario_uo serial NOT NULL,
    id_usuario integer,
    id_uo integer,
    CONSTRAINT tusuario_uo_pkey PRIMARY KEY (id_usuario_uo)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table testructura_uo (OID = 306562) : 
--
CREATE TABLE orga.testructura_uo (
    id_estructura_uo serial NOT NULL,
    id_uo_padre integer,
    id_uo_hijo integer,
    CONSTRAINT testructura_uo_pkey PRIMARY KEY (id_estructura_uo)
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
    fecha_ingreso date DEFAULT now() NOT NULL,
    telefono_ofi varchar(50),
    antiguedad_anterior INTEGER,
    id_biometrico INTEGER,
    id_auxiliar INTEGER,
    codigo_rciva VARCHAR(200),
    monto_rciva_anterior NUMERIC(10,2) DEFAULT 0 NOT NULL,
    profesion VARCHAR(500),
    fecha_quinquenio DATE,
    CONSTRAINT tfuncionario_id_persona_key UNIQUE (id_persona),
    CONSTRAINT tfuncionario_pkey PRIMARY KEY (id_funcionario)
) 
INHERITS (pxp.tbase) WITH OIDS;

COMMENT ON COLUMN orga.tfuncionario.email_empresa IS 'correo corporativo  asignado por la empresa';
COMMENT ON COLUMN orga.tfuncionario.interno IS 'numero telefonico interno de la empresa';

COMMENT ON COLUMN orga.tfuncionario.id_auxiliar
IS 'ahce referencia al id_auciliar_contable del funcionario, es de uso opcional';

COMMENT ON COLUMN orga.tfuncionario.codigo_rciva
IS 'codigo RCVIVA que permite acumular el IVA del FUNCIONARIO cuando viene de otra empresas';

COMMENT ON COLUMN orga.tfuncionario.monto_rciva_anterior
IS 'Si viene de otra empresa y tiene iva acumulado';

COMMENT ON COLUMN orga.tfuncionario.profesion
IS 'nombre de la profesion';

COMMENT ON COLUMN orga.tfuncionario.fecha_quinquenio
IS 'fecha del ultimo quinquenio pagado al funcionario, si es nulo no se le pago ninguno';
--
-- Structure for table tnivel_organizacional (OID = 306592) : 
--
CREATE TABLE orga.tnivel_organizacional (
    id_nivel_organizacional serial NOT NULL,
    nombre_nivel varchar(50) NOT NULL,
    numero_nivel integer NOT NULL,
    CONSTRAINT tnivel_organizacional_numero_nivel_key UNIQUE (numero_nivel),
    CONSTRAINT tnivel_organizacional_pk_kp_id_nivel_organizacional PRIMARY KEY (id_nivel_organizacional)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tuo (OID = 306669) : 
--
CREATE TABLE orga.tuo (
    id_uo serial NOT NULL,
    nombre_unidad varchar(100),
    nombre_cargo varchar(150),
    cargo_individual varchar,
    descripcion varchar(100),
    presupuesta varchar(2),
    codigo varchar(15),
    nodo_base varchar(2) DEFAULT 'no'::character varying NOT NULL,
    gerencia varchar(2),
    correspondencia varchar(2),
    id_nivel_organizacional INTEGER,
    planilla VARCHAR(2) DEFAULT 'no',
    prioridad VARCHAR(30),
    codigo_alterno VARCHAR,
    centro VARCHAR(2) DEFAULT 'no' NOT NULL,
    orden_centro NUMERIC DEFAULT 0 NOT NULL,
    vigente VARCHAR(2) DEFAULT 'si',
    tipo_unidad varchar(20) default 'no',
    CONSTRAINT tuo_pkey PRIMARY KEY (id_uo)
)
INHERITS (pxp.tbase) WITH OIDS;
COMMENT ON COLUMN orga.tuo.orden_centro
IS 'para ordenar en reportes, admite decimales';


COMMENT ON COLUMN orga.tuo.centro
IS 'si o no,  señala si es en un centro de revision util para agrupar en reprotes';


COMMENT ON COLUMN orga.tuo.codigo_alterno
IS 'este codigo se puede usar como llave de manera alterna al codigo de la UO';


COMMENT ON COLUMN orga.tuo.nodo_base IS 'Identifica la raiz del organigrama';

--
-- Structure for table tuo_funcionario (OID = 306676) : 
--
CREATE TABLE orga.tuo_funcionario (
    estado_reg varchar(10) NOT NULL,
    id_uo_funcionario serial NOT NULL,
    id_uo integer,
    id_funcionario integer,
    fecha_asignacion date,
    fecha_finalizacion date,
    tipo VARCHAR(10) default 'oficial' NOT NULL,
    fecha_documento_asignacion DATE,
    nro_documento_asignacion VARCHAR(50),
    observaciones_finalizacion VARCHAR(50) DEFAULT 'fin contrato', 
    id_cargo INTEGER,
    certificacion_presupuestaria  VARCHAR,
    carga_horaria INTEGER DEFAULT 240 NOT NULL,
    prioridad NUMERIC,
    separar_contrato VARCHAR(2) DEFAULT 'no',
    CONSTRAINT tuo_funcionario_pkey PRIMARY KEY (id_uo_funcionario),
    CONSTRAINT tuo_funcionario__tipo_chk CHECK (tipo='funcional' or tipo = 'oficial')

)
INHERITS (pxp.tbase) WITH OIDS;
ALTER TABLE orga.tuo_funcionario
  ALTER COLUMN id_uo SET STATISTICS 0;

COMMENT ON COLUMN orga.tuo_funcionario.carga_horaria
IS 'carga horaria mensual, tiempo completo 240 por defecto';

COMMENT ON COLUMN orga.tuo_funcionario.estado_reg IS 'activo :  relacion vigente
eliminado: relacion eliminada no se tiene que considerar 
finalizada: el funcionario se le cambiio el cargo, se tiene que considerar como historico 
finalizado:';

COMMENT ON COLUMN orga.tuo_funcionario.separar_contrato
IS 'Valor por defecto ''no'', cambia a si cuando al no haber periodo de descanso entre contratos, existe cambio de tipo_contrato (planta-odt) o modificacion a carga_horaria.';


--
-- Structure for table tdepto_usuario (OID = 429265) : 
--
CREATE TABLE orga.tdepto_usuario (
    id_depto_usuario serial NOT NULL,
    id_depto integer,
    id_usuario integer,
    cargo varchar(300),
    CONSTRAINT tdepto_usuario_tdepto_usuairo_pkey PRIMARY KEY (id_depto_usuario)
    
)
INHERITS (pxp.tbase) WITH OIDS;


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
  fecha DATE,
  numero_especialidad VARCHAR(10),
  descripcion VARCHAR(200), 
  CONSTRAINT tfuncionario_especialidad_pkey PRIMARY KEY (id_funcionario_especialidad),
  CONSTRAINT uq__id_funcionario_especialidad UNIQUE (id_funcionario, id_especialidad)
) INHERITS (pxp.tbase)
WITH OIDS;
ALTER TABLE orga.tfuncionario_especialidad OWNER TO postgres;

/********************************************F-SCP-JRR-ORGA-1-19/11/2012********************************************/



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
  fecha_ini DATE, 
  fecha_fin DATE, 
  aprobado VARCHAR(2) DEFAULT 'si' NOT NULL,
  nro_casos INTEGER NOT NULL,
  id_escala_padre INTEGER,
  PRIMARY KEY(id_escala_salarial),
  CONSTRAINT chk__tescala_salarial__aprobado CHECK (aprobado = 'si' or aprobado = 'no')
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.tcargo (
  id_cargo SERIAL NOT NULL, 
  id_uo	INTEGER NOT NULL,
  id_tipo_contrato INTEGER NOT NULL, 
  id_escala_salarial INTEGER NOT NULL, 
  codigo VARCHAR(20) NOT NULL, 
  nombre VARCHAR(200) NOT NULL,
  fecha_ini DATE NOT NULL,
  fecha_fin DATE,
  id_lugar INTEGER NOT NULL,
  id_temporal_cargo INTEGER,
  id_oficina INTEGER ,
  id_cargo_padre  INTEGER,
  id_tipo_cargo INTEGER,
  PRIMARY KEY(id_cargo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

COMMENT ON COLUMN orga.tcargo.id_tipo_cargo
IS 'clasifica el cargo, util para aplicar configuracion como el factor de diponibilidad de manera masiva';

CREATE TABLE orga.tcargo_presupuesto (
  id_cargo_presupuesto SERIAL NOT NULL, 
  id_centro_costo INTEGER NOT NULL, 
  id_cargo INTEGER NOT NULL,
  porcentaje NUMERIC(5,2) NOT NULL, 
  fecha_ini DATE NOT NULL, 
  id_gestion INTEGER NOT NULL,
  id_ot INTEGER,
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
  id_ot INTEGER,
  PRIMARY KEY(id_cargo_centro_costo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE orga.ttemporal_cargo (
  id_temporal_cargo SERIAL NOT NULL, 
  nombre VARCHAR(200) NOT NULL, 
  estado VARCHAR(20) NOT NULL, 
  id_temporal_jerarquia_aprobacion INTEGER NOT NULL, 
  fecha_ini DATE,
  fecha_fin DATE,
  id_cargo_padre INTEGER,
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
  zona_franca VARCHAR(2),
  frontera VARCHAR(2),
  direccion VARCHAR(255) NULL,
  correo_oficina VARCHAR,
  telefono VARCHAR(50),
  orden NUMERIC(100,2),
  PRIMARY KEY(id_oficina),
  CONSTRAINT chk__toficina__aeropuerto CHECK (aeropuerto = 'si' or aeropuerto = 'no')
) INHERITS (pxp.tbase)
WITHOUT OIDS;


  

  
  
  

 
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
  considerar_planilla VARCHAR(2) DEFAULT 'no'::character varying NOT NULL,
  indefinido VARCHAR(2) DEFAULT 'no',
  CONSTRAINT ttipo_contrato_pkey PRIMARY KEY(id_tipo_contrato) 
)INHERITS (pxp.tbase) WITH OIDS;
/*****************************F-SCP-JRR-ORGA-0-21/01/2014*************/

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


/*****************************I-SCP-RAC-ORGA-0-05/03/2015*************/

CREATE TABLE orga.tuo_funcionario_ope (
  id_uo_funcionario_ope SERIAL,
  id_uo INTEGER,
  id_funcionario INTEGER,
  fecha_asignacion DATE,
  fecha_finalizacion DATE,
  CONSTRAINT tuo_funcionario_ope_pkey PRIMARY KEY(id_uo_funcionario_ope)
 
  
) INHERITS (pxp.tbase)

WITH (oids = true);

  
/*****************************F-SCP-RAC-ORGA-0-05/03/2015*************/


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
  estado VARCHAR DEFAULT 'activo' NOT NULL,
  migrado VARCHAR(4) DEFAULT 'no' NOT NULL,
  nivel	varchar(100)
) 
WITH (oids = false);


CREATE TABLE orga.tcargo_tmp (
  codigo_uo VARCHAR,
  uo VARCHAR,
  item VARCHAR,
  cargo VARCHAR,
  migrado VARCHAR(10) COLLATE pg_catalog."default" DEFAULT 'no'::character varying,
  id_cargo INTEGER,
  individual VARCHAR,
  contrato VARCHAR DEFAULT 'planta' NOT NULL,
  lugar VARCHAR DEFAULT 'BOLIVIA' NOT NULL,
  escala VARCHAR(10),
  fecha_ingreso DATE,
  oficina VARCHAR(200)
) 
WITH (oids = false);
COMMENT ON COLUMN orga.tcargo_tmp.individual
IS 'si cargo individual se lo asgina a la gerencia, si no crea una uo que depende de la gerencia antes de asociar el cargo';

COMMENT ON COLUMN orga.tcargo_tmp.contrato
IS 'planta, eventual';

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
  matricula_seguro VARCHAR,
  usuario VARCHAR(100)
) 
WITH (oids = false);

/*****************************F-SCP-RAC-ORGA-0-14/02/2017*************/

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


/*****************************I-SCP-FEA-ORGA-0-20/09/2017*************/

--------------- SQL ---------------
CREATE SEQUENCE orga.tfuncionario_id_biometrico_seq
INCREMENT 1 MINVALUE 1
MAXVALUE 9223372036854775807 START 1
CACHE 1;

/*****************************F-SCP-FEA-ORGA-0-20/09/2017*************/


/*****************************I-SCP-RAC-ORGA-0-01/12/2018*************/

CREATE TABLE orga.tfuncionario_cat_prof (
  id_usuario_reg INTEGER,
  id_usuario_mod INTEGER,
  fecha_reg TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
  fecha_mod TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
  estado_reg VARCHAR(10) DEFAULT 'activo'::character varying,
  id_usuario_ai INTEGER,
  usuario_ai VARCHAR(300),
  id_funcionario_cat_prof SERIAL,
  codigo VARCHAR(20) ,
  cat_profesional VARCHAR(50),
  CONSTRAINT tfuncionario_cat_prof_pkey PRIMARY KEY (id_funcionario_cat_prof) NOT DEFERRABLE
) INHERITS (pxp.tbase)

WITH (oids = false);
ALTER TABLE orga.tfuncionario_cat_prof
  ALTER COLUMN id_funcionario_cat_prof SET STATISTICS 0;

 ALTER TABLE orga.tfuncionario_cat_prof
  ALTER COLUMN codigo SET STATISTICS 0;

ALTER TABLE orga.tfuncionario_cat_prof
  ALTER COLUMN cat_profesional SET STATISTICS 0 ;
  
/*****************************F-SCP-RAC-ORGA-0-01/12/2018*************/


/*****************************I-SCP-RAC-ORGA-30-15/07/2019*************/

--------------- SQL ---------------

CREATE TABLE orga.ttipo_cargo (
  id_tipo_cargo SERIAL NOT NULL,
  codigo VARCHAR(30) NOT NULL UNIQUE,
  nombre VARCHAR(300) NOT NULL,
  id_escala_salarial_min INTEGER,
  id_escala_salarial_max INTEGER NOT NULL,
  factor_disp NUMERIC DEFAULT 0 NOT NULL,
  obs VARCHAR,
  id_tipo_contrato INTEGER,
  factor_nocturno NUMERIC DEFAULT 0,
  PRIMARY KEY(id_tipo_cargo)
) INHERITS (pxp.tbase)
WITH (oids = false);

COMMENT ON COLUMN orga.ttipo_cargo.id_escala_salarial_min
IS 'escala salarial de rango minimo salarial';

COMMENT ON COLUMN orga.ttipo_cargo.id_escala_salarial_max
IS 'escala salarial maxima apra el tipo de cargo';

COMMENT ON COLUMN orga.ttipo_cargo.factor_disp
IS 'entre 0 a 1,  para calculo de bono de diposnibilidad  en planillas';

COMMENT ON COLUMN orga.ttipo_cargo.factor_nocturno
IS 'entre 0 a 1';
/*****************************F-SCP-RAC-ORGA-30-15/07/2019*************/

/*****************************I-SCP-MMV-ORGA-60-10/09/2019*************/
CREATE TABLE orga.tcodigo_funcionario (
  id_codigo_funcionario SERIAL NOT NULL ,
  codigo VARCHAR(20) NOT NULL UNIQUE ,
  id_funcionario INTEGER NOT NULL,
  fecha_asignacion DATE NOT NULL,
  fecha_finalizacion DATE,
  PRIMARY KEY(id_codigo_funcionario)
) INHERITS (pxp.tbase)
WITH (oids = false);
ALTER TABLE orga.tcodigo_funcionario
  ALTER COLUMN id_codigo_funcionario SET STATISTICS 0;

  ALTER TABLE orga.tfuncionario_cat_prof
  ALTER COLUMN codigo SET STATISTICS 0 ;

/*****************************F-SCP-MMV-ORGA-60-10/09/2019*************/

/*****************************I-SCP-VAN-ORGA-0-11/05/2020*************/
create table orga.huo_funcionario
(
    id                           serial not null
        constraint huo_funcionario_pkey primary key,
    estado_reg                   varchar(10),
    id_uo_funcionario            integer,
    id_uo                        integer,
    id_funcionario               integer,
    fecha_asignacion             date,
    fecha_finalizacion           date,
    tipo                         varchar(10),
    fecha_documento_asignacion   date,
    nro_documento_asignacion     varchar(50),
    observaciones_finalizacion   varchar(50),
    id_cargo                     integer,
    certificacion_presupuestaria varchar,
    carga_horaria                integer,
    prioridad                    numeric,
    separar_contrato             varchar(2),
    fecha_registro_historico     timestamp
) inherits (pxp.tbase);
alter table orga.huo_funcionario
    owner to postgres;
/*****************************F-SCP-VAN-ORGA-0-11/05/2020*************/





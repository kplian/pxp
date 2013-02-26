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
    email_empresa varchar(40),
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
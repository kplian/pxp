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
    nombre_cargo varchar(50),
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
-- Definition for view vfuncionario (OID = 306686) : 
--
CREATE VIEW orga.vfuncionario AS
SELECT funcio.id_funcionario, person.nombre_completo1 AS desc_funcionario1,
    person.nombre_completo2 AS desc_funcionario2, person.num_documento AS
    num_doc, person.ci, funcio.codigo, funcio.estado_reg
FROM (orga.tfuncionario funcio JOIN segu.vpersona person ON ((funcio.id_persona
    = person.id_persona)));

--
-- Definition for view vfuncionario_cargo (OID = 306690) : 
--
CREATE VIEW orga.vfuncionario_cargo AS
SELECT uof.id_uo_funcionario, funcio.id_funcionario,
    person.nombre_completo1 AS desc_funcionario1, person.nombre_completo2
    AS desc_funcionario2, uo.id_uo, uo.nombre_cargo, uof.fecha_asignacion,
    uof.fecha_finalizacion, person.num_documento AS num_doc, person.ci,
    funcio.codigo, funcio.email_empresa, funcio.estado_reg AS
    estado_reg_fun, uof.estado_reg AS estado_reg_asi
FROM (((orga.tfuncionario funcio JOIN segu.vpersona person ON
    ((funcio.id_persona = person.id_persona))) JOIN orga.tuo_funcionario uof ON
    ((uof.id_funcionario = funcio.id_funcionario))) JOIN orga.tuo uo ON
    ((uo.id_uo = uof.id_funcionario)));


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
--
-- Definition for index fk_tdepto__id_subsistema (OID = 308873) : 
--
ALTER TABLE ONLY orga.tdepto
    ADD CONSTRAINT fk_tdepto__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
--
-- Definition for index fk_tusuario_uo__id_uo (OID = 308908) : 
--
ALTER TABLE ONLY orga.tusuario_uo
    ADD CONSTRAINT fk_tusuario_uo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
--
-- Definition for index fk_tusuario_uo__id_ususario (OID = 308913) : 
--
ALTER TABLE ONLY orga.tusuario_uo
    ADD CONSTRAINT fk_tusuario_uo__id_ususario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tfuncionario__id_persona (OID = 308948) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index fk_tfuncionario__id_usuario_mod (OID = 308953) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_usuario_mod
    FOREIGN KEY (id_usuario_mod) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tfuncionario__id_usuario_reg (OID = 308958) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_usuario_reg
    FOREIGN KEY (id_usuario_reg) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tuo__id_uo_padre (OID = 414043) : 
--
ALTER TABLE ONLY orga.testructura_uo
    ADD CONSTRAINT fk_tuo__id_uo_padre
    FOREIGN KEY (id_uo_padre) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_testructura_uo__id_uo_hijo (OID = 414078) : 
--
ALTER TABLE ONLY orga.testructura_uo
    ADD CONSTRAINT fk_testructura_uo__id_uo_hijo
    FOREIGN KEY (id_uo_hijo) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_tuo_functionario__id_uo (OID = 414083) : 
--
ALTER TABLE ONLY orga.tuo_funcionario
    ADD CONSTRAINT fk_tuo_functionario__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_tuo_functionario__id_funcionario (OID = 414088) : 
--
ALTER TABLE ONLY orga.tuo_funcionario
    ADD CONSTRAINT fk_tuo_functionario__id_funcionario
    FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario(id_funcionario) ON UPDATE CASCADE;

--
-- Definition for index fk_tcorrelativo__id_depto (OID = 308838) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_depto
    FOREIGN KEY (id_depto) REFERENCES orga.tdepto(id_depto);

--
-- Definition for index fk_tcorrelativo__id_uo (OID = 308858) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
--
-- Definition for index tdepto_usuario_tdepto_usuairo_pkey (OID = 429272) : 
--
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

-----------------------------------------------------------------DATA--------------------------------------------------

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('ORGA', 'Organigrama', '2009-11-02', 'OR', 'activo', 'organigrama', NULL);

select pxp.f_insert_tfuncion ('ft_parametro_rhum_sel', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_parametro_rhum_ime', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_planilla_ime', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_planilla_sel', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_funcionario_sel', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_funcionario_ime', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_columna_ime', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_columna_sel', 'Funcion para tabla', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_obligacion_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_tipo_obligacion_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('f_obtener_uo_x_funcionario', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_estructura_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_estructura_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('__24nov11_ft_estructura_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('__24nov11_ft_funcionario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('__24nov11_ft_estructura_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_uo_funcionario_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('ft_uo_funcionario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tgui ('Parametros de RRHH', 'Parametros de RRHH', 'PARRHH', 'si', 1, 'sis_organigrama/vista/parametro_rhum/parametro_rhum.js', 3, '', 'parametro_rhum', 'ORGA');
select pxp.f_insert_tgui ('Definicion de Planillas', 'Definicion de Planillas', 'DEFPLAN', 'si', 1, '', 3, '', '', 'ORGA');
select pxp.f_insert_tgui ('Tipo Columna', 'Tipo Columna', 'TIPCOL', 'si', 1, 'sis_organigrama/vista/tipo_columna/tipo_columna.js', 4, '', 'tipo_columna', 'ORGA');
select pxp.f_insert_tgui ('Estructura Organizacional', 'Estructura Organizacional', 'ESTORG', 'si', 2, 'sis_organigrama/vista/estructura_uo/EstructuraUo.php', 3, '', 'EstructuraUo', 'ORGA');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'FUNCIO', 'si', 1, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'ORGA');
select pxp.f_insert_tgui ('Parametros', 'Parametros', 'PARAMRH', 'si', 1, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Procesos', 'Procesos', 'PROCRH', 'si', 2, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Reportes', 'Reportes', 'REPRH', 'si', 3, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('ORGANIGRAMA', 'Organigrama Institucional', 'ORGA', 'si', 5, '', 1, '', '', 'ORGA');
select pxp.f_insert_testructura_gui ('PARRHH', 'PARAMRH');
select pxp.f_insert_testructura_gui ('DEFPLAN', 'PARAMRH');
select pxp.f_insert_testructura_gui ('TIPCOL', 'DEFPLAN');
select pxp.f_insert_testructura_gui ('ESTORG', 'PARAMRH');
select pxp.f_insert_testructura_gui ('FUNCIO', 'PROCRH');
select pxp.f_insert_testructura_gui ('PARAMRH', 'ORGA');
select pxp.f_insert_testructura_gui ('PROCRH', 'ORGA');
select pxp.f_insert_testructura_gui ('REPRH', 'ORGA');
select pxp.f_insert_testructura_gui ('ORGA', 'SISTEMA');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_CONT', '	Conteo de funcionarios con cargos historicos
', 'si', '', '', 'ft_funcionario_sel');

select pxp.f_insert_tprocedimiento ('RH_ESTRUO_SEL', '	Listado de uos
', 'si', '', '', '__24nov11_ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_CONT', '	Conteo de estructura uos
', 'si', '', '', '__24nov11_ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_SEL', '	Listado de uos
', 'si', '', '', 'ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_CONT', '	Conteo de uos
', 'si', '', '', 'ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_SEL', '	Listado de funcionarios con cargos historicos
', 'si', '', '', 'ft_funcionario_sel');

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
  CONSTRAINT tespecialidad_pkey PRIMARY KEY (id_especialidad),
  CONSTRAINT fk_tespecialidad__id_especialidad_nivel FOREIGN KEY (id_especialidad_nivel)
      REFERENCES orga.tespecialidad_nivel (id_especialidad_nivel) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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


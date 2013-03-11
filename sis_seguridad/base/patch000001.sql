/***********************************I-SCP-JRR-SEGU-1-19/11/2012****************************************/

CREATE DOMAIN segu.activo_inactivo AS varchar(10) NOT NULL DEFAULT 'activo'::character varying;
--
-- Definition for type error_advertencia_informativo (OID = 303865) : 
--
CREATE DOMAIN segu.error_advertencia_informativo AS varchar(15);
--
-- Definition for type estado (OID = 303867) : 
--
CREATE TYPE segu.estado AS ENUM
  ( 'activo', 'inactivo' );
--
-- Definition for type si_no (OID = 303871) : 
--
CREATE DOMAIN segu.si_no AS varchar(10) DEFAULT 'si'::character varying;


--
-- Structure for table tusuario (OID = 305814) : 
--
CREATE TABLE segu.tusuario (
    id_usuario serial NOT NULL,
    id_clasificador integer,
    cuenta varchar(100) NOT NULL,
    contrasena varchar(100) NOT NULL,
    fecha_caducidad date,
    fecha_reg date DEFAULT now() NOT NULL,
    estilo varchar(100),
    contrasena_anterior varchar(100),
    id_persona integer NOT NULL,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg,
    autentificacion varchar(20) DEFAULT 'local'::character varying
) WITHOUT OIDS;
--
-- Structure for table tlog (OID = 306090) : 
--
CREATE TABLE segu.tlog (
    id_log serial NOT NULL,
    id_usuario integer,
    id_subsistema integer,
    mac_maquina varchar(30),
    ip_maquina varchar(30),
    tipo_log varchar(30) NOT NULL,
    descripcion text,
    fecha_reg timestamp(0) without time zone DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL,
    procedimientos text NOT NULL,
    transaccion varchar(20),
    consulta varchar,
    tiempo_ejecucion integer,
    usuario_base varchar(100),
    codigo_error varchar,
    dia_semana integer NOT NULL,
    pid_db integer,
    pid_web integer,
    sid_web varchar(100),
    cuenta_usuario varchar,
    descripcion_transaccion text,
    codigo_subsistema varchar(30),
    si_log integer
) WITHOUT OIDS;
--
-- Structure for table tpersona (OID = 306441) : 
--
CREATE TABLE segu.tpersona (
    id_persona serial NOT NULL,
    nombre varchar(150),
    apellido_paterno varchar(100),
    apellido_materno varchar(100),
    ci varchar(20),
    correo varchar(50),
    celular1 varchar(15),
    num_documento integer,
    telefono1 varchar(20),
    telefono2 varchar(20),
    celular2 varchar(15),
    foto bytea,
    extension varchar(15),
    genero varchar(1),
    fecha_nacimiento date,
    direccion varchar
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tactividad (OID = 306979) : 
--
CREATE TABLE segu.tactividad (
    id_actividad serial NOT NULL,
    nombre varchar(150) NOT NULL,
    descripcion varchar(500),
    codigo varchar
) INHERITS (pxp.tbase) WITH OIDS;
--
-- Structure for table testructura_dato (OID = 306991) : 
--
CREATE TABLE segu.testructura_dato (
    id_estructura_dato serial NOT NULL,
    id_subsistema integer NOT NULL,
    nombre varchar(50),
    descripcion text,
    encripta segu.si_no,
    log segu.si_no,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL,
    tipo varchar(30) NOT NULL
) WITHOUT OIDS;
--
-- Structure for table testructura_gui (OID = 307001) : 
--
CREATE TABLE segu.testructura_gui (
    id_estructura_gui serial NOT NULL,
    id_gui integer NOT NULL,
    fk_id_gui integer NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tgui_rol (OID = 307013) : 
--
CREATE TABLE segu.tgui_rol (
    id_gui_rol serial NOT NULL,
    id_rol integer NOT NULL,
    id_gui integer NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tpermiso (OID = 307043) : 
--
CREATE TABLE segu.tpermiso (
    id_permiso serial NOT NULL,
    id_procedimiento integer NOT NULL,
    id_estructura integer NOT NULL,
    permiso varchar(30),
    acceso segu.si_no DEFAULT 'no'::character varying,
    descripcion text,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tprocedimiento_gui (OID = 307055) : 
--
CREATE TABLE segu.tprocedimiento_gui (
    id_procedimiento_gui serial NOT NULL,
    id_procedimiento integer NOT NULL,
    id_gui integer NOT NULL,
    boton segu.si_no NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tproyecto (OID = 307067) : 
--
CREATE TABLE segu.tproyecto (
    id_proyecto serial NOT NULL,
    nombre varchar(150) NOT NULL,
    descripcion varchar(500),
    fecha_reg timestamp(0) without time zone DEFAULT now(),
    estado_reg varchar(10) DEFAULT 'activo'::character varying NOT NULL,
    codigo varchar(20),
    id_usuario_reg integer,
    fecha_mod timestamp(0) without time zone DEFAULT now(),
    id_usuario_mod integer
) WITHOUT OIDS;

--
-- Structure for table trecurso (OID = 307082) : 
--
CREATE TABLE segu.trecurso (
    id_recurso serial NOT NULL,
    nombre varchar(50),
    valor varchar(50) NOT NULL,
    observaciones text,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table trol_procedimiento_gui (OID = 307095) : 
--
CREATE TABLE segu.trol_procedimiento_gui (
    id_rol_procedimiento serial NOT NULL,
    id_procedimiento_gui integer NOT NULL,
    id_rol integer,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tbloqueo_notificacion (OID = 307106) : 
--
CREATE TABLE segu.tbloqueo_notificacion (
    id_bloqueo_notificacion serial NOT NULL,
    id_patron_evento integer NOT NULL,
    nombre_patron varchar(100) NOT NULL,
    fecha_hora_ini timestamp(0) without time zone NOT NULL,
    fecha_hora_fin timestamp(0) without time zone NOT NULL,
    estado_reg varchar(10) NOT NULL,
    id_usuario integer,
    usuario varchar(50),
    ip varchar(50) NOT NULL,
    tipo varchar(15) NOT NULL,
    aplicacion varchar(15) NOT NULL,
    tipo_evento varchar(35)
) WITH OIDS;
ALTER TABLE ONLY segu.tbloqueo_notificacion ALTER COLUMN id_bloqueo_notificacion SET STATISTICS 0;
--
-- Structure for table tclasificador (OID = 307111) : 
--
CREATE TABLE segu.tclasificador (
    id_clasificador serial NOT NULL,
    codigo varchar(20),
    descripcion text,
    prioridad integer,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tfuncion (OID = 307126) : 
--
CREATE TABLE segu.tfuncion (
    id_funcion serial NOT NULL,
    nombre varchar(50) NOT NULL,
    descripcion text,
    fecha_reg date DEFAULT now() NOT NULL,
    id_subsistema integer NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::pxp.estado_reg NOT NULL,
    CONSTRAINT chk_id_subsistema CHECK ((id_subsistema > 0))
) WITHOUT OIDS;
--
-- Structure for table tgui (OID = 307136) : 
--
CREATE TABLE segu.tgui (
    id_gui serial NOT NULL,
    nombre varchar(50),
    descripcion text,
    fecha_reg date DEFAULT now() NOT NULL,
    codigo_gui varchar(30) NOT NULL,
    visible segu.si_no,
    orden_logico integer,
    ruta_archivo text,
    nivel integer,
    icono varchar(50),
    id_subsistema integer,
    clase_vista varchar(100),
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL
) WITHOUT OIDS;
--
-- Structure for table thorario_trabajo (OID = 307147) : 
--
CREATE TABLE segu.thorario_trabajo (
    id_horario_trabajo serial NOT NULL,
    dia_semana integer,
    hora_ini time(0) without time zone,
    hora_fin time(0) without time zone
) WITH OIDS;
ALTER TABLE ONLY segu.thorario_trabajo ALTER COLUMN dia_semana SET STATISTICS 0;
--
-- Structure for table ttipo_documento (OID = 307152) : 
--
CREATE TABLE segu.ttipo_documento (
    id_tipo_documento serial NOT NULL,
    nombre varchar(15) NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tpatron_evento (OID = 307168) : 
--
CREATE TABLE segu.tpatron_evento (
    id_patron_evento serial NOT NULL,
    tipo_evento varchar(20) NOT NULL,
    operacion varchar,
    aplicacion varchar,
    cantidad_intentos integer,
    periodo_intentos numeric,
    tiempo_bloqueo numeric,
    email varchar,
    nombre_patron varchar(100),
    estado_reg varchar(20),
    CONSTRAINT tpatron_evento__aplicacion__chk CHECK ((((aplicacion)::text = 'usuario'::text) OR ((aplicacion)::text = 'ip'::text))),
    CONSTRAINT tpatron_evento__operacion__chk CHECK ((((operacion)::text = 'bloqueo'::text) OR ((operacion)::text = 'notificacion'::text)))
) WITH OIDS;
--
-- Structure for table tperfil (OID = 307178) : 
--
CREATE TABLE segu.tperfil (
    id_perfil serial NOT NULL,
    perfil varchar(30),
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL,
    defecto segu.si_no DEFAULT 'si'::character varying NOT NULL,
    id_recurso integer
) WITHOUT OIDS;

--
-- Structure for table segu.tprimo (OID = 307189) : 
--
CREATE TABLE segu.tprimo (
    id_primo serial NOT NULL,
    numero integer
) WITHOUT OIDS;
--
-- Structure for table tprocedimiento (OID = 307193) : 
--
CREATE TABLE segu.tprocedimiento (
    id_procedimiento serial NOT NULL,
    id_funcion integer,
    codigo varchar(20) NOT NULL,
    descripcion text NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    habilita_log segu.si_no DEFAULT 'si'::character varying NOT NULL,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL,
    autor varchar(100),
    fecha_creacion varchar(40)
) WITHOUT OIDS;
--
-- Structure for table tregional (OID = 307203) : 
--
CREATE TABLE segu.tregional (
    id_regional serial NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    nombre varchar(150) NOT NULL,
    descripcion varchar(500),
    estado_reg pxp.estado_reg
) WITHOUT OIDS;
--
-- Structure for table trol (OID = 307211) : 
--
CREATE TABLE segu.trol (
    id_rol serial NOT NULL,
    descripcion text,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL,
    rol varchar(150) NOT NULL,
    id_subsistema integer
) WITHOUT OIDS;
--
-- Structure for table tsesion (OID = 307220) : 
--
CREATE TABLE segu.tsesion (
    id_sesion bigserial NOT NULL,
    variable text NOT NULL,
    ip varchar(20) NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    id_usuario integer,
    estado_reg pxp.estado_reg,
    hora_act time(0) without time zone NOT NULL,
    hora_des time(0) without time zone,
    datos text,
    pid_web integer,
    pid_bd integer,
    transaccion_actual varchar,
    funcion_actual varchar,
    inicio_proceso timestamp(0) without time zone
) WITH OIDS;
ALTER TABLE ONLY segu.tsesion ALTER COLUMN fecha_reg SET STATISTICS 0;

--
-- Structure for table tsubsistema (OID = 307229) : 
--
CREATE TABLE segu.tsubsistema (
    id_subsistema serial NOT NULL,
    codigo varchar(20) NOT NULL,
    nombre varchar(50) NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    prefijo varchar(10) NOT NULL,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL,
    nombre_carpeta varchar(50),
    id_subsis_orig integer
) WITHOUT OIDS;

--
-- Structure for table tusuario_actividad (OID = 307237) : 
--
CREATE TABLE segu.tusuario_actividad (
    id_usuario_actividad serial NOT NULL,
    id_usuario integer NOT NULL,
    id_actividad integer NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tusuario_perfil (OID = 307244) : 
--
CREATE TABLE segu.tusuario_perfil (
    id_usuario_perfil serial NOT NULL,
    id_usuario integer,
    id_perfil integer,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tusuario_proyecto (OID = 307252) : 
--
CREATE TABLE segu.tusuario_proyecto (
    id_usuario_proyecto serial NOT NULL,
    id_usuario integer NOT NULL,
    id_proyecto integer NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tusuario_regional (OID = 307259) : 
--
CREATE TABLE segu.tusuario_regional (
    id_usuario_regional serial NOT NULL,
    id_regional integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_reg date DEFAULT now() NOT NULL,
    estado_reg segu.activo_inactivo DEFAULT 'activo'::character varying NOT NULL
) WITHOUT OIDS;
--
-- Structure for table tusuario_rol (OID = 307268) : 
--
CREATE TABLE segu.tusuario_rol (
    id_usuario_rol serial NOT NULL,
    id_rol integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_reg date,
    estado_reg pxp.estado_reg DEFAULT 'activo'::pxp.estado_reg NOT NULL
) WITHOUT OIDS;


--
-- Structure for table tprograma (OID = 397129) : 
--
CREATE TABLE segu.tprograma (
    id_programa serial NOT NULL,
    codigo varchar(20) NOT NULL,
    nombre varchar NOT NULL,
    descripcion varchar(500)
)
INHERITS (pxp.tbase) WITH OIDS;

--
-- Structure for table tep (OID = 397143) : 
--
CREATE TABLE segu.tep (
    id_ep serial NOT NULL,
    id_programa integer,
    id_proyecto integer,
    id_actividad integer
)
INHERITS (pxp.tbase) WITH OIDS;

--
-- Structure for table tep_persona (OID = 397171) : 
--
CREATE TABLE segu.tep_persona (
    id_ep_persona serial NOT NULL,
    id_persona integer NOT NULL,
    id_ep integer NOT NULL
)
INHERITS (pxp.tbase) WITH OIDS;

 
CREATE VIEW segu.vep (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_ep,
    id_programa,
    id_proyecto,
    id_actividad,
    codigo_programa,
    codigo_proyecto,
    codigo_actividad,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    desc_ep)
AS
SELECT ep.id_usuario_reg, ep.id_usuario_mod, ep.fecha_reg, ep.fecha_mod,
    ep.estado_reg, ep.id_ep, ep.id_programa, ep.id_proyecto, ep.id_actividad,
    prog.codigo AS codigo_programa, proy.codigo AS codigo_proyecto, act.codigo
    AS codigo_actividad, prog.nombre AS nombre_programa, proy.nombre AS
    nombre_proyecto, act.nombre AS nombre_actividad, (((prog.codigo::text ||
    '-'::text) || proy.codigo::text) || '-'::text) || act.codigo::text AS desc_ep
FROM segu.tep ep
   JOIN segu.tprograma prog ON prog.id_programa = ep.id_programa
   JOIN segu.tproyecto proy ON proy.id_proyecto = ep.id_proyecto
   JOIN segu.tactividad act ON act.id_actividad = ep.id_actividad;

--
-- Definition for index clasificador_pk (OID = 308296) : 
--
CREATE UNIQUE INDEX clasificador_pk ON segu.tclasificador USING btree (id_clasificador);
--
-- Definition for index es_asignado_fk (OID = 308297) : 
--
CREATE INDEX es_asignado_fk ON segu.tusuario_rol USING btree (id_rol);
--
-- Definition for index fki_estructura_dato__id_subsistema (OID = 308299) : 
--
CREATE INDEX fki_estructura_dato__id_subsistema ON segu.testructura_dato USING btree (id_subsistema);
--
-- Definition for index fki_estructura_gui__id_hijo (OID = 308300) : 
--
CREATE INDEX fki_estructura_gui__id_hijo ON segu.testructura_gui USING btree (id_gui);
--
-- Definition for index fki_estructura_gui__id_padre (OID = 308301) : 
--
CREATE INDEX fki_estructura_gui__id_padre ON segu.testructura_gui USING btree (fk_id_gui);
--
-- Definition for index fki_gui_rol__id_gui (OID = 308302) : 
--
CREATE INDEX fki_gui_rol__id_gui ON segu.tgui_rol USING btree (id_gui);
--
-- Definition for index fki_permiso__id_estructura (OID = 308303) : 
--
CREATE INDEX fki_permiso__id_estructura ON segu.tpermiso USING btree (id_estructura);
--
-- Definition for index fki_permiso__id_proc (OID = 308304) : 
--
CREATE INDEX fki_permiso__id_proc ON segu.tpermiso USING btree (id_procedimiento);
--
-- Definition for index fki_rol_procedimiento__id_proc (OID = 308305) : 
--
CREATE INDEX fki_rol_procedimiento__id_proc ON segu.trol_procedimiento_gui USING btree (id_procedimiento_gui);
--
-- Definition for index fki_rol_procedimiento__id_rol (OID = 308306) : 
--
CREATE INDEX fki_rol_procedimiento__id_rol ON segu.trol_procedimiento_gui USING btree (id_rol);
--
-- Definition for index fki_usuario_actividad__id_actividad (OID = 308307) : 
--
CREATE INDEX fki_usuario_actividad__id_actividad ON segu.tusuario_actividad USING btree (id_actividad);
--
-- Definition for index fki_usuario_actividad__id_usuario (OID = 308308) : 
--
CREATE INDEX fki_usuario_actividad__id_usuario ON segu.tusuario_actividad USING btree (id_usuario);
--
-- Definition for index fki_usuario_proyecto__id_proyecto (OID = 308309) : 
--
CREATE INDEX fki_usuario_proyecto__id_proyecto ON segu.tusuario_proyecto USING btree (id_proyecto);
--
-- Definition for index fki_usuario_proyecto__id_usuario (OID = 308310) : 
--
CREATE INDEX fki_usuario_proyecto__id_usuario ON segu.tusuario_proyecto USING btree (id_usuario);
--
-- Definition for index funcion_pk (OID = 308311) : 
--
CREATE UNIQUE INDEX funcion_pk ON segu.tfuncion USING btree (id_funcion);
--
-- Definition for index gui_pk (OID = 308312) : 
--
CREATE UNIQUE INDEX gui_pk ON segu.tgui USING btree (id_gui);
--
-- Definition for index perfil_pk (OID = 308314) : 
--
CREATE UNIQUE INDEX perfil_pk ON segu.tperfil USING btree (id_perfil);
--
-- Definition for index persona_pk (OID = 308315) : 
--
CREATE UNIQUE INDEX persona_pk ON segu.tpersona USING btree (id_persona);
--
-- Definition for index persona_relationship_11_fk (OID = 308316) : 
--
CREATE INDEX persona_relationship_11_fk ON segu.tpersona USING btree (id_persona);
--
-- Definition for index pki_actividad__id_actividad (OID = 308317) : 
--
CREATE UNIQUE INDEX pki_actividad__id_actividad ON segu.tactividad USING btree (id_actividad);
--
-- Definition for index pki_estructura_dato__id_estructura_dato (OID = 308318) : 
--
CREATE UNIQUE INDEX pki_estructura_dato__id_estructura_dato ON segu.testructura_dato USING btree (id_estructura_dato);
--
-- Definition for index pki_estructura_gui__id_estructura_gui (OID = 308319) : 
--
CREATE UNIQUE INDEX pki_estructura_gui__id_estructura_gui ON segu.testructura_gui USING btree (id_estructura_gui);
--
-- Definition for index pki_gui_rol__id_gui_rol (OID = 308320) : 
--
CREATE UNIQUE INDEX pki_gui_rol__id_gui_rol ON segu.tgui_rol USING btree (id_gui_rol);
--
-- Definition for index pki_permiso__id_permiso (OID = 308321) : 
--
CREATE UNIQUE INDEX pki_permiso__id_permiso ON segu.tpermiso USING btree (id_permiso);
--
-- Definition for index pki_proyecto__id_proyecto (OID = 308322) : 
--
CREATE UNIQUE INDEX pki_proyecto__id_proyecto ON segu.tproyecto USING btree (id_proyecto);
--
-- Definition for index pki_recurso__id_recurso (OID = 308323) : 
--
CREATE UNIQUE INDEX pki_recurso__id_recurso ON segu.trecurso USING btree (id_recurso);
--
-- Definition for index pki_rol_procedimiento__id_rol_proc (OID = 308324) : 
--
CREATE UNIQUE INDEX pki_rol_procedimiento__id_rol_proc ON segu.trol_procedimiento_gui USING btree (id_rol_procedimiento);
--
-- Definition for index pki_tipo_documento__id_tipo_doc (OID = 308325) : 
--
CREATE UNIQUE INDEX pki_tipo_documento__id_tipo_doc ON segu.ttipo_documento USING btree (id_tipo_documento);
--
-- Definition for index pki_usuario_actividad__id_usuario_actividad (OID = 308326) : 
--
CREATE UNIQUE INDEX pki_usuario_actividad__id_usuario_actividad ON segu.tusuario_actividad USING btree (id_usuario_actividad);
--
-- Definition for index pki_usuario_proyecto__id_usuario_proyecto (OID = 308327) : 
--
CREATE UNIQUE INDEX pki_usuario_proyecto__id_usuario_proyecto ON segu.tusuario_proyecto USING btree (id_usuario_proyecto);
--
-- Definition for index primo_pk (OID = 308328) : 
--
CREATE UNIQUE INDEX primo_pk ON segu.tprimo USING btree (id_primo);
--
-- Definition for index procedimiento_pk (OID = 308330) : 
--
CREATE UNIQUE INDEX procedimiento_pk ON segu.tprocedimiento USING btree (id_procedimiento);
--
-- Definition for index regional_pk (OID = 308331) : 
--
CREATE UNIQUE INDEX regional_pk ON segu.tregional USING btree (id_regional);
--
-- Definition for index regional_tiene_usuarios_fk (OID = 308332) : 
--
CREATE INDEX regional_tiene_usuarios_fk ON segu.tusuario_regional USING btree (id_regional);
--
-- Definition for index rol_pk (OID = 308333) : 
--
CREATE UNIQUE INDEX rol_pk ON segu.trol USING btree (id_rol);
--
-- Definition for index se_asigna_a_usuario_fk (OID = 308334) : 
--
CREATE INDEX se_asigna_a_usuario_fk ON segu.tusuario_perfil USING btree (id_perfil);
--
-- Definition for index se_asigna_fk (OID = 308335) : 
--
CREATE INDEX se_asigna_fk ON segu.tusuario USING btree (id_clasificador);
--
-- Definition for index subsistema_pk (OID = 308336) : 
--
CREATE UNIQUE INDEX subsistema_pk ON segu.tsubsistema USING btree (id_subsistema);
--
-- Definition for index tiene_perfil_fk (OID = 308337) : 
--
CREATE INDEX tiene_perfil_fk ON segu.tusuario_perfil USING btree (id_usuario);
--
-- Definition for index tiene_privilegios_fk (OID = 308338) : 
--
CREATE INDEX tiene_privilegios_fk ON segu.tusuario_rol USING btree (id_usuario);
--
-- Definition for index tiene_procedimientos_fk (OID = 308339) : 
--
CREATE INDEX tiene_procedimientos_fk ON segu.tprocedimiento USING btree (id_funcion);
--
-- Definition for index tlog_26112010_esta_fk (OID = 308340) : 
--
CREATE INDEX tlog_26112010_esta_fk ON segu.tlog USING btree (id_subsistema);
--
-- Definition for index tlog_26112010_log_pk (OID = 308341) : 
--
CREATE UNIQUE INDEX tlog_26112010_log_pk ON segu.tlog USING btree (id_log);
--
-- Definition for index tlog_26112010_usuario_esta_en_log_fk (OID = 308342) : 
--
CREATE INDEX tlog_26112010_usuario_esta_en_log_fk ON segu.tlog USING btree (id_usuario);
--
-- Definition for index tprocedimiento_gui_idx (OID = 308344) : 
--
CREATE UNIQUE INDEX tprocedimiento_gui_idx ON segu.tprocedimiento_gui USING btree (id_gui, id_procedimiento);
--
-- Definition for index usuario_perfil_pk (OID = 308346) : 
--
CREATE UNIQUE INDEX usuario_perfil_pk ON segu.tusuario_perfil USING btree (id_usuario_perfil);
--
-- Definition for index usuario_pertenece_a_regional_fk (OID = 308347) : 
--
CREATE INDEX usuario_pertenece_a_regional_fk ON segu.tusuario_regional USING btree (id_usuario);
--
-- Definition for index usuario_pk (OID = 308348) : 
--
CREATE UNIQUE INDEX usuario_pk ON segu.tusuario USING btree (id_usuario);
--
-- Definition for index usuario_regional_pk (OID = 308349) : 
--
CREATE UNIQUE INDEX usuario_regional_pk ON segu.tusuario_regional USING btree (id_usuario_regional);
--
-- Definition for index usuario_rol_pk (OID = 308350) : 
--
CREATE UNIQUE INDEX usuario_rol_pk ON segu.tusuario_rol USING btree (id_usuario_rol);
--
-- Definition for index tep_fki_tep__id_actividad (OID = 397167) : 
--
CREATE INDEX tep_fki_tep__id_actividad ON segu.tep USING btree (id_actividad);
--
-- Definition for index tep_fki_tep__id_proyecto (OID = 397168) : 
--
CREATE INDEX tep_fki_tep__id_proyecto ON segu.tep USING btree (id_proyecto);

--
-- Definition for index trol_rol_key (OID = 429319) : 
--
ALTER TABLE ONLY segu.trol
    ADD CONSTRAINT trol_rol_key
    UNIQUE (rol);
--
-- Definition for index gui_codigo_gui_key (OID = 308132) : 
--
ALTER TABLE ONLY segu.tgui
    ADD CONSTRAINT gui_codigo_gui_key
    UNIQUE (codigo_gui);
--
-- Definition for index persona_pk_persona (OID = 308138) : 
--
ALTER TABLE ONLY segu.tpersona
    ADD CONSTRAINT persona_pk_persona
    PRIMARY KEY (id_persona);
--
-- Definition for index pk_actividad (OID = 308140) : 
--
ALTER TABLE ONLY segu.tactividad
    ADD CONSTRAINT pk_actividad
    PRIMARY KEY (id_actividad);
--
-- Definition for index pk_clasificador (OID = 308142) : 
--
ALTER TABLE ONLY segu.tclasificador
    ADD CONSTRAINT pk_clasificador
    PRIMARY KEY (id_clasificador);
--
-- Definition for index pk_estructura_dato (OID = 308144) : 
--
ALTER TABLE ONLY segu.testructura_dato
    ADD CONSTRAINT pk_estructura_dato
    PRIMARY KEY (id_estructura_dato);
--
-- Definition for index pk_estructura_gui (OID = 308146) : 
--
ALTER TABLE ONLY segu.testructura_gui
    ADD CONSTRAINT pk_estructura_gui
    PRIMARY KEY (id_estructura_gui);
--
-- Definition for index pk_funcion (OID = 308148) : 
--
ALTER TABLE ONLY segu.tfuncion
    ADD CONSTRAINT pk_funcion
    PRIMARY KEY (id_funcion);
--
-- Definition for index pk_gui (OID = 308150) : 
--
ALTER TABLE ONLY segu.tgui
    ADD CONSTRAINT pk_gui
    PRIMARY KEY (id_gui);
--
-- Definition for index pk_gui_rol (OID = 308152) : 
--
ALTER TABLE ONLY segu.tgui_rol
    ADD CONSTRAINT pk_gui_rol
    PRIMARY KEY (id_gui_rol);
--
-- Definition for index pk_id_recurso (OID = 308154) : 
--
ALTER TABLE ONLY segu.trecurso
    ADD CONSTRAINT pk_id_recurso
    PRIMARY KEY (id_recurso);
--
-- Definition for index pk_id_tipo_documento (OID = 308156) : 
--
ALTER TABLE ONLY segu.ttipo_documento
    ADD CONSTRAINT pk_id_tipo_documento
    PRIMARY KEY (id_tipo_documento);
--
-- Definition for index pk_perfil (OID = 308160) : 
--
ALTER TABLE ONLY segu.tperfil
    ADD CONSTRAINT pk_perfil
    PRIMARY KEY (id_perfil);
--
-- Definition for index pk_permiso (OID = 308162) : 
--
ALTER TABLE ONLY segu.tpermiso
    ADD CONSTRAINT pk_permiso
    PRIMARY KEY (id_permiso);
--
-- Definition for index pk_primo (OID = 308164) : 
--
ALTER TABLE ONLY segu.tprimo
    ADD CONSTRAINT pk_primo
    PRIMARY KEY (id_primo);
--
-- Definition for index pk_procedimiento (OID = 308166) : 
--
ALTER TABLE ONLY segu.tprocedimiento
    ADD CONSTRAINT pk_procedimiento
    PRIMARY KEY (id_procedimiento);
--
-- Definition for index pk_procedimiento_gui (OID = 308168) : 
--
ALTER TABLE ONLY segu.tprocedimiento_gui
    ADD CONSTRAINT pk_procedimiento_gui
    PRIMARY KEY (id_procedimiento_gui);
--
-- Definition for index pk_proyecto (OID = 308170) : 
--
ALTER TABLE ONLY segu.tproyecto
    ADD CONSTRAINT pk_proyecto
    PRIMARY KEY (id_proyecto);
--
-- Definition for index pk_regional (OID = 308172) : 
--
ALTER TABLE ONLY segu.tregional
    ADD CONSTRAINT pk_regional
    PRIMARY KEY (id_regional);
--
-- Definition for index pk_rol (OID = 308174) : 
--
ALTER TABLE ONLY segu.trol
    ADD CONSTRAINT pk_rol
    PRIMARY KEY (id_rol);
--
-- Definition for index pk_rol_procedimiento (OID = 308176) : 
--
ALTER TABLE ONLY segu.trol_procedimiento_gui
    ADD CONSTRAINT pk_rol_procedimiento
    PRIMARY KEY (id_rol_procedimiento);
--
-- Definition for index pk_subsistema (OID = 308178) : 
--
ALTER TABLE ONLY segu.tsubsistema
    ADD CONSTRAINT pk_subsistema
    PRIMARY KEY (id_subsistema);
--
-- Definition for index pk_usuario (OID = 308180) : 
--
ALTER TABLE ONLY segu.tusuario
    ADD CONSTRAINT pk_usuario
    PRIMARY KEY (id_usuario);
--
-- Definition for index pk_usuario_actividad (OID = 308182) : 
--
ALTER TABLE ONLY segu.tusuario_actividad
    ADD CONSTRAINT pk_usuario_actividad
    PRIMARY KEY (id_usuario_actividad);
--
-- Definition for index pk_usuario_perfil (OID = 308184) : 
--
ALTER TABLE ONLY segu.tusuario_perfil
    ADD CONSTRAINT pk_usuario_perfil
    PRIMARY KEY (id_usuario_perfil);
--
-- Definition for index pk_usuario_proyecto (OID = 308186) : 
--
ALTER TABLE ONLY segu.tusuario_proyecto
    ADD CONSTRAINT pk_usuario_proyecto
    PRIMARY KEY (id_usuario_proyecto);
--
-- Definition for index pk_usuario_regional (OID = 308188) : 
--
ALTER TABLE ONLY segu.tusuario_regional
    ADD CONSTRAINT pk_usuario_regional
    PRIMARY KEY (id_usuario_regional);
--
-- Definition for index pk_usuario_rol (OID = 308190) : 
--
ALTER TABLE ONLY segu.tusuario_rol
    ADD CONSTRAINT pk_usuario_rol
    PRIMARY KEY (id_usuario_rol);
--
-- Definition for index subsistema_codigo_key (OID = 308192) : 
--
ALTER TABLE ONLY segu.tsubsistema
    ADD CONSTRAINT subsistema_codigo_key
    UNIQUE (codigo);
--
-- Definition for index subsistema_prefijo_key (OID = 308194) : 
--
ALTER TABLE ONLY segu.tsubsistema
    ADD CONSTRAINT subsistema_prefijo_key
    UNIQUE (prefijo);
--
-- Definition for index tbloqueo_notificacion_pkey (OID = 308196) : 
--
ALTER TABLE ONLY segu.tbloqueo_notificacion
    ADD CONSTRAINT tbloqueo_notificacion_pkey
    PRIMARY KEY (id_bloqueo_notificacion);
--
-- Definition for index tfuncion_nombre_key (OID = 308198) : 
--
ALTER TABLE ONLY segu.tfuncion
    ADD CONSTRAINT tfuncion_nombre_key
    UNIQUE (nombre);
--
-- Definition for index thorario_trabajo_pkey (OID = 308200) : 
--
ALTER TABLE ONLY segu.thorario_trabajo
    ADD CONSTRAINT thorario_trabajo_pkey
    PRIMARY KEY (id_horario_trabajo);
--
-- Definition for index tlog_26112010_pk_log (OID = 308202) : 
--
ALTER TABLE ONLY segu.tlog
    ADD CONSTRAINT tlog_26112010_pk_log
    PRIMARY KEY (id_log);
--
-- Definition for index tpatron_evento_pkey (OID = 308204) : 
--
ALTER TABLE ONLY segu.tpatron_evento
    ADD CONSTRAINT tpatron_evento_pkey
    PRIMARY KEY (id_patron_evento);
--
-- Definition for index tprocedimiento_codigo_key (OID = 308206) : 
--
ALTER TABLE ONLY segu.tprocedimiento
    ADD CONSTRAINT tprocedimiento_codigo_key
    UNIQUE (codigo);
--
-- Definition for index tsesion_pkey (OID = 308208) : 
--
ALTER TABLE ONLY segu.tsesion
    ADD CONSTRAINT tsesion_pkey
    PRIMARY KEY (id_sesion);
--
-- Definition for index tusuario_cuenta_key (OID = 308210) : 
--
ALTER TABLE ONLY segu.tusuario
    ADD CONSTRAINT tusuario_cuenta_key
    UNIQUE (cuenta);

-- Definition for trigger trig_log (OID = 308351) : 
--
CREATE TRIGGER trig_log
    BEFORE INSERT ON segu.tlog
    FOR EACH ROW
    EXECUTE PROCEDURE segu.ftrig_log ();
--
-- Definition for trigger trigger_usuario (OID = 308352) : 
--
CREATE TRIGGER trigger_usuario
    AFTER INSERT OR DELETE OR UPDATE ON segu.tusuario
    FOR EACH ROW
    EXECUTE PROCEDURE pxp.trigger_usuario ();

/***********************************F-SCP-JRR-SEGU-1-19/11/2012****************************************/

 
/***********************************F-SCP-JRR-SEGU-2-19/11/2012****************************************/

/***********************************I-SCP-RCM-SEGU-0-29/11/2012****************************************/
--Creación de vista de usuario
CREATE OR REPLACE VIEW segu.vusuario AS 
 SELECT usu.id_usuario, usu.id_clasificador, usu.cuenta, usu.contrasena, usu.fecha_caducidad, usu.fecha_reg,
 usu.estilo, usu.contrasena_anterior, usu.id_persona, usu.estado_reg, usu.autentificacion,
 (((per.nombre::text || ' '::text) || per.apellido_paterno::text) || ' '::text) || per.apellido_materno::text AS desc_persona, per.ci, per.correo
   FROM segu.tusuario usu
   JOIN segu.tpersona per ON per.id_persona = usu.id_persona;

ALTER TABLE segu.vusuario OWNER TO postgres;
/***********************************F-SCP-JRR-SEGU-0-29/11/2012****************************************/


/***********************************I-SCP-RCM-SEGU-0-07/12/2012****************************************/
--Correción de campo nulo de vista de usuario
CREATE OR REPLACE VIEW segu.vusuario AS 
 SELECT usu.id_usuario, usu.id_clasificador, usu.cuenta, usu.contrasena, usu.fecha_caducidad, usu.fecha_reg,
 usu.estilo, usu.contrasena_anterior, usu.id_persona, usu.estado_reg, usu.autentificacion,
 (((coalesce(per.nombre,'')::text || ' '::text) || coalesce(per.apellido_paterno,'')::text) || ' '::text) || coalesce(per.apellido_materno,'')::text AS desc_persona, per.ci, per.correo
   FROM segu.tusuario usu
   JOIN segu.tpersona per ON per.id_persona = usu.id_persona;

ALTER TABLE segu.vusuario OWNER TO postgres;
/***********************************F-SCP-JRR-SEGU-0-07/12/2012****************************************/

/***********************************I-SCP-RAC-SEGU-0-14/12/2012****************************************/

ALTER TABLE segu.tfuncion
  DROP CONSTRAINT tfuncion_nombre_key RESTRICT;
  
  CREATE UNIQUE INDEX tfuncion_idx ON segu.tfuncion
  USING btree (nombre, id_subsistema, estado_reg);
  
  
/***********************************F-SCP-RAC-SEGU-0-14/12/2012****************************************/

/****************************I-SCP-JRR-SEGU-0-09/01/2012*************/
ALTER TABLE segu.testructura_gui
  ADD COLUMN modificado INTEGER;

ALTER TABLE segu.tfuncion
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.tgui_rol
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.tgui
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.tprocedimiento_gui
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.tprocedimiento
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.trol_procedimiento_gui
  ADD COLUMN modificado INTEGER;
  
ALTER TABLE segu.trol
  ADD COLUMN modificado INTEGER;

/****************************F-SCP-JRR-SEGU-0-09/01/2012*************/
  
/*****************************I-SCP-JRR-SEGU-0-21/01/2013*************/
 -- object recreation
DROP INDEX segu.tfuncion_idx;

CREATE UNIQUE INDEX tfuncion_idx ON segu.tfuncion
  USING btree (nombre, id_subsistema)
  WHERE estado_reg = 'activo';

 -- object recreation
ALTER TABLE segu.tsubsistema
  DROP CONSTRAINT subsistema_codigo_key RESTRICT;

CREATE UNIQUE INDEX subsistema_codigo_key ON segu.tsubsistema
  USING btree (codigo)
  WHERE estado_reg = 'activo';
  
 -- object recreation
ALTER TABLE segu.trol
  DROP CONSTRAINT trol_rol_key RESTRICT;

CREATE UNIQUE INDEX trol_rol_key ON segu.trol
  USING btree (rol)
  WHERE estado_reg = 'activo';
  
 -- object recreation
ALTER TABLE segu.tgui
  DROP CONSTRAINT gui_codigo_gui_key RESTRICT;

CREATE UNIQUE INDEX gui_codigo_gui_key ON segu.tgui
  USING btree (codigo_gui)
  WHERE estado_reg = 'activo';
  
 -- object recreation
ALTER TABLE segu.tprocedimiento
  DROP CONSTRAINT tprocedimiento_codigo_key RESTRICT;

CREATE UNIQUE INDEX tprocedimiento_codigo_key ON segu.tprocedimiento
  USING btree (codigo)
  WHERE estado_reg = 'activo';
  
 -- object recreation
DROP INDEX segu.tprocedimiento_gui_idx;

CREATE UNIQUE INDEX tprocedimiento_gui_idx ON segu.tprocedimiento_gui
  USING btree (id_gui, id_procedimiento)
  WHERE estado_reg = 'activo';
  

/*****************************F-SCP-JRR-SEGU-0-21/01/2013*************/

/*****************************I-SCP-JRR-SEGU-0-08/03/2013*************/

ALTER TABLE segu.tgui
  ADD COLUMN combo_trigger VARCHAR(2);
  
/*****************************F-SCP-JRR-SEGU-0-08/03/2013*************/

/***********************************I-DEP-RAC-SEGU-0-31/12/2012*****************************************/

--
-- Definition for index fk_estructura_dato__id_subsistema (OID = 309308) : 
--
ALTER TABLE ONLY segu.testructura_dato
    ADD CONSTRAINT fk_estructura_dato__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
--
-- Definition for index fk_gui_rol__id_gui (OID = 309333) : 
--
ALTER TABLE ONLY segu.tgui_rol
    ADD CONSTRAINT fk_gui_rol__id_gui
    FOREIGN KEY (id_gui) REFERENCES segu.tgui(id_gui);
--
-- Definition for index fk_gui_rol__id_rol (OID = 309338) : 
--
ALTER TABLE ONLY segu.tgui_rol
    ADD CONSTRAINT fk_gui_rol__id_rol
    FOREIGN KEY (id_rol) REFERENCES segu.trol(id_rol);
--
-- Definition for index fk_id_patron_evento (OID = 309343) : 
--
ALTER TABLE ONLY segu.tbloqueo_notificacion
    ADD CONSTRAINT fk_id_patron_evento
    FOREIGN KEY (id_patron_evento) REFERENCES segu.tpatron_evento(id_patron_evento) ON UPDATE CASCADE;
--
-- Definition for index fk_log_esta_subsiste (OID = 309353) : 
--
ALTER TABLE ONLY segu.tlog
    ADD CONSTRAINT fk_log_esta_subsiste
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Definition for index fk_log_usuario_e_usuario (OID = 309368) : 
--
ALTER TABLE ONLY segu.tlog
    ADD CONSTRAINT fk_log_usuario_e_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Definition for index fk_perfil__id_recurso (OID = 309373) : 
--
ALTER TABLE ONLY segu.tperfil
    ADD CONSTRAINT fk_perfil__id_recurso
    FOREIGN KEY (id_recurso) REFERENCES segu.trecurso(id_recurso);
--
-- Definition for index fk_permiso__id_estructura (OID = 309378) : 
--
ALTER TABLE ONLY segu.tpermiso
    ADD CONSTRAINT fk_permiso__id_estructura
    FOREIGN KEY (id_estructura) REFERENCES segu.testructura_dato(id_estructura_dato);
--
-- Definition for index fk_permiso__id_proc (OID = 309383) : 
--
ALTER TABLE ONLY segu.tpermiso
    ADD CONSTRAINT fk_permiso__id_proc
    FOREIGN KEY (id_procedimiento) REFERENCES segu.tprocedimiento(id_procedimiento);
--
-- Definition for index fk_rol_procedimiento__id_procedimiento_gui (OID = 309408) : 
--
ALTER TABLE ONLY segu.trol_procedimiento_gui
    ADD CONSTRAINT fk_rol_procedimiento__id_procedimiento_gui
    FOREIGN KEY (id_procedimiento_gui) REFERENCES segu.tprocedimiento_gui(id_procedimiento_gui);
--
-- Definition for index fk_rol_procedimiento__id_rol (OID = 309413) : 
--
ALTER TABLE ONLY segu.trol_procedimiento_gui
    ADD CONSTRAINT fk_rol_procedimiento__id_rol
    FOREIGN KEY (id_rol) REFERENCES segu.trol(id_rol);
--
-- Definition for index fk_usuario__id_persona (OID = 309423) : 
--
ALTER TABLE ONLY segu.tusuario
    ADD CONSTRAINT fk_usuario__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);

-- Definition for index fk_usuario__se_asigna_perfil (OID = 309433) : 
--
ALTER TABLE ONLY segu.tusuario_perfil
    ADD CONSTRAINT fk_usuario__se_asigna_perfil
    FOREIGN KEY (id_perfil) REFERENCES segu.tperfil(id_perfil) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Definition for index fk_usuario__tiene_per_usuario (OID = 309438) : 
--
ALTER TABLE ONLY segu.tusuario_perfil
    ADD CONSTRAINT fk_usuario__tiene_per_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Definition for index fk_usuario_se_asigna_clasific (OID = 309473) : 
--
ALTER TABLE ONLY segu.tusuario
    ADD CONSTRAINT fk_usuario_se_asigna_clasific
    FOREIGN KEY (id_clasificador) REFERENCES segu.tclasificador(id_clasificador) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Definition for index fk_estructura_gui__id_hijo (OID = 414093) : 
--
ALTER TABLE ONLY segu.testructura_gui
    ADD CONSTRAINT fk_estructura_gui__id_hijo
    FOREIGN KEY (id_gui) REFERENCES segu.tgui(id_gui) ON UPDATE CASCADE;
--
-- Definition for index fk_estructura_gui__id_padre (OID = 414098) : 
--
ALTER TABLE ONLY segu.testructura_gui
    ADD CONSTRAINT fk_estructura_gui__id_padre
    FOREIGN KEY (fk_id_gui) REFERENCES segu.tgui(id_gui) ON UPDATE CASCADE;
--
-- Definition for index fk_funcion__id_subsistema (OID = 414103) : 
--
ALTER TABLE ONLY segu.tfuncion
    ADD CONSTRAINT fk_funcion__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) ON UPDATE CASCADE;
--
-- Definition for index fk_gui__id_subsistema (OID = 414108) : 
--
ALTER TABLE ONLY segu.tgui
    ADD CONSTRAINT fk_gui__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) ON UPDATE CASCADE;
--
-- Definition for index fk_procedim_tiene_pro_funcion (OID = 414113) : 
--
ALTER TABLE ONLY segu.tprocedimiento
    ADD CONSTRAINT fk_procedim_tiene_pro_funcion
    FOREIGN KEY (id_funcion) REFERENCES segu.tfuncion(id_funcion) ON UPDATE CASCADE ON DELETE RESTRICT;
--
-- Definition for index fk_procedimiento_gui__id_gui (OID = 414118) : 
--
ALTER TABLE ONLY segu.tprocedimiento_gui
    ADD CONSTRAINT fk_procedimiento_gui__id_gui
    FOREIGN KEY (id_gui) REFERENCES segu.tgui(id_gui) ON UPDATE CASCADE;
--
-- Definition for index fk_procedimiento_gui__id_proc (OID = 414123) : 
--
ALTER TABLE ONLY segu.tprocedimiento_gui
    ADD CONSTRAINT fk_procedimiento_gui__id_proc
    FOREIGN KEY (id_procedimiento) REFERENCES segu.tprocedimiento(id_procedimiento) ON UPDATE CASCADE;
--
-- Definition for index fk_rol__id_subsistema (OID = 414128) : 
--
ALTER TABLE ONLY segu.trol
    ADD CONSTRAINT fk_rol__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) ON UPDATE CASCADE;
--
-- Definition for index fk_usuario__es_asigna_rol (OID = 414133) : 
--
ALTER TABLE ONLY segu.tusuario_rol
    ADD CONSTRAINT fk_usuario__es_asigna_rol
    FOREIGN KEY (id_rol) REFERENCES segu.trol(id_rol) ON UPDATE CASCADE ON DELETE RESTRICT;
--
-- Definition for index fk_usuario__tiene_pri_usuario (OID = 414138) : 
--
ALTER TABLE ONLY segu.tusuario_rol
    ADD CONSTRAINT fk_usuario__tiene_pri_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario) ON UPDATE CASCADE ON DELETE RESTRICT;
    
ALTER TABLE ONLY pxp.tbase
    ADD CONSTRAINT fk_tbase__id_usuario_mod
    FOREIGN KEY (id_usuario_mod) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tbase__id_usuario_reg (OID = 308943) : 
--
ALTER TABLE ONLY pxp.tbase
    ADD CONSTRAINT fk_tbase__id_usuario_reg
    FOREIGN KEY (id_usuario_reg) REFERENCES segu.tusuario(id_usuario);    

--
-- Definition for view vpersona (OID = 306450) : 
--
CREATE VIEW segu.vpersona AS
SELECT p.id_persona, p.apellido_materno AS ap_materno, p.apellido_paterno
    AS ap_paterno, p.nombre, (((((COALESCE(p.nombre, ''::character
    varying))::text || ' '::text) || (COALESCE(p.apellido_paterno,
    ''::character varying))::text) || ' '::text) ||
    (COALESCE(p.apellido_materno, ''::character varying))::text) AS
    nombre_completo1, (((((COALESCE(p.apellido_paterno, ''::character
    varying))::text || ' '::text) || (COALESCE(p.apellido_materno,
    ''::character varying))::text) || ' '::text) || (COALESCE(p.nombre,
    ''::character varying))::text) AS nombre_completo2, p.ci, p.correo,
    p.celular1, p.num_documento, p.telefono1, p.telefono2, p.celular2
FROM segu.tpersona p;

--
-- Definition for view vlog (OID = 307283) : 
--
CREATE VIEW segu.vlog
AS
  SELECT tlog.id_log,
         tlog.id_usuario,
         tlog.id_subsistema,
         tlog.mac_maquina,
         tlog.ip_maquina,
         tlog.tipo_log,
         tlog.descripcion,
         tlog.fecha_reg,
         tlog.estado_reg,
         tlog.procedimientos,
         tlog.transaccion,
         tlog.consulta,
         tlog.tiempo_ejecucion,
         tlog.usuario_base,
         tlog.codigo_error,
         tlog.dia_semana,
         tlog.pid_db,
         tlog.pid_web,
         tlog.sid_web,
         tlog.cuenta_usuario,
         tlog.descripcion_transaccion,
         tlog.codigo_subsistema,
         tlog.usuario_ai
  FROM segu.tlog
  WHERE tlog.fecha_reg >=(now() - '24:00:00' ::interval) AND
        tlog.fecha_reg <= now();

ALTER TABLE segu.vlog
  OWNER TO postgres;

--
-- Definition for view vmonitor_bd_esquema (OID = 307288) : 
--
CREATE VIEW segu.vmonitor_bd_esquema AS
SELECT (n.oid)::integer AS nspoid, (ut.schemaname)::character varying AS
    schemaname, (u.usename)::character varying AS usename, (
    SELECT count(pg_class.oid) AS count
    FROM pg_class
    WHERE ((pg_class.relnamespace = n.oid) AND (pg_class.relkind = 'r'::"char"))
    ) AS cantidad_tablas, count(i.indexrelid) AS cantidad_indices,
        sum(ut.seq_scan) AS scaneos_secuenciales, sum(ut.seq_tup_read) AS
        tuplas_seq_leidas, sum(ut.idx_scan) AS indices_scaneados,
        sum(ut.idx_tup_fetch) AS tuplas_idx_leidas, sum(ut.n_tup_ins) AS
        tuplas_insertadas, sum(ut.n_tup_upd) AS tuplas_actualizadas,
        sum(ut.n_tup_del) AS tuplas_borradas, sum(ut.n_tup_hot_upd) AS
        tuplas_actualizadas_hot, sum(ut.n_live_tup) AS tuplas_vivas,
        sum(ut.n_dead_tup) AS tuplas_muertas, sum(uiot.heap_blks_read) AS
        bloques_leidos_disco_tabla, sum(uiot.heap_blks_hit) AS
        bloques_leidos_buffer_tabla, sum(uiot.idx_blks_read) AS
        bloques_leidos_disco_indice, sum(uiot.idx_blks_hit) AS
        bloques_leidos_buffer_indice, sum(uiot.toast_blks_read) AS
        bloques_leidos_disco_toast, sum(uiot.toast_blks_hit) AS
        bloques_leidos_buffer_toast, sum(uiot.tidx_blks_read) AS
        bloques_leidos_disco_toast_indice, sum(uiot.tidx_blks_hit) AS
        bloques_leidos_buffer_toast_indice, sum((c.relpages * 8)) AS
        kb_tablas, sum((ci.relpages * 8)) AS kb_indices
FROM ((((((pg_stat_user_tables ut JOIN pg_statio_user_tables uiot ON
    ((ut.relid = uiot.relid))) JOIN pg_class c ON ((c.oid = ut.relid)))
    JOIN pg_namespace n ON ((n.oid = c.relnamespace))) JOIN pg_user u ON
    ((n.nspowner = u.usesysid))) LEFT JOIN pg_index i ON ((i.indrelid =
    c.oid))) LEFT JOIN pg_class ci ON ((ci.oid = i.indexrelid)))
WHERE (ut.schemaname !~~ 'pg_temp%'::text)
GROUP BY n.oid, ut.schemaname, u.usename;

--
-- Definition for view vmonitor_bd_funcion (OID = 307293) : 
--
CREATE VIEW segu.vmonitor_bd_funcion AS
SELECT (pro.oid)::integer AS oid, (pro.pronamespace)::integer AS
    pronamespace, (pro.proname)::character varying AS proname, (CASE WHEN
    pro.prosecdef THEN 'si'::text ELSE 'no'::text END)::character varying
    AS setuid, (u.usename)::character varying AS usename
FROM (pg_proc pro JOIN pg_user u ON ((pro.proowner = u.usesysid)));

--
-- Definition for view vmonitor_bd_indice (OID = 307298) : 
--
CREATE VIEW segu.vmonitor_bd_indice AS
SELECT (ui.relid)::integer AS relid, (ui.indexrelid)::integer AS
    indexrelid, (ui.indexrelname)::character varying AS indexrelname,
    ui.idx_scan AS numero_index_scan, ui.idx_tup_read AS
    numero_indices_devueltos, ui.idx_tup_fetch AS numero_tuplas_vivas,
    ioi.idx_blks_read AS bloques_disco_leidos, ioi.idx_blks_hit AS
    bloques_buffer_leidos
FROM (pg_stat_user_indexes ui JOIN pg_statio_user_indexes ioi ON
    ((ui.indexrelid = ioi.indexrelid)));

--
-- Definition for view vmonitor_bd_tabla (OID = 307302) : 
--
CREATE VIEW segu.vmonitor_bd_tabla AS
SELECT (c.oid)::integer AS oid, (c.relnamespace)::integer AS relnamespace,
    (c.relname)::character varying AS relname, (u.usename)::character
    varying AS usename, to_char(ut.last_vacuum, 'DD/MM/YYYY HH24:MI'::text)
    AS last_vacuum, to_char(ut.last_autovacuum, 'DD/MM/YYYY HH24:MI'::text)
    AS last_autovacuum, to_char(ut.last_analyze,
    'DD/MM/YYYY HH24:MI'::text) AS last_analyze,
    to_char(ut.last_autoanalyze, 'DD/MM/YYYY HH24:MI'::text) AS
    last_autoanalyze, count(i.indexrelid) AS cantidad_indices, (
    SELECT count(*) AS count
    FROM pg_trigger
    WHERE ((pg_trigger.tgrelid = c.oid) AND (pg_trigger.tgisinternal = false))
    ) AS cantidad_triggers, (ut.seq_scan)::numeric AS scaneos_secuenciales,
        (ut.seq_tup_read)::numeric AS tuplas_seq_leidas,
        (ut.idx_scan)::numeric AS indices_scaneados,
        (ut.idx_tup_fetch)::numeric AS tuplas_idx_leidas,
        (ut.n_tup_ins)::numeric AS tuplas_insertadas,
        (ut.n_tup_upd)::numeric AS tuplas_actualizadas,
        (ut.n_tup_del)::numeric AS tuplas_borradas,
        (ut.n_tup_hot_upd)::numeric AS tuplas_actualizadas_hot,
        (ut.n_live_tup)::numeric AS tuplas_vivas, (ut.n_dead_tup)::numeric
        AS tuplas_muertas, (uiot.heap_blks_read)::numeric AS
        bloques_leidos_disco_tabla, (uiot.heap_blks_hit)::numeric AS
        bloques_leidos_buffer_tabla, (uiot.idx_blks_read)::numeric AS
        bloques_leidos_disco_indice, (uiot.idx_blks_hit)::numeric AS
        bloques_leidos_buffer_indice, (uiot.toast_blks_read)::numeric AS
        bloques_leidos_disco_toast, (uiot.toast_blks_hit)::numeric AS
        bloques_leidos_buffer_toast, (uiot.tidx_blks_read)::numeric AS
        bloques_leidos_disco_toast_indice, (uiot.tidx_blks_hit)::numeric AS
        bloques_leidos_buffer_toast_indice, ((c.relpages * 8))::numeric AS
        kb_tabla, (sum((ci.relpages * 8)))::numeric AS kb_indices
FROM (((((pg_stat_user_tables ut JOIN pg_statio_user_tables uiot ON
    ((ut.relid = uiot.relid))) JOIN pg_class c ON ((c.oid = ut.relid)))
    JOIN pg_user u ON ((c.relowner = u.usesysid))) LEFT JOIN pg_index i ON
    ((i.indrelid = c.oid))) LEFT JOIN pg_class ci ON ((ci.oid = i.indexrelid)))
GROUP BY c.oid, c.relnamespace, c.relname, u.usename, c.relhastriggers,
    ut.last_vacuum, ut.last_autovacuum, ut.last_analyze,
    ut.last_autoanalyze, ut.seq_scan, ut.seq_tup_read, ut.idx_scan,
    ut.idx_tup_fetch, ut.n_tup_ins, ut.n_tup_upd, ut.n_tup_del,
    ut.n_tup_hot_upd, ut.n_live_tup, ut.n_dead_tup, uiot.heap_blks_read,
    uiot.heap_blks_hit, uiot.idx_blks_read, uiot.idx_blks_hit,
    uiot.toast_blks_read, uiot.toast_blks_hit, uiot.tidx_blks_read,
    uiot.tidx_blks_hit, (c.relpages * 8);


/***********************************F-DEP-RAC-SEGU-0-31/12/2012*****************************************/

/***********************************I-DEP-JRR-SEGU-0-19/01/2012*****************************************/


CREATE TRIGGER trig_tprocedimiento BEFORE UPDATE 
ON segu.tprocedimiento FOR EACH ROW 
EXECUTE PROCEDURE segu.ftrig_tprocedimiento();

CREATE TRIGGER trig_tgui BEFORE UPDATE 
ON segu.tgui FOR EACH ROW
EXECUTE PROCEDURE segu.ftrig_tgui();

CREATE TRIGGER trig_testructura_gui BEFORE UPDATE 
ON segu.testructura_gui FOR EACH ROW 
EXECUTE PROCEDURE segu.ftrig_testructura_gui();

CREATE TRIGGER trig_tfuncion BEFORE UPDATE 
ON segu.tfuncion FOR EACH ROW
EXECUTE PROCEDURE segu.ftrig_tfuncion();

CREATE TRIGGER trig_tprocedimiento_gui BEFORE UPDATE 
ON segu.tprocedimiento_gui FOR EACH ROW
EXECUTE PROCEDURE segu.ftrig_tprocedimiento_gui();

CREATE TRIGGER trig_trol BEFORE UPDATE 
ON segu.trol FOR EACH ROW
EXECUTE PROCEDURE segu.ftrig_trol();

CREATE TRIGGER trig_tgui_rol BEFORE UPDATE 
ON segu.tgui_rol FOR EACH ROW 
EXECUTE PROCEDURE segu.ftrig_tgui_rol();

CREATE TRIGGER trig_trol_procedimiento_gui BEFORE UPDATE 
ON segu.trol_procedimiento_gui FOR EACH ROW 
EXECUTE PROCEDURE segu.ftrig_trol_procedimiento_gui();

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
    
update segu.tusuario set contrasena = '21232f297a57a5a743894a0e4a801fc3'
where id_usuario = 1;

/***********************************F-DEP-JRR-SEGU-0-19/01/2012*****************************************/






/*******************************************I-DEP-RAC-SEGU-0-15/01/2015**********************************************/



CREATE OR REPLACE VIEW segu.vpersona2
AS
  SELECT p.id_persona,
         p.apellido_materno AS ap_materno,
         p.apellido_paterno AS ap_paterno,
         p.nombre,
         (((COALESCE(p.nombre, ''::character varying)::text || ' '::text) ||
           COALESCE(p.apellido_paterno, ''::character varying)::text) || ' '::
           text) || COALESCE(p.apellido_materno, ''::character varying)::text AS
           nombre_completo1,
         (((COALESCE(p.apellido_paterno, ''::character varying)::text || ' '::
           text) || COALESCE(p.apellido_materno, ''::character varying)::text)
           || ' '::text) || COALESCE(p.nombre, ''::character varying)::text AS
           nombre_completo2,
         p.ci,
         p.correo,
         p.correo2,
         p.celular1,
         p.celular2,
         p.num_documento,
         p.telefono1,
         p.telefono2,
         p.direccion,
         p.extension,
         p.fecha_nacimiento,
         p.genero
         
         
  FROM segu.tpersona p;

/*******************************************F-DEP-RAC-SEGU-0-15/01/2015**********************************************/

/*******************************************I-DEP-RAC-SEGU-0-11/02/2015**********************************************/

CREATE OR REPLACE VIEW segu.vusuario(
    id_usuario,
    id_clasificador,
    cuenta,
    contrasena,
    fecha_caducidad,
    fecha_reg,
    estilo,
    contrasena_anterior,
    id_persona,
    estado_reg,
    autentificacion,
    desc_persona,
    ci,
    correo)
AS
  SELECT usu.id_usuario,
         usu.id_clasificador,
         usu.cuenta,
         usu.contrasena,
         usu.fecha_caducidad,
         usu.fecha_reg,
         usu.estilo,
         usu.contrasena_anterior,
         usu.id_persona,
         usu.estado_reg,
         usu.autentificacion,
         (((COALESCE(per.nombre, '' ::character varying) ::text || ' ' ::text)
          || COALESCE(per.apellido_paterno, '' ::character varying) ::text) ||
           ' ' ::text) || COALESCE(per.apellido_materno, '' ::character varying)
            ::text AS desc_persona,
         per.ci,
         per.correo2::character varying (50) AS correo
  FROM segu.tusuario usu
       JOIN segu.tpersona per ON per.id_persona = usu.id_persona;
       
/*******************************************F-DEP-RAC-SEGU-0-11/02/2015**********************************************/

/***********************************I-DEP-JRR-SEGU-0-04/05/2016*****************************************/

ALTER TABLE segu.tpersona
    ADD CONSTRAINT fk_tpersona__id_lugar
    FOREIGN KEY (id_lugar) REFERENCES param.tlugar(id_lugar);

/***********************************F-DEP-JRR-SEGU-0-04/05/2016*****************************************/

/***********************************I-DEP-JRR-SEGU-0-16/03/2017*****************************************/
ALTER TABLE segu.tusuario ENABLE ALWAYS TRIGGER trigger_usuario;
/***********************************F-DEP-JRR-SEGU-0-16/03/2017*****************************************/


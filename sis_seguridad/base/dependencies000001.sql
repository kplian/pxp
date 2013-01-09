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
--
-- Definition for index fk_usuario__regional__regional (OID = 309428) : 
--
ALTER TABLE ONLY segu.tusuario_regional
    ADD CONSTRAINT fk_usuario__regional__regional
    FOREIGN KEY (id_regional) REFERENCES segu.tregional(id_regional) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
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
-- Definition for index fk_usuario__usuario_p_usuario (OID = 309448) : 
--
ALTER TABLE ONLY segu.tusuario_regional
    ADD CONSTRAINT fk_usuario__usuario_p_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Definition for index fk_usuario_actividad__id_actividad (OID = 309453) : 
--
ALTER TABLE ONLY segu.tusuario_actividad
    ADD CONSTRAINT fk_usuario_actividad__id_actividad
    FOREIGN KEY (id_actividad) REFERENCES segu.tactividad(id_actividad);
--
-- Definition for index fk_usuario_actividad__id_usuario (OID = 309458) : 
--
ALTER TABLE ONLY segu.tusuario_actividad
    ADD CONSTRAINT fk_usuario_actividad__id_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_usuario_proyecto__id_proyecto (OID = 309463) : 
--
ALTER TABLE ONLY segu.tusuario_proyecto
    ADD CONSTRAINT fk_usuario_proyecto__id_proyecto
    FOREIGN KEY (id_proyecto) REFERENCES segu.tproyecto(id_proyecto);
--
-- Definition for index fk_usuario_proyecto__id_usuario (OID = 309468) : 
--
ALTER TABLE ONLY segu.tusuario_proyecto
    ADD CONSTRAINT fk_usuario_proyecto__id_usuario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_usuario_se_asigna_clasific (OID = 309473) : 
--
ALTER TABLE ONLY segu.tusuario
    ADD CONSTRAINT fk_usuario_se_asigna_clasific
    FOREIGN KEY (id_clasificador) REFERENCES segu.tclasificador(id_clasificador) ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Definition for index tprograma_pkey (OID = 397139) : 
--
ALTER TABLE ONLY segu.tprograma
    ADD CONSTRAINT tprograma_pkey
    PRIMARY KEY (id_programa);
--
-- Definition for index tep_pkey (OID = 397150) : 
--
ALTER TABLE ONLY segu.tep
    ADD CONSTRAINT tep_pkey
    PRIMARY KEY (id_ep);
--
-- Definition for index fk_tep__id_actividad (OID = 397152) : 
--
ALTER TABLE ONLY segu.tep
    ADD CONSTRAINT fk_tep__id_actividad
    FOREIGN KEY (id_actividad) REFERENCES segu.tactividad(id_actividad);
--
-- Definition for index fk_tep__id_programa (OID = 397157) : 
--
ALTER TABLE ONLY segu.tep
    ADD CONSTRAINT fk_tep__id_programa
    FOREIGN KEY (id_programa) REFERENCES segu.tprograma(id_programa) ON UPDATE CASCADE;
--
-- Definition for index fk_tep__id_proyecto (OID = 397162) : 
--
ALTER TABLE ONLY segu.tep
    ADD CONSTRAINT fk_tep__id_proyecto
    FOREIGN KEY (id_proyecto) REFERENCES segu.tproyecto(id_proyecto);
--
-- Definition for index tep_persona_pkey (OID = 397178) : 
--
ALTER TABLE ONLY segu.tep_persona
    ADD CONSTRAINT tep_persona_pkey
    PRIMARY KEY (id_ep_persona);
--
-- Definition for index fk_tep_persona__id_persona (OID = 397180) : 
--
ALTER TABLE ONLY segu.tep_persona
    ADD CONSTRAINT fk_tep_persona__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona) DEFERRABLE;
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




/***********************************F-DEP-RAC-SEGU-0-31/12/2012*****************************************/





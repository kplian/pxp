/****************************I-DAT-JRR-PXP-2-19/11/2012*************/     


select pxp.f_crear_rol_sistema('conexion', '', true);

--
-- Data for table pxp.variable_global (OID = 306540) (LIMIT 0,6)
--
INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (2, 'sincronizar_base', 'dbendesis', 'nombre de la base dew datos a sincronizar');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (5, 'sincronizar_password', 'db_link', 'password para la sincronizacion de base de datos encriptado');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (4, 'sincronizar_user', 'db_link', 'nombre de usuario para sincronizar base de datos');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (6, 'sincroniza_ip', '10.172.0.13', 'ip de base de datos para sincronizacion');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (7, 'sincroniza_puerto', '5432', 'puesto de sincronizacion de base de datos postgres');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (1, 'sincronizar', 'false', 'habilita la sincronización entre base de datos');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (3, 'habilitar_ime', 'false', 'habilita o deshabilita la insercion, edicion en tablas migradas');

--
-- Data for sequence pxp.variable_global_id_variable_global_seq (OID = 306546)
--
SELECT pg_catalog.setval('pxp.variable_global_id_variable_global_seq', 7, true);

/****************************F-DAT-JRR-PXP-2-19/11/2012*************/ 


/****************************I-DAT-JRR-PXP-0-25/04/2014******************/
select pxp.f_insert_tgui ('SISTEMA', 'NODO RAIZ', 'SISTEMA', 'si', 1, '', 0, '', 'NODO RAIZ', 'PXP');
select pxp.f_insert_tgui ('Alertas', 'Alertas', 'ALERTA', 'si', 102, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 1, '../../../lib/imagenes/warning.png', 'AlarmaFuncionario', 'PXP');
select pxp.f_insert_tgui ('Configurar', 'Configurar', 'CONFIG', 'si', 102, 'sis_seguridad/vista/configurar/Configurar.php', 1, '../../../lib/imagenes/config.32x32.png', 'Configurar', 'PXP');
select pxp.f_insert_tgui ('Help Desk', 'Help Desk', 'INITRAHP', 'si', 100, 'sis_workflow/vista/proceso_wf/ProcesoWfIniHelpDesk.php', 1, '../../../lib/imagenes/help_desk.png', 'ProcesoWfIniHD', 'PXP');
select pxp.f_insert_tgui ('Manuales', 'Video Manuales', 'VIDEMANU', 'si', 104, 'sis_seguridad/vista/gui/Videos.php', 1, '../../../lib/imagenes/youtube.png', 'Videos', 'PXP');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'INITRAHP.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 3, '', '90%', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'INITRAHP.2', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 3, '', 'FormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'INITRAHP.3', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 3, '', 'AntFormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INITRAHP.4', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'INITRAHP.5', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'WF');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'INITRAHP.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 4, '', 'SubirArchivoWf', 'WF');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'INITRAHP.1.2', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 4, '', 'TipoDocumentoEstadoWF', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INITRAHP.4.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INITRAHP.5.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INITRAHP.5.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_trol ('PXP-Rol inicial', 'PXP-Rol inicial', 'PXP');
select pxp.f_insert_testructura_gui ('INITRAHP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('VIDEMANU', 'SISTEMA');
select pxp.f_insert_testructura_gui ('INITRAHP.1', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.2', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.3', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.4', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.5', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.1.1', 'INITRAHP.1');
select pxp.f_insert_testructura_gui ('INITRAHP.1.2', 'INITRAHP.1');
select pxp.f_insert_testructura_gui ('INITRAHP.4.1', 'INITRAHP.4');
select pxp.f_insert_testructura_gui ('INITRAHP.5.1', 'INITRAHP.5');
select pxp.f_insert_testructura_gui ('INITRAHP.5.1.1', 'INITRAHP.5.1');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_TUTO_SEL', 'VIDEMANU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_TUTO_CONT', 'VIDEMANU', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INITRAHP.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INITRAHP.5.1.1', 'no');
select pxp.f_insert_tgui_rol ('ALERTA', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('SISTEMA', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('CONFIG', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.5', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.5.1', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.5.1.1', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.4', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.4.1', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.3', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.2', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.1', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.1.2', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('INITRAHP.1.1', 'PXP-Rol inicial');
select pxp.f_insert_tgui_rol ('VIDEMANU', 'PXP-Rol inicial');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSONMIN_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'PM_INSTIT_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_TIPPROC_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_PROMAC_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_GATNREP_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_PWF_INS', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_PWF_MOD', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_PWF_ELI', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_ANTEPRO_IME', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_PWF_SEL', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_SESPRO_IME', 'INITRAHP');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SG_TUTO_SEL', 'VIDEMANU');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SG_TUTO_CONT', 'VIDEMANU');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSONMIN_SEL', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_SEL', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'PM_INSTIT_INS', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'PM_INSTIT_MOD', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'PM_INSTIT_ELI', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'PM_INSTIT_SEL', 'INITRAHP.5');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSONMIN_SEL', 'INITRAHP.5.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_ELI', 'INITRAHP.5.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_MOD', 'INITRAHP.5.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_INS', 'INITRAHP.5.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_UPFOTOPER_MOD', 'INITRAHP.5.1.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSONMIN_SEL', 'INITRAHP.4');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_ELI', 'INITRAHP.4');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_MOD', 'INITRAHP.4');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_PERSON_INS', 'INITRAHP.4');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'SEG_UPFOTOPER_MOD', 'INITRAHP.4.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DOCWFAR_MOD', 'INITRAHP.3');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_FUNTIPES_SEL', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_TIPES_SEL', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DOCWFAR_MOD', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DEPTIPES_SEL', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_VERSIGPRO_IME', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_CHKSTA_IME', 'INITRAHP.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DWF_MOD', 'INITRAHP.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DWF_ELI', 'INITRAHP.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DWF_SEL', 'INITRAHP.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_CABMOM_IME', 'INITRAHP.1');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_TIPES_SEL', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_TIPPROC_SEL', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_INS', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_MOD', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_ELI', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_SEL', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DOCWFAR_MOD', 'INITRAHP.1.1');
/****************************F-DAT-JRR-PXP-0-25/04/2014******************/
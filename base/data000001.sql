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
select pxp.f_insert_trol ('PXP-Rol inicial', 'PXP-Rol inicial', 'PXP');
select pxp.f_insert_testructura_gui ('INITRAHP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('VIDEMANU', 'SISTEMA');
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

/****************************F-DAT-JRR-PXP-0-25/04/2014******************/
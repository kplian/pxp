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

/****************************F-DAT-JRR-PXP-0-25/04/2014******************/

/****************************I-DAT-JRR-PXP-0-07/05/2014******************/
select pxp.f_insert_tgui ('Alertas', 'Alertas', 'ALERTA', 'si', 102, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 1, '../../../lib/imagenes/warning.png', 'AlarmaFuncionario', 'PXP');
select pxp.f_insert_tgui ('Configurar', 'Configurar', 'CONFIG', 'si', 102, 'sis_seguridad/vista/configurar/Configurar.php', 1, '../../../lib/imagenes/config.32x32.png', 'Configurar', 'PXP');

/****************************F-DAT-JRR-PXP-0-07/05/2014******************/


/****************************I-DAT-RAC-PXP-0-21/05/2014******************/


select pxp.f_insert_tgui ('Aplicar Interinato', 'Aplicar interinato, asume lor roles y responsabilidades del  titular', 'APLIINT', 'si', 105, 'sis_organigrama/vista/interinato/AplicarInterino.php', 1, '', 'AplicarInterino', 'PXP');

/****************************F-DAT-RAC-PXP-0-21/05/2014******************/




/****************************I-DAT-RAC-PXP-0-05/06/2014******************/


----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

 select pxp.f_insert_tgui ('Help Desk', 'Help Desk', 'INITRAHP', 'si', 100, 'sis_workflow/vista/proceso_wf/ProcesoWfIniHelpDesk.php', 1, '../../../lib/imagenes/help_desk.png', 'ProcesoWfIniHD', 'PXP');
 select pxp.f_insert_tgui ('Asignar interino', 'Asigna interinos', 'ASINT', 'si', 105, 'sis_organigrama/vista/interinato/AsignarInterino.php', 1, '', 'AsignarInterino', 'PXP');


/****************************F-DAT-RAC-PXP-0-05/06/2014******************/


/****************************I-DAT-RAC-PXP-0-04/05/2015******************/


INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'pxp_array_lista_blanca', E'PM_CONACUSE_MOD', E'separa por comas sin espacion, los nombres de las transacciones que se omiten en la verificacion de permisos');

/****************************F-DAT-RAC-PXP-0-04/05/2015******************/


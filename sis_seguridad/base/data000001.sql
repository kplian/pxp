/********************************************I-DAT-RCM-SEGU-0-15/01/2013********************************************/
/*
*	Author: RAC
*	Date: 21/12/2012
*	Description: Build the menu definition and the composition
*/


/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos

*/




INSERT INTO segu.tsubsistema (id_subsistema, codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES (0, 'PXP', 'FRAMEWORK', '2011-11-23', 'PXP', 'activo', 'FRAMEWORK', NULL);

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('SEGU', 'Sistema de Seguridad', '2009-11-02', 'SG', 'activo', 'seguridad', NULL);




INSERT INTO segu.tgui ("id_gui", "nombre", "descripcion", "fecha_reg", "codigo_gui", "visible", "orden_logico", "ruta_archivo", "nivel", "icono", "id_subsistema", "clase_vista", "estado_reg", "modificado")
VALUES (0, E'SISTEMA', E'NODO RAIZ', E'2009-09-08', E'SISTEMA', E'si', 1, NULL, 0, NULL, 0, E'NODO RAIZ', E'activo', 1);




-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------
select pxp.f_insert_tgui ('SEGU', 'Seguridad', 'SEGU', 'si', 1, '', 1, '../../../lib/imagenes/segu32x32.png', 'Seguridad', 'SEGU');

select pxp.f_insert_tgui ('Interfaces', 'Gestion de interfaces por subsistema', 'GUISUB', 'no', 1, '/', 4, '', 'gui', 'SEGU');
select pxp.f_insert_tgui ('Procedimientos Gui', 'Asignacion de procedimientos por interfaz', 'PROGUI', 'no', 1, 'procedimiento_gui.js', 5, '', 'procedimiento_gui', 'SEGU');
select pxp.f_insert_tgui ('funciones', 'funciones', 'funciones', 'no', 2, 'funciones.js', 4, '', 'funciones', 'SEGU');
select pxp.f_insert_tgui ('Personas', 'Personas', 'Personas', 'si', 1, 'sis_seguridad/vista/reportes/persona.js', 3, '', 'repPersona', 'SEGU');
select pxp.f_insert_tgui ('Persona', 'persona', 'per', 'si', 7, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'SEGU');
select pxp.f_insert_tgui ('Usuario', 'usuario', 'USUARI', 'si', 2, 'sis_seguridad/vista/usuario/Usuario.php', 3, '', 'usuario', 'SEGU');
select pxp.f_insert_tgui ('Rol', 'rol', 'RROOLL', 'si', 3, 'sis_seguridad/vista/rol/Rol.php', 3, '', 'rol', 'SEGU');
select pxp.f_insert_tgui ('Clasificador', 'clasificador', 'CLASIF', 'si', 3, 'sis_seguridad/vista/clasificador/Clasificador.php', 3, '', 'clasificador', 'SEGU');
select pxp.f_insert_tgui ('Sistema', 'subsistema', 'SISTEM', 'si', 5, 'sis_seguridad/vista/subsistema/Subsistema.php', 3, '', 'Subsistema', 'SEGU');
select pxp.f_insert_tgui ('Libreta', 'Libreta', 'LIB', 'si', 100, 'sis_seguridad/vista/libreta_her/LibretaHer.php', 3, '', 'LibretaHer', 'SEGU');
select pxp.f_insert_tgui ('Procesos', '', 'PROCSEGU', 'si', 2, '', 2, '', '', 'SEGU');
select pxp.f_insert_tgui ('Parametros', '', 'o', 'si', 1, '', 2, '', '', 'SEGU');
select pxp.f_insert_tgui ('Interfaces por sistema', 'gui', '', 'no', 1, 'sis_seguridad/vista/gui/gui.js', 3, '', 'gui', 'SEGU');
select pxp.f_insert_tgui ('Reportes', 'Reportes', 'RepSeg', 'si', 3, '', 2, '', '', 'SEGU');

select pxp.f_insert_tgui ('Estructura Dato', 'Estructura Dato', 'ESTDAT', 'no', 4, 'sis_seguridad/vista/estructura_dato/EstructuraDato.php', 3, '', 'estructura_dato', 'SEGU');

select pxp.f_insert_tgui ('Tipo Documento', 'tipo_documento', 'TIPDOC', 'si', 7, 'sis_seguridad/vista/tipo_documento/TipoDocumento.php', 3, '', 'tipo_documento', 'SEGU');
select pxp.f_insert_tgui ('Patrones de Eventos', 'Patrones de Eventos', 'PATROEVE', 'si', 8, 'sis_seguridad/vista/patron_evento/PatronEvento.php', 4, '', 'patron_evento', 'SEGU');
select pxp.f_insert_tgui ('Log', 'log', 'LOG', 'no', 4, 'sis_seguridad/vista/log/Log.php', 3, '', 'log', 'SEGU');
select pxp.f_insert_tgui ('Horarios de Trabajo', 'Horarios de Trabajo', 'HORTRA', 'si', 9, 'sis_seguridad/vista/horario_trabajo/HorarioTrabajo.php', 3, '', 'horario_trabajo', 'SEGU');
select pxp.f_insert_tgui ('Monitoreo y Análisis de Bitácoras', 'Herramienta para hacer seguimiento a eventos del sistema', 'MONANA', 'si', 6, '', 3, '', '', 'SEGU');
select pxp.f_insert_tgui ('Monitoreo', 'Monitoreo', 'MONITOR', 'si', 1, '', 4, '', '', 'SEGU');
select pxp.f_insert_tgui ('Análisis de Bitácoras', 'Análisis de Bitácoras', 'ANABIT', 'si', 2, '', 4, '', '', 'SEGU');
select pxp.f_insert_tgui ('Bloqueos', 'Bloqueos', 'BLOMON', 'si', 3, 'sis_seguridad/vista/bloqueo/Bloqueo.php', 4, '', 'bloqueo', 'SEGU');
select pxp.f_insert_tgui ('Notificaciones', 'Notificaciones', 'NOTMON', 'si', 4, 'sis_seguridad/vista/notificacion/Notificacion.php', 4, '', 'notificacion', 'SEGU');
select pxp.f_insert_tgui ('Monitor de Sistema', 'Monitor de Sistema', 'MONSIS', 'si', 1, 'sis_seguridad/vista/monitor_sistema/MonitorSistema.php', 5, '', 'monitor_sistema', 'SEGU');
select pxp.f_insert_tgui ('Monitor de Uso de Recursos', 'Monitor de Uso de Recursos', 'MONUSREC', 'si', 2, 'sis_seguridad/vista/monitor_recursos/MonitorRecursos.php', 4, '', 'monitor_recursos', 'SEGU');
select pxp.f_insert_tgui ('Monitor de Actividades en BD', 'Monitor de Actividades en BD', 'MONBD', 'si', 3, 'sis_seguridad/vista/monitor_bd/MonitorBD.php', 5, '', 'monitor_bd', 'SEGU');
select pxp.f_insert_tgui ('Monitor de Objetos de BD', 'Monitor de Objetos de BD', 'MONOJBD', 'si', 4, 'sis_seguridad/vista/monitor_objetos/MonitorObjetos.php', 5, '', 'monitor_objetos', 'SEGU');
select pxp.f_insert_tgui ('Bitácoras de Sistema', 'Bitácoras de Sistema', 'BITSIS', 'si', 1, 'sis_seguridad/vista/bitacora_sistema/BitacoraSistema.php', 5, '', 'bitacora_sistema', 'SEGU');
select pxp.f_insert_tgui ('Bitácoras de BD', 'Bitácoras de BD', 'BITBD', 'si', 2, 'sis_seguridad/vista/bitacora_bd/BitacoraBD.php', 5, '', 'bitacora_bd', 'SEGU');
select pxp.f_insert_tgui ('Trabajo Fuera de Horario', 'Trabajo Fuera de Horario', 'TRAHOR', 'si', 3, 'sis_seguridad/vista/fuera_horario/FueraHorario.php', 5, '', 'fuera_horario', 'SEGU');
select pxp.f_insert_testructura_gui ('SEGU', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PROGUI', 'GUISUB');
select pxp.f_insert_testructura_gui ('funciones', 'SISTEM');
select pxp.f_insert_testructura_gui ('GUISUB', 'SISTEM');
select pxp.f_insert_testructura_gui ('PROCSEGU', 'SEGU');
select pxp.f_insert_testructura_gui ('o', 'SEGU');
select pxp.f_insert_testructura_gui ('RepSeg', 'SEGU');
select pxp.f_insert_testructura_gui ('MONANA', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('RROOLL', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('USUARI', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('SISTEM', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('LOG', 'PROCSEGU');
select pxp.f_insert_testructura_gui ('HORTRA', 'o');
select pxp.f_insert_testructura_gui ('PATROEVE', 'o');


select pxp.f_insert_testructura_gui ('ESTDAT', 'o');
select pxp.f_insert_testructura_gui ('CLASIF', 'o');


select pxp.f_insert_testructura_gui ('per', 'o');
select pxp.f_insert_testructura_gui ('TIPDOC', 'o');

select pxp.f_insert_testructura_gui ('Personas', 'RepSeg');
select pxp.f_insert_testructura_gui ('NOTMON', 'MONANA');
select pxp.f_insert_testructura_gui ('BLOMON', 'MONANA');
select pxp.f_insert_testructura_gui ('ANABIT', 'MONANA');
select pxp.f_insert_testructura_gui ('MONITOR', 'MONANA');
select pxp.f_insert_testructura_gui ('MONOJBD', 'MONITOR');
select pxp.f_insert_testructura_gui ('MONBD', 'MONITOR');
select pxp.f_insert_testructura_gui ('MONUSREC', 'MONITOR');
select pxp.f_insert_testructura_gui ('MONSIS', 'MONITOR');
select pxp.f_insert_testructura_gui ('TRAHOR', 'ANABIT');
select pxp.f_insert_testructura_gui ('BITBD', 'ANABIT');
select pxp.f_insert_testructura_gui ('BITSIS', 'ANABIT');


----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------


select pxp.f_insert_tfuncion ('segu.ft_usuario_proyecto_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_importar_menu', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_subsistema_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_subsistema_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_procedimiento_gui_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_rol_procedimiento_gui_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_grant_all_privileges', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_rol_sel', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_menu_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_regional_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_procedimiento_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_rol_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_bloqueo_notificacion_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_gui_rol_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_rol_procedimiento_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_log', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_sesion_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_validar_usuario_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_estructura_dato_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_libreta_her_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_regional_ime', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_libreta_her_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_procedimiento_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_gui_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_estructura_gui_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_clasificador_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_estructura_gui_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_procedimiento_gui_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_verif_eliminado', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_funcion_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_proyecto_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_funcion_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_get_id_usuario', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_rol_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_actividad_sel', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_tipo_documento_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_estructura_dato_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_patron_evento_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_monitorear_recursos', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_gui_ime', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.f_actualizar_log_bd', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_horario_trabajo_sel', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_patron_evento_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_clasificador_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_actividad_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_primo_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_gui_rol_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_actualizar_sesion', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_rol_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_persona_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_log_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_sesion_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_permiso_rol', 'Funcion para tabla     ', 'SEGU');

select pxp.f_insert_tfuncion ('segu.ft_monitor_bd_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_horario_trabajo_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_persona_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_configurar_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_bloqueo_notificacion_ime', 'Funcion para tabla     ', 'SEGU');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------



select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_ELI', '	Inactiva el subsistema selecionado
', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_MOD', '	Modifica el subsistema seleccionada 
', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_INS', '	Inserta Subsistemas
', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_CONT', '	Contar usuarios activos de sistema
', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_SEL', '	Listar usuarios activos de sistema
', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_VALUSU_SEL', '	consulta los datos del usario segun contrasena y login
', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_CONT', '	Contar  los subsistemas registrados del sistema
', 'si', '', '', 'segu.ft_subsistema_sel');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_SEL', '	Listado de los subsistemas registradas del sistema
', 'si', '', '', 'segu.ft_subsistema_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_ELI', '	Elimina Procedimiento_Gui
', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_MOD', '	Modifica Procedimiento_Gui
', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_INS', '	Inserta Procedimiento_Gui
', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_CONT', '	Cuenta Procesos por Gui y Rol
', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPROLPROGUI_SEL', '	Listado de rol_procedimiento_gui de un subsistema para exportar
', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROLPROGUI_SEL', '	Selecciona Procesos por Gui y Rol
', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_CONT', '	cuenta los roles activos que corresponden al usuario
', 'si', '', '', 'segu.ft_usuario_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_SEL', '	Lista los roles activos que corresponden al usuario
', 'si', '', '', 'segu.ft_usuario_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_MENU_SEL', '	Arma el menu que aparece en la parte izquierda
                de la pantalla del sistema
', 'si', '', '', 'segu.ft_menu_sel');


select pxp.f_insert_tprocedimiento ('SEG_PROCED_ELI', '	Elimina Procedimiento
', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_MOD', '	Modifica Procedimiento
', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_INS', '	Inserta Procedimiento
', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_ELI', '	Eliminar Usuarios
', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_MOD', '	Modifica datos de  usuario
', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_INS', '	Inserta usuarios
', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_ELI', '	retira  el rol asignado a un uusario
', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_MOD', '	modifica roles de usuario
', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_INS', '	funcion para insertar usuario 
', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_BLOQUE_CONT', '	Contar registros de bloqueos del sistema
', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_BLOQUE_SEL', '	Listado de bloqueos del sistema
', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_NOTI_CONT', '	Contar registros de notificaciones de enventos del sistema
', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_NOTI_SEL', '	Listado del notificacion de eventos del sistema
', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_CONT', '	Contar las interfaces con privilegios sobre procedimientos
', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPGUIROL_SEL', '	Listado de gui_rol de un subsistema para exportar
', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_SEL', '	Listado de interfaces con privilegios sobre procedimientos
', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_ELI', '	elimina Rol Procedimiento gui
', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_MOD', '	modifica Rol Procedimiento gui
', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_INS', '	Inserta Rol Procedimiento gui
', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_SESION_CONT', '	Contar  las sesiones activas en el sistema
', 'si', '', '', 'segu.ft_sesion_sel');
select pxp.f_insert_tprocedimiento ('SEG_SESION_SEL', '	Listado de las sesiones activas en el sistema
', 'si', '', '', 'segu.ft_sesion_sel');
select pxp.f_insert_tprocedimiento ('SEG_VALUSU_SEG', '	verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion
', 'si', '', '', 'segu.ft_validar_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_CONT', '	Cuenta Estructura dato
', 'si', '', '', 'segu.ft_estructura_dato_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_SEL', '	Selecciona Estructura dato
', 'si', '', '', 'segu.ft_estructura_dato_sel');
select pxp.f_insert_tprocedimiento ('SG_LIB_CONT', '	Conteo de registros
 	', 'si', '', '', 'segu.ft_libreta_her_sel');
select pxp.f_insert_tprocedimiento ('SG_LIB_SEL', '	Consulta de datos
 	', 'si', '', '', 'segu.ft_libreta_her_sel');
 	
 	
select pxp.f_insert_tprocedimiento ('SG_LIB_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SG_LIB_MOD', '	Modificacion de registros
 	', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SG_LIB_INS', '	Insercion de registros
 	', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCECMB_CONT', '	Cuenta Procedimientos para el listado
                del combo en la vista de procedimiento_gui
', 'si', '', '', 'segu.ft_procedimiento_sel');

select pxp.f_insert_tprocedimiento ('SEG_PROCECMB_SEL', '	Selecciona Procedimientos para el listado
                del combo en la vista de procedimiento_gui
', 'si', '', '', 'segu.ft_procedimiento_sel');

select pxp.f_insert_tprocedimiento ('SEG_PROCE_CONT', '	Cuenta Procedimientos
', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCE_SEL', '	Listado de Procedimientos
', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_CONT', '	Cuenta Procedimientos para agregar al listado del arbol
', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPPROC_SEL', '	Listado de procedimiento de un subsistema para exportar
', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_SEL', '	Selecciona Procedimientos para agregar al listado del arbol
', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUI_CONT', '	Listado de guis de un subsistema para exportar
', 'si', '', '', 'segu.ft_gui_sel');

select pxp.f_insert_tprocedimiento ('SEG_EXPGUI_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUI_SEL', '	Listado de interfaces en formato de arbol
', 'si', '', '', 'segu.ft_gui_sel');

select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_ELI', '	Elimina Estructura gui
', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_MOD', '	Modifica Estructura gui
', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_INS', '	Inserta Estructura gui
', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_CONT', '	Cuenta Clasificador
', 'si', '', '', 'segu.ft_clasificador_sel');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_SEL', '	Selecciona Clasificador
', 'si', '', '', 'segu.ft_clasificador_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_CONT', '	Cuenta Estructura gui
', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPESTGUI_SEL', '	Listado de estructura_gui de un subsistema para exportar
', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_SEL', '	Selecciona Estructura gui
', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_CONT', '	Cuenta procedimientos de una interfaz dada
', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPPROCGUI_SEL', '	Listado de procedimiento_gui de un subsistema para exportar
', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_SEL', '	Lista procedimientos de una interfaz dada
', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_SINCFUN_MOD', '	Este proceso busca todas las funciones de base de datos para el esquema seleccionado
                las  introduce en la tabla de fucniones luego revisa el cuerpo de la funcion 
                y saca los codigos de procedimiento y sus descripciones
', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_ELI', '	Inactiva las funcion selecionada 
', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_MOD', '	Modifica la funcion seleccionada 
', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_INS', '	Inserta Funciones
', 'si', '', '', 'segu.ft_funcion_ime');


select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_CONT', '	Contar  funciones registradas del sistema
', 'si', '', '', 'segu.ft_funcion_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPFUN_SEL', '	Listado de funciones de un subsistema para exportar
', 'si', '', '', 'segu.ft_funcion_sel');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_SEL', '	Listado de funciones registradas del sistema
', 'si', '', '', 'segu.ft_funcion_sel');

select pxp.f_insert_tprocedimiento ('SEG_ROL_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROL_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_rol_sel');


select pxp.f_insert_tprocedimiento ('SEG_TIPDOC_CONT', '	Contar  los procedimeintos de BD registradas del sistema
', 'si', '', '', 'segu.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('SEG_TIPDOC_SEL', '	Listado de los procedimientos de BD
', 'si', '', '', 'segu.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_ELI', '	Elimina Estructura Dato
', 'si', '', '', 'segu.ft_estructura_dato_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_MOD', '	Modifica Estructura Dato
', 'si', '', '', 'segu.ft_estructura_dato_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_INS', '	Inserta Estructura Dato
', 'si', '', '', 'segu.ft_estructura_dato_ime');

select pxp.f_insert_tprocedimiento ('SEG_PATEVE_ELI', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_patron_evento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PATEVE_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_patron_evento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PATEVE_INS', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_patron_evento_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_ELI', '	Inactiva la interfaz del arbol seleccionada 
', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_MOD', '	Modifica la interfaz del arbol seleccionada 
', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_INS', '	Inserta interfaces en el arbol
', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUIDD_IME', '	Inserta interfaces en el arbol
', 'si', '', '', 'segu.ft_gui_ime');

select pxp.f_insert_tprocedimiento ('SEG_HORTRA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_horario_trabajo_sel');
select pxp.f_insert_tprocedimiento ('SEG_HORTRA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_horario_trabajo_sel');

select pxp.f_insert_tprocedimiento ('SEG_PATEVE_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_patron_evento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PATEVE_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_patron_evento_sel');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_ELI', '	Elimina Clasificacion
', 'si', '', '', 'segu.ft_clasificador_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_MOD', '	Modifica Clasificacion
', 'si', '', '', 'segu.ft_clasificador_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_INS', '	Inserta Actividades
', 'si', '', '', 'segu.ft_clasificador_ime');

select pxp.f_insert_tprocedimiento ('SEG_PRIMO_CONT', '	cuenta el listado de numeros primos
', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_PRIMO_SEL', '	listado de numeros primo
', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_OBTEPRI_SEL', '	Obtienen un numero primo segun indice
                el indice se obtiene en el servidor web randomicamente
', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_INS', '	Modifica los permisos del un rol ID_ROL sobre un  tipo TIPO
', 'si', '', '', 'segu.ft_gui_rol_ime');

select pxp.f_insert_tprocedimiento ('SEG_ROL_ELI', '	Elimina Rol
', 'si', '', '', 'segu.ft_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROL_MOD', '	Modifica Rol
', 'si', '', '', 'segu.ft_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROL_INS', '	Inserta Rol
', 'si', '', '', 'segu.ft_rol_ime');

select pxp.f_insert_tprocedimiento ('SEG_PERSONMIN_CONT', '	Cuenta Personas con foto
', 'si', '', '', 'segu.ft_persona_sel');

select pxp.f_insert_tprocedimiento ('SEG_PERSONMIN_SEL', '	Selecciona Personas + fotografia
', 'si', '', '', 'segu.ft_persona_sel');

select pxp.f_insert_tprocedimiento ('SEG_PERSON_CONT', '	Cuenta Personas
', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_SEL', '	Selecciona Personas
', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGHOR_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGHOR_SEL', '	Contar  los eventos fuera de horario de trabajo
', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOG_CONT', '	Lista eventos del sistema sucedidos fuera de horarios de trabajo
', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOG_SEL', '	Contar  los eventos del sistema registrados
', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGMON_CONT', '	Contar registros del monitor de enventos del sistema(Actualiza eventos de BD)
', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGMON_SEL', '	Listado del monitoreo de eventos del  XPH sistema
', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_SESION_MOD', '	Modifica la una variable de sesion
', 'si', '', '', 'segu.ft_sesion_ime');
select pxp.f_insert_tprocedimiento ('SEG_SESION_INS', '	registra sesiones  de un usuario
', 'si', '', '', 'segu.ft_sesion_ime');

select pxp.f_insert_tprocedimiento ('SEG_MONREC_SEL', '	Monitorear recursos usados por el sistema
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONIND_CONT', '	Contar registros del monitor de objetos de bd (indices)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONIND_SEL', '	Listado de registros del monitor de objetos de bd (Indices)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONFUN_CONT', '	Contar registros del monitor de objetos de bd (funciones)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONFUN_SEL', '	Listado de registros del monitor de objetos de bd (Funciones)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONTAB_CONT', '	Contar registros del monitor de objetos de bd (Tablas)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONTAB_SEL', '	Listado de registros del monitor de objetos de bd (Tablas)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONESQ_CONT', '	Contar registros del monitor de objetos de bd (Esquemas)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONESQ_SEL', '	Listado de registros del monitor de objetos de bd (Esquemas)
', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_HORTRA_ELI', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_horario_trabajo_ime');
select pxp.f_insert_tprocedimiento ('SEG_HORTRA_MOD', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_horario_trabajo_ime');
select pxp.f_insert_tprocedimiento ('SEG_HORTRA_INS', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_horario_trabajo_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_ELI', '	Elimina Persona
', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_UPFOTOPER_MOD', '	Modifica la foto de la persona
', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_MOD', '	Modifica Persona
', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_INS', '	Inserta Persona
', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SG_CONF_MOD', '	Configuración de cuenta de usuario
 	', 'si', '', '', 'segu.ft_configurar_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESBLONO_MOD', '	Cambia el estado de notificacion y bloqueos
', 'si', '', '', 'segu.ft_bloqueo_notificacion_ime');






-------------------------------------------
-------------------------------------------
-------------------------------------------

---------------------------
-- Data for table segu.tclasificador (OID = 307111) (LIMIT 0,4)
------------------------------------
INSERT INTO segu.tclasificador ( codigo, descripcion, prioridad, fecha_reg, estado_reg)
VALUES ('ASE', 'ALTO SECRETO', 1, '2009-01-01', 'activo');

INSERT INTO segu.tclasificador (codigo, descripcion, prioridad, fecha_reg, estado_reg)
VALUES ('SEC', 'SECRETO', 2, '2009-11-02', 'activo');

INSERT INTO segu.tclasificador (codigo, descripcion, prioridad, fecha_reg, estado_reg)
VALUES ('PRI', 'PRIVADA', 4, '2010-08-25', 'activo');

INSERT INTO segu.tclasificador (codigo, descripcion, prioridad, fecha_reg, estado_reg)
VALUES ('PUB', 'PUBLICO', 3, '2010-09-10', 'activo');


------------------------------------------------
-- DDEF DE USUARIO INICIAL ADMINISTRADOR
------------------------------------------------------


INSERT INTO segu.tpersona (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, nombre, apellido_paterno, apellido_materno, ci, correo, celular1, num_documento, telefono1, telefono2, celular2, foto, extension, genero, fecha_nacimiento, direccion)
VALUES (NULL, NULL, NULL, NULL, NULL, 'ADMINISTRADOR', 'DEL SISTEMA', '', '', '', NULL, NULL, NULL, NULL, NULL, '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', 'jpg', NULL, NULL, NULL);

--
-- Data for table segu.tusuario (OID = 305814) (LIMIT 0,1)
--
INSERT INTO segu.tusuario ( id_clasificador, cuenta, contrasena, fecha_caducidad, fecha_reg, estilo, contrasena_anterior, id_persona, estado_reg, autentificacion)
VALUES (1, 'admin', 'admin', '2020-01-31', '2011-05-10', 'xtheme-access.css', 'f1290186a5d0b1ceab27f4e77c0c5d68', 1, 'activo', 'local');

--
-- Data for table segu.trol (OID = 307211) (LIMIT 0,1)
--
INSERT INTO segu.trol (descripcion, fecha_reg, estado_reg, rol, id_subsistema)
VALUES ('Administrador', '2011-05-17', 'activo', 'Administrador', NULL);

--
-- Data for table segu.tusuario_rol (OID = 307268) (LIMIT 0,1)
--
INSERT INTO segu.tusuario_rol (id_rol, id_usuario, fecha_reg, estado_reg)
VALUES (1, 1, '2011-05-17', 'activo');


-------------------------------------
--  DEF DE NUMEROS PRIMOS PARA RSA
-------------------------------


INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1, 961772029);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (2, 961772047);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (3, 961772057);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (4, 961772087);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (5, 961772111);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (6, 961772131);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (7, 961772159);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (8, 961772167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (9, 961772171);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (10, 961772173);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (11, 961772183);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (12, 961772213);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (13, 961772249);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (14, 961772261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (15, 961772281);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (16, 961772309);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (17, 961772323);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (18, 961772341);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (19, 961772351);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (20, 961772401);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (21, 961772417);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (22, 961772429);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (23, 961772431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (24, 961772459);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (25, 961772479);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (26, 961772519);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (27, 961772521);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (28, 961772563);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (29, 961772573);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (30, 961772593);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (31, 961772639);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (32, 961772653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (33, 961772659);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (34, 961772677);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (35, 961772681);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (36, 961772689);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (37, 961772699);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (38, 961772717);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (39, 961772729);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (40, 961772741);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (41, 961772753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (42, 961772759);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (43, 961772839);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (44, 961772863);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (45, 961772869);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (46, 961772879);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (47, 961772897);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (48, 961772921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (49, 961772963);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (50, 961773013);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (51, 961773067);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (52, 961773073);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (53, 961773091);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (54, 961773119);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (55, 961773151);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (56, 961773157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (57, 961773167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (58, 961773199);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (59, 961773223);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (60, 961773247);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (61, 961773251);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (62, 961773271);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (63, 961773277);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (64, 961773287);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (65, 961773289);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (66, 961773299);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (67, 961773347);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (68, 961773353);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (69, 961773377);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (70, 961773383);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (71, 961773403);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (72, 961773443);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (73, 961773473);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (74, 961773479);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (75, 961773493);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (76, 961773499);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (77, 961773529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (78, 961773551);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (79, 961773569);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (80, 961773581);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (81, 961773583);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (82, 961773587);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (83, 961773601);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (84, 961773607);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (85, 961773731);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (86, 961773751);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (87, 961773781);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (88, 961773889);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (89, 961773899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (90, 961773913);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (91, 961773937);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (92, 961773949);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (93, 961774013);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (94, 961774027);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (95, 961774043);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (96, 961774057);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (97, 961774061);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (98, 961774063);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (99, 961774069);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (100, 961774127);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (101, 961774153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (102, 961774157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (103, 961774211);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (104, 961774223);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (105, 961774267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (106, 961774273);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (107, 961774313);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (108, 961774381);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (109, 961774397);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (110, 961774403);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (111, 961774409);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (112, 961774447);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (113, 961774459);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (114, 961774487);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (115, 961774493);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (116, 961774523);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (117, 961774537);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (118, 961774553);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (119, 961774571);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (120, 961774577);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (121, 961774603);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (122, 961774607);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (123, 961774657);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (124, 961774669);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (125, 961774687);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (126, 961774703);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (127, 961774717);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (128, 961774741);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (129, 961774769);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (130, 961774787);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (131, 961774829);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (132, 961774859);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (133, 961774873);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (134, 961774901);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (135, 961774939);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (136, 961774951);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (137, 961774967);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (138, 961774981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (139, 961775011);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (140, 961775063);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (141, 961775081);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (142, 961775099);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (143, 961775123);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (144, 961775179);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (145, 961775197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (146, 961775203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (147, 961775239);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (148, 961775251);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (149, 961775257);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (150, 961775263);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (151, 961775267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (152, 961775293);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (153, 961775317);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (154, 961775359);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (155, 961775369);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (156, 961775377);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (157, 961775387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (158, 961775393);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (159, 961775411);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (160, 961775449);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (161, 961775489);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (162, 961775501);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (163, 961775509);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (164, 961775569);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (165, 961775587);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (166, 961775597);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (167, 961775603);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (168, 961775623);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (169, 961775627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (170, 961775641);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (171, 961775653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (172, 961775671);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (173, 961775677);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (174, 961775693);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (175, 961775701);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (176, 961775707);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (177, 961775747);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (178, 961775753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (179, 961775791);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (180, 961775849);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (181, 961775851);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (182, 961775887);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (183, 961775917);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (184, 961775921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (185, 961775977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (186, 961775987);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (187, 961776061);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (188, 961776091);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (189, 961776131);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (190, 961776133);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (191, 961776157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (192, 961776161);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (193, 961776163);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (194, 961776197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (195, 961776217);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (196, 961776251);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (197, 961776253);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (198, 961776269);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (199, 961776281);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (200, 961776289);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (201, 961776307);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (202, 961776311);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (203, 961776317);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (204, 961776331);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (205, 961776367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (206, 961776379);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (207, 961776383);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (208, 961776419);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (209, 961776421);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (210, 961776443);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (211, 961776449);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (212, 961776469);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (213, 961776481);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (214, 961776521);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (215, 961776559);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (216, 961776587);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (217, 961776593);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (218, 961776617);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (219, 961776659);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (220, 961776667);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (221, 961776689);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (222, 961776703);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (223, 961776709);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (224, 961776727);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (225, 961776749);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (226, 961776791);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (227, 961776799);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (228, 961776847);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (229, 961776857);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (230, 961776919);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (231, 961776943);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (232, 961777021);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (233, 961777043);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (234, 961777067);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (235, 961777079);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (236, 961777109);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (237, 961777111);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (238, 961777123);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (239, 961777129);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (240, 961777151);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (241, 961777153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (242, 961777181);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (243, 961777211);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (244, 961777217);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (245, 961777237);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (246, 961777277);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (247, 961777291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (248, 961777339);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (249, 961777351);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (250, 961777367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (251, 961777381);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (252, 961777391);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (253, 961777417);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (254, 961777441);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (255, 961777451);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (256, 961777459);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (257, 961777493);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (258, 961777507);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (259, 961777529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (260, 961777541);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (261, 961777589);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (262, 961777711);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (263, 961777717);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (264, 961777723);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (265, 961777753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (266, 961777783);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (267, 961777807);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (268, 961777811);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (269, 961777813);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (270, 961777823);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (271, 961777829);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (272, 961777841);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (273, 961777871);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (274, 961777897);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (275, 961777903);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (276, 961777937);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (277, 961777969);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (278, 961777981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (279, 961778023);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (280, 961778087);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (281, 961778093);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (282, 961778101);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (283, 961778137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (284, 961778159);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (285, 961778161);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (286, 961778171);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (287, 961778173);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (288, 961778267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (289, 961778269);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (290, 961778273);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (291, 961778357);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (292, 961778387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (293, 961778429);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (294, 961778453);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (295, 961778471);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (296, 961778473);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (297, 961778483);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (298, 961778509);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (299, 961778527);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (300, 961778563);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (301, 961778581);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (302, 961778593);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (303, 961778599);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (304, 961778659);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (305, 961778681);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (306, 961778693);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (307, 961778717);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (308, 961778743);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (309, 961778749);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (310, 961778761);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (311, 961778773);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (312, 961778789);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (313, 961778801);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (314, 961778827);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (315, 961778837);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (316, 961778843);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (317, 961778891);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (318, 961778897);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (319, 961778899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (320, 961778911);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (321, 961778921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (322, 961778929);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (323, 961778941);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (324, 961778957);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (325, 961778977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (326, 961778989);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (327, 961779011);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (328, 961779043);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (329, 961779197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (330, 961779241);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (331, 961779257);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (332, 961779263);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (333, 961779361);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (334, 961779367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (335, 961779383);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (336, 961779397);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (337, 961779421);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (338, 961779463);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (339, 961779493);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (340, 961779547);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (341, 961779571);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (342, 961779587);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (343, 961779613);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (344, 961779647);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (345, 961779649);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (346, 961779683);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (347, 961779719);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (348, 961779727);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (349, 961779757);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (350, 961779769);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (351, 961779787);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (352, 961779823);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (353, 961779857);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (354, 961779859);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (355, 961779883);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (356, 961779893);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (357, 961779901);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (358, 961779911);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (359, 961779977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (360, 961779997);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (361, 961780007);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (362, 961780031);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (363, 961780069);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (364, 961780073);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (365, 961780081);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (366, 961780087);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (367, 961780153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (368, 961780187);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (369, 961780189);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (370, 961780199);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (371, 961780231);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (372, 961780289);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (373, 961780291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (374, 961780297);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (375, 961780349);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (376, 961780367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (377, 961780373);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (378, 961780387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (379, 961780433);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (380, 961780439);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (381, 961780483);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (382, 961780507);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (383, 961780517);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (384, 961780529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (385, 961780541);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (386, 961780577);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (387, 961780591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (388, 961780607);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (389, 961780619);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (390, 961780637);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (391, 961780639);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (392, 961780643);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (393, 961780649);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (394, 961780663);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (395, 961780669);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (396, 961780709);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (397, 961780711);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (398, 961780723);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (399, 961780733);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (400, 961780739);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (401, 961780769);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (402, 961780777);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (403, 961780789);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (404, 961780823);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (405, 961780837);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (406, 961780847);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (407, 961780867);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (408, 961780879);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (409, 961780907);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (410, 961780951);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (411, 961780987);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (412, 961780991);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (413, 961781003);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (414, 961781017);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (415, 961781021);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (416, 961781039);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (417, 961781053);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (418, 961781063);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (419, 961781077);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (420, 961781131);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (421, 961781147);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (422, 961781153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (423, 961781167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (424, 961781173);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (425, 961781189);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (426, 961781203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (427, 961781207);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (428, 961781213);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (429, 961781251);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (430, 961781263);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (431, 961781279);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (432, 961781281);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (433, 961781291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (434, 961781297);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (435, 961781299);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (436, 961781323);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (437, 961781347);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (438, 961781371);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (439, 961781389);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (440, 961781393);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (441, 961781411);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (442, 961781413);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (443, 961781419);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (444, 961781453);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (445, 961781503);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (446, 961781537);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (447, 961781609);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (448, 961781621);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (449, 961781627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (450, 961781641);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (451, 961781659);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (452, 961781669);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (453, 961781671);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (454, 961781683);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (455, 961781687);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (456, 961781719);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (457, 961781741);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (458, 961781771);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (459, 961781819);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (460, 961781861);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (461, 961781879);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (462, 961781911);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (463, 961781921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (464, 961781923);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (465, 961781939);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (466, 961781941);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (467, 961781963);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (468, 961781983);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (469, 961782023);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (470, 961782047);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (471, 961782061);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (472, 961782067);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (473, 961782079);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (474, 961782097);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (475, 961782139);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (476, 961782167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (477, 961782193);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (478, 961782209);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (479, 961782229);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (480, 961782271);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (481, 961782277);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (482, 961782287);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (483, 961782301);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (484, 961782317);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (485, 961782359);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (486, 961782377);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (487, 961782383);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (488, 961782389);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (489, 961782391);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (490, 961782431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (491, 961782433);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (492, 961782439);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (493, 961782443);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (494, 961782449);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (495, 961782473);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (496, 961782509);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (497, 961782517);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (498, 961782529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (499, 961782539);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (500, 961782583);

--
-- Data for table segu.segu.tprimo (OID = 307189) (LIMIT 500,500)
--
INSERT INTO segu.tprimo (id_primo, numero)
VALUES (501, 961782589);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (502, 961782611);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (503, 961782629);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (504, 961782637);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (505, 961782643);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (506, 961782649);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (507, 961782671);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (508, 961782733);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (509, 961782737);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (510, 961782751);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (511, 961782817);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (512, 961782821);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (513, 961782823);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (514, 961782853);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (515, 961782859);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (516, 961782863);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (517, 961782937);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (518, 961783003);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (519, 961783049);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (520, 961783087);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (521, 961783127);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (522, 961783129);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (523, 961783133);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (524, 961783159);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (525, 961783169);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (526, 961783171);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (527, 961783181);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (528, 961783189);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (529, 961783201);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (530, 961783213);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (531, 961783219);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (532, 961783237);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (533, 961783261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (534, 961783271);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (535, 961783297);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (536, 961783327);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (537, 961783343);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (538, 961783349);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (539, 961783351);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (540, 961783357);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (541, 961783369);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (542, 961783379);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (543, 961783393);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (544, 961783411);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (545, 961783441);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (546, 961783469);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (547, 961783507);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (548, 961783519);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (549, 961783531);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (550, 961783549);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (551, 961783631);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (552, 961783643);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (553, 961783723);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (554, 961783729);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (555, 961783777);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (556, 961783783);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (557, 961783807);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (558, 961783817);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (559, 961783843);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (560, 961783871);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (561, 961783873);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (562, 961783903);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (563, 961783931);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (564, 961783969);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (565, 961783973);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (566, 961783981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (567, 961783987);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (568, 961784017);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (569, 961784051);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (570, 961784071);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (571, 961784137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (572, 961784143);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (573, 961784167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (574, 961784177);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (575, 961784203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (576, 961784227);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (577, 961784267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (578, 961784279);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (579, 961784287);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (580, 961784293);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (581, 961784309);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (582, 961784323);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (583, 961784339);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (584, 961784347);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (585, 961784371);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (586, 961784407);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (587, 961784419);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (588, 961784431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (589, 961784441);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (590, 961784459);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (591, 961784479);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (592, 961784497);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (593, 961784521);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (594, 961784543);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (595, 961784557);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (596, 961784573);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (597, 961784581);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (598, 961784591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (599, 961784599);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (600, 961784627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (601, 961784633);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (602, 961784647);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (603, 961784653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (604, 961784671);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (605, 961784687);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (606, 961784729);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (607, 961784737);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (608, 961784753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (609, 961784773);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (610, 961784777);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (611, 961784833);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (612, 961784849);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (613, 961784861);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (614, 961784869);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (615, 961784881);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (616, 961784899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (617, 961784903);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (618, 961784909);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (619, 961784927);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (620, 961784953);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (621, 961785007);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (622, 961785049);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (623, 961785061);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (624, 961785103);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (625, 961785119);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (626, 961785151);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (627, 961785169);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (628, 961785173);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (629, 961785191);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (630, 961785197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (631, 961785221);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (632, 961785239);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (633, 961785269);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (634, 961785281);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (635, 961785317);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (636, 961785359);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (637, 961785367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (638, 961785379);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (639, 961785427);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (640, 961785431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (641, 961785463);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (642, 961785467);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (643, 961785481);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (644, 961785497);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (645, 961785499);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (646, 961785527);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (647, 961785547);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (648, 961785563);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (649, 961785569);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (650, 961785577);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (651, 961785637);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (652, 961785653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (653, 961785661);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (654, 961785691);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (655, 961785701);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (656, 961785703);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (657, 961785763);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (658, 961785767);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (659, 961785787);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (660, 961785793);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (661, 961785817);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (662, 961785889);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (663, 961785941);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (664, 961785961);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (665, 961785973);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (666, 961785983);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (667, 961785991);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (668, 961785997);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (669, 961786027);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (670, 961786043);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (671, 961786057);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (672, 961786109);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (673, 961786127);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (674, 961786141);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (675, 961786157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (676, 961786187);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (677, 961786261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (678, 961786277);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (679, 961786291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (680, 961786313);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (681, 961786349);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (682, 961786379);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (683, 961786391);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (684, 961786393);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (685, 961786409);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (686, 961786417);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (687, 961786433);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (688, 961786447);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (689, 961786457);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (690, 961786481);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (691, 961786523);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (692, 961786531);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (693, 961786571);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (694, 961786583);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (695, 961786591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (696, 961786627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (697, 961786691);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (698, 961786697);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (699, 961786729);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (700, 961786739);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (701, 961786751);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (702, 961786757);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (703, 961786801);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (704, 961786909);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (705, 961786921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (706, 961786927);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (707, 961786937);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (708, 961786949);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (709, 961786963);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (710, 961786981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (711, 961786993);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (712, 961786999);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (713, 961787017);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (714, 961787027);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (715, 961787051);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (716, 961787089);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (717, 961787137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (718, 961787147);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (719, 961787153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (720, 961787171);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (721, 961787209);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (722, 961787219);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (723, 961787221);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (724, 961787243);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (725, 961787263);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (726, 961787269);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (727, 961787279);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (728, 961787363);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (729, 961787377);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (730, 961787413);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (731, 961787473);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (732, 961787503);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (733, 961787521);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (734, 961787591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (735, 961787609);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (736, 961787641);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (737, 961787647);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (738, 961787653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (739, 961787663);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (740, 961787677);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (741, 961787681);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (742, 961787707);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (743, 961787737);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (744, 961787753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (745, 961787777);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (746, 961787789);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (747, 961787807);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (748, 961787819);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (749, 961787821);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (750, 961787831);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (751, 961787839);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (752, 961787887);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (753, 961787899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (754, 961787917);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (755, 961787933);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (756, 961787947);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (757, 961787977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (758, 961787993);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (759, 961788001);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (760, 961788017);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (761, 961788019);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (762, 961788049);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (763, 961788071);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (764, 961788089);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (765, 961788167);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (766, 961788169);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (767, 961788173);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (768, 961788187);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (769, 961788193);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (770, 961788199);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (771, 961788203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (772, 961788229);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (773, 961788239);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (774, 961788241);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (775, 961788253);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (776, 961788257);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (777, 961788259);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (778, 961788329);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (779, 961788367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (780, 961788371);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (781, 961788409);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (782, 961788431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (783, 961788463);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (784, 961788467);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (785, 961788491);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (786, 961788497);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (787, 961788533);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (788, 961788587);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (789, 961788599);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (790, 961788601);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (791, 961788613);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (792, 961788623);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (793, 961788637);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (794, 961788661);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (795, 961788689);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (796, 961788727);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (797, 961788731);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (798, 961788743);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (799, 961788757);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (800, 961788781);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (801, 961788803);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (802, 961788809);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (803, 961788847);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (804, 961788881);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (805, 961788899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (806, 961788983);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (807, 961789007);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (808, 961789019);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (809, 961789021);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (810, 961789099);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (811, 961789121);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (812, 961789163);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (813, 961789181);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (814, 961789187);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (815, 961789219);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (816, 961789243);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (817, 961789249);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (818, 961789261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (819, 961789289);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (820, 961789313);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (821, 961789319);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (822, 961789327);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (823, 961789337);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (824, 961789343);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (825, 961789351);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (826, 961789363);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (827, 961789391);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (828, 961789393);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (829, 961789417);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (830, 961789429);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (831, 961789441);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (832, 961789453);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (833, 961789469);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (834, 961789483);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (835, 961789537);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (836, 961789567);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (837, 961789571);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (838, 961789579);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (839, 961789583);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (840, 961789613);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (841, 961789627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (842, 961789639);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (843, 961789649);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (844, 961789651);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (845, 961789667);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (846, 961789691);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (847, 961789711);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (848, 961789721);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (849, 961789793);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (850, 961789799);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (851, 961789837);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (852, 961789847);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (853, 961789853);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (854, 961789903);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (855, 961789921);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (856, 961789957);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (857, 961789967);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (858, 961789979);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (859, 961789991);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (860, 961790087);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (861, 961790101);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (862, 961790107);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (863, 961790129);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (864, 961790143);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (865, 961790197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (866, 961790237);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (867, 961790239);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (868, 961790261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (869, 961790267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (870, 961790273);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (871, 961790299);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (872, 961790359);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (873, 961790369);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (874, 961790371);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (875, 961790383);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (876, 961790387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (877, 961790399);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (878, 961790411);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (879, 961790429);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (880, 961790443);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (881, 961790483);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (882, 961790497);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (883, 961790509);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (884, 961790519);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (885, 961790537);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (886, 961790569);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (887, 961790581);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (888, 961790591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (889, 961790633);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (890, 961790663);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (891, 961790671);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (892, 961790677);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (893, 961790719);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (894, 961790857);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (895, 961790867);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (896, 961790873);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (897, 961790891);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (898, 961790897);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (899, 961790899);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (900, 961790911);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (901, 961790957);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (902, 961790971);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (903, 961790981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (904, 961791011);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (905, 961791029);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (906, 961791043);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (907, 961791071);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (908, 961791073);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (909, 961791137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (910, 961791143);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (911, 961791157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (912, 961791163);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (913, 961791169);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (914, 961791197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (915, 961791199);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (916, 961791203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (917, 961791211);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (918, 961791223);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (919, 961791241);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (920, 961791287);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (921, 961791307);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (922, 961791319);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (923, 961791353);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (924, 961791359);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (925, 961791361);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (926, 961791421);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (927, 961791427);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (928, 961791433);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (929, 961791451);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (930, 961791463);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (931, 961791487);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (932, 961791517);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (933, 961791539);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (934, 961791553);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (935, 961791581);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (936, 961791599);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (937, 961791601);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (938, 961791619);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (939, 961791629);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (940, 961791659);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (941, 961791661);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (942, 961791679);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (943, 961791797);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (944, 961791821);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (945, 961791877);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (946, 961791889);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (947, 961791893);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (948, 961791947);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (949, 961791977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (950, 961791979);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (951, 961792003);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (952, 961792031);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (953, 961792033);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (954, 961792159);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (955, 961792177);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (956, 961792207);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (957, 961792213);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (958, 961792229);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (959, 961792241);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (960, 961792261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (961, 961792277);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (962, 961792283);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (963, 961792313);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (964, 961792339);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (965, 961792343);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (966, 961792361);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (967, 961792367);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (968, 961792387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (969, 961792399);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (970, 961792439);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (971, 961792477);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (972, 961792523);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (973, 961792529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (974, 961792543);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (975, 961792549);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (976, 961792583);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (977, 961792589);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (978, 961792591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (979, 961792609);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (980, 961792613);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (981, 961792621);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (982, 961792661);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (983, 961792669);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (984, 961792723);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (985, 961792751);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (986, 961792753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (987, 961792757);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (988, 961792759);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (989, 961792781);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (990, 961792789);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (991, 961792813);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (992, 961792823);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (993, 961792849);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (994, 961792873);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (995, 961792891);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (996, 961792943);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (997, 961792987);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (998, 961792999);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (999, 961793009);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1000, 961793017);

--
-- Data for table segu.segu.tprimo (OID = 307189) (LIMIT 1000,230)
--
INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1001, 961793099);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1002, 961793113);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1003, 961793123);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1004, 961793137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1005, 961793153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1006, 961793159);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1007, 961793171);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1008, 961793221);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1009, 961793237);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1010, 961793249);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1011, 961793267);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1012, 961793269);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1013, 961793291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1014, 961793311);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1015, 961793351);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1016, 961793353);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1017, 961793387);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1018, 961793389);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1019, 961793419);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1020, 961793423);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1021, 961793431);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1022, 961793449);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1023, 961793473);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1024, 961793501);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1025, 961793531);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1026, 961793537);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1027, 961793549);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1028, 961793551);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1029, 961793579);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1030, 961793603);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1031, 961793611);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1032, 961793617);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1033, 961793627);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1034, 961793641);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1035, 961793647);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1036, 961793687);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1037, 961793689);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1038, 961793713);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1039, 961793743);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1040, 961793753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1041, 961793773);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1042, 961793797);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1043, 961793803);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1044, 961793827);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1045, 961793831);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1046, 961793837);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1047, 961793849);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1048, 961793881);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1049, 961793891);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1050, 961793923);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1051, 961793933);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1052, 961793939);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1053, 961793951);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1054, 961793977);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1055, 961793983);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1056, 961793993);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1057, 961794007);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1058, 961794011);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1059, 961794017);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1060, 961794049);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1061, 961794073);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1062, 961794083);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1063, 961794131);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1064, 961794139);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1065, 961794149);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1066, 961794157);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1067, 961794181);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1068, 961794203);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1069, 961794209);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1070, 961794247);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1071, 961794257);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1072, 961794283);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1073, 961794311);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1074, 961794343);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1075, 961794413);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1076, 961794451);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1077, 961794521);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1078, 961794569);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1079, 961794571);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1080, 961794593);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1081, 961794607);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1082, 961794643);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1083, 961794653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1084, 961794683);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1085, 961794689);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1086, 961794707);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1087, 961794709);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1088, 961794719);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1089, 961794721);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1090, 961794727);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1091, 961794731);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1092, 961794751);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1093, 961794781);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1094, 961794797);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1095, 961794833);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1096, 961794853);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1097, 961794881);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1098, 961794923);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1099, 961794943);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1100, 961794961);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1101, 961794971);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1102, 961794973);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1103, 961795013);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1104, 961795019);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1105, 961795069);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1106, 961795099);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1107, 961795123);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1108, 961795189);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1109, 961795193);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1110, 961795199);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1111, 961795223);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1112, 961795249);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1113, 961795253);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1114, 961795259);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1115, 961795283);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1116, 961795291);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1117, 961795297);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1118, 961795327);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1119, 961795337);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1120, 961795339);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1121, 961795361);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1122, 961795363);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1123, 961795369);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1124, 961795381);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1125, 961795397);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1126, 961795423);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1127, 961795441);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1128, 961795453);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1129, 961795487);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1130, 961795493);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1131, 961795517);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1132, 961795529);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1133, 961795543);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1134, 961795559);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1135, 961795591);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1136, 961795609);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1137, 961795613);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1138, 961795619);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1139, 961795631);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1140, 961795633);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1141, 961795651);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1142, 961795657);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1143, 961795673);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1144, 961795687);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1145, 961795699);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1146, 961795727);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1147, 961795763);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1148, 961795829);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1149, 961795867);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1150, 961795873);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1151, 961795883);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1152, 961795897);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1153, 961795907);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1154, 961795931);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1155, 961795943);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1156, 961795957);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1157, 961795963);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1158, 961795981);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1159, 961796009);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1160, 961796023);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1161, 961796041);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1162, 961796057);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1163, 961796123);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1164, 961796137);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1165, 961796149);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1166, 961796153);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1167, 961796219);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1168, 961796237);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1169, 961796257);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1170, 961796261);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1171, 961796279);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1172, 961796293);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1173, 961796371);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1174, 961796377);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1175, 961796401);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1176, 961796413);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1177, 961796453);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1178, 961796501);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1179, 961796519);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1180, 961796551);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1181, 961796617);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1182, 961796621);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1183, 961796653);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1184, 961796657);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1185, 961796677);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1186, 961796711);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1187, 961796723);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1188, 961796741);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1189, 961796753);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1190, 961796761);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1191, 961796789);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1192, 961796791);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1193, 961796809);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1194, 961796831);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1195, 961796837);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1196, 961796839);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1197, 961796851);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1198, 961796881);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1199, 961796887);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1200, 961796909);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1201, 961796933);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1202, 961796951);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1203, 961796971);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1204, 961796987);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1205, 961797007);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1206, 961797013);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1207, 961797029);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1208, 961797037);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1209, 961797059);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1210, 961797071);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1211, 961797077);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1212, 961797079);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1213, 961797107);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1214, 961797121);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1215, 961797139);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1216, 961797149);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1217, 961797197);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1218, 961797217);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1219, 961797247);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1220, 961797283);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1221, 961797293);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1222, 961797299);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1223, 961797301);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1224, 961797323);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1225, 961797329);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1226, 961797341);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1227, 961797349);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1228, 961797379);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1229, 961797401);

INSERT INTO segu.tprimo (id_primo, numero)
VALUES (1230, 961797407);

--
-- Data for sequence segu.primo_id_primo_seq (OID = 307053)
--
SELECT pg_catalog.setval('segu.tprimo_id_primo_seq', 1230, true);

--RAC  5 de noviembre 2012
select pxp.f_insert_tgui ('Alertas', 'Alertas', 'ALERTA', 'si', 9, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 1, '', 'AlarmaFuncionario', 'PXP');
select pxp.f_insert_tgui ('Configurar', 'Configurar', 'CONFIG', 'si', 13, 'sis_seguridad/vista/configurar/Configurar.php', 1, '', 'Configurar', 'PXP');
select pxp.f_insert_testructura_gui ('ALERTA', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CONFIG', 'SISTEMA');



/********************************************F-DAT-RCM-SEGU-0-15/01/2013********************************************/

/********************************************I-DAT-JRR-SEGU-0-02/02/2013**********************************************/
select pxp.f_delete_tgui ('GUISUB');
select pxp.f_delete_tgui ('PROGUI');
select pxp.f_delete_tgui ('funciones');
select pxp.f_delete_tgui ('');
select pxp.f_delete_tgui ('LOG');
/********************************************F-DAT-JRR-SEGU-0-02/02/2013**********************************************/

/********************************************I-DAT-RCM-SEGU-0-17/01/2014**********************************************/
select pxp.f_insert_tgui ('Tablas migradas ENDESIS', 'Listado de las tablas que se migran de ENDESIS', 'TBLMIG', 'si', 3, 'sis_seguridad/vista/tabla_migrar/TablaMigrar.php', 3, '', 'TablaMigrar', 'SEGU');

select pxp.f_insert_testructura_gui ('TBLMIG', 'o');
/********************************************F-DAT-RCM-SEGU-0-17/01/2014**********************************************/

/*******************************************I-DAT-JRR-SEGU-0-25/04/2014***********************************************/

select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'per.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'SEGU');
select pxp.f_insert_tgui ('Personas', 'Personas', 'USUARI.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'SEGU');
select pxp.f_insert_tgui ('Roles', 'Roles', 'USUARI.2', 'no', 0, 'sis_seguridad/vista/usuario_rol/UsuarioRol.php', 4, '', 'usuario_rol', 'SEGU');
select pxp.f_insert_tgui ('EP\', 'EP\', 'USUARI.3', 'no', 0, 'sis_seguridad/vista/usuario_grupo_ep/UsuarioGrupoEp.php', 4, '', ', 
          width:400,
          cls:', 'SEGU');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'USUARI.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'SEGU');
select pxp.f_insert_tgui ('Procedimientos', 'Procedimientos', 'RROOLL.1', 'no', 0, 'sis_seguridad/vista/gui_rol/GuiRol.php', 4, '', 'gui_rol', 'SEGU');
select pxp.f_insert_tgui ('Funcion', 'Funcion', 'SISTEM.1', 'no', 0, 'sis_seguridad/vista/funcion/Funcion.php', 4, '', 'funcion', 'SEGU');
select pxp.f_insert_tgui ('Interfaces', 'Interfaces', 'SISTEM.2', 'no', 0, 'sis_seguridad/vista/gui/Gui.php', 4, '', 'gui', 'SEGU');
select pxp.f_insert_tgui ('Procedimientos', 'Procedimientos', 'SISTEM.1.1', 'no', 0, 'sis_seguridad/vista/procedimiento/Procedimiento.php', 5, '', 'procedimiento', 'SEGU');
select pxp.f_insert_tgui ('Procedimientos', 'Procedimientos', 'SISTEM.2.1', 'no', 0, 'sis_seguridad/vista/procedimiento_gui/ProcedimientoGui.php', 5, '', 'procedimiento_gui', 'SEGU');
select pxp.f_insert_tgui ('Tablas', 'Tablas', 'MONOJBD.1', 'no', 0, 'sis_seguridad/vista/monitor_objetos/MonitorObjetosTabla.php', 6, '', 'monitor_objetos_tabla', 'SEGU');
select pxp.f_insert_tgui ('Funciones', 'Funciones', 'MONOJBD.2', 'no', 0, 'sis_seguridad/vista/monitor_objetos/MonitorObjetosFuncion.php', 6, '', 'monitor_objetos_funcion', 'SEGU');
select pxp.f_insert_tgui ('Indices', 'Indices', 'MONOJBD.1.1', 'no', 0, 'sis_seguridad/vista/monitor_objetos/MonitorObjetosIndice.php', 7, '', 'monitor_objetos_indice', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_ep_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_programa_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_tfuncion', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_trol', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_actividad_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_ep_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_tabla_migrar_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_tabla_migrar_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_programa_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_tprocedimiento', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_tipo_comunicacion_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_trol_procedimiento_gui', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_tipo_comunicacion_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_tgui', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_proyecto_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_tprocedimiento_gui', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_proyecto_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_testructura_gui', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_regional_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_grupo_ep_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_regional_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ftrig_tgui_rol', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_actividad_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_usuario_grupo_ep_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_video_ime', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.ft_video_sel', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tfuncion ('segu.f_insertar_rol_pxp', 'Funcion para tabla     ', 'SEGU');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_ELI', 'Inactiva el subsistema selecionado', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_MOD', 'Modifica el subsistema seleccionada', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_INS', 'Inserta Subsistemas', 'si', '', '', 'segu.ft_subsistema_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_CONT', 'Contar usuarios activos de sistema', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_SEL', 'Listar usuarios activos de sistema', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_VALUSU_SEL', 'consulta los datos del usario segun contrasena y login', 'si', '', '', 'segu.ft_usuario_sel');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_CONT', 'Contar  los subsistemas registrados del sistema', 'si', '', '', 'segu.ft_subsistema_sel');
select pxp.f_insert_tprocedimiento ('SEG_SUBSIS_SEL', 'Listado de los subsistemas registradas del sistema', 'si', '', '', 'segu.ft_subsistema_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_ELI', 'Elimina Procedimiento_Gui', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_MOD', 'Modifica Procedimiento_Gui', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_INS', 'Inserta Procedimiento_Gui', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_CONT', 'Cuenta Procesos por Gui y Rol', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPROLPROGUI_SEL', 'Listado de rol_procedimiento_gui de un subsistema para exportar', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROLPROGUI_SEL', 'Selecciona Procesos por Gui y Rol', 'si', '', '', 'segu.ft_rol_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_CONT', 'cuenta los roles activos que corresponden al usuario', 'si', '', '', 'segu.ft_usuario_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_SEL', 'Lista los roles activos que corresponden al usuario', 'si', '', '', 'segu.ft_usuario_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_MENU_SEL', 'Arma el menu que aparece en la parte izquierda
                de la pantalla del sistema', 'si', '', '', 'segu.ft_menu_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_ELI', 'Elimina Procedimiento', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_MOD', 'Modifica Procedimiento', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_INS', 'Inserta Procedimiento', 'si', '', '', 'segu.ft_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_ELI', 'Eliminar Usuarios', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_MOD', 'Modifica datos de  usuario', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUARI_INS', 'Inserta usuarios', 'si', '', '', 'segu.ft_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_ELI', 'retira  el rol asignado a un uusario', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_MOD', 'modifica roles de usuario', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUROL_INS', 'funcion para insertar usuario', 'si', '', '', 'segu.ft_usuario_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_BLOQUE_CONT', 'Contar registros de bloqueos del sistema', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_BLOQUE_SEL', 'Listado de bloqueos del sistema', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_NOTI_CONT', 'Contar registros de notificaciones de enventos del sistema', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_NOTI_SEL', 'Listado del notificacion de eventos del sistema', 'si', '', '', 'segu.ft_bloqueo_notificacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_CONT', 'Contar las interfaces con privilegios sobre procedimientos', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPGUIROL_SEL', 'Listado de gui_rol de un subsistema para exportar', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_SEL', 'Listado de interfaces con privilegios sobre procedimientos', 'si', '', '', 'segu.ft_gui_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_ELI', 'elimina Rol Procedimiento gui', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_MOD', 'modifica Rol Procedimiento gui', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROLPRO_INS', 'Inserta Rol Procedimiento gui', 'si', '', '', 'segu.ft_rol_procedimiento_ime');
select pxp.f_insert_tprocedimiento ('SEG_SESION_CONT', 'Contar  las sesiones activas en el sistema', 'si', '', '', 'segu.ft_sesion_sel');
select pxp.f_insert_tprocedimiento ('SEG_SESION_SEL', 'Listado de las sesiones activas en el sistema', 'si', '', '', 'segu.ft_sesion_sel');
select pxp.f_insert_tprocedimiento ('SEG_VALUSU_SEG', 'verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion', 'si', '', '', 'segu.ft_validar_usuario_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_CONT', 'Cuenta Estructura dato', 'si', '', '', 'segu.ft_estructura_dato_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_SEL', 'Selecciona Estructura dato', 'si', '', '', 'segu.ft_estructura_dato_sel');
select pxp.f_insert_tprocedimiento ('SG_LIB_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_libreta_her_sel');
select pxp.f_insert_tprocedimiento ('SG_LIB_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_libreta_her_sel');
select pxp.f_insert_tprocedimiento ('SG_LIB_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SG_LIB_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SG_LIB_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_libreta_her_ime');
select pxp.f_insert_tprocedimiento ('SEG_PROCECMB_CONT', 'Cuenta Procedimientos para el listado
                del combo en la vista de procedimiento_gui', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCECMB_SEL', 'Selecciona Procedimientos para el listado
                del combo en la vista de procedimiento_gui', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCE_CONT', 'Cuenta Procedimientos', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCE_SEL', 'Listado de Procedimientos', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_CONT', 'Cuenta Procedimientos para agregar al listado del arbol', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPPROC_SEL', 'Listado de procedimiento de un subsistema para exportar', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROCED_SEL', 'Selecciona Procedimientos para agregar al listado del arbol', 'si', '', '', 'segu.ft_procedimiento_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUI_CONT', 'Listado de guis para sincronizar', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPGUI_SEL', 'Lista de datos para el manual', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUI_SEL', 'Listado de interfaces en formato de arbol', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_ELI', 'Elimina Estructura gui', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_MOD', 'Modifica Estructura gui', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_INS', 'Inserta Estructura gui', 'si', '', '', 'segu.ft_estructura_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_CONT', 'Cuenta Clasificador', 'si', '', '', 'segu.ft_clasificador_sel');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_SEL', 'Selecciona Clasificador', 'si', '', '', 'segu.ft_clasificador_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_CONT', 'Cuenta Estructura gui', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPESTGUI_SEL', 'Listado de estructura_gui de un subsistema para exportar', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTGUI_SEL', 'Selecciona Estructura gui', 'si', '', '', 'segu.ft_estructura_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_CONT', 'Cuenta procedimientos de una interfaz dada', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPPROCGUI_SEL', 'Listado de procedimiento_gui de un subsistema para exportar', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUI_SEL', 'Lista procedimientos de una interfaz dada', 'si', '', '', 'segu.ft_procedimiento_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_SINCFUN_MOD', 'Este proceso busca todas las funciones de base de datos para el esquema seleccionado
                las  introduce en la tabla de fucniones luego revisa el cuerpo de la funcion 
                y saca los codigos de procedimiento y sus descripciones', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_ELI', 'Inactiva las funcion selecionada', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_MOD', 'Modifica la funcion seleccionada', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_INS', 'Inserta Funciones', 'si', '', '', 'segu.ft_funcion_ime');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_CONT', 'Contar  funciones registradas del sistema', 'si', '', '', 'segu.ft_funcion_sel');
select pxp.f_insert_tprocedimiento ('SEG_EXPFUN_SEL', 'Listado de funciones de un subsistema para exportar', 'si', '', '', 'segu.ft_funcion_sel');
select pxp.f_insert_tprocedimiento ('SEG_FUNCIO_SEL', 'Listado de funciones registradas del sistema', 'si', '', '', 'segu.ft_funcion_sel');
select pxp.f_insert_tprocedimiento ('SEG_ROL_SEL', 'Listado de gui_rol de un subsistema para exportar', 'si', '', '', 'segu.ft_rol_sel');
select pxp.f_insert_tprocedimiento ('SEG_TIPDOC_CONT', 'Contar  los procedimeintos de BD registradas del sistema', 'si', '', '', 'segu.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('SEG_TIPDOC_SEL', 'Listado de los procedimientos de BD', 'si', '', '', 'segu.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_ELI', 'Elimina Estructura Dato', 'si', '', '', 'segu.ft_estructura_dato_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_MOD', 'Modifica Estructura Dato', 'si', '', '', 'segu.ft_estructura_dato_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESTDAT_INS', 'Inserta Estructura Dato', 'si', '', '', 'segu.ft_estructura_dato_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_ELI', 'Inactiva la interfaz del arbol seleccionada', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_MOD', 'Modifica la interfaz del arbol seleccionada', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUI_INS', 'Inserta interfaces en el arbol', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUIDD_IME', 'Inserta interfaces en el arbol', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_ELI', 'Elimina Clasificacion', 'si', '', '', 'segu.ft_clasificador_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_MOD', 'Modifica Clasificacion', 'si', '', '', 'segu.ft_clasificador_ime');
select pxp.f_insert_tprocedimiento ('SEG_CLASIF_INS', 'Inserta Actividades', 'si', '', '', 'segu.ft_clasificador_ime');
select pxp.f_insert_tprocedimiento ('SEG_PRIMO_CONT', 'cuenta el listado de numeros primos', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_PRIMO_SEL', 'listado de numeros primo', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_OBTEPRI_SEL', 'Obtienen un numero primo segun indice
                el indice se obtiene en el servidor web randomicamente', 'si', '', '', 'segu.ft_primo_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUIROL_INS', 'Modifica los permisos del un rol ID_ROL sobre un  tipo TIPO', 'si', '', '', 'segu.ft_gui_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROL_ELI', 'Elimina Rol', 'si', '', '', 'segu.ft_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROL_MOD', 'Modifica Rol', 'si', '', '', 'segu.ft_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_ROL_INS', 'Inserta Rol', 'si', '', '', 'segu.ft_rol_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSONMIN_CONT', 'Cuenta Personas con foto', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_PERSONMIN_SEL', 'Selecciona Personas + fotografia', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_CONT', 'Cuenta Personas', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_SEL', 'Selecciona Personas', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGHOR_SEL', 'Contar  los eventos fuera de horario de trabajo', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOG_CONT', 'Lista eventos del sistema sucedidos fuera de horarios de trabajo', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOG_SEL', 'Contar  los eventos del sistema registrados', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGMON_CONT', 'Contar registros del monitor de enventos del sistema(Actualiza eventos de BD)', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_LOGMON_SEL', 'Listado del monitoreo de eventos del  XPH sistema', 'si', '', '', 'segu.ft_log_sel');
select pxp.f_insert_tprocedimiento ('SEG_SESION_MOD', 'Modifica la una variable de sesion', 'si', '', '', 'segu.ft_sesion_ime');
select pxp.f_insert_tprocedimiento ('SEG_SESION_INS', 'registra sesiones  de un usuario', 'si', '', '', 'segu.ft_sesion_ime');
select pxp.f_insert_tprocedimiento ('SEG_MONREC_SEL', 'Monitorear recursos usados por el sistema', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONIND_CONT', 'Contar registros del monitor de objetos de bd (indices)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONIND_SEL', 'Listado de registros del monitor de objetos de bd (Indices)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONFUN_CONT', 'Contar registros del monitor de objetos de bd (funciones)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONFUN_SEL', 'Listado de registros del monitor de objetos de bd (Funciones)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONTAB_CONT', 'Contar registros del monitor de objetos de bd (Tablas)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONTAB_SEL', 'Listado de registros del monitor de objetos de bd (Tablas)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONESQ_CONT', 'Contar registros del monitor de objetos de bd (Esquemas)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_MONESQ_SEL', 'Listado de registros del monitor de objetos de bd (Esquemas)', 'si', '', '', 'segu.ft_monitor_bd_sel');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_ELI', 'Elimina Persona', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_UPFOTOPER_MOD', 'Modifica la foto de la persona', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_MOD', 'Modifica Persona', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SEG_PERSON_INS', 'Inserta Persona', 'si', '', '', 'segu.ft_persona_ime');
select pxp.f_insert_tprocedimiento ('SG_CONF_MOD', 'Configuración de cuenta de usuario', 'si', '', '', 'segu.ft_configurar_ime');
select pxp.f_insert_tprocedimiento ('SEG_ESBLONO_MOD', 'Cambia el estado de notificacion y bloqueos', 'si', '', '', 'segu.ft_bloqueo_notificacion_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUREG_SEL', 'lista las regionales del usuario', 'si', '', '', 'segu.ft_usuario_regional_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUREG_CONT', 'cuenta las regionales del usuario', 'si', '', '', 'segu.ft_usuario_regional_sel');
select pxp.f_insert_tprocedimiento ('SG_ESP_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_ep_ime');
select pxp.f_insert_tprocedimiento ('SG_ESP_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_ep_ime');
select pxp.f_insert_tprocedimiento ('SG_ESP_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_ep_ime');
select pxp.f_insert_tprocedimiento ('SG_PROGRA_INS', 'Inserci?n de registros', 'si', '', '', 'segu.ft_programa_ime');
select pxp.f_insert_tprocedimiento ('SG_PROGRA_MOD', 'Modificaci?n de registros', 'si', '', '', 'segu.ft_programa_ime');
select pxp.f_insert_tprocedimiento ('SG_PROGRA_ELI', 'Eliminaci?n de registros', 'si', '', '', 'segu.ft_programa_ime');
select pxp.f_insert_tprocedimiento ('SEG_GUISINC_IME', 'Inserta una interfaz desde la utilidad de soncronizacion', 'si', '', '', 'segu.ft_gui_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUACT_SEL', 'lista las actividades por usuario', 'si', '', '', 'segu.ft_usuario_actividad_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUACT_CONT', 'Contar  las actividades por usuario', 'si', '', '', 'segu.ft_usuario_actividad_sel');
select pxp.f_insert_tprocedimiento ('SG_ACT_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('SG_ACT_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_actividad_sel');
select pxp.f_insert_tprocedimiento ('SG_ESP_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_ep_sel');
select pxp.f_insert_tprocedimiento ('SG_ESP_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_ep_sel');
select pxp.f_insert_tprocedimiento ('SG_TBLMIG_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_tabla_migrar_ime');
select pxp.f_insert_tprocedimiento ('SG_TBLMIG_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_tabla_migrar_ime');
select pxp.f_insert_tprocedimiento ('SG_TBLMIG_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_tabla_migrar_ime');
select pxp.f_insert_tprocedimiento ('SEG_OPERFOT_SEL', 'Selecciona Personas + fotografia', 'si', '', '', 'segu.ft_persona_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUACT_INS', 'Relaciona actividades con usuario', 'si', '', '', 'segu.ft_usuario_actividad_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUACT_MOD', 'Modifica la relacion de  actividades con usuario', 'si', '', '', 'segu.ft_usuario_actividad_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUACT_ELI', 'Inactivacion de la relacion de  actividades con usuario', 'si', '', '', 'segu.ft_usuario_actividad_ime');
select pxp.f_insert_tprocedimiento ('SG_TBLMIG_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_tabla_migrar_sel');
select pxp.f_insert_tprocedimiento ('SG_TBLMIG_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_tabla_migrar_sel');
select pxp.f_insert_tprocedimiento ('SG_PROGRA_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_programa_sel');
select pxp.f_insert_tprocedimiento ('SG_PROGRA_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_programa_sel');
select pxp.f_insert_tprocedimiento ('SG_TICOM_SEL', 'Consulta de datos', 'si', '', '', 'segu.f_tipo_comunicacion_sel');
select pxp.f_insert_tprocedimiento ('SG_TICOM_CONT', 'Conteo de registros', 'si', '', '', 'segu.f_tipo_comunicacion_sel');
select pxp.f_insert_tprocedimiento ('SEG_PROGUISINC_MOD', 'Sincroniza la relacion de las transacciones con las interfaces', 'si', '', '', 'segu.ft_procedimiento_gui_ime');
select pxp.f_insert_tprocedimiento ('SG_TICOM_INS', 'Insercion de registros', 'si', '', '', 'segu.f_tipo_comunicacion_ime');
select pxp.f_insert_tprocedimiento ('SG_TICOM_MOD', 'Modificacion de registros', 'si', '', '', 'segu.f_tipo_comunicacion_ime');
select pxp.f_insert_tprocedimiento ('SG_TICOM_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.f_tipo_comunicacion_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUPRO_SEL', 'lista las proyectos por usuario', 'si', '', '', 'segu.ft_usuario_proyecto_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUPRO_CONT', 'contar proyectos por usuario', 'si', '', '', 'segu.ft_usuario_proyecto_sel');
select pxp.f_insert_tprocedimiento ('SG_PROY_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_proyecto_sel');
select pxp.f_insert_tprocedimiento ('SG_PROY_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_proyecto_sel');
select pxp.f_insert_tprocedimiento ('SEG_GETGUI_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_GUISINC_SEL', 'Listado de guis de un subsistema para exportar', 'si', '', '', 'segu.ft_gui_sel');
select pxp.f_insert_tprocedimiento ('SEG_USUPRO_INS', 'Relaciona proyectos con usuario', 'si', '', '', 'segu.ft_usuario_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUPRO_MOD', 'Modifica la relacion de proyectos con usuario', 'si', '', '', 'segu.ft_usuario_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUPRO_ELI', 'Inactiva la relacion de proyectos con usuario', 'si', '', '', 'segu.ft_usuario_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUREG_INS', 'Relaciona una regional al usuario', 'si', '', '', 'segu.ft_usuario_regional_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUREG_MOD', 'Modifica la relacion una regional y un  usuario', 'si', '', '', 'segu.ft_usuario_regional_ime');
select pxp.f_insert_tprocedimiento ('SEG_USUREG_ELI', 'Inactiva la relacion de una regional y un  usuario', 'si', '', '', 'segu.ft_usuario_regional_ime');
select pxp.f_insert_tprocedimiento ('SG_PROY_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SG_PROY_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SG_PROY_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_proyecto_ime');
select pxp.f_insert_tprocedimiento ('SEG_REGION_INS', 'Inserta Regional', 'si', '', '', 'segu.ft_regional_ime');
select pxp.f_insert_tprocedimiento ('SEG_REGION_MOD', 'Modifica Regional', 'si', '', '', 'segu.ft_regional_ime');
select pxp.f_insert_tprocedimiento ('SEG_REGION_ELI', 'Elimina Regional', 'si', '', '', 'segu.ft_regional_ime');
select pxp.f_insert_tprocedimiento ('SG_UEP_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_usuario_grupo_ep_sel');
select pxp.f_insert_tprocedimiento ('SG_UEP_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_usuario_grupo_ep_sel');
select pxp.f_insert_tprocedimiento ('SG_ACT_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('SG_ACT_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('SG_ACT_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_actividad_ime');
select pxp.f_insert_tprocedimiento ('SEG_EXPROL_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_rol_sel');
select pxp.f_insert_tprocedimiento ('SG_UEP_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_usuario_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('SG_UEP_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_usuario_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('SG_UEP_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_usuario_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('SEG_LISTUSU_SEG', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'segu.ft_validar_usuario_ime');
select pxp.f_insert_tprocedimiento ('SG_TUTO_INS', 'Insercion de registros', 'si', '', '', 'segu.ft_video_ime');
select pxp.f_insert_tprocedimiento ('SG_TUTO_MOD', 'Modificacion de registros', 'si', '', '', 'segu.ft_video_ime');
select pxp.f_insert_tprocedimiento ('SG_TUTO_ELI', 'Eliminacion de registros', 'si', '', '', 'segu.ft_video_ime');
select pxp.f_insert_tprocedimiento ('SG_TUTO_SEL', 'Consulta de datos', 'si', '', '', 'segu.ft_video_sel');
select pxp.f_insert_tprocedimiento ('SG_TUTO_CONT', 'Conteo de registros', 'si', '', '', 'segu.ft_video_sel');

select pxp.f_insert_trol ('PXP-Rol inicial', 'PXP-Rol inicial', 'PXP');

/*******************************************F-DAT-JRR-SEGU-0-25/04/2014***********************************************/

/*******************************************I-DAT-RAC-SEGU-0-25/05/2017***********************************************/

select pxp.f_insert_tgui ('<i class="fa fa-users fa-2x"></i> SEGURIDAD', 'Seguridad', 'SEGU', 'si', 1, '', 1, '', 'Seguridad', 'SEGU');

/*******************************************F-DAT-RAC-SEGU-0-25/05/2017***********************************************/





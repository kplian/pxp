
/***********************************I-DAT-RAC-PARAM-0-31/12/2012*****************************************/

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

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('PARAM', 'Parametros Generales', '2009-11-02', 'PM', 'activo', 'parametros', NULL);

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('PARAM', 'Parametros Generales', 'PARAM', 'si', 2, '', 1, '../../../lib/imagenes/param32x32.png', 'Sistema de Parametros', 'PARAM');
select pxp.f_insert_tgui ('Alarmas', 'Para programar las alarmas', 'ALARM', 'si', 1, 'sis_parametros/vista/alarma/Alarma.php', 2, '', 'Alarma', 'PARAM');
select pxp.f_insert_tgui ('Departamentos', 'Departamentos', 'DEPTO', 'si', 3, 'sis_parametros/vista/depto/Depto.php', 2, '', 'Depto', 'PARAM');
select pxp.f_insert_tgui ('Lugar', 'Lugar', 'LUG', 'si', 4, 'sis_parametros/vista/lugar/Lugar.php', 2, '', 'Lugar', 'PARAM');
select pxp.f_insert_tgui ('Institucion', 'Detalle de instituciones', 'INSTIT', 'si', 5, 'sis_parametros/vista/institucion/Institucion.php', 2, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Proyecto EP', 'Proyecto EP proviene de ENDESIS', 'PRO', 'si', 5, 'sis_parametros/vista/proyecto/Proyecto.php', 2, '', 'Proyecto', 'PARAM');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'PROVEE', 'si', 5, 'sis_parametros/vista/proveedor/Proveedor.php', 2, '', 'proveedor', 'PARAM');
select pxp.f_insert_tgui ('Documentos', 'Documentos por Sistema', 'DOCUME', 'si', 4, 'sis_parametros/vista/documento/Documento.php', 2, '', 'Documento', 'PARAM');
select pxp.f_insert_tgui ('Configuracion Alarmas', 'Para configurar las alarmas', 'CONALA', 'si', 1, 'sis_parametros/vista/config_alarma/ConfigAlarma.php', 2, '', 'ConfigAlarma', 'PARAM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Registro de Unidades de Medida', 'UME', 'si', 10, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 2, '', 'UnidadMedida', 'PARAM');
select pxp.f_insert_tgui ('Gestion', 'Manejo de gestiones', 'GESTIO', 'si', 1, 'sis_parametros/vista/gestion/Gestion.php', 2, '', 'Gestion', 'PARAM');

select pxp.f_insert_tgui ('Catalogo', 'Catalogo', 'CATA', 'si', 4, 'sis_parametros/vista/catalogo/Catalogo.php', 2, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERIOD', 'si', 2, 'sis_parametros/vista/periodo/Periodo.php', 2, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('Moneda', 'Monedas', 'MONPAR', 'si', 3, 'sis_parametros/vista/moneda/Moneda.php', 2, '', 'Moneda', 'PARAM');
select pxp.f_insert_tgui ('Tipos de Catálogos', 'Tipos de Catálogos', 'PACATI', 'si', 11, 'sis_parametros/vista/catalogo_tipo/CatalogoTipo.php', 2, '', 'CatalogoTipo', 'PARAM');
select pxp.f_insert_tgui ('Servicios', 'Para registro de los servicios', 'SERVIC', 'si', 1, 'sis_parametros/vista/servicio/Servicio.php', 2, '', 'Servicio', 'PARAM');
select pxp.f_insert_tgui ('EP', 'Elementos de la Estructura Programatica', 'CEP', 'si', 1, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Compras', 'Parametrizaciones re lacionadas con compras', 'CCOM', 'si', 2, '', 3, '', '', 'PARAM');
select pxp.f_insert_tgui ('Aprobadores', 'Aprobadores de Compras', 'APROC', 'si', 1, 'sis_parametros/vista/aprobador/Aprobador.php', 4, '', 'Aprobador', 'PARAM');
select pxp.f_insert_tgui ('Financiador', 'Financiadores de Compras', 'FIN', 'si', 1, 'sis_parametros/vista/financiador/Financiador.php', 3, '', 'Financiador', 'PARAM');
select pxp.f_insert_tgui ('Regional', 'Regionales de Compras', 'REGIO', 'si', 2, 'sis_parametros/vista/regional/Regional.php', 3, '', 'Regional', 'PARAM');
select pxp.f_insert_tgui ('Programa', 'Programas de Compras', 'PROG', 'si', 3, 'sis_parametros/vista/programa/Programa.php', 3, '', 'Programa', 'PARAM');
select pxp.f_insert_tgui ('Actividad', 'Actividad', 'ACT', 'si', 5, 'sis_parametros/vista/actividad/Actividad.php', 3, '', 'Actividad', 'PARAM');
select pxp.f_insert_tgui ('Programa-Proyecto-Actividad', 'programa proyecto actividad', 'PPA', 'si', 6, 'sis_parametros/vista/programa_proyecto_acttividad/ProgramaProyectoActtividad.php', 3, '', 'ProgramaProyectoActtividad', 'PARAM');
select pxp.f_insert_tgui ('Proyecto', 'Proyecto EP proviene de ENDESIS', 'PRO', 'si', 5, 'sis_parametros/vista/proyecto/Proyecto.php', 2, '', 'Proyecto', 'PARAM');
select pxp.f_insert_tgui ('Financiador-Regional-Programa-Proyecto', 'financiadores Regionales Programas Proyectos', 'FRPP', 'si', 7, 'sis_parametros/vista/ep/Ep.php', 3, '', 'Ep', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_moneda_base', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tdepto_usuario_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_proveedor_item_servicio_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_catalogo_tipo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tproveedor_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tpm_proyecto_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_unidad_medida_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_config_alarma_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_periodo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_catalogo_tipo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_config_alarma_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_institucion_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_unidad_medida_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_catalogo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_dispara_alarma_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_convertir_moneda', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_catalogo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_proveedor_item_servicio_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_servicio_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_gestion_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tpm_proyecto_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_lugar_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_documento_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_institucion_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_periodo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_gestion_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_moneda_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_dispara_alarma_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_inserta_alarma', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_obtener_correlativo', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tproveedor_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_servicio_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_documento_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_alarma_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_alarma_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_lugar_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_obtener_padre_lugar', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_moneda_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tdepto_usuario_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_financiador_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_financiador_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_regional_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_regional_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_programa_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_programa_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_actividad_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_actividad_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_programa_proyecto_acttividad_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_programa_proyecto_acttividad_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_proyecto_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_proyecto_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_ep_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_ep_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_INS', 'Insercion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_PERIOD_INS', 'Inserta Funciones', 'si', '', '', 'param.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_PERIOD_MOD', 'Modifica la periodo seleccionada', 'si', '', '', 'param.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_PERIOD_ELI', 'Inactiva la periodo selecionada', 'si', '', '', 'param.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_GESTIO_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_gestion_sel');
select pxp.f_insert_tprocedimiento ('PM_GESTIO_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_gestion_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.f_moneda_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.f_moneda_sel');
select pxp.f_insert_tprocedimiento ('PM_DISALARM_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_dispara_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_DISALARM_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_dispara_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEEV_SEL', 'Consulta de datos de proveedores a partir de una vista de base de datos', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEEV_CONT', 'Conteo de registros de proveedores en la vista vproveedor', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_SEL', 'Consulta de datos', 'si', '', '', 'param.f_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_CONT', 'Conteo de registros', 'si', '', '', 'param.f_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_SEL', 'Listado de documentos', 'si', '', '', 'param.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_INS', 'Insercion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARM_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_DESCCOR_MOD', 'DEsactiva envio de correos', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARM_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARMCOR_SEL', 'Consulta de alarmas pendientes de envio de correo no se utiliza con pagiancion', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_PEND', 'Cuenta cuantas alarmas tiene pendientes el funcionario', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_ARB_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_INS', 'Inserta Funciones', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_MOD', 'Modifica la moneda seleccionada', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_ELI', 'Inactiva la moneda selecionada', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tdepto_usuario_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tdepto_usuario_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_INS', 'Insercion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_INS', 'Insercion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_INS', 'Insercion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_INS', 'Insercion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tpm_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PRO_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tpm_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_SEL', 'Consulta de datos', 'si', '', '', 'param.f_unidad_medida_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_CONT', 'Conteo de registros', 'si', '', '', 'param.f_unidad_medida_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_INS', 'Insercion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CONALA_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CONALA_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_PERIOD_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_periodo_sel');
select pxp.f_insert_tprocedimiento ('PM_PERIOD_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_periodo_sel');
select pxp.f_insert_tprocedimiento ('PM_PACATI_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_catalogo_tipo_sel');
select pxp.f_insert_tprocedimiento ('PM_PACATI_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_tipo_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALATABLA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALATABLA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_institucion_sel');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_institucion_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_INS', 'Insercion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_UME_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_UME_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CAT_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CATCMB_SEL', 'Listado de los catálogos para combos', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CATCMB_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_GENALA_INS', 'Revisa alaramas del sistema SAJ', 'si', '', '', 'param.ft_dispara_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_INS', 'Insercion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_SEL', 'Consulta de datos', 'si', '', '', 'param.f_proveedor_item_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_CONT', 'Conteo de registros', 'si', '', '', 'param.f_proveedor_item_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_INS', 'Insercion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_GESTIO_INS', 'Inserta Funciones', 'si', '', '', 'param.ft_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GESTIO_MOD', 'Modifica la gestion seleccionada', 'si', '', '', 'param.ft_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GESTIO_ELI', 'Inactiva la gestion selecionada', 'si', '', '', 'param.ft_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_INS', 'Insercion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_INS', 'Insercion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_INS', 'Inserta Documentos', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_MOD', 'Modifica la documento seleccionada', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_ELI', 'Inactiva el documento selecionado', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_SEL', 'Consulta de datos', 'si', '', '', 'param.f_financiador_sel');
select pxp.f_insert_tprocedimiento ('PM_fin_CONT', 'Conteo de registros', 'si', '', '', 'param.f_financiador_sel');
select pxp.f_insert_tprocedimiento ('PM_fin_INS', 'Insercion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_SEL', 'Consulta de datos', 'si', '', '', 'param.f_regional_sel');
select pxp.f_insert_tprocedimiento ('PM_REGIO_CONT', 'Conteo de registros', 'si', '', '', 'param.f_regional_sel');
select pxp.f_insert_tprocedimiento ('PM_REGIO_INS', 'Insercion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_INS', 'Insercion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_SEL', 'Consulta de datos', 'si', '', '', 'param.f_programa_sel');
select pxp.f_insert_tprocedimiento ('PM_PROG_CONT', 'Conteo de registros', 'si', '', '', 'param.f_programa_sel');
select pxp.f_insert_tprocedimiento ('PM_ACT_INS', 'Insercion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_SEL', 'Consulta de datos', 'si', '', '', 'param.f_actividad_sel');
select pxp.f_insert_tprocedimiento ('PM_ACT_CONT', 'Conteo de registros', 'si', '', '', 'param.f_actividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PPA_INS', 'Insercion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_SEL', 'Consulta de datos', 'si', '', '', 'param.f_programa_proyecto_acttividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PPA_CONT', 'Conteo de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_SEL', 'Consulta de datos', 'si', '', '', 'param.f_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_CONT', 'Conteo de registros', 'si', '', '', 'param.f_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_INS', 'Insercion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PROY_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PROY_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_INS', 'Insercion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_SEL', 'Consulta de datos', 'si', '', '', 'param.f_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_FRPP_CONT', 'Conteo de registros', 'si', '', '', 'param.f_ep_sel');
---------------------------------
--COPY LINES TO dependencies.sql FILE 
---------------------------------

select pxp.f_insert_testructura_gui ('PARAM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CCOM', 'PARAM');
select pxp.f_insert_testructura_gui ('CEP', 'PARAM');
select pxp.f_insert_testructura_gui ('CONALA', 'PARAM');
select pxp.f_insert_testructura_gui ('DOCUME', 'PARAM');
select pxp.f_insert_testructura_gui ('DEPTO', 'PARAM');
select pxp.f_insert_testructura_gui ('ALARM', 'PARAM');
select pxp.f_insert_testructura_gui ('PROVEE', 'PARAM');
select pxp.f_insert_testructura_gui ('INSTIT', 'PARAM');
select pxp.f_insert_testructura_gui ('LUG', 'PARAM');
select pxp.f_insert_testructura_gui ('MONPAR', 'PARAM');
select pxp.f_insert_testructura_gui ('PERIOD', 'PARAM');
select pxp.f_insert_testructura_gui ('CATA', 'PARAM');
select pxp.f_insert_testructura_gui ('GESTIO', 'PARAM');
select pxp.f_insert_testructura_gui ('UME', 'PARAM');
select pxp.f_insert_testructura_gui ('PACATI', 'PARAM');
select pxp.f_insert_testructura_gui ('SERVIC', 'PARAM');
select pxp.f_insert_testructura_gui ('APROC', 'CCOM');
select pxp.f_insert_testructura_gui ('PRO', 'CEP');
select pxp.f_insert_testructura_gui ('FIN', 'CEP');
select pxp.f_insert_testructura_gui ('REGIO', 'CEP');
select pxp.f_insert_testructura_gui ('PROG', 'CEP');
select pxp.f_insert_testructura_gui ('ACT', 'CEP');
select pxp.f_insert_testructura_gui ('PPA', 'CEP');
select pxp.f_insert_testructura_gui ('FRPP', 'CEP');
/***********************************F-DAT-RAC-PARAM-0-31/12/2012*****************************************/

/***********************************I-DAT-RCM-PARAM-0-23/01/2013*****************************************/
--Catálogos
select pxp.f_add_catalog('PARAM','tunidad_medida','Longitud');
select pxp.f_add_catalog('PARAM','tunidad_medida','Masa');
select pxp.f_add_catalog('PARAM','tunidad_medida','Tiempo');
select pxp.f_add_catalog('PARAM','tunidad_medida','Intensidad eléctrica');
select pxp.f_add_catalog('PARAM','tunidad_medida','Temperatura');
select pxp.f_add_catalog('PARAM','tunidad_medida','Intensidad luminosa');
select pxp.f_add_catalog('PARAM','tunidad_medida','Cantidad de sustancia');
/***********************************F-DAT-RCM-PARAM-0-23/01/2013*****************************************/


/***********************************I-DAT-RAC-PARAM-0-04/02/2013*****************************************/


select pxp.f_insert_tgui ('Empresa', 'Empresa', 'EMP', 'si', 1, 'sis_parametros/vista/empresa/Empresa.php', 2, '', 'Empresa', 'PARAM');

select pxp.f_insert_testructura_gui ('EMP', 'PARAM');

select pxp.f_insert_tgui ('Concepto de Ingreso/Gasto', 'Parametrizaciond e concepto de gasto o ingreso', 'CONIG', 'si', 2, 'sis_parametros/vista/concepto_ingas/ConceptoIngas.php', 4, '', 'ConceptoIngas', 'PARAM');

select pxp.f_insert_testructura_gui ('CONIG', 'CCOM');

/***********************************F-DAT-RAC-PARAM-0-04/02/2013*****************************************/

/***********************************I-DAT-GSS-PARAM-38-18/02/2013*****************************************/

select pxp.f_insert_tgui ('Centro de Costo', 'Centro de costo', 'CCOST', 'si', 1, 'sis_parametros/vista/centro_costo/CentroCosto.php', 2, '', 'CentroCosto', 'PARAM');

select pxp.f_insert_testructura_gui ('CCOST', 'PARAM');

/***********************************F-DAT-GSS-PARAM-38-18/02/2013*****************************************/

/***********************************I-DAT-GSS-PARAM-72-08/03/2013*****************************************/

select pxp.f_insert_tgui ('Tipo de Cambio', 'tipo de cambio', 'TCB', 'si', 10, 'sis_parametros/vista/tipo_cambio/TipoCambio.php', 2, '', 'TipoCambio', 'PARAM');

select pxp.f_insert_testructura_gui ('TCB', 'PARAM');

/***********************************F-DAT-GSS-PARAM-72-08/03/2013*****************************************/

/***********************************I-DAT-GSS-PARAM-81-26/03/2013*****************************************/

--funciones
select pxp.f_insert_tfuncion ('param.f_gestion_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_aprobadores_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_centro_costo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_concepto_ingas_sel', 'Funcion para tabla     ', 'PARAM');

--procedimientos

select pxp.f_insert_tprocedimiento ('PM_GES_INS', 'Insercion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GES_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GES_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GETGES_ELI', 'Recuepra el id_gestion segun la fecha', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_SEL', 'Listado de departamento', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_CONT', 'cuenta la cantidad de departamentos', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_OBTARPOBA_SEL', 'Listado de aprobadores filtradao segun criterio de configuracion', 'si', '', '', 'param.f_aprobadores_sel');
select pxp.f_insert_tprocedimiento ('PM_CEC_SEL', 'Consulta de datos', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CEC_CONT', 'Conteo de registros', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIG_SEL', 'Consulta de datos', 'si', '', '', 'param.f_concepto_ingas_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIG_CONT', 'Conteo de registros', 'si', '', '', 'param.f_concepto_ingas_sel');

/***********************************F-DAT-GSS-PARAM-81-26/03/2013*****************************************/


/***********************************I-DAT-JRR-PARAM-104-05/04/2013*****************************************/

select pxp.f_insert_tgui ('Asistentes', 'Asistentes', 'ASI', 'si', 4, 'sis_parametros/vista/asistente/Asistente.php', 2, '', 'Asistente', 'PARAM');
select pxp.f_insert_testructura_gui ('ASI', 'PARAM');

/***********************************F-DAT-JRR-PARAM-104-05/04/2013*****************************************/

/***********************************I-DAT-RCM-PARAM-85-03/04/2013*****************************************/
select pxp.f_insert_tgui ('Documentos Fiscales', 'Listado de todos los Documentos fiscales', 'DF', 'si', 11, 'sis_parametros/vista/documento_fiscal/DocumentoFiscal.php', 2, '', 'DocumentoFiscal', 'PARAM');
select pxp.f_insert_testructura_gui ('DF', 'PARAM');
/***********************************F-DAT-RCM-PARAM-85-03/04/2013*****************************************/


/***********************************I-DAT-RCM-PARAM-85-05/04/2013*****************************************/
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Incompleto');
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Completo');
select pxp.f_add_catalog('PARAM','tdocumento_fiscal__estado','Anulado');
select pxp.f_insert_tgui ('Plantillas', 'Plantillas', 'PLANT', 'si', 1, 'sis_parametros/vista/plantilla/Plantilla.php', 2, '', 'Plantilla', 'PARAM');
select pxp.f_insert_testructura_gui ('PLANT', 'PARAM');

/***********************************F-DAT-RCM-PARAM-85-05/04/2013*****************************************/

/***********************************I-DAT-GSS-PARAM-101-22/04/2013*****************************************/

select pxp.f_insert_tfuncion ('param.f_plantilla_sel', 'Funcion para tabla     ', 'PARAM');

select pxp.f_insert_tprocedimiento ('PM_PLT_CONT', 'Conteo de registros', 'si', '', '', 'param.f_plantilla_sel');
select pxp.f_insert_tprocedimiento ('PM_PLT_SEL', 'Consulta de datos', 'si', '', '', 'param.f_plantilla_sel');

/***********************************F-DAT-GSS-PARAM-101-22/04/2013*****************************************/

/***********************************I-DAT-AAO-PARAM-72-23/04/2013*****************************************/
select pxp.f_insert_tgui ('Usuarios por Departamento', 'Usuarios por Departamento', 'DEPTO.1', 'no', 0, 'sis_parametros/vista/depto_usuario/DeptoUsuario.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Usuarios', 'Usuarios', 'DEPTO.1.1', 'no', 0, 'sis_seguridad/vista/usuario/Usuario.php', 4, '', 'usuario', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'DEPTO.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'DEPTO.1.1.2', 'no', 0, 'sis_seguridad/vista/usuario_rol/UsuarioRol.php', 5, '', 'usuario_rol', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'DEPTO.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 6, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Ubicacion Lugar', 'Ubicacion Lugar', 'LUG.1', 'no', 0, 'sis_parametros/vista/lugar/mapaLugar.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Items/Servicios ofertados', 'Items/Servicios ofertados', 'PROVEE.1', 'no', 0, 'sis_parametros/vista/proveedor_item_servicio/ProveedorItemServicio.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodos', 'Periodos', 'GESTIO.1', 'no', 0, 'sis_parametros/vista/periodo/Periodo.php', 3, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('subir Logo', 'subir Logo', 'EMP.1', 'no', 0, 'sis_parametros/vista/empresa/subirLogo.php', 3, '', 'subirLogo', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_documento_fiscal_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_periodo_subsistema_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_aprobador_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_concepto_ingas_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_ep_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_asistente_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_centro_costo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_aprobador_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_inserta_documento', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_uo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_periodo_subsistema_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_periodo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_documento_fiscal_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_obtener_listado_aprobadores', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_gestion_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_empresa_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_ep_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tipo_cambio_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_tipo_cambio_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_empresa_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_plantilla_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_uo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_datos_proveedor', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_periodo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_asistente_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_INS', 'Insercion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_institucion_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_SEL', 'Consulta de datos', 'si', '', '', 'param.f_moneda_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_CONT', 'Conteo de registros', 'si', '', '', 'param.f_moneda_sel');
select pxp.f_insert_tprocedimiento ('PM_DISALARM_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_dispara_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_DISALARM_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_dispara_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEEV_SEL', 'Consulta de datos de proveedores a partir de una vista de base
                    de datos', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_PROVEEV_CONT', 'Conteo de registros de proveedores en la vista vproveedor', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_SEL', 'Consulta de datos', 'si', '', '', 'param.f_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_CONT', 'Conteo de registros', 'si', '', '', 'param.f_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_SEL', 'Listado de documentos', 'si', '', '', 'param.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_documento_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_INS', 'Insercion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARM_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_DESCCOR_MOD', 'DEsactiva envio de correos', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARM_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_ALARMCOR_SEL', 'Consulta de alarmas pendientes de envio de correo no se utiliza con pagiancion', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_PEND', 'Cuenta cuantas alarmas tiene pendientes el funcionario', 'si', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_ARB_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_LUG_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_lugar_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_INS', 'Insercion de registros', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tdepto_usuario_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tdepto_usuario_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_INS', 'Insercion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUSU_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tdepto_usuario_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_INS', 'Insercion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_proveedor_item_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_INS', 'Insercion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_catalogo_tipo_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_INS', 'Insercion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PROVEE_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tproveedor_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tpm_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PRO_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tpm_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_SEL', 'Consulta de datos', 'si', '', '', 'param.f_unidad_medida_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_CONT', 'Conteo de registros', 'si', '', '', 'param.f_unidad_medida_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_INS', 'Insercion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CONALA_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CONALA_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_config_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_PACATI_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_catalogo_tipo_sel');
select pxp.f_insert_tprocedimiento ('PM_PACATI_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_tipo_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_CONALA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALATABLA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALATABLA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_config_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_institucion_sel');
select pxp.f_insert_tprocedimiento ('PM_INSTIT_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_institucion_sel');
select pxp.f_insert_tprocedimiento ('PM_UME_INS', 'Insercion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_UME_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_UME_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_unidad_medida_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CAT_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CATCMB_SEL', 'Listado de los catálogos para combos', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_CATCMB_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_catalogo_sel');
select pxp.f_insert_tprocedimiento ('PM_GENALA_INS', 'Revisa alaramas del sistema SAJ', 'si', '', '', 'param.ft_dispara_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_INS', 'Insercion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_CAT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_catalogo_ime');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_SEL', 'Consulta de datos', 'si', '', '', 'param.f_proveedor_item_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_PRITSE_CONT', 'Conteo de registros', 'si', '', '', 'param.f_proveedor_item_servicio_sel');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_INS', 'Insercion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_SERVIC_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_servicio_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_INS', 'Insercion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PRO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tpm_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_INS', 'Insercion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_LUG_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_lugar_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_INS', 'Inserta Documentos', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_MOD', 'Modifica la documento seleccionada', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCUME_ELI', 'Inactiva el documento selecionado', 'si', '', '', 'param.ft_documento_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_SEL', 'Consulta de datos', 'si', '', '', 'param.f_financiador_sel');
select pxp.f_insert_tprocedimiento ('PM_fin_CONT', 'Conteo de registros', 'si', '', '', 'param.f_financiador_sel');
select pxp.f_insert_tprocedimiento ('PM_fin_INS', 'Insercion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_fin_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_financiador_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_SEL', 'Consulta de datos', 'si', '', '', 'param.f_regional_sel');
select pxp.f_insert_tprocedimiento ('PM_REGIO_CONT', 'Conteo de registros', 'si', '', '', 'param.f_regional_sel');
select pxp.f_insert_tprocedimiento ('PM_REGIO_INS', 'Insercion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_REGIO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_regional_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_INS', 'Insercion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_programa_ime');
select pxp.f_insert_tprocedimiento ('PM_PROG_SEL', 'Consulta de datos', 'si', '', '', 'param.f_programa_sel');
select pxp.f_insert_tprocedimiento ('PM_PROG_CONT', 'Conteo de registros', 'si', '', '', 'param.f_programa_sel');
select pxp.f_insert_tprocedimiento ('PM_ACT_INS', 'Insercion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_actividad_ime');
select pxp.f_insert_tprocedimiento ('PM_ACT_SEL', 'Consulta de datos', 'si', '', '', 'param.f_actividad_sel');
select pxp.f_insert_tprocedimiento ('PM_ACT_CONT', 'Conteo de registros', 'si', '', '', 'param.f_actividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PPA_INS', 'Insercion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_ime');
select pxp.f_insert_tprocedimiento ('PM_PPA_SEL', 'Consulta de datos', 'si', '', '', 'param.f_programa_proyecto_acttividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PPA_CONT', 'Conteo de registros', 'si', '', '', 'param.f_programa_proyecto_acttividad_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_SEL', 'Consulta de datos', 'si', '', '', 'param.f_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_CONT', 'Conteo de registros', 'si', '', '', 'param.f_proyecto_sel');
select pxp.f_insert_tprocedimiento ('PM_PROY_INS', 'Insercion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PROY_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_PROY_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_proyecto_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_INS', 'Insercion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_FRPP_SEL', 'Consulta de datos', 'si', '', '', 'param.f_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_FRPP_CONT', 'Conteo de registros', 'si', '', '', 'param.f_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_GES_INS', 'Insercion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GES_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GES_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_GETGES_ELI', 'Recuepra el id_gestion segun la fecha', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_SEL', 'Listado de departamento', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_CONT', 'cuenta la cantidad de departamentos', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_OBTARPOBA_SEL', 'Listado de aprobadores filtradao segun criterio de configuracion', 'si', '', '', 'param.f_aprobadores_sel');
select pxp.f_insert_tprocedimiento ('PM_CEC_SEL', 'Consulta de datos', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CEC_CONT', 'Conteo de registros', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIG_SEL', 'Consulta de datos', 'si', '', '', 'param.f_concepto_ingas_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIG_CONT', 'Conteo de registros', 'si', '', '', 'param.f_concepto_ingas_sel');
select pxp.f_insert_tprocedimiento ('PM_PLT_CONT', 'Conteo de registros', 'si', '', '', 'param.f_plantilla_sel');
select pxp.f_insert_tprocedimiento ('PM_PLT_SEL', 'Consulta de datos', 'si', '', '', 'param.f_plantilla_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCFIS_INS', 'Insercion de registros', 'si', '', '', 'param.ft_documento_fiscal_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCFIS_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_documento_fiscal_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCFIS_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_documento_fiscal_ime');
select pxp.f_insert_tprocedimiento ('PM_OBTNIT_GET', 'Obtiene datos en función del NIT', 'si', '', '', 'param.ft_documento_fiscal_ime');
select pxp.f_insert_tprocedimiento ('PM_PESU_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_periodo_subsistema_sel');
select pxp.f_insert_tprocedimiento ('PM_PESU_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_periodo_subsistema_sel');
select pxp.f_insert_tprocedimiento ('PM_APRO_SEL', 'Consulta de datos', 'si', '', '', 'param.f_aprobador_sel');
select pxp.f_insert_tprocedimiento ('PM_APRO_CONT', 'Conteo de registros', 'si', '', '', 'param.f_aprobador_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIG_INS', 'Insercion de registros', 'si', '', '', 'param.f_concepto_ingas_ime');
select pxp.f_insert_tprocedimiento ('PM_CONIG_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_concepto_ingas_ime');
select pxp.f_insert_tprocedimiento ('PM_CONIG_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_concepto_ingas_ime');
select pxp.f_insert_tprocedimiento ('PM_GRU_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_grupo_sel');
select pxp.f_insert_tprocedimiento ('PM_GRU_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_grupo_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_INS', 'Inserta deptos', 'si', '', '', 'param.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_MOD', 'Modifica la depto seleccionada', 'si', '', '', 'param.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_ELI', 'Inactiva el depto selecionado', 'si', '', '', 'param.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('PM_GRU_INS', 'Insercion de registros', 'si', '', '', 'param.ft_grupo_ime');
select pxp.f_insert_tprocedimiento ('PM_GRU_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_grupo_ime');
select pxp.f_insert_tprocedimiento ('PM_GRU_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_grupo_ime');
select pxp.f_insert_tprocedimiento ('PM_GQP_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_grupo_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_GQP_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_grupo_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_ASIS_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_asistente_sel');
select pxp.f_insert_tprocedimiento ('PM_ASIS_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_asistente_sel');
select pxp.f_insert_tprocedimiento ('PM_CEC_INS', 'Insercion de registros', 'si', '', '', 'param.f_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('PM_CEC_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('PM_CEC_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('PM_APRO_INS', 'Insercion de registros', 'si', '', '', 'param.f_aprobador_ime');
select pxp.f_insert_tprocedimiento ('PM_APRO_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_aprobador_ime');
select pxp.f_insert_tprocedimiento ('PM_APRO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_aprobador_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUO_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_depto_uo_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUO_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_depto_uo_sel');
select pxp.f_insert_tprocedimiento ('PM_PESU_INS', 'Insercion de registros', 'si', '', '', 'param.ft_periodo_subsistema_ime');
select pxp.f_insert_tprocedimiento ('PM_PESU_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_periodo_subsistema_ime');
select pxp.f_insert_tprocedimiento ('PM_PESU_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_periodo_subsistema_ime');
select pxp.f_insert_tprocedimiento ('PM_PESUGEN_INS', 'Genracion de registros para un subsistema', 'si', '', '', 'param.ft_periodo_subsistema_ime');
select pxp.f_insert_tprocedimiento ('PM_SWESTPE_MOD', 'Cambio de estado para un periodo_subsistema', 'si', '', '', 'param.ft_periodo_subsistema_ime');
select pxp.f_insert_tprocedimiento ('PM_PER_INS', 'Insercion de registros', 'si', '', '', 'param.f_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_PER_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_PER_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_periodo_ime');
select pxp.f_insert_tprocedimiento ('PM_DOCFIS_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_documento_fiscal_sel');
select pxp.f_insert_tprocedimiento ('PM_DOCFIS_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_documento_fiscal_sel');
select pxp.f_insert_tprocedimiento ('PM_GES_SEL', 'Consulta de datos', 'si', '', '', 'param.f_gestion_sel');
select pxp.f_insert_tprocedimiento ('PM_GES_CONT', 'Conteo de registros', 'si', '', '', 'param.f_gestion_sel');
select pxp.f_insert_tprocedimiento ('PM_EMP_INS', 'Insercion de registros', 'si', '', '', 'param.f_empresa_ime');
select pxp.f_insert_tprocedimiento ('PM_EMP_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_empresa_ime');
select pxp.f_insert_tprocedimiento ('PM_LOGMOD_IME', 'Modifica la ruta de logo', 'si', '', '', 'param.f_empresa_ime');
select pxp.f_insert_tprocedimiento ('PM_EMP_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_empresa_ime');
select pxp.f_insert_tprocedimiento ('PM_GQP_INS', 'Insercion de registros', 'si', '', '', 'param.ft_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_GQP_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_GQP_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_grupo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_TCB_SEL', 'Consulta de datos', 'si', '', '', 'param.f_tipo_cambio_sel');
select pxp.f_insert_tprocedimiento ('PM_TCB_CONT', 'Conteo de registros', 'si', '', '', 'param.f_tipo_cambio_sel');
select pxp.f_insert_tprocedimiento ('PM_TCB_INS', 'Insercion de registros', 'si', '', '', 'param.f_tipo_cambio_ime');
select pxp.f_insert_tprocedimiento ('PM_TCB_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_tipo_cambio_ime');
select pxp.f_insert_tprocedimiento ('PM_TCB_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_tipo_cambio_ime');
select pxp.f_insert_tprocedimiento ('PM_OBTTCB_GET', 'Permite recuperar dede la interface el tipo de cambio para la moneda y fecha determinada', 'si', '', '', 'param.f_tipo_cambio_ime');
select pxp.f_insert_tprocedimiento ('PM_EMP_SEL', 'Consulta de datos', 'si', '', '', 'param.f_empresa_sel');
select pxp.f_insert_tprocedimiento ('PM_EMP_CONT', 'Conteo de registros', 'si', '', '', 'param.f_empresa_sel');
select pxp.f_insert_tprocedimiento ('PM_PLT_INS', 'Insercion de registros', 'si', '', '', 'param.f_plantilla_ime');
select pxp.f_insert_tprocedimiento ('PM_PLT_MOD', 'Modificacion de registros', 'si', '', '', 'param.f_plantilla_ime');
select pxp.f_insert_tprocedimiento ('PM_PLT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.f_plantilla_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUO_INS', 'Insercion de registros', 'si', '', '', 'param.ft_depto_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUO_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_depto_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPUO_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_depto_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_PER_SEL', 'Consulta de datos', 'si', '', '', 'param.f_periodo_sel');
select pxp.f_insert_tprocedimiento ('PM_PER_CONT', 'Conteo de registros', 'si', '', '', 'param.f_periodo_sel');
select pxp.f_insert_tprocedimiento ('PM_ASIS_INS', 'Insercion de registros', 'si', '', '', 'param.ft_asistente_ime');
select pxp.f_insert_tprocedimiento ('PM_ASIS_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_asistente_ime');
select pxp.f_insert_tprocedimiento ('PM_ASIS_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_asistente_ime');
/***********************************F-DAT-AAO-PARAM-72-23/04/2013*****************************************/

/***********************************I-DAT-RAC-PARAM-00-26/04/2013*****************************************/
select pxp.f_insert_tgui ('Generadores de Alarma', 'Configuracion funciones que generan alarmas', 'GAL', 'si', 4, 'sis_parametros/vista/generador_alarma/GeneradorAlarma.php', 2, '', 'GeneradorAlarma', 'PARAM');
select pxp.f_insert_testructura_gui ('GAL', 'PARAM');
select pxp.f_insert_tgui ('Grupos', 'Grupos', 'GQP', 'si', 8, 'sis_parametros/vista/grupo/Grupo.php', 3, '', 'Grupo', 'PARAM');
select pxp.f_insert_testructura_gui ('GQP', 'CEP');
/***********************************F-DAT-RAC-PARAM-00-26/04/2013*****************************************/

/***********************************I-DAT-RCM-PARAM-00-03/05/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__bandera','Si');
select pxp.f_add_catalog('PARAM','tgral__bandera','No');
/***********************************F-DAT-RCM-PARAM-00-03/05/2013*****************************************/
/***********************************I-DAT-GSS-PARAM-00-07/05/2013*****************************************/

select pxp.f_insert_tprocedimiento ('PM_DEPUSUCOMB_SEL', 'Listado de departamento por usuario para combos', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_CECCOM_SEL', 'Consulta de datos de centro de costo combo', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CECCOM_CONT', 'Conteo de registros centro de costo combo', 'si', '', '', 'param.f_centro_costo_sel');

/***********************************F-DAT-GSS-PARAM-00-07/05/2013*****************************************/

/***********************************I-DAT-RCM-PARAM-00-24/06/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__estado','activo');
select pxp.f_add_catalog('PARAM','tgral__estado','inactivo');

select pxp.f_add_catalog('PARAM','tgral__gestion','2005');
select pxp.f_add_catalog('PARAM','tgral__gestion','2006');
select pxp.f_add_catalog('PARAM','tgral__gestion','2007');
select pxp.f_add_catalog('PARAM','tgral__gestion','2008');
select pxp.f_add_catalog('PARAM','tgral__gestion','2009');
select pxp.f_add_catalog('PARAM','tgral__gestion','2010');
select pxp.f_add_catalog('PARAM','tgral__gestion','2011');
select pxp.f_add_catalog('PARAM','tgral__gestion','2012');
select pxp.f_add_catalog('PARAM','tgral__gestion','2013');
select pxp.f_add_catalog('PARAM','tgral__gestion','2014');
select pxp.f_add_catalog('PARAM','tgral__gestion','2015');
select pxp.f_add_catalog('PARAM','tgral__gestion','2016');
select pxp.f_add_catalog('PARAM','tgral__gestion','2017');
select pxp.f_add_catalog('PARAM','tgral__gestion','2018');
select pxp.f_add_catalog('PARAM','tgral__gestion','2019');
select pxp.f_add_catalog('PARAM','tgral__gestion','2020');
select pxp.f_add_catalog('PARAM','tgral__gestion','2021');
select pxp.f_add_catalog('PARAM','tgral__gestion','2022');
select pxp.f_add_catalog('PARAM','tgral__gestion','2023');
select pxp.f_add_catalog('PARAM','tgral__gestion','2024');
select pxp.f_add_catalog('PARAM','tgral__gestion','2025');
/***********************************F-DAT-RCM-PARAM-00-24/06/2013*****************************************/

/***********************************I-DAT-RCM-PARAM-00-08/10/2013*****************************************/
select pxp.f_add_catalog('PARAM','tgral__bandera_min','si');
select pxp.f_add_catalog('PARAM','tgral__bandera_min','no');
/***********************************F-DAT-RCM-PARAM-00-08/10/2013*****************************************/

/***********************************I-DAT-JRR-PARAM-0-25/04/2014*****************************************/
select pxp.f_insert_tgui ('Depto - UO', 'Depto - UO', 'DEPTO.2', 'no', 0, 'sis_parametros/vista/depto_uo/DeptoUo.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto - EP', 'Depto - EP', 'DEPTO.3', 'no', 0, 'sis_parametros/vista/depto_ep/DeptoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto UO - EP', 'Depto UO - EP', 'DEPTO.4', 'no', 0, 'sis_parametros/vista/depto_uo_ep/DeptoUoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Firmas Documentos', 'Firmas Documentos', 'DEPTO.5', 'no', 0, 'sis_parametros/vista/firma/Firma.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Subsistema', 'Subsistema', 'DEPTO.6', 'no', 0, 'id_subsistema', 3, '', 'Subsistema...', 'PARAM');
select pxp.f_insert_tgui ('EP\', 'EP\', 'DEPTO.1.1.3', 'no', 0, 'sis_seguridad/vista/usuario_grupo_ep/UsuarioGrupoEp.php', 5, '', ', 
          width:400,
          cls:', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INSTIT.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INSTIT.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVEE.3', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.3.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'UME.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'GESTIO.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'GESTIO.1.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'PERIOD.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'APROC.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'APROC.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'APROC.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'CONIG.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Organigrama', 'Organigrama', 'ASI.1', 'no', 0, 'sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php', 3, '', '60%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.2', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ASI.3', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'ASI.1.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 4, '', 'Cargo', 'PARAM');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'ASI.1.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'ASI.1.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 5, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'ASI.1.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 5, '', 'CargoCentroCosto', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.1.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ASI.1.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ASI.1.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DF.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'GQP.1', 'no', 0, 'sis_parametros/vista/grupo_ep/GrupoEp.php', 4, '', 'GrupoEp', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_extension_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_firma_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_id_lugares', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_uo_ep_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_id_periodo_anterior', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_ep_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_extension_grupo_archivo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_archivo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_extension_grupo_archivo_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_verifica_periodo_subsistema_abierto', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_lista_deptos_x_usuario', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_extension_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_generador_alarma_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_lista_ccosto_x_usuario', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_grupo_archivo_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_ep_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_firma_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_tipo_cambio', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_generador_alarma_ime', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.ft_depto_uo_ep_sel', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_periodo_gestion', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tfuncion ('param.f_get_factor_actualizacion_ufv', 'Funcion para tabla     ', 'PARAM');
select pxp.f_insert_tprocedimiento ('PM_PROVEEV_SEL', 'Consulta de datos de proveedores a partir de una vista de base
                    de datos', 'si', '', '', 'param.f_tproveedor_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSUCOMB_SEL', 'Listado de departamento filtrados por los usuarios configurados en los mismo', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_EXT_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_extension_sel');
select pxp.f_insert_tprocedimiento ('PM_EXT_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_extension_sel');
select pxp.f_insert_tprocedimiento ('PM_FIR_INS', 'Insercion de registros', 'si', '', '', 'param.ft_firma_ime');
select pxp.f_insert_tprocedimiento ('PM_FIR_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_firma_ime');
select pxp.f_insert_tprocedimiento ('PM_FIR_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_firma_ime');
select pxp.f_insert_tprocedimiento ('PM_DUE_INS', 'Insercion de registros', 'si', '', '', 'param.ft_depto_uo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_DUE_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_depto_uo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_DUE_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_depto_uo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_DEEP_INS', 'Insercion de registros', 'si', '', '', 'param.ft_depto_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_DEEP_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_depto_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_DEEP_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_depto_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_G_AR_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_extension_grupo_archivo_sel');
select pxp.f_insert_tprocedimiento ('PM_EXT_G_AR_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_extension_grupo_archivo_sel');
select pxp.f_insert_tprocedimiento ('PM_GRUPO_AR_INS', 'Insercion de registros', 'si', '', '', 'param.ft_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_GRUPO_AR_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_GRUPO_AR_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_G_AR_INS', 'Insercion de registros', 'si', '', '', 'param.ft_extension_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_G_AR_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_extension_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_G_AR_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_extension_grupo_archivo_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_INS', 'Insercion de registros', 'si', '', '', 'param.ft_extension_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_extension_ime');
select pxp.f_insert_tprocedimiento ('PM_EXT_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_extension_ime');
select pxp.f_insert_tprocedimiento ('PM_CONIGPP_SEL', 'Consulta de datos conmceptos de gasto filtrados por partidas', 'si', '', '', 'param.f_concepto_ingas_sel');
select pxp.f_insert_tprocedimiento ('PM_CONIGPP_CONT', 'Conteo de registros', 'si', '', '', 'param.f_concepto_ingas_sel');
select pxp.f_insert_tprocedimiento ('PM_GAL_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_generador_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_GAL_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_generador_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_GRUPO_AR_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_grupo_archivo_sel');
select pxp.f_insert_tprocedimiento ('PM_GRUPO_AR_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_grupo_archivo_sel');
select pxp.f_insert_tprocedimiento ('PM_DEEP_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_depto_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_DEEP_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_depto_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_FIR_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_firma_sel');
select pxp.f_insert_tprocedimiento ('PM_FIR_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_firma_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPUSUCOMB_CONT', 'cuenta la cantidad de departamentos por usuario para combos', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPFILUSU_SEL', 'Listado departametos filtrado por los grupos ep del usuarios', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPFILUSU_CONT', 'Listado departametos filtrado por los grupos ep del usuarios', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPFILEPUO_SEL', 'Listado departametos filtrado por vector de uos, eps
                      Este modulo busca ser generico para que desde cualquier sistema
                      se obtenga un filtro de depto en ufncion a un array de uo y ep,
                      
                      Estos array se arman en control en otra cosulta que si deberia ser particular segun el 
                      sistema desde el que se quiera lista', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPFILEPUO_CONT', 'Listado departametos filtrado por vector de uos, eps
                Este modulo busca ser generico para que desde cualquier sistema
                se obtenga un filtro de depto en ufncion a un array de uo y ep,
                
                Estos array se arman en control en otra cosulta que si deberia ser particular segun el 
                sistema desde el que se quiera lista', 'si', '', '', 'param.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_GAL_INS', 'Insercion de registros', 'si', '', '', 'param.ft_generador_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_GAL_MOD', 'Modificacion de registros', 'si', '', '', 'param.ft_generador_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_GAL_ELI', 'Eliminacion de registros', 'si', '', '', 'param.ft_generador_alarma_ime');
select pxp.f_insert_tprocedimiento ('PM_DUE_SEL', 'Consulta de datos', 'si', '', '', 'param.ft_depto_uo_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_DUE_CONT', 'Conteo de registros', 'si', '', '', 'param.ft_depto_uo_ep_sel');
select pxp.f_insert_tprocedimiento ('PM_CECCOMFU_SEL', 'Consulta de datos de centro de costo combo filtrado por grupo_ep del usuario', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CECCOMFU_CONT', 'Conteo de registros centro de costo combo', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CCFILDEP_SEL', 'Consulta  de centro de costos filtrado por el departamento que llega como parametros id_depto
                    ademas si la opcio filtrar = grupo_ep ademas anhade al filtro las 
                    lo grupo_de ep correspondiente al usuario', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_CCFILDEP_CONT', 'Conteo de registros de la Consulta  de centro de costos filtrado por el departamento que llega como parametros id_depto', 'si', '', '', 'param.f_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('PM_PERSUB_SIN', 'Generación de los periodos subsistema para los subsistemas recientes', 'si', '', '', 'param.f_gestion_ime');
select pxp.f_insert_tprocedimiento ('PM_SINCEPUO_IME', 'Sincronizar todas las ep o uo en el depto selecionado', 'si', '', '', 'param.ft_depto_uo_ep_ime');
select pxp.f_insert_tprocedimiento ('PM_GETALA_SEL', 'recupera datos de la alerta especificada', 'si', '', '', 'param.ft_alarma_sel');


/***********************************F-DAT-JRR-PARAM-0-25/04/2014*****************************************/



/***********************************I-DAT-RAC-PARAM-0-15/05/2014*****************************************/

select pxp.f_add_catalog('PARAM','tdepto_usuario_cargo','responsable');
select pxp.f_add_catalog('PARAM','tdepto_usuario_cargo','auxiliar');

/***********************************F-DAT-RAC-PARAM-0-15/05/2014*****************************************/




/***********************************I-DAT-RAC-PARAM-0-28/10/2015*****************************************/

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'moneda_intercambio', E'false', E'el sistema maneja moneda de intercambio');

/***********************************F-DAT-RAC-PARAM-0-28/10/2015*****************************************/


/***********************************I-DAT-RCM-PARAM-0-21/01/2016*****************************************/
select pxp.f_add_catalog('PARAM','tmoneda__origen','nacional');
select pxp.f_add_catalog('PARAM','tmoneda__origen','extranjera');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','sin_actualizacion');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','por_saldo');
select pxp.f_add_catalog('PARAM','tmoneda__tipo_actualizacion','por_transaccion');
/***********************************F-DAT-RCM-PARAM-0-21/01/2016*****************************************/



/***********************************I-DAT-RCM-PARAM-0-24/01/2016*****************************************/


select pxp.f_insert_tgui ('Entidad', 'Entidad', 'ENT', 'si', 10, 'sis_parametros/vista/entidad/Entidad.php', 2, '', 'Entidad', 'PARAM');
select pxp.f_insert_testructura_gui ('ENT', 'PARAM');

/***********************************F-DAT-RCM-PARAM-0-24/01/2016*****************************************/




/***********************************I-DAT-RAC-PARAM-0-12/04/2016*****************************************/

/* Data for the 'pxp.variable_global' table  (Records 1 - 1) */

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES 
  (E'param_comunicado', E'usuario', E'(usuario , funcionario) envio de copmunicados a usuarios de sistema o todos los funcionarios');


select pxp.f_insert_tgui ('<i class="fa fa-wrench fa-2x"></i> PARAMETROS GENERALES', 'Parametros Generales', 'PARAM', 'si', 2, '', 1, '', 'Sistema de Parametros', 'PARAM');
select pxp.f_insert_tgui ('Alarmas', 'Para programar las alarmas', 'ALARM', 'si', 0, 'sis_parametros/vista/alarma/Alarma.php', 2, '', 'Alarma', 'PARAM');
select pxp.f_insert_tgui ('Departamentos', 'Departamentos', 'DEPTO', 'si', 0, 'sis_parametros/vista/depto/Depto.php', 2, '', 'Depto', 'PARAM');
select pxp.f_insert_tgui ('Lugar', 'Lugar', 'LUG', 'si', 0, 'sis_parametros/vista/lugar/Lugar.php', 2, '', 'Lugar', 'PARAM');
select pxp.f_insert_tgui ('Institucion', 'Detalle de instituciones', 'INSTIT', 'si', 0, 'sis_parametros/vista/institucion/Institucion.php', 2, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Proyecto', 'Proyecto EP proviene de ENDESIS', 'PRO', 'si', 5, 'sis_parametros/vista/proyecto/Proyecto.php', 2, '', 'Proyecto', 'PARAM');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'PROVEE', 'si', 3, 'sis_parametros/vista/proveedor/Proveedor.php', 2, '', 'proveedor', 'PARAM');
select pxp.f_insert_tgui ('Documentos', 'Documentos por Sistema', 'DOCUME', 'si', 0, 'sis_parametros/vista/documento/Documento.php', 2, '', 'Documento', 'PARAM');
select pxp.f_insert_tgui ('Configuracion Alarmas', 'Para configurar las alarmas', 'CONALA', 'si', 0, 'sis_parametros/vista/config_alarma/ConfigAlarma.php', 2, '', 'ConfigAlarma', 'PARAM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Registro de Unidades de Medida', 'UME', 'si', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 2, '', 'UnidadMedida', 'PARAM');
select pxp.f_insert_tgui ('Gestion', 'Manejo de gestiones', 'GESTIO', 'si', 0, 'sis_parametros/vista/gestion/Gestion.php', 2, '', 'Gestion', 'PARAM');
select pxp.f_insert_tgui ('Catalogo', 'Catalogo', 'CATA', 'si', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 2, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERIOD', 'si', 0, 'sis_parametros/vista/periodo/Periodo.php', 2, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('Moneda', 'Monedas', 'MONPAR', 'si', 0, 'sis_parametros/vista/moneda/Moneda.php', 2, '', 'Moneda', 'PARAM');
select pxp.f_insert_tgui ('Tipos de Catálogos', 'Tipos de Catálogos', 'PACATI', 'si', 0, 'sis_parametros/vista/catalogo_tipo/CatalogoTipo.php', 2, '', 'CatalogoTipo', 'PARAM');
select pxp.f_insert_tgui ('Servicios', 'Para registro de los servicios', 'SERVIC', 'si', 0, 'sis_parametros/vista/servicio/Servicio.php', 2, '', 'Servicio', 'PARAM');
select pxp.f_insert_tgui ('EP', 'Elementos de la Estructura Programatica', 'CEP', 'si', 1, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Compras', 'Parametrizaciones re lacionadas con compras', 'CCOM', 'si', 2, '', 3, '', '', 'PARAM');
select pxp.f_insert_tgui ('Aprobadores', 'Aprobadores de Compras', 'APROC', 'si', 1, 'sis_parametros/vista/aprobador/Aprobador.php', 4, '', 'Aprobador', 'PARAM');
select pxp.f_insert_tgui ('Financiador', 'Financiadores de Compras', 'FIN', 'si', 1, 'sis_parametros/vista/financiador/Financiador.php', 3, '', 'Financiador', 'PARAM');
select pxp.f_insert_tgui ('Regional', 'Regionales de Compras', 'REGIO', 'si', 2, 'sis_parametros/vista/regional/Regional.php', 3, '', 'Regional', 'PARAM');
select pxp.f_insert_tgui ('Programa', 'Programas de Compras', 'PROG', 'si', 3, 'sis_parametros/vista/programa/Programa.php', 3, '', 'Programa', 'PARAM');
select pxp.f_insert_tgui ('Actividad', 'Actividad', 'ACT', 'si', 5, 'sis_parametros/vista/actividad/Actividad.php', 3, '', 'Actividad', 'PARAM');
select pxp.f_insert_tgui ('Programa-Proyecto-Actividad', 'programa proyecto actividad', 'PPA', 'si', 6, 'sis_parametros/vista/programa_proyecto_acttividad/ProgramaProyectoActtividad.php', 3, '', 'ProgramaProyectoActtividad', 'PARAM');
select pxp.f_insert_tgui ('Financiador-Regional-Programa-Proyecto', 'financiadores Regionales Programas Proyectos', 'FRPP', 'si', 7, 'sis_parametros/vista/ep/Ep.php', 3, '', 'Ep', 'PARAM');
select pxp.f_insert_tgui ('Empresa', 'Empresa', 'EMP', 'si', 0, 'sis_parametros/vista/empresa/Empresa.php', 2, '', 'Empresa', 'PARAM');
select pxp.f_insert_tgui ('Concepto de Ingreso/Gasto', 'Parametrizaciond e concepto de gasto o ingreso', 'CONIG', 'si', 2, 'sis_parametros/vista/concepto_ingas/ConceptoIngas.php', 4, '', 'ConceptoIngas', 'PARAM');
select pxp.f_insert_tgui ('Centro de Costo', 'Centro de costo', 'CCOST', 'si', 9, 'sis_parametros/vista/centro_costo/CentroCosto.php', 2, '', 'CentroCosto', 'PARAM');
select pxp.f_insert_tgui ('Tipo de Cambio', 'tipo de cambio', 'TCB', 'si', 0, 'sis_parametros/vista/tipo_cambio/TipoCambio.php', 2, '', 'TipoCambio', 'PARAM');
select pxp.f_insert_tgui ('Asistentes', 'Asistentes', 'ASI', 'si', 4, 'sis_parametros/vista/asistente/Asistente.php', 2, '', 'Asistente', 'PARAM');
select pxp.f_insert_tgui ('Documentos Fiscales', 'Listado de todos los Documentos fiscales', 'DF', 'si', 0, 'sis_parametros/vista/documento_fiscal/DocumentoFiscal.php', 2, '', 'DocumentoFiscal', 'PARAM');
select pxp.f_insert_tgui ('Plantillas', 'Plantillas', 'PLANT', 'si', 0, 'sis_parametros/vista/plantilla/Plantilla.php', 2, '', 'Plantilla', 'PARAM');
select pxp.f_insert_tgui ('Usuarios por Departamento', 'Usuarios por Departamento', 'DEPTO.1', 'no', 0, 'sis_parametros/vista/depto_usuario/DeptoUsuario.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Usuarios', 'Usuarios', 'DEPTO.1.1', 'no', 0, 'sis_seguridad/vista/usuario/Usuario.php', 4, '', 'usuario', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'DEPTO.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'DEPTO.1.1.2', 'no', 0, 'sis_seguridad/vista/usuario_rol/UsuarioRol.php', 5, '', 'usuario_rol', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'DEPTO.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 6, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Ubicacion Lugar', 'Ubicacion Lugar', 'LUG.1', 'no', 0, 'sis_parametros/vista/lugar/mapaLugar.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Items/Servicios ofertados', 'Items/Servicios ofertados', 'PROVEE.1', 'no', 0, 'sis_parametros/vista/proveedor_item_servicio/ProveedorItemServicio.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodos', 'Periodos', 'GESTIO.1', 'no', 0, 'sis_parametros/vista/periodo/Periodo.php', 3, '', 'Periodo', 'PARAM');
select pxp.f_insert_tgui ('subir Logo', 'subir Logo', 'EMP.1', 'no', 0, 'sis_parametros/vista/empresa/subirLogo.php', 3, '', 'subirLogo', 'PARAM');
select pxp.f_insert_tgui ('Generadores de Alarma', 'Configuracion funciones que generan alarmas', 'GAL', 'si', 0, 'sis_parametros/vista/generador_alarma/GeneradorAlarma.php', 2, '', 'GeneradorAlarma', 'PARAM');
select pxp.f_insert_tgui ('Grupos', 'Grupos', 'GQP', 'si', 8, 'sis_parametros/vista/grupo/Grupo.php', 3, '', 'Grupo', 'PARAM');
select pxp.f_insert_tgui ('Depto - UO', 'Depto - UO', 'DEPTO.2', 'no', 0, 'sis_parametros/vista/depto_uo/DeptoUo.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto - EP', 'Depto - EP', 'DEPTO.3', 'no', 0, 'sis_parametros/vista/depto_ep/DeptoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Depto UO - EP', 'Depto UO - EP', 'DEPTO.4', 'no', 0, 'sis_parametros/vista/depto_uo_ep/DeptoUoEp.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Firmas Documentos', 'Firmas Documentos', 'DEPTO.5', 'no', 0, 'sis_parametros/vista/firma/Firma.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Subsistema', 'Subsistema', 'DEPTO.6', 'no', 0, 'id_subsistema', 3, '', 'Subsistema...', 'PARAM');
select pxp.f_insert_tgui ('EP\', 'EP\', 'DEPTO.1.1.3', 'no', 0, 'sis_seguridad/vista/usuario_grupo_ep/UsuarioGrupoEp.php', 5, '', ', 
          width:400,
          cls:', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INSTIT.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INSTIT.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'PROVEE.3', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'PROVEE.3.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'UME.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'GESTIO.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'GESTIO.1.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Periodo Subistema', 'Periodo Subistema', 'PERIOD.1', 'no', 0, 'sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'APROC.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'APROC.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'APROC.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'APROC.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'CONIG.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Organigrama', 'Organigrama', 'ASI.1', 'no', 0, 'sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php', 3, '', '60%', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.2', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ASI.3', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'ASI.1.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 4, '', 'Cargo', 'PARAM');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'ASI.1.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 4, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'ASI.1.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 5, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'ASI.1.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 5, '', 'CargoCentroCosto', 'PARAM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ASI.1.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ASI.1.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ASI.1.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.1.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DF.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 3, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Roles', 'Roles', 'GQP.1', 'no', 0, 'sis_parametros/vista/grupo_ep/GrupoEp.php', 4, '', 'GrupoEp', 'PARAM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'DEPTO.1.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'PROVEE.3.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'APROC.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.1.2.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ASI.2.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 4, '', 'FuncionarioCuentaBancaria', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.2.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ASI.2.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 5, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ASI.2.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ASI.2.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'PARAM');
select pxp.f_insert_tgui ('Depto - Cuenta Bancaria', 'Depto - Cuenta Bancaria', 'DEPTO.7', 'no', 0, 'sis_tesoreria/vista/depto_cuenta_bancaria/DeptoCuentaBancaria.php', 3, '', '50%', 'PARAM');
select pxp.f_insert_tgui ('Entidad', 'Entidad', 'ENT', 'si', 0, 'sis_parametros/vista/entidad/Entidad.php', 2, '', 'Entidad', 'PARAM');
select pxp.f_insert_tgui ('Monedas', 'Monedas', 'MNDS', 'si', 2, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'ALRMS', 'si', 3, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Empresa', 'Empresa', 'EMPS', 'si', 1, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Catalogos', 'Catalogos', 'CTLGS', 'si', 2, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Otros', 'Otros', 'OTROS', 'si', 50, '', 2, '', '', 'PARAM');
select pxp.f_insert_tgui ('Comunicados', 'registro de comunicados ', 'COMAL', 'si', 1, 'sis_parametros/vista/alarma/Comunicado.php', 3, '', 'Comunicado', 'PARAM');




/***********************************F-DAT-RAC-PARAM-0-12/04/2016*****************************************/


/*******************************************I-DAT-JRR-PARAM-0-18/06/2016***********************************************/

select pxp.f_insert_tprocedimiento ('PM_ALARM_SEL', 'Consulta de datos', 'no', '', '', 'param.ft_alarma_sel');
select pxp.f_insert_tprocedimiento ('PM_ALARM_CONT', 'Conteo de registros', 'no', '', '', 'param.ft_alarma_sel');

/*******************************************F-DAT-JRR-PARAM-0-18/06/2016***********************************************/


/*******************************************I-DAT-RAC-PARAM-0-06/09/2016***********************************************/

select pxp.f_insert_tgui ('Dashboard', 'Dashboard', 'DASH', 'si', 50, 'sis_parametros/vista/dashboard/Dashboard.php', 1, '', 'Dashboard', 'PXP');
select pxp.f_insert_testructura_gui ('DASH', 'SISTEMA');

/*******************************************F-DAT-RAC-PARAM-0-06/09/2016***********************************************/



/*******************************************I-DAT-RAC-PARAM-0-07/10/2016***********************************************/

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------
select pxp.f_insert_tgui ('Widget', 'Widget para dashboard', 'WIDGET', 'si', 10, 'sis_parametros/vista/widget/WidgetConfig.php', 3, '', 'WidgetConfig', 'PARAM');
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------
select pxp.f_insert_testructura_gui ('WIDGET', 'OTROS');



/* Data for the 'param.twidget' table  (Records 1 - 3) */

INSERT INTO param.twidget ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_widget", "nombre", "obs", "foto", "clase", "tipo", "ruta")
VALUES 
  (1, 1, E'2016-09-10 04:34:20.673', E'2016-09-11 05:59:54.043', E'activo', NULL, E'NULL', 1, E'Prueba', E'este es un widget  de prueba sin datos relevantes', E'./../../../uploaded_files/sis_parametros/Widget/85ab53cb4ec4e66acb25d58419cfc392_v.jpg', E'Prueba', E'objeto', E'sis_seguridad/widgets/Prueba.php'),
  (1, 1, E'2016-09-10 06:24:19.559', E'2016-09-11 10:36:09.940', E'activo', NULL, E'NULL', 2, E'test', E'test', NULL, E'Prueba3', E'objeto', E'sis_seguridad/widgets/Prueba3.php'),
  (1, NULL, E'2016-09-11 10:59:02.279', NULL, E'activo', NULL, E'NULL', 3, E'iframe', E'iframe', NULL, E'Prueba2', E'iframe', E'sis_seguridad/widgets/Prueba2.php');


/* Data for the 'param.tdashboard' table  (Records 1 - 4) */

INSERT INTO param.tdashboard ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_usuario_ai", "usuario_ai", "id_dashboard", "nombre", "id_usuario")
VALUES 
  (1, 1, E'2016-09-10 07:41:23', E'2016-09-11 18:25:46.596', E'activo', NULL, E'NULL', 1, E'mi test', 1),
  (1, NULL, E'2016-09-11 06:24:06.452', NULL, E'activo', NULL, E'NULL', 27, E'Mi dashboard', 1),
  (1, 1, E'2016-09-11 23:07:16.106', E'2016-09-11 23:07:26.357', E'activo', NULL, E'NULL', 28, E'prueba', 1),
  (1, 1, E'2016-09-11 23:07:46.370', E'2016-09-11 23:07:54.814', E'activo', NULL, E'NULL', 29, E'test', 1);


/*******************************************F-DAT-RAC-PARAM-0-07/10/2016***********************************************/



/***********************************I-DAT-GSS-PARAM-0-05/01/2017*****************************************/

select pxp.f_insert_tgui ('Archivos Excel', 'Archivos Excel', 'ARXLS', 'si', 10, 'sis_parametros/vista/plantilla_archivo_excel/PlantillaArchivoExcel.php', 3, '', 'PlantillaArchivoExcel', 'PARAM');
select pxp.f_insert_tgui ('Columnas Excel', 'columnas excel del archivo', 'COLXLS', 'si', 1, 'sis_parametros/vista/columnas_archivo_excel/ColumnasArchivoExcel.php', 4, '', 'ColumnasArchivoExcel', 'PARAM');

select pxp.f_insert_testructura_gui ('ARXLS', 'OTROS');
select pxp.f_insert_testructura_gui ('COLXLS', 'ARXLS');

/***********************************F-DAT-GSS-PARAM-0-05/01/2017*****************************************/


/***********************************I-DAT-FFP-PARAM-0-27/02/2017*****************************************/


select pxp.f_insert_tgui ('Configuracion Lector', 'configuracion lector', 'CONFLECT', 'si', 10, 'sis_parametros/vista/conf_lector_mobile/ConfLectorMobile.php', 3, '', 'ConfLectorMobile', 'PARAM');

select pxp.f_insert_testructura_gui ('CONFLECT', 'OTROS');
/***********************************F-DAT-FFP-PARAM-0-27/02/2017*****************************************/

/***********************************I-DAT-FFP-PARAM-0-24/02/2017*****************************************/

select pxp.f_insert_tgui ('Tipo Archivo', 'tipos de archivos', 'TIPOAR', 'si', 9, 'sis_parametros/vista/tipo_archivo/TipoArchivo.php', 3, '', 'TipoArchivo', 'PARAM');
select pxp.f_insert_testructura_gui ('TIPOAR', 'OTROS');
/***********************************F-DAT-FFP-PARAM-0-24/02/2017*****************************************/


/***********************************I-DAT-RAC-PARAM-0-01/06/2017*****************************************/
select pxp.f_insert_tgui ('Tipo Centro de Costo', 'Tipo de Centro de Costo', 'TIPCC', 'si', 14, 'sis_parametros/vista/tipo_cc/TipoCcArb.php', 3, '', 'TipoCcArb', 'PARAM');
select pxp.f_insert_testructura_gui ('TIPCC', 'CEP');
/***********************************F-DAT-RAC-PARAM-0-01/06/2017*****************************************/





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
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERIOD', 'si', 2, 'sis_parametros/vista/periodo/periodo.js', 2, '', 'periodo', 'PARAM');
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
select pxp.f_insert_tfuncion ('param.ft_moneda_sel', 'Funcion para tabla     ', 'PARAM');
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
select pxp.f_insert_tfuncion ('param.ft_moneda_ime', 'Funcion para tabla     ', 'PARAM');
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
select pxp.f_insert_tprocedimiento ('PM_MONEDA_SEL', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_moneda_sel');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_CONT', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'param.ft_moneda_sel');
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
select pxp.f_insert_tprocedimiento ('PM_MONEDA_INS', 'Inserta Funciones', 'si', '', '', 'param.ft_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_MOD', 'Modifica la moneda seleccionada', 'si', '', '', 'param.ft_moneda_ime');
select pxp.f_insert_tprocedimiento ('PM_MONEDA_ELI', 'Inactiva la moneda selecionada', 'si', '', '', 'param.ft_moneda_ime');
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



/***********************************F-DAT-RAC-PARAM-0-04/02/2013*****************************************/



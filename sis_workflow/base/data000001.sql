/********************************************I-DAT-FRH-WF-0-15/02/2013********************************************/
/*
*	Author: FRH
*	Date: 15/02/2013
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
VALUES ('WF', 'Work Flow', '2013-02-15', 'WF', 'activo', 'workflow', NULL);

-------------------------------------
--DEFINICION DE INTERFACES
-------------------------------------

select pxp.f_insert_tgui ('Work Flow', '', 'WF', 'si', 1, '', 1, '', '', 'WF');

select pxp.f_insert_tgui ('Proceso Macro', 'Proceso Macro', 'WF.2', 'si', 1, 'sis_workflow/vista/proceso_macro/ProcesoMacro.php', 2, '', 'ProcesoMacro', 'WF');
select pxp.f_insert_tgui ('Tipo Estado', 'Tipo Estado', 'WF.1.1', 'si', 1, 'sis_workflow/vista/tipo_estado/TipoEstado.php', 3, '', 'TipoEstado', 'WF');
select pxp.f_insert_tgui ('Tipo Proceso', 'Tipo Proceso', 'WF.1.2', 'si', 1, 'sis_workflow/vista/tipo_proceso/TipoProceso.php', 3, '', 'TipoProceso', 'WF');
select pxp.f_insert_tgui ('Estructura Estado', 'Estructura Estado', 'WF.1.3', 'si', 1, 'sis_workflow/vista/estructura_estado/EstructuraEstado.php', 3, '', 'EstructuraEstado', 'WF');


-------------------------------------
select pxp.f_insert_testructura_gui ('WF', 'SISTEMA');
select pxp.f_insert_testructura_gui ('WF.2', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.1', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.2', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.3', 'WF');


----------------------------------------------
--  DEF DE FUNCIONES
----------------------------------------------
select pxp.f_insert_tfuncion ('wf.ft_num_tramite_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_num_tramite_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_proceso_macro_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_proceso_macro_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_get_numero_tramite.sql', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_estructura_estado_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_estructura_estado_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_estado_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_estado_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_proceso_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_proceso_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_estado_tipo_proceso', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_disparador_predecesor_proceso', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_registra_estado_wf', 'Funcion      ', 'WF');

/********************************************F-DAT-FRH-WF-0-15/02/2013**********************************************/

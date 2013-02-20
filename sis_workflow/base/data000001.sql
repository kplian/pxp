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

select pxp.f_insert_tgui ('Proceso Macro', 'Proceso Macro', 'WF.1', 'si', 1, 'sis_workflow/vista/proceso_macro/ProcesoMacro.php', 2, '', 'ProcesoMacro', 'WF');

-------------------------------------
select pxp.f_insert_testructura_gui ('WF', 'SISTEMA');
select pxp.f_insert_testructura_gui ('WF.1', 'WF');


----------------------------------------------
--  DEF DE FUNCIONES
----------------------------------------------
select pxp.f_insert_tfuncion ('wf.ft_num_tramite_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_num_tramite_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_proceso_macro_ime', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_proceso_macro_sel', 'Funcion      ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_get_numero_siguiente', 'Funcion      ', 'WF');


/********************************************F-DAT-FRH-WF-0-15/02/2013**********************************************/

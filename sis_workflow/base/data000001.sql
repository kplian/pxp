/********************************************I-DAT-RCM-SEGU-0-15/01/2013********************************************/
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

-------------------------------------
select pxp.f_insert_testructura_gui ('WF', 'SISTEMA');


----------------------------------------------
--  DEF DE FUNCIONES
----------------------------------------------


/********************************************F-DAT-JRR-SEGU-0-02/02/2013**********************************************/

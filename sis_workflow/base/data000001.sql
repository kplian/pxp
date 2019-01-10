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


select pxp.f_insert_tgui ('<i class="fa fa-cogs fa-2x"></i> FLUJO DE TRABAJO', '', 'WF', 'si', 3, '', 1, '', '', 'WF');
select pxp.f_insert_tgui ('Proceso Macro', 'Proceso Macro', 'WF.2', 'si', 1, 'sis_workflow/vista/proceso_macro/ProcesoMacro.php', 2, '', 'ProcesoMacro', 'WF');
select pxp.f_insert_tgui ('Tipo Proceso', 'Tipo Proceso', 'WF.1.2', 'si', 1, 'sis_workflow/vista/tipo_proceso/TipoProceso.php', 3, '', 'TipoProceso', 'WF');
select pxp.f_insert_tgui ('Inicio de Tramites', 'Inicio de Tramites', 'INT', 'si', 3, 'sis_workflow/vista/proceso_wf/ProcesoWfIniTra.php', 2, '', 'ProcesoWfIniTra', 'WF');
select pxp.f_insert_tgui ('Seguir Tramite', 'Seguimiento de tramites', 'STR', 'si', 4, 'sis_workflow/vista/proceso_wf/ProcesoWfVb.php', 2, '', 'ProcesoWfVb', 'WF');
select pxp.f_insert_tgui ('VoBo Procesos', 'VoBo procesos del work flow', 'VOBOWF', 'si', 10, 'sis_workflow/vista/proceso_wf/VoBoProceso.php', 2, '', 'VoBoProceso', 'WF');
select pxp.f_insert_tgui ('Categoria Documento', 'Categorias de Documento', 'CATDOC', 'si', 1, 'sis_workflow/vista/categoria_documento/CategoriaDocumento.php', 2, '', 'CategoriaDocumento', 'WF');
select pxp.f_insert_tgui ('Bitacoras Procesos', 'Bitacoras Procesos', 'BP', 'si', 11, 'sis_workflow/vista/reporte_procesos/FromFiltro.php', 2, '', 'FormFiltro', 'WF');


/********************************************F-DAT-FRH-WF-0-15/02/2013**********************************************/



/******************************************I-DAT-RCM-WF-0-21/05/2014**********************************************/

select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','string');
select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','date');
select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','numeric');

/******************************************F-DAT-RCM-WF-0-21/05/2014**********************************************/

/******************************************I-DAT-EGS-WF-0-02/01/2019**********************************************/
INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES 
  (E'extensiones_documento_wf', E'doc,docx,pdf,jpg,jpeg,bmp,gif,png,xls,xlsx,rar,zip,txt,pptx,vsd,mpp', E'Tipos de Extensiones para documentos Wf');
  
/******************************************F-DAT-EGS-WF-0-02/01/2019**********************************************/

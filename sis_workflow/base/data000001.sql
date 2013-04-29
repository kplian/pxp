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
select pxp.f_insert_tgui ('Tipo Estado', 'Tipo Estado', 'WF.1.1', 'no', 1, 'sis_workflow/vista/tipo_estado/TipoEstado.php', 3, '', 'TipoEstado', 'WF');
select pxp.f_insert_tgui ('Tipo Proceso', 'Tipo Proceso', 'WF.1.2', 'si', 1, 'sis_workflow/vista/tipo_proceso/TipoProceso.php', 3, '', 'TipoProceso', 'WF');
select pxp.f_insert_tgui ('Estructura Estado', 'Estructura Estado', 'WF.1.3', 'no', 1, 'sis_workflow/vista/estructura_estado/EstructuraEstado.php', 3, '', 'EstructuraEstado', 'WF');
select pxp.f_insert_tgui ('Definicion Labores x Proceso', 'Definicion Labores x Proceso', 'WF.1.4', 'no', 1, 'sis_workflow/vista/labores_tipo_proceso/LaboresTipoProceso.php', 3, '', 'LaboresTipoProceso', 'WF');


-------------------------------------
select pxp.f_insert_testructura_gui ('WF', 'SISTEMA');
select pxp.f_insert_testructura_gui ('WF.2', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.1', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.2', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.3', 'WF');
select pxp.f_insert_testructura_gui ('WF.1.4', 'WF');

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


/********************************************I-DAT-GSS-WF-81-26/03/2013**********************************************/
--definicion de interfaces

select pxp.f_insert_tgui ('Numero de tramite', 'Numero de tramite', 'WF.2.1', 'no', 0, 'sis_workflow/vista/num_tramite/NumTramite.php', 3, '', '35%', 'WF');
select pxp.f_insert_tgui ('Estados', 'Estados', 'WF.1.2.1', 'no', 0, 'sis_workflow/vista/tipo_estado/TipoEstado.php', 4, '', 'TipoEstado', 'WF');
select pxp.f_insert_tgui ('Hijos', 'Hijos', 'WF.1.2.1.1', 'no', 0, 'sis_workflow/vista/estructura_estado/EstructuraEstadoHijo.php', 5, '', '50%', 'WF');

select pxp.f_insert_tgui ('Inicio de Tramites', 'Inicio de Tramites', 'INT', 'si', 3, 'sis_workflow/vista/proceso_wf/ProcesoWfIniTra.php', 2, '', 'ProcesoWfIniTra', 'WF');
select pxp.f_insert_tgui ('Seguir Tramite', 'Seguimiento de tramites', 'STR', 'si', 4, 'sis_workflow/vista/proceso_wf/ProcesoWfVb.php', 2, '', 'ProcesoWfVb', 'WF');


--estructura de interface

select pxp.f_insert_testructura_gui ('WF.2.1', 'WF.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1.1', 'WF.1.2.1');

select pxp.f_insert_testructura_gui ('INT', 'WF');
select pxp.f_insert_testructura_gui ('STR', 'WF');

--funciones--

select pxp.f_insert_tfuncion ('wf.f_insert_tproceso_macro', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_depto_wf_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_funcionario_wf_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_get_numero_tramite', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_cadena_tipos_estados_anteriores_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_insert_testructura_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_registra_proceso_disparado_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_diparador_predecesor_proceso', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_tipo_estado_inicial_del_tipo_proceso', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_estado_ant_log_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_insert_ttipo_proceso', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_estado_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_insert_ttipo_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_funcionario_tipo_estado_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_inicia_tramite', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_funcionario_tipo_estado_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_labores_tipo_proceso_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_labores_tipo_proceso_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_estado_segun_log_wf', 'Funcion para tabla     ', 'WF');

--procedimientos--

select pxp.f_insert_tprocedimiento ('WF_TIPES_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPES_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPES_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_FUNTIPES_SEL', 'Consulta los funcionarios correpondientes con el tipo de estado', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_FUNTIPES_CONT', 'Consulta los funcionarios correpondientes con el tipo de estado', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPES_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPTIPES_SEL', 'Listado de los datos de tipo estado segun del proceso macro seleccionado para exportar', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPES_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPPROC_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPROC_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPROC_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_ESTES_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_estructura_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPESTES_SEL', 'Listado de estructura de datos del proceso macro seleccionado para exportar', 'si', '', '', 'wf.ft_estructura_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_ESTES_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_estructura_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_FUNCTEST_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_funcionario_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_FUNCTEST_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_funcionario_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_PROMAC_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_proceso_macro_ime');
select pxp.f_insert_tprocedimiento ('WF_PROMAC_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_proceso_macro_ime');
select pxp.f_insert_tprocedimiento ('WF_PROMAC_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_proceso_macro_ime');
select pxp.f_insert_tprocedimiento ('WF_ESTES_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_estructura_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_ESTES_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_estructura_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_ESTES_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_estructura_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_NUMTRAM_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_num_tramite_ime');
select pxp.f_insert_tprocedimiento ('WF_NUMTRAM_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_num_tramite_ime');
select pxp.f_insert_tprocedimiento ('WF_NUMTRAM_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_num_tramite_ime');
select pxp.f_insert_tprocedimiento ('WF_FUNCTEST_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_funcionario_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_FUNCTEST_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_funcionario_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_FUNCTEST_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_funcionario_tipo_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPROC_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPPROC_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPTIPPROC_SEL', 'Listado de tipos de proceso de un proceso macro para exportar', 'si', '', '', 'wf.ft_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_LABTPROC_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_labores_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_LABTPROC_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_labores_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_LABTPROC_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_labores_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_LABTPROC_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_labores_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_LABTPROC_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_labores_tipo_proceso_ime');
select pxp.f_insert_tprocedimiento ('WF_NUMTRAM_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_num_tramite_sel');
select pxp.f_insert_tprocedimiento ('WF_NUMTRAM_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_num_tramite_sel');
select pxp.f_insert_tprocedimiento ('WF_PROMAC_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_proceso_macro_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPPROMAC_SEL', 'Listado de los datos del proceso macro seleccionado para exportar', 'si', '', '', 'wf.ft_proceso_macro_sel');
select pxp.f_insert_tprocedimiento ('WF_PROMAC_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_proceso_macro_sel');

--procedimiento_gui--

select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_INS', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_MOD', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_ELI', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_NUMTRAM_INS', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_NUMTRAM_MOD', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_NUMTRAM_ELI', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_NUMTRAM_SEL', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_INS', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_MOD', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_ELI', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'WF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_INS', 'WF.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_MOD', 'WF.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_ELI', 'WF.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_INS', 'WF.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_MOD', 'WF.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_ELI', 'WF.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_SEL', 'WF.1.2.1.1', 'no');


/********************************************F-DAT-GSS-WF-81-26/03/2013**********************************************/


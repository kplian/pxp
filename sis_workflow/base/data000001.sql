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


/******************************************I-DAT-JRR-WF-0-25/04/2014**********************************************/

select pxp.f_insert_tgui ('Tipo de Documentos', 'Tipo de Documentos', 'WF.1.2.2', 'no', 0, 'sis_workflow/vista/tipo_documento/TipoDocumento.php', 4, '', 'TipoDocumento', 'WF');
select pxp.f_insert_tgui ('Labores', 'Labores', 'WF.1.2.3', 'no', 0, 'sis_workflow/vista/labores_tipo_proceso/LaboresTipoProceso.php', 4, '', 'LaboresTipoProceso', 'WF');
select pxp.f_insert_tgui ('Padres', 'Padres', 'WF.1.2.1.2', 'no', 0, 'sis_workflow/vista/estructura_estado/EstructuraEstadoPadre.php', 5, '', '50%', 'WF');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'WF.1.2.1.3', 'no', 0, 'sis_workflow/vista/funcionario_tipo_estado/FuncionarioTipoEstado.php', 5, '', '50%', 'WF');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'WF.1.2.1.3.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 6, '', 'funcionario', 'WF');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'WF.1.2.1.3.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 7, '', 'FuncionarioCuentaBancaria', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'WF.1.2.1.3.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'WF.1.2.1.3.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 8, '', 'Institucion', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'WF.1.2.1.3.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 9, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'WF.1.2.1.3.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 10, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'WF.1.2.2.1', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstado.php', 5, '', '50%', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INT.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'INT.2', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INT.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'INT.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'STR.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'STR.2', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'STR.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'STR.2.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'WF.1.2.1.3.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'INT.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'STR.2.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'WF.1.2.1.4', 'no', 0, 'sis_workflow/vista/tipo_estado/PlantillaMensaje.php', 5, '', '80%', 'WF');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'INT.3', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 3, '', '90%', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'INT.4', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 3, '', 'FormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'INT.5', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 3, '', 'AntFormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'INT.3.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 4, '', 'SubirArchivoWf', 'WF');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'INT.3.2', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 4, '', 'TipoDocumentoEstadoWF', 'WF');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'STR.3', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 3, '', '90%', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'STR.4', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 3, '', 'FormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'STR.5', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 3, '', 'AntFormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'STR.3.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 4, '', 'SubirArchivoWf', 'WF');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'STR.3.2', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 4, '', 'TipoDocumentoEstadoWF', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_documento_estado_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_documento_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_obtener_tipos_procesos', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_documento_wf_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_gant_wf_recursiva', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_gant_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_encontrar_proceso_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_proceso_wf_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_inserta_documento_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_modificar_momento_documento_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_tipo_dato_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_proceso_wf_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_tipo_dato_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_documento_estado_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_verifica_documento', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_documento_wf_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_documento_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_test', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_procesar_plantilla', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tprocedimiento ('WF_DES_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_documento_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_DES_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_documento_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_DES_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_documento_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPDW_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPDW_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('WF_DWF_MOD', 'Mofifica documentos, chequeo fisico y boservaciones', 'si', '', '', 'wf.ft_documento_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_DWF_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_documento_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_DOCWFAR_MOD', 'Subir arhcivos al documento de WF', 'si', '', '', 'wf.ft_documento_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_GATNREP_SEL', 'Consulta del diagrama gant del WF', 'si', '', '', 'wf.f_gant_wf');
select pxp.f_insert_tprocedimiento ('WF_SIGEST_SEL', 'Devuelve los siguientes estados posibles', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_SIGEST_CONT', 'Conteo de registros de los siguientes estados posibles', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_PWF_INS', 'Insercion de registros', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_PWF_MOD', 'Modificacion de registros', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_PWF_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_SIGPRO_IME', 'funcion que controla el cambio al Siguiente esado del tipo_proceso', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_ANTEPRO_IME', 'Trasaacion utilizada  pasar a  estado anterior del proceso
                    segun la operacion definida', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_TDT_INS', 'Insercion de registros', 'si', '', '', 'wf.f_tipo_dato_ime');
select pxp.f_insert_tprocedimiento ('WF_TDT_MOD', 'Modificacion de registros', 'si', '', '', 'wf.f_tipo_dato_ime');
select pxp.f_insert_tprocedimiento ('WF_TDT_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.f_tipo_dato_ime');
select pxp.f_insert_tprocedimiento ('WF_PWF_SEL', 'Consulta de datos', 'si', '', '', 'wf.f_proceso_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_PWF_CONT', 'Conteo de registros', 'si', '', '', 'wf.f_proceso_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_TRAWF_SEL', 'Consulta flujos de tramite', 'si', '', '', 'wf.f_proceso_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_TDT_SEL', 'Consulta de datos', 'si', '', '', 'wf.f_tipo_dato_sel');
select pxp.f_insert_tprocedimiento ('WF_TDT_CONT', 'Conteo de registros', 'si', '', '', 'wf.f_tipo_dato_sel');
select pxp.f_insert_tprocedimiento ('WF_DES_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_documento_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_DES_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_documento_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_DWF_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_documento_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_DWF_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_documento_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPDW_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_documento_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPDW_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_documento_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPDW_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_documento_ime');
select pxp.f_insert_tprocedimiento ('WF_CABMOM_IME', 'Cambiar Momentos (exigir, verificar) de Documentos WF', 'si', '', '', 'wf.ft_documento_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_DEPTIPES_SEL', 'Consulta los departamentos correspondientes al tipo de estado wf', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_DEPTIPES_CONT', 'Cuenta los registros de la consulta de departamentos correspondientes al tipo de estado wf', 'si', '', '', 'wf.ft_tipo_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_VERSIGPRO_IME', 'Verifica los parametros necesarios para tomar la decision sobre el sisguiente estado', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_CHKSTA_IME', 'Este procedimiento verifica los procesos disparados disponibles  y
                    retorna los datos para configurar el la interface wizard de wf (vista)', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_SESPRO_IME', 'Cambio de estado en el proceso de WF, controla tambien el inicio de los procesos disparados', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_VERSIGPRO_BK', 'Verificas los parametros necesriso para tomas la decision sobre el sisguiete estado', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_UPDPLAMEN_MOD', 'Actualizar la plantilla de mensajes de correo', 'si', '', '', 'wf.ft_tipo_estado_ime');
select pxp.f_insert_testructura_gui ('WF.1.2.2', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.3', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1.2', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1', 'WF.1.2.1.3');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1', 'WF.1.2.1.3.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.2', 'WF.1.2.1.3.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1', 'WF.1.2.1.3.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1.1', 'WF.1.2.1.3.1.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1.1.1', 'WF.1.2.1.3.1.1.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.2.1', 'WF.1.2.2');
select pxp.f_insert_testructura_gui ('INT.1', 'INT');
select pxp.f_insert_testructura_gui ('INT.2', 'INT');
select pxp.f_insert_testructura_gui ('INT.1.1', 'INT.1');
select pxp.f_insert_testructura_gui ('INT.2.1', 'INT.2');
select pxp.f_insert_testructura_gui ('STR.1', 'STR');
select pxp.f_insert_testructura_gui ('STR.2', 'STR');
select pxp.f_insert_testructura_gui ('STR.1.1', 'STR.1');
select pxp.f_insert_testructura_gui ('STR.2.1', 'STR.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.2.1', 'WF.1.2.1.3.1.2');
select pxp.f_insert_testructura_gui ('INT.2.1.1', 'INT.2.1');
select pxp.f_insert_testructura_gui ('STR.2.1.1', 'STR.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.4', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('INT.3', 'INT');
select pxp.f_insert_testructura_gui ('INT.4', 'INT');
select pxp.f_insert_testructura_gui ('INT.5', 'INT');
select pxp.f_insert_testructura_gui ('INT.3.1', 'INT.3');
select pxp.f_insert_testructura_gui ('INT.3.2', 'INT.3');
select pxp.f_insert_testructura_gui ('STR.3', 'STR');
select pxp.f_insert_testructura_gui ('STR.4', 'STR');
select pxp.f_insert_testructura_gui ('STR.5', 'STR');
select pxp.f_insert_testructura_gui ('STR.3.1', 'STR.3');
select pxp.f_insert_testructura_gui ('STR.3.2', 'STR.3');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_INS', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_MOD', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_ELI', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_SEL', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_INS', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_MOD', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_ELI', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'WF.1.2.1.3.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_INS', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_MOD', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_ELI', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_SEL', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_INS', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_MOD', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_ELI', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_SEL', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INT.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'STR.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'WF.1.2.1.3.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INT.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'STR.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.5', 'no');

/******************************************F-DAT-JRR-WF-0-25/04/2014**********************************************/

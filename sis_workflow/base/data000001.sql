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

/******************************************F-DAT-JRR-WF-0-25/04/2014**********************************************/




/******************************************I-DAT-RCM-WF-0-21/05/2014**********************************************/

select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','string');
select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','date');
select pxp.f_add_catalog('WF','ttipo_propiedad__tipo_dato','numeric');

/******************************************F-DAT-RCM-WF-0-21/05/2014**********************************************/


/******************************************I-DAT-RAC-WF-0-18/08/2014**********************************************/

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('Seguir Tramite', 'Seguimiento de tramites', 'STR', 'si', 4, 'sis_workflow/vista/proceso_wf/ProcesoWfVb.php', 2, '', 'ProcesoWfVb', 'WF');
select pxp.f_insert_tgui ('Tablas Relacionadas a este tipo proceso', 'Tablas Relacionadas a este tipo proceso', 'WF.1.2.4', 'no', 0, 'sis_workflow/vista/tabla/Tabla.php', 4, '', '90%', 'WF');
select pxp.f_insert_tgui ('Tipo Columna', 'Tipo Columna', 'WF.1.2.5', 'no', 0, 'sis_workflow/vista/tipo_columna/TipoColumna.php', 4, '', 'TipoColumna', 'WF');
select pxp.f_insert_tgui ('Origenes', 'Origenes', 'WF.1.2.6', 'no', 0, 'sis_workflow/vista/tipo_proceso_origen/TipoProcesoOrigen.php', 4, '', 'TipoProcesoOrigen', 'WF');
select pxp.f_insert_tgui ('south', 'south', 'WF.1.2.4.1', 'no', 0, 'north', 5, '', 'east', 'WF');
select pxp.f_insert_tgui ('Tabla Maestro', 'Tabla Maestro', 'WF.1.2.4.2', 'no', 0, 'vista_id_tabla_maestro', 5, '', 'vista_id_tabla_maestro', 'WF');
select pxp.f_insert_tgui ('Columnas X Estado', 'Columnas X Estado', 'WF.1.2.5.1', 'no', 0, 'sis_workflow/vista/columna_estado/ColumnaEstado.php', 5, '', '50%', 'WF');
select pxp.f_insert_tgui ('VoBo Procesos', 'VoBo procesos del work flow', 'VOBOWF', 'si', 10, 'sis_workflow/vista/proceso_wf/VoBoProceso.php', 2, '', 'VoBoProceso', 'WF');
select pxp.f_insert_tgui ('Chequear documento del WF', 'Chequear documento del WF', 'VOBOWF.1', 'no', 0, 'sis_workflow/vista/documento_wf/DocumentoWf.php', 3, '', '90%', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'VOBOWF.2', 'no', 0, 'sis_workflow/vista/estado_wf/FormEstadoWf.php', 3, '', 'FormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Estado de Wf', 'Estado de Wf', 'VOBOWF.3', 'no', 0, 'sis_workflow/vista/estado_wf/AntFormEstadoWf.php', 3, '', 'AntFormEstadoWf', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'VOBOWF.4', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 3, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'VOBOWF.5', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 3, '', 'Institucion', 'WF');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'VOBOWF.1.1', 'no', 0, 'sis_workflow/vista/documento_wf/SubirArchivoWf.php', 4, '', 'SubirArchivoWf', 'WF');
select pxp.f_insert_tgui ('Estados por momento', 'Estados por momento', 'VOBOWF.1.2', 'no', 0, 'sis_workflow/vista/tipo_documento_estado/TipoDocumentoEstadoWF.php', 4, '', 'TipoDocumentoEstadoWF', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'VOBOWF.4.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 4, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tgui ('Personas', 'Personas', 'VOBOWF.5.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'WF');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'VOBOWF.5.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'WF');
select pxp.f_insert_tfuncion ('wf.f_evaluar_regla_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_cancela_proceso_wf', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_get_codigo_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_valida_cambio_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_columna_estado_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tabla_instancia_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tabla_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tabla_instancia_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_columna_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_columna_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_comp_tipo_prop_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_componente_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_componente_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_comp_tipo_prop_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_propiedad_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_proceso_origen_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_buscar_estado_procesos_disparados', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_columna_estado_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tabla_sel', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_proceso_origen_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ft_tipo_propiedad_ime', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_registra_gui_tabla', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_proceso', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_tcolumna_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_documento_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_columna', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttabla', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_tproceso_macro', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_tlabores_tipo_proceso', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_testructura_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_documento', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_estado', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.ftrig_ttipo_proceso_origen', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tfuncion ('wf.f_import_tproceso_macro', 'Funcion para tabla     ', 'WF');
select pxp.f_insert_tprocedimiento ('WF_SIGPRO_IME', 'funcion que controla el cambio al Siguiente esado del tipo_proceso, valido solo para mobile y estados simple, sin disparon sin varios funcionarios', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_ANTEPRO_IME', 'Trasaacion utilizada  pasar a  estado anterior del proceso
                    segun la operacion definida', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_CHKSTA_IME', 'Este procedimiento verifica los procesos disparados disponibles  y
                    retorna los datos para configurar el la interface wizard de wf (vista)', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_COLEST_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_columna_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_COLEST_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_columna_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_COLEST_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_columna_estado_ime');
select pxp.f_insert_tprocedimiento ('WF_TABLAINS_INS', 'Insercion de registros en tabla autogenerada del workflow', 'si', '', '', 'wf.ft_tabla_instancia_ime');
select pxp.f_insert_tprocedimiento ('WF_TABLAINS_MOD', 'Modificacion de registros en tabla autogenerada del workflow', 'si', '', '', 'wf.ft_tabla_instancia_ime');
select pxp.f_insert_tprocedimiento ('WF_TABLAINS_ELI', 'Eliminacion de registros de tabla autogenerada en el sistema de workflow', 'si', '', '', 'wf.ft_tabla_instancia_ime');
select pxp.f_insert_tprocedimiento ('WF_tabla_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tabla_ime');
select pxp.f_insert_tprocedimiento ('WF_tabla_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tabla_ime');
select pxp.f_insert_tprocedimiento ('WF_tabla_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tabla_ime');
select pxp.f_insert_tprocedimiento ('WF_EJSCTABLA_PRO', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tabla_ime');
select pxp.f_insert_tprocedimiento ('WF_TABLAINS_SEL', 'Consulta de datos de la instancia de una tabla', 'si', '', '', 'wf.ft_tabla_instancia_sel');
select pxp.f_insert_tprocedimiento ('WF_TABLAINS_CONT', 'Conteo de registros de la instancia de tabla', 'si', '', '', 'wf.ft_tabla_instancia_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOL_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_columna_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOL_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_columna_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOLES_SEL', 'Consulta de datos por estado', 'si', '', '', 'wf.ft_tipo_columna_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOL_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_columna_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPCOL_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_columna_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPCOL_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_columna_ime');
select pxp.f_insert_tprocedimiento ('WF_TCOTPR_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_comp_tipo_prop_ime');
select pxp.f_insert_tprocedimiento ('WF_TCOTPR_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_comp_tipo_prop_ime');
select pxp.f_insert_tprocedimiento ('WF_TCOTPR_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_comp_tipo_prop_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPCOM_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_componente_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOM_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_componente_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPCOM_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_componente_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPCOM_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_componente_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPCOM_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_componente_ime');
select pxp.f_insert_tprocedimiento ('WF_TCOTPR_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_comp_tipo_prop_sel');
select pxp.f_insert_tprocedimiento ('WF_TCOTPR_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_comp_tipo_prop_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPPRO_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_propiedad_sel');
select pxp.f_insert_tprocedimiento ('WF_TIPPRO_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_propiedad_sel');
select pxp.f_insert_tprocedimiento ('WF_TPO_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tipo_proceso_origen_sel');
select pxp.f_insert_tprocedimiento ('WF_TPO_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_proceso_origen_sel');
select pxp.f_insert_tprocedimiento ('WF_COLEST_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_columna_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_COLEST_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_columna_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_tabla_SEL', 'Consulta de datos', 'si', '', '', 'wf.ft_tabla_sel');
select pxp.f_insert_tprocedimiento ('WF_tabla_CONT', 'Conteo de registros', 'si', '', '', 'wf.ft_tabla_sel');
select pxp.f_insert_tprocedimiento ('WF_TPO_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_proceso_origen_ime');
select pxp.f_insert_tprocedimiento ('WF_TPO_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_proceso_origen_ime');
select pxp.f_insert_tprocedimiento ('WF_TPO_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_proceso_origen_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPRO_INS', 'Insercion de registros', 'si', '', '', 'wf.ft_tipo_propiedad_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPRO_MOD', 'Modificacion de registros', 'si', '', '', 'wf.ft_tipo_propiedad_ime');
select pxp.f_insert_tprocedimiento ('WF_TIPPRO_ELI', 'Eliminacion de registros', 'si', '', '', 'wf.ft_tipo_propiedad_ime');
select pxp.f_insert_tprocedimiento ('WF_VOBOWF_SEL', 'Consulta de vistos buenos pendietes de prceso WF', 'si', '', '', 'wf.f_proceso_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_VOBOWF_CONT', 'Conteo de registros de Vistos buenos para el proceso WF (este listado se usa en la interface de mobile)', 'si', '', '', 'wf.f_proceso_wf_sel');
select pxp.f_insert_tprocedimiento ('WF_EVAPLA_IME', 'Evalua plantilla de estado para el WF', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_tprocedimiento ('WF_EXPTABLA_SEL', 'Consulta para exportacion de workflow', 'si', '', '', 'wf.ft_tabla_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPTIPCOL_SEL', 'Exportacion de Tipo columna', 'si', '', '', 'wf.ft_tipo_columna_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPDES_SEL', 'Conteo de registros', 'si', '', '', 'wf.ft_tipo_documento_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPTIPDW_SEL', 'Exportacion de Tipo documento', 'si', '', '', 'wf.ft_tipo_documento_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPLABTPROC_SEL', 'Exportacion de labores tipo proceso', 'si', '', '', 'wf.ft_labores_tipo_proceso_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPCOLEST_SEL', 'Conteo de registros', 'si', '', '', 'wf.ft_columna_estado_sel');
select pxp.f_insert_tprocedimiento ('WF_EXPTPO_SEL', 'Exportacion de tipo proceso origen', 'si', '', '', 'wf.ft_tipo_proceso_origen_sel');
select pxp.f_insert_tprocedimiento ('WF_CHECKVB_IME', 'Chequea si existen nuevos registros desde la ultima consulta, se usa en la interface mobile para lanzar alertas sonora', 'si', '', '', 'wf.f_proceso_wf_ime');
select pxp.f_insert_trol ('VoBo procesos de WF', 'WF - VoBo', 'WF');
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------

select pxp.f_insert_testructura_gui ('WF.1.2.4', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.5', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.6', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.4.1', 'WF.1.2.4');
select pxp.f_insert_testructura_gui ('WF.1.2.4.2', 'WF.1.2.4');
select pxp.f_insert_testructura_gui ('WF.1.2.5.1', 'WF.1.2.5');
select pxp.f_insert_testructura_gui ('VOBOWF', 'WF');
select pxp.f_insert_testructura_gui ('VOBOWF.1', 'VOBOWF');
select pxp.f_insert_testructura_gui ('VOBOWF.2', 'VOBOWF');
select pxp.f_insert_testructura_gui ('VOBOWF.3', 'VOBOWF');
select pxp.f_insert_testructura_gui ('VOBOWF.4', 'VOBOWF');
select pxp.f_insert_testructura_gui ('VOBOWF.5', 'VOBOWF');
select pxp.f_insert_testructura_gui ('VOBOWF.1.1', 'VOBOWF.1');
select pxp.f_insert_testructura_gui ('VOBOWF.1.2', 'VOBOWF.1');
select pxp.f_insert_testructura_gui ('VOBOWF.4.1', 'VOBOWF.4');
select pxp.f_insert_testructura_gui ('VOBOWF.5.1', 'VOBOWF.5');
select pxp.f_insert_testructura_gui ('VOBOWF.5.1.1', 'VOBOWF.5.1');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TABLAINS_SEL', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_tabla_SEL', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TABLAINS_INS', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TABLAINS_MOD', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_tabla_INS', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_tabla_MOD', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TABLAINS_ELI', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_tabla_ELI', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EJSCTABLA_PRO', 'WF.1.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'WF.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_UPDPLAMEN_MOD', 'WF.1.2.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TABLAINS_SEL', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_tabla_SEL', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPCOL_INS', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPCOL_MOD', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPCOL_ELI', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPCOL_SEL', 'WF.1.2.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_COLEST_INS', 'WF.1.2.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_COLEST_MOD', 'WF.1.2.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_COLEST_ELI', 'WF.1.2.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_COLEST_SEL', 'WF.1.2.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TPO_INS', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TPO_MOD', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TPO_ELI', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TPO_SEL', 'WF.1.2.6', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VOBOWF_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VOBOWF_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VOBOWF_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'VOBOWF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'VOBOWF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'VOBOWF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'VOBOWF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'VOBOWF.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'VOBOWF.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'VOBOWF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'VOBOWF.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'VOBOWF.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'VOBOWF.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'VOBOWF.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'VOBOWF.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'VOBOWF.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'VOBOWF.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'VOBOWF.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'VOBOWF.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'VOBOWF.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'VOBOWF.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'VOBOWF.5.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EVAPLA_IME', 'VOBOWF', 'si');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPPROMAC_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTIPPROC_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTABLA_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTIPES_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTIPCOL_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTIPDW_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPLABTPROC_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPDES_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPCOLEST_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPESTES_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_EXPTPO_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGPRO_IME', 'VOBOWF', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHECKVB_IME', 'VOBOWF', 'no');
select pxp.f_insert_tgui_rol ('VOBOWF', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('WF', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('SISTEMA', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.5', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.5.1', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.5.1.1', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.4', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.4.1', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.3', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.2', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.1', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.1.2', 'WF - VoBo');
select pxp.f_insert_tgui_rol ('VOBOWF.1.1', 'WF - VoBo');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DWF_MOD', 'INITRAHP.1');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DWF_ELI', 'INITRAHP.1');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_CABMOM_IME', 'INITRAHP.1');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_INS', 'INITRAHP.1.2');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_MOD', 'INITRAHP.1.2');
select pxp.f_delete_trol_procedimiento_gui ('PXP-Rol inicial', 'WF_DES_ELI', 'INITRAHP.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_GATNREP_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_TIPPROC_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_PWF_INS', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_PWF_MOD', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_PWF_ELI', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_PWF_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_VOBOWF_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_PROMAC_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_ANTEPRO_IME', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_SESPRO_IME', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSONMIN_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'PM_INSTIT_SEL', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'PM_INSTIT_INS', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'PM_INSTIT_MOD', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'PM_INSTIT_ELI', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'PM_INSTIT_SEL', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_SEL', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSONMIN_SEL', 'VOBOWF.5');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_INS', 'VOBOWF.5.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_MOD', 'VOBOWF.5.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_ELI', 'VOBOWF.5.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSONMIN_SEL', 'VOBOWF.5.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_UPFOTOPER_MOD', 'VOBOWF.5.1.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_INS', 'VOBOWF.4');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_MOD', 'VOBOWF.4');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSON_ELI', 'VOBOWF.4');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_PERSONMIN_SEL', 'VOBOWF.4');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'SEG_UPFOTOPER_MOD', 'VOBOWF.4.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DOCWFAR_MOD', 'VOBOWF.3');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DOCWFAR_MOD', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_VERSIGPRO_IME', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_CHKSTA_IME', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_TIPES_SEL', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_FUNTIPES_SEL', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DEPTIPES_SEL', 'VOBOWF.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DWF_MOD', 'VOBOWF.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DWF_ELI', 'VOBOWF.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DWF_SEL', 'VOBOWF.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_CABMOM_IME', 'VOBOWF.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_TIPPROC_SEL', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_TIPES_SEL', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DES_INS', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DES_MOD', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DES_ELI', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DES_SEL', 'VOBOWF.1.2');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_DOCWFAR_MOD', 'VOBOWF.1.1');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_EVAPLA_IME', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_SIGPRO_IME', 'VOBOWF');
select pxp.f_insert_trol_procedimiento_gui ('WF - VoBo', 'WF_CHECKVB_IME', 'VOBOWF');

/******************************************F-DAT-RAC-WF-0-18/08/2014**********************************************/


/******************************************I-DAT-RAC-WF-0-20/03/2014**********************************************/

select pxp.f_insert_tgui ('Categoria Documento', 'Categorias de Documento', 'CATDOC', 'si', 1, 'sis_workflow/vista/categoria_documento/CategoriaDocumento.php', 2, '', 'CategoriaDocumento', 'WF');
select pxp.f_insert_testructura_gui ('CATDOC', 'WF');

/******************************************F-DAT-RAC-WF-0-20/03/2014**********************************************/





/***********************************I-DAT-RAC-WF-0-13/0/2015*****************************************/

select pxp.f_insert_tgui ('Observaciones', 'Observaciones del WF', 'OBSFUN', 'si', 106, 'sis_workflow/vista/obs/ObsFuncionario.php', 1, '', 'ObsFuncionario', 'PXP');
select pxp.f_insert_testructura_gui ('OBSFUN', 'SISTEMA');
/***********************************F-DAT-RAC-WF-0-13/0/2015*****************************************/

/***********************************I-DAT-MMV-WF-0-29/05/2017*****************************************/
select pxp.f_insert_tgui ('Bitacoras Procesos', 'Bitacoras Procesos', 'BP', 'si', 11, 'sis_workflow/vista/reporte_procesos/FromFiltro.php', 2, '', 'FormFiltro', 'WF');
select pxp.f_insert_testructura_gui ('BP', 'WF');
/***********************************F-DAT-MMV-WF-0-29/05/2017*****************************************/


/***********************************I-DAT-RAC-WF-0-30/05/2017*****************************************/

select pxp.f_insert_tgui ('<i class="fa fa-cogs fa-2x"></i> FLUJO DE TRABAJO', '', 'WF', 'si', 3, '', 1, '', '', 'WF');

/***********************************F-DAT-RAC-WF-0-30/05/2017*****************************************/





/********************************************I-DAT-RAC-ORGA-0-31/12/2012********************************************/



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
VALUES ('ORGA', 'Organigrama', '2009-11-02', 'OR', 'activo', 'organigrama', NULL);


-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------


select pxp.f_insert_tgui ('Parametros de RRHH', 'Parametros de RRHH', 'PARRHH', 'si', 1, 'sis_organigrama/vista/parametro_rhum/parametro_rhum.js', 3, '', 'parametro_rhum', 'ORGA');



select pxp.f_insert_tgui ('Definicion de Planillas', 'Definicion de Planillas', 'DEFPLAN', 'si', 1, '', 3, '', '', 'ORGA');
select pxp.f_insert_tgui ('Tipo Columna', 'Tipo Columna', 'TIPCOL', 'si', 1, 'sis_organigrama/vista/tipo_columna/tipo_columna.js', 4, '', 'tipo_columna', 'ORGA');
select pxp.f_insert_tgui ('Estructura Organizacional', 'Estructura Organizacional', 'ESTORG', 'si', 2, 'sis_organigrama/vista/estructura_uo/EstructuraUo.php', 3, '', 'EstructuraUo', 'ORGA');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'FUNCIO', 'si', 1, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'ORGA');
select pxp.f_insert_tgui ('Parametros', 'Parametros', 'PARAMRH', 'si', 1, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Procesos', 'Procesos', 'PROCRH', 'si', 2, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Reportes', 'Reportes', 'REPRH', 'si', 3, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('ORGANIGRAMA', 'Organigrama Institucional', 'ORGA', 'si', 5, '', 1, '../../../lib/imagenes/orga32x32.png', '', 'ORGA');
select pxp.f_insert_testructura_gui ('PARRHH', 'PARAMRH');
select pxp.f_insert_testructura_gui ('DEFPLAN', 'PARAMRH');
select pxp.f_insert_testructura_gui ('TIPCOL', 'DEFPLAN');
select pxp.f_insert_testructura_gui ('ESTORG', 'PARAMRH');
select pxp.f_insert_testructura_gui ('FUNCIO', 'PROCRH');
select pxp.f_insert_testructura_gui ('PARAMRH', 'ORGA');
select pxp.f_insert_testructura_gui ('PROCRH', 'ORGA');
select pxp.f_insert_testructura_gui ('REPRH', 'ORGA');
select pxp.f_insert_testructura_gui ('ORGA', 'SISTEMA');


----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------
select pxp.f_insert_tfuncion ('orga.ft_estructura_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_uo_funcionario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_funcionario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_obtener_uo_x_funcionario', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_estructura_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_tipo_horario_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_uo_funcionario_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_obtener_funcionarios_x_uo', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_usuario_uo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_funcionario_especialidad_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_especialidad_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_depto_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_uo_arb_inicia', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_uo_arb_recursivo', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_especialidad_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_especialidad_nivel_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_tipo_horario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_usuario_uo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_depto_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_funcionario_especialidad_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_especialidad_nivel_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_funcionario_ime', 'Funcion para tabla     ', 'ORGA');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------





select pxp.f_insert_tprocedimiento ('RH_ESTRUO_ELI', '	Inactiva la parametrizacion selecionada. Verifica dependencias hacia abajo
', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_MOD', '	Modifica la parametrizacion seleccionada
', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_INS', '	Inserta estructura de uos
', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_ELI', '	Inactiva la parametrizacion selecionada
', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_MOD', '	Modifica la parametrizacion seleccionada
', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_INS', '	Inserta uos
', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_CONT', '	Conteo de uos
', 'si', '', '', 'orga.ft_uo_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_SEL', '	Listado de uo funcionarios
', 'si', '', '', 'orga.ft_uo_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_CONT', '	Conteo de funcionarios con cargos historicos
', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_SEL', '	Listado de funcionarios con cargos historicos
', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_CONT', '	Conteo de funcionarios
', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_SEL', '	Listado de funcionarios
', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_CONT', '	Conteo de estructura uos
', 'si', '', '', 'orga.ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_SEL', '	Listado de uos
', 'si', '', '', 'orga.ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_CONT', '	Conteo de uos
', 'si', '', '', 'orga.ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_SEL', '	Listado de uos
', 'si', '', '', 'orga.ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_MOD', '	Modificacion de registros
 	', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_INS', '	Insercion de registros
 	', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_ELI', '	Inactiva la parametrizacion selecionada
', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_MOD', '	Modifica la parametrizacion seleccionada
', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_INS', '	Inserta uos funcionario
', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_MOD', '	Modificacion de registros
 	', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_INS', '	Insercion de registros
 	', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_RHESFU_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'orga.f_funcionario_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_RHESFU_MOD', '	Modificacion de registros
 	', 'si', '', '', 'orga.f_funcionario_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_RHESFU_INS', '	Insercion de registros
 	', 'si', '', '', 'orga.f_funcionario_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_ESPCIA_CONT', '	Conteo de registros
 	', 'si', '', '', 'orga.f_especialidad_sel');
select pxp.f_insert_tprocedimiento ('RH_ESPCIA_SEL', '	Consulta de datos
 	', 'si', '', '', 'orga.f_especialidad_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_ELI', '	Inactiva el depto selecionado
', 'si', '', '', 'orga.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_MOD', '	Modifica la depto seleccionada
', 'si', '', '', 'orga.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_INS', '	Inserta deptos
', 'si', '', '', 'orga.ft_depto_ime');
select pxp.f_insert_tprocedimiento ('RH_INIUOARB_SEL', '	Filtro en organigrama
 	', 'si', '', '', 'orga.f_uo_arb_inicia');
select pxp.f_insert_tprocedimiento ('RH_ESPCIA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'orga.f_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_ESPCIA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'orga.f_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_ESPCIA_INS', '	Insercion de registros
 	', 'si', '', '', 'orga.f_especialidad_ime');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_CONT', '	Conteo de registros
 	', 'si', '', '', 'orga.ft_especialidad_nivel_sel');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_SEL', '	Consulta de datos
 	', 'si', '', '', 'orga.ft_especialidad_nivel_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_CONT', '	Conteo de registros
 	', 'si', '', '', 'orga.f_tipo_horario_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_SEL', '	Consulta de datos
 	', 'si', '', '', 'orga.f_tipo_horario_sel');
select pxp.f_insert_tprocedimiento ('PM_UUO_CONT', '	Conteo de registros
 	', 'si', '', '', 'orga.ft_usuario_uo_sel');
select pxp.f_insert_tprocedimiento ('PM_UUO_SEL', '	Consulta de datos
 	', 'si', '', '', 'orga.ft_usuario_uo_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_CONT', '	cuenta la cantidad de departamentos
', 'si', '', '', 'orga.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('PM_DEPPTO_SEL', '	Listado de departamento
', 'si', '', '', 'orga.ft_depto_sel');
select pxp.f_insert_tprocedimiento ('RH_RHESFU_CONT', '	Conteo de registros
 	', 'si', '', '', 'orga.f_funcionario_especialidad_sel');
select pxp.f_insert_tprocedimiento ('RH_RHESFU_SEL', '	Consulta de datos
 	', 'si', '', '', 'orga.f_funcionario_especialidad_sel');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_MOD', '	Modificacion de registros
 	', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_INS', '	Insercion de registros
 	', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_ELI', '	Inactiva la parametrizacion selecionada
', 'si', '', '', 'orga.ft_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_MOD', '	Modifica la parametrizacion seleccionada
', 'si', '', '', 'orga.ft_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_INS', '	Inserta Funcionarios
', 'si', '', '', 'orga.ft_funcionario_ime');



------------------------------------
--DEF DE OTROS DATOS
-------------------------------------


/********************************************F-DAT-RAC-ORGA-0-31/12/2012********************************************/



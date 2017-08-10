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
select pxp.f_insert_tfuncion ('orga.f_uo_arb_inicia', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_uo_arb_recursivo', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_especialidad_nivel_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_tipo_horario_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_usuario_uo_sel', 'Funcion para tabla     ', 'ORGA');
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
select pxp.f_insert_tprocedimiento ('RH_INIUOARB_SEL', '	Filtro en organigrama
 	', 'si', '', '', 'orga.f_uo_arb_inicia');
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

/********************************************I-DAT-RCM-ALM-0-16/08/2013********************************************/
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Todos los Funcionarios');
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Seleccionar Funcionarios');
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Por Organigrama');
/********************************************F-DAT-RCM-ALM-0-16/08/2013********************************************/
/*****************************I-DAT-JRR-ORGA-0-9/01/2014*************/
select pxp.f_delete_tgui ('PARRHH');
select pxp.f_delete_tgui ('DEFPLAN');
select pxp.f_delete_tgui ('TIPCOL');
select pxp.f_insert_tgui ('Definición de Cargos', 'Definición de Cargos', 'CARPCARG', 'si', 2, '', 3, '', '', 'ORGA');
select pxp.f_insert_tgui ('Jerarquia Aprobación', 'Jerarquia Aprobacion', 'JERAPRO', 'si', 1, 'sis_organigrama/vista/temporal_jerarquia_aprobacion/TemporalJerarquiaAprobacion.php', 4, '', 'TemporalJerarquiaAprobacion', 'ORGA');
select pxp.f_insert_tgui ('Categoria Salarial', 'Escala Salarial', 'ESCASAL', 'si', 2, 'sis_organigrama/vista/categoria_salarial/CategoriaSalarial.php', 4, '', 'CategoriaSalarial', 'ORGA');
select pxp.f_insert_tgui ('Nivel Organizacional', 'Nivel Organizacional', 'NIVORGA', 'si', 3, 'sis_organigrama/vista/nivel_organizacional/NivelOrganizacional.php', 3, '', 'NivelOrganizacional', 'ORGA');
select pxp.f_insert_tgui ('Tipo Contrato', 'Tipo Contrato', 'ORTIPCON', 'si', 3, 'sis_organigrama/vista/tipo_contrato/TipoContrato.php', 4, '', 'TipoContrato', 'ORGA');
select pxp.f_insert_tgui ('Oficina', 'Oficina', 'OFICI', 'si', 2, 'sis_organigrama/vista/oficina/Oficina.php', 3, '', 'Oficina', 'ORGA');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'ESTORG.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 4, '', 'Cargo', 'ORGA');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'ESTORG.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 4, '', '50%', 'ORGA');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'ESTORG.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 5, '', '50%', 'ORGA');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'ESTORG.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 5, '', 'CargoCentroCosto', 'ORGA');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ESTORG.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 5, '', 'funcionario', 'ORGA');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ESTORG.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 6, '', 'FuncionarioCuentaBancaria', 'ORGA');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ESTORG.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'ORGA');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ESTORG.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 7, '', 'Institucion', 'ORGA');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ESTORG.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'ORGA');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ESTORG.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 9, '', 'subirFotoPersona', 'ORGA');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'FUNCIO.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 4, '', 'FuncionarioCuentaBancaria', 'ORGA');
select pxp.f_insert_tgui ('Personas', 'Personas', 'FUNCIO.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 4, '', 'persona', 'ORGA');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'FUNCIO.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 5, '', 'Institucion', 'ORGA');
select pxp.f_insert_tgui ('Personas', 'Personas', 'FUNCIO.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 6, '', 'persona', 'ORGA');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'FUNCIO.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'ORGA');
select pxp.f_insert_tgui ('Cargos por Jerarquia', 'Cargos por Jerarquia', 'JERAPRO.1', 'no', 0, 'sis_organigrama/vista/temporal_cargo/TemporalCargo.php', 5, '', '50%', 'ORGA');
select pxp.f_insert_tgui ('Escala Salarial por Categoria', 'Escala Salarial por Categoria', 'ESCASAL.1', 'no', 0, 'sis_organigrama/vista/escala_salarial/EscalaSalarial.php', 5, '', '50%', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_categoria_salarial_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_nivel_organizacional_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_temporal_jerarquia_aprobacion_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_categoria_salarial_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_nivel_organizacional_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_temporal_jerarquia_aprobacion_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_temporal_cargo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_escala_salarial_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_escala_salarial_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_tipo_contrato_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_tipo_contrato_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_presupuesto_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_empleado_x_item', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_presupuesto_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_centro_costo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_oficina_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_oficina_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_cargos_en_uso', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_funcionarios_con_asignacion_activa', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_existe_columna', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_funcionario_cuenta_bancaria_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_funcionario_cuenta_bancaria_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_temporal_cargo_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_cargo_centro_costo_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_uo_presupuesta', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_id_uo', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_aprobadores_x_funcionario', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_obtener_funcionarios_x_uo_array', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_funcionarios_x_usuario_asistente', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_ELI', 'Inactiva la parametrizacion selecionada. Verifica dependencias hacia abajo', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_MOD', 'Modifica la parametrizacion seleccionada', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_INS', 'Inserta estructura de uos', 'si', '', '', 'orga.ft_estructura_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_ELI', 'Inactiva la parametrizacion selecionada', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_MOD', 'Modifica la parametrizacion seleccionada', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UO_INS', 'Inserta uos', 'si', '', '', 'orga.ft_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_CONT', 'Conteo de uos', 'si', '', '', 'orga.ft_uo_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_SEL', 'Listado de uo funcionarios', 'si', '', '', 'orga.ft_uo_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_CONT', 'Conteo de funcionarios con cargos historicos', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIOCAR_SEL', 'Listado de funcionarios con cargos historicos', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_CONT', 'Conteo de funcionarios', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_SEL', 'Listado de funcionarios', 'si', '', '', 'orga.ft_funcionario_sel');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_CONT', 'Conteo de estructura uos', 'si', '', '', 'orga.ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_ESTRUO_SEL', 'Listado de uos', 'si', '', '', 'orga.ft_estructura_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_CONT', 'Conteo de uos', 'si', '', '', 'orga.ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_UO_SEL', 'Listado de uos', 'si', '', '', 'orga.ft_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_MOD', 'Modificacion de registros', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_INS', 'Insercion de registros', 'si', '', '', 'orga.f_tipo_horario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_ELI', 'Inactiva la parametrizacion selecionada', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_MOD', 'Modifica la parametrizacion seleccionada', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_UOFUNC_INS', 'Inserta uos funcionario', 'si', '', '', 'orga.ft_uo_funcionario_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('PM_uuo_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_usuario_uo_ime');
select pxp.f_insert_tprocedimiento ('RH_INIUOARB_SEL', 'Filtro en organigrama', 'si', '', '', 'orga.f_uo_arb_inicia');;
select pxp.f_insert_tprocedimiento ('RH_RHNIES_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_especialidad_nivel_sel');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_especialidad_nivel_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_CONT', 'Conteo de registros', 'si', '', '', 'orga.f_tipo_horario_sel');
select pxp.f_insert_tprocedimiento ('RH_RHTIHO_SEL', 'Consulta de datos', 'si', '', '', 'orga.f_tipo_horario_sel');
select pxp.f_insert_tprocedimiento ('PM_UUO_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_usuario_uo_sel');
select pxp.f_insert_tprocedimiento ('PM_UUO_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_usuario_uo_sel');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_RHNIES_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_especialidad_nivel_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_ELI', 'Inactiva la parametrizacion selecionada', 'si', '', '', 'orga.ft_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_MOD', 'Modifica la parametrizacion seleccionada', 'si', '', '', 'orga.ft_funcionario_ime');
select pxp.f_insert_tprocedimiento ('RH_FUNCIO_INS', 'Inserta Funcionarios', 'si', '', '', 'orga.ft_funcionario_ime');
select pxp.f_insert_tprocedimiento ('OR_CATSAL_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_categoria_salarial_sel');
select pxp.f_insert_tprocedimiento ('OR_CATSAL_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_categoria_salarial_sel');
select pxp.f_insert_tprocedimiento ('OR_NIVORG_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_nivel_organizacional_ime');
select pxp.f_insert_tprocedimiento ('OR_NIVORG_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_nivel_organizacional_ime');
select pxp.f_insert_tprocedimiento ('OR_NIVORG_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_nivel_organizacional_ime');
select pxp.f_insert_tprocedimiento ('OR_JERAPR_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_temporal_jerarquia_aprobacion_sel');
select pxp.f_insert_tprocedimiento ('OR_JERAPR_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_temporal_jerarquia_aprobacion_sel');
select pxp.f_insert_tprocedimiento ('OR_CATSAL_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_categoria_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_CATSAL_MOD', 'Modificacion de categoria salarial e incremento salarial por categoria', 'si', '', '', 'orga.ft_categoria_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_CATSAL_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_categoria_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_NIVORG_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_nivel_organizacional_sel');
select pxp.f_insert_tprocedimiento ('OR_NIVORG_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_nivel_organizacional_sel');
select pxp.f_insert_tprocedimiento ('OR_JERAPR_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_temporal_jerarquia_aprobacion_ime');
select pxp.f_insert_tprocedimiento ('OR_JERAPR_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_temporal_jerarquia_aprobacion_ime');
select pxp.f_insert_tprocedimiento ('OR_JERAPR_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_temporal_jerarquia_aprobacion_ime');
select pxp.f_insert_tprocedimiento ('OR_TCARGO_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_temporal_cargo_sel');
select pxp.f_insert_tprocedimiento ('OR_TCARGO_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_temporal_cargo_sel');
select pxp.f_insert_tprocedimiento ('OR_ESCSAL_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_escala_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_ESCSAL_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_escala_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_ESCSAL_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_escala_salarial_ime');
select pxp.f_insert_tprocedimiento ('OR_ESCSAL_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_escala_salarial_sel');
select pxp.f_insert_tprocedimiento ('OR_ESCSAL_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_escala_salarial_sel');
select pxp.f_insert_tprocedimiento ('OR_TIPCON_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_tipo_contrato_sel');
select pxp.f_insert_tprocedimiento ('OR_TIPCON_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_tipo_contrato_sel');
select pxp.f_insert_tprocedimiento ('OR_TIPCON_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_tipo_contrato_ime');
select pxp.f_insert_tprocedimiento ('OR_TIPCON_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_tipo_contrato_ime');
select pxp.f_insert_tprocedimiento ('OR_TIPCON_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_tipo_contrato_ime');
select pxp.f_insert_tprocedimiento ('OR_CARPRE_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_cargo_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('OR_CARPRE_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_cargo_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('OR_CARPRE_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_cargo_presupuesto_ime');
select pxp.f_insert_tprocedimiento ('OR_CARPRE_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_cargo_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('OR_CARPRE_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_cargo_presupuesto_sel');
select pxp.f_insert_tprocedimiento ('OR_CARCC_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_cargo_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARCC_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_cargo_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARCC_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_cargo_centro_costo_ime');
select pxp.f_insert_tprocedimiento ('OR_OFI_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_oficina_ime');
select pxp.f_insert_tprocedimiento ('OR_OFI_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_oficina_ime');
select pxp.f_insert_tprocedimiento ('OR_OFI_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_oficina_ime');
select pxp.f_insert_tprocedimiento ('OR_OFI_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_oficina_sel');
select pxp.f_insert_tprocedimiento ('OR_OFI_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_oficina_sel');
select pxp.f_insert_tprocedimiento ('OR_CARGO_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARGO_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARGO_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARGO_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_cargo_sel');
select pxp.f_insert_tprocedimiento ('OR_CARGO_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_cargo_sel');
select pxp.f_insert_tprocedimiento ('OR_FUNCUE_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_funcionario_cuenta_bancaria_sel');
select pxp.f_insert_tprocedimiento ('OR_FUNCUE_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_funcionario_cuenta_bancaria_sel');
select pxp.f_insert_tprocedimiento ('OR_FUNCUE_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_funcionario_cuenta_bancaria_ime');
select pxp.f_insert_tprocedimiento ('OR_FUNCUE_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_funcionario_cuenta_bancaria_ime');
select pxp.f_insert_tprocedimiento ('OR_FUNCUE_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_funcionario_cuenta_bancaria_ime');
select pxp.f_insert_tprocedimiento ('OR_TCARGO_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_temporal_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_TCARGO_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_temporal_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_TCARGO_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_temporal_cargo_ime');
select pxp.f_insert_tprocedimiento ('OR_CARCC_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_cargo_centro_costo_sel');
select pxp.f_insert_tprocedimiento ('OR_CARCC_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_cargo_centro_costo_sel');
select pxp.f_delete_testructura_gui ('PARRHH', 'PARAMRH');
select pxp.f_delete_testructura_gui ('DEFPLAN', 'PARAMRH');
select pxp.f_delete_testructura_gui ('TIPCOL', 'DEFPLAN');
select pxp.f_insert_testructura_gui ('CARPCARG', 'PARAMRH');
select pxp.f_insert_testructura_gui ('JERAPRO', 'CARPCARG');
select pxp.f_insert_testructura_gui ('ESCASAL', 'CARPCARG');
select pxp.f_insert_testructura_gui ('NIVORGA', 'PARAMRH');
select pxp.f_insert_testructura_gui ('ORTIPCON', 'CARPCARG');
select pxp.f_insert_testructura_gui ('OFICI', 'PARAMRH');
select pxp.f_insert_testructura_gui ('ESTORG.1', 'ESTORG');
select pxp.f_insert_testructura_gui ('ESTORG.2', 'ESTORG');
select pxp.f_insert_testructura_gui ('ESTORG.1.1', 'ESTORG.1');
select pxp.f_insert_testructura_gui ('ESTORG.1.2', 'ESTORG.1');
select pxp.f_insert_testructura_gui ('ESTORG.2.1', 'ESTORG.2');
select pxp.f_insert_testructura_gui ('ESTORG.2.1.1', 'ESTORG.2.1');
select pxp.f_insert_testructura_gui ('ESTORG.2.1.2', 'ESTORG.2.1');
select pxp.f_insert_testructura_gui ('ESTORG.2.1.1.1', 'ESTORG.2.1.1');
select pxp.f_insert_testructura_gui ('ESTORG.2.1.1.1.1', 'ESTORG.2.1.1.1');
select pxp.f_insert_testructura_gui ('ESTORG.2.1.1.1.1.1', 'ESTORG.2.1.1.1.1');
select pxp.f_insert_testructura_gui ('FUNCIO.1', 'FUNCIO');
select pxp.f_insert_testructura_gui ('FUNCIO.2', 'FUNCIO');
select pxp.f_insert_testructura_gui ('FUNCIO.1.1', 'FUNCIO.1');
select pxp.f_insert_testructura_gui ('FUNCIO.1.1.1', 'FUNCIO.1.1');
select pxp.f_insert_testructura_gui ('FUNCIO.1.1.1.1', 'FUNCIO.1.1.1');
select pxp.f_insert_testructura_gui ('JERAPRO.1', 'JERAPRO');
select pxp.f_insert_testructura_gui ('ESCASAL.1', 'ESCASAL');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_SEL', 'ESTORG', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'ESTORG', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_ESTRUO_SEL', 'ESTORG', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_SEL', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_SEL', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_SEL', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_SEL', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_INS', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_MOD', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_ELI', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ESTORG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_INS', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_MOD', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_ELI', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_INS', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_MOD', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_ELI', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_SEL', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ESTORG.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ESTORG.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ESTORG.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ESTORG.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'ESTORG.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'ESTORG.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'ESTORG.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'ESTORG.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ESTORG.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ESTORG.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ESTORG.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ESTORG.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ESTORG.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ESTORG.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'ESTORG.2.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ESTORG.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ESTORG.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ESTORG.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ESTORG.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'FUNCIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'FUNCIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'FUNCIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'FUNCIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'FUNCIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'FUNCIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'FUNCIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'FUNCIO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'FUNCIO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'FUNCIO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'FUNCIO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'FUNCIO.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'FUNCIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'FUNCIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'FUNCIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'FUNCIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_JERAPR_INS', 'JERAPRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_JERAPR_MOD', 'JERAPRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_JERAPR_ELI', 'JERAPRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_JERAPR_SEL', 'JERAPRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_INS', 'JERAPRO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_MOD', 'JERAPRO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_ELI', 'JERAPRO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_SEL', 'JERAPRO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CATSAL_INS', 'ESCASAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CATSAL_MOD', 'ESCASAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CATSAL_ELI', 'ESCASAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CATSAL_SEL', 'ESCASAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_INS', 'ESCASAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_MOD', 'ESCASAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_ELI', 'ESCASAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_SEL', 'ESCASAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_INS', 'NIVORGA', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_MOD', 'NIVORGA', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_ELI', 'NIVORGA', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_SEL', 'NIVORGA', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_INS', 'ORTIPCON', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_MOD', 'ORTIPCON', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_ELI', 'ORTIPCON', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_SEL', 'ORTIPCON', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_SEL', 'OFICI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_ARB_SEL', 'OFICI', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_INS', 'OFICI', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_MOD', 'OFICI', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_ELI', 'OFICI', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_SEL', 'OFICI', 'no');
/*****************************F-DAT-JRR-ORGA-0-9/01/2014*************/

/*****************************I-DAT-JRR-ORGA-0-25/04/2014*************/
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ESTORG.2.1.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 7, '', 'subirFotoPersona', 'ORGA');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'FUNCIO.2.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 5, '', 'subirFotoPersona', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_uos_x_gerencia', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_uo_planilla', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_uo_gerencia', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_uos_x_planilla', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tprocedimiento ('RH_MAILFUN_GET', 'Recuepra el email del funcionario', 'si', '', '', 'orga.ft_funcionario_ime');

/*****************************F-DAT-JRR-ORGA-0-25/04/2014*************/


/*****************************I-DAT-RAC-ORGA-0-21/05/2014*************/

select pxp.f_insert_tgui ('Interinos', 'Registro de Interinos', 'Interinos', 'si', 1, 'sis_organigrama/vista/interinato/AsignarInterino.php', 3, '', 'AsignarInterino', 'ORGA');
select pxp.f_insert_testructura_gui ('Interinos', 'PROCRH');


/*****************************F-DAT-RAC-ORGA-0-21/05/2014*************/


/*****************************I-DAT-RAC-ORGA-0-05/08/2014*************/


select pxp.f_insert_tgui ('Servicios de la Oficina', 'Servicios de la Oficina', 'OFICI.1', 'no', 0, 'sis_organigrama/vista/oficina_cuenta/OficinaCuenta.php', 4, '', 'OficinaCuenta', 'ORGA');
select pxp.f_insert_tgui ('Asignacion de Interinos', 'Asignacion de interinos general', 'ASIGINGEN', 'si', 1, 'sis_organigrama/vista/interinato/Interinato.php', 3, '', 'Interinato', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_funcionarios_x_cargo', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_interinato_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_interinato_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_oficina_cuenta_sel', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.ft_oficina_cuenta_ime', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_prorratear_x_empleado', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tfuncion ('orga.f_get_ultimo_centro_costo_funcionario', 'Funcion para tabla     ', 'ORGA');
select pxp.f_insert_tprocedimiento ('OR_INT_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_interinato_ime');
select pxp.f_insert_tprocedimiento ('OR_INT_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_interinato_ime');
select pxp.f_insert_tprocedimiento ('OR_INT_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_interinato_ime');
select pxp.f_insert_tprocedimiento ('OR_APLINT_IME', 'captura los datos del interinato selecionado para su postrior aplicacion', 'si', '', '', 'orga.ft_interinato_ime');
select pxp.f_insert_tprocedimiento ('OR_INT_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_interinato_sel');
select pxp.f_insert_tprocedimiento ('OR_INT_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_interinato_sel');
select pxp.f_insert_tprocedimiento ('OR_OFCU_SEL', 'Consulta de datos', 'si', '', '', 'orga.ft_oficina_cuenta_sel');
select pxp.f_insert_tprocedimiento ('OR_OFCU_CONT', 'Conteo de registros', 'si', '', '', 'orga.ft_oficina_cuenta_sel');
select pxp.f_insert_tprocedimiento ('OR_OFCU_INS', 'Insercion de registros', 'si', '', '', 'orga.ft_oficina_cuenta_ime');
select pxp.f_insert_tprocedimiento ('OR_OFCU_MOD', 'Modificacion de registros', 'si', '', '', 'orga.ft_oficina_cuenta_ime');
select pxp.f_insert_tprocedimiento ('OR_OFCU_ELI', 'Eliminacion de registros', 'si', '', '', 'orga.ft_oficina_cuenta_ime');


/*****************************F-DAT-RAC-ORGA-0-05/08/2014*************/


/*****************************I-DAT-LPZ-ORGA-0-11/05/2016*************/

select pxp.f_insert_tgui ('Nivel Especialidad', 'Organiza deacuardo a la especialidad que se registra o grado de instruccion que se tiene', 'NIVESPE', 'si', 5, 'sis_organigrama/vista/especialidad_nivel/EspecialidadNivel.php', 3, '', 'EspecialidadNivel', 'ORGA');
select pxp.f_insert_testructura_gui ('NIVESPE', 'PARAMRH');

/*****************************F-DAT-LPZ-ORGA-0-11/05/2016*************/



/*****************************I-DAT-RAC-ORGA-0-14/06/2016*************/
/* Data for the 'pxp.variable_global' table  (Records 1 - 2) */

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES 
  (E'orga_codigo_gerencia_financiera', E'GAF', E'codigo de la uo correspondiente a la gerencia financiera'),
  (E'orga_codigo_gerencia_general', E'GG', E'codigo de la uo correspomndiente a gerencia general');



/*****************************F-DAT-RAC-ORGA-0-14/06/2016*************/

/*****************************I-DAT-JRR-ORGA-0-02/05/2017*************/
/* Data for the 'pxp.variable_global' table  (Records 1 - 2) */

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES
  (E'orga_exigir_ot', E'no', E'obligara a registrar ot en las tablas cargo_presupuesto y cargo_centro_costo');

/*****************************F-DAT-JRR-ORGA-0-02/05/2017*************/




/*****************************I-DAT-RAC-ORGA-0-30/05/2017*************/
select pxp.f_insert_tgui ('<i class="fa fa-sitemap fa-2x"></i> ORGANIGRAMA', 'Organigrama Institucional', 'ORGA', 'si', 5, '', 1, '', '', 'ORGA');
/*****************************F-DAT-RAC-ORGA-0-30/05/2017*************/




/*****************************I-DAT-RAC-ORGA-0-08/08/2017*************/

------------- SQL ---------------

ALTER TABLE orga.tfuncionario
  ADD COLUMN id_auxiliar INTEGER;

COMMENT ON COLUMN orga.tfuncionario.id_auxiliar
IS 'ahce referencia al id_auciliar_contable del funcionario, es de uso opcional';


/*****************************F-DAT-RAC-ORGA-0-08/08/2017*************/



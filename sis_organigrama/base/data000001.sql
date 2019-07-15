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



select pxp.f_insert_tgui ('Estructura Organizacional', 'Estructura Organizacional', 'ESTORG', 'si', 2, 'sis_organigrama/vista/estructura_uo/EstructuraUo.php', 3, '', 'EstructuraUo', 'ORGA');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'FUNCIO', 'si', 1, 'sis_organigrama/vista/funcionario/Funcionario.php', 3, '', 'funcionario', 'ORGA');
select pxp.f_insert_tgui ('Parametros', 'Parametros', 'PARAMRH', 'si', 1, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Procesos', 'Procesos', 'PROCRH', 'si', 2, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('Reportes', 'Reportes', 'REPRH', 'si', 3, '', 2, '', '', 'ORGA');
select pxp.f_insert_tgui ('<i class="fa fa-sitemap fa-2x"></i> ORGANIGRAMA', 'Organigrama Institucional', 'ORGA', 'si', 5, '', 1, '', '', 'ORGA');
select pxp.f_insert_tgui ('Definición de Cargos', 'Definición de Cargos', 'CARPCARG', 'si', 2, '', 3, '', '', 'ORGA');
select pxp.f_insert_tgui ('Jerarquia Aprobación', 'Jerarquia Aprobacion', 'JERAPRO', 'si', 1, 'sis_organigrama/vista/temporal_jerarquia_aprobacion/TemporalJerarquiaAprobacion.php', 4, '', 'TemporalJerarquiaAprobacion', 'ORGA');
select pxp.f_insert_tgui ('Categoria Salarial', 'Escala Salarial', 'ESCASAL', 'si', 2, 'sis_organigrama/vista/categoria_salarial/CategoriaSalarial.php', 4, '', 'CategoriaSalarial', 'ORGA');
select pxp.f_insert_tgui ('Nivel Organizacional', 'Nivel Organizacional', 'NIVORGA', 'si', 3, 'sis_organigrama/vista/nivel_organizacional/NivelOrganizacional.php', 3, '', 'NivelOrganizacional', 'ORGA');
select pxp.f_insert_tgui ('Tipo Contrato', 'Tipo Contrato', 'ORTIPCON', 'si', 3, 'sis_organigrama/vista/tipo_contrato/TipoContrato.php', 4, '', 'TipoContrato', 'ORGA');
select pxp.f_insert_tgui ('Oficina', 'Oficina', 'OFICI', 'si', 2, 'sis_organigrama/vista/oficina/Oficina.php', 3, '', 'Oficina', 'ORGA');
select pxp.f_insert_tgui ('Interinos', 'Registro de Interinos', 'Interinos', 'si', 1, 'sis_organigrama/vista/interinato/AsignarInterino.php', 3, '', 'AsignarInterino', 'ORGA');
select pxp.f_insert_tgui ('Asignacion de Interinos', 'Asignacion de interinos general', 'ASIGINGEN', 'si', 1, 'sis_organigrama/vista/interinato/Interinato.php', 3, '', 'Interinato', 'ORGA');
select pxp.f_insert_tgui ('Nivel Especialidad', 'Organiza deacuardo a la especialidad que se registra o grado de instruccion que se tiene', 'NIVESPE', 'si', 5, 'sis_organigrama/vista/especialidad_nivel/EspecialidadNivel.php', 3, '', 'EspecialidadNivel', 'ORGA');



/********************************************F-DAT-RAC-ORGA-0-31/12/2012********************************************/

/********************************************I-DAT-RCM-ALM-0-16/08/2013********************************************/
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Todos los Funcionarios');
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Seleccionar Funcionarios');
select pxp.f_add_catalog('ORGA','tfuncionario__opciones','Por Organigrama');
/********************************************F-DAT-RCM-ALM-0-16/08/2013********************************************/



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




/*****************************I-DAT-JRR-ORGA-30-15/07/2019*************/

select pxp.f_insert_tgui ('Tipo de Cargo', 'Tipos de Cargo', 'TIPCAR', 'si', 1, 'sis_organigrama/vista/tipo_cargo/TipoCargo.php', 4, '', 'TipoCargo', 'ORGA');
select pxp.f_insert_testructura_gui ('TIPCAR', 'CARPCARG');


/*****************************F-DAT-JRR-ORGA-30-15/07/2019*************/





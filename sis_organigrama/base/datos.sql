
-----------------------------------------------------------------DATA--------------------------------------------------

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('ORGA', 'Organigrama', '2009-11-02', 'OR', 'activo', 'organigrama', NULL);

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



-- Funcionario
INSERT INTO orga.tfuncionario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_funcionario, id_persona, codigo, email_empresa, interno, fecha_ingreso)
VALUES (1, NULL, '2012-11-10 12:56:13', '2012-11-10 12:56:13', 'activo', 1, 2, '1001', 'jperez@empresa.bo', '123', '2012-11-10');

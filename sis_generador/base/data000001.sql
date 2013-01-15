/***********************************I-DAT-RCM-GEN-0-14/01/2013****************************************/

INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('GEN', 'Sistema Generador de Codigo', '2009-11-02', 'GEN', 'activo', 'generador', NULL);

select pxp.f_insert_tfuncion ('ft_tabla_sel', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_tabla_ime', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_columna_ime', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_columna_sel', 'Funcion para tabla', 'GEN');
select pxp.f_insert_tfuncion ('ft_esquema_sel', 'Funcion para tabla', 'GEN');

select pxp.f_insert_tgui ('GEN', 'Generador de Código', 'GEN', 'si', 3, '', 1, '../../../lib/imagenes/gen32x32.png', '', 'GEN');
select pxp.f_insert_tgui ('Procesos', '', 'PROCGEN', 'si', 2, '', 2, '', '', 'GEN');
select pxp.f_insert_tgui ('Generador', 'Registro de las tablas', 'TABLA', 'si', 1, 'sis_generador/vista/tabla/tabla.js', 3, '', 'tabla', 'GEN');
select pxp.f_insert_tgui ('Columnas', 'Registro de las Columnas de las tablas', 'COL', 'no', 1, 'sis_generador/vista/columna/columna.js', 4, '', 'columna', 'GEN');

select pxp.f_insert_testructura_gui ('GEN', 'SISTEMA');
select pxp.f_insert_testructura_gui ('PROCGEN', 'GEN');
select pxp.f_insert_testructura_gui ('TABLA', 'PROCGEN');
select pxp.f_insert_testructura_gui ('COL', 'TABLA');
/***********************************F-DAT-RCM-GEN-0-14/01/2013****************************************/
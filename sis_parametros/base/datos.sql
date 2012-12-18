
-----------------------------------------------------DATA-----------------------------------------------------------------
INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('PARAM', 'Parametros Generales', '2009-11-02', 'PM', 'activo', 'parametros', NULL);

INSERT INTO param.tgestion (gestion, id_usuario_reg) VALUES (2012, 1);


select pxp.f_insert_tgui ('Alarmas', 'Para programar las alarmas', 'ALARM', 'si', 1, 'sis_parametros/vista/alarma/Alarma.php', 2, '', 'Alarma', 'PARAM');
select pxp.f_insert_tgui ('Departamentos', 'Departamentos', 'DEPTO', 'si', 3, 'sis_parametros/vista/depto/Depto.php', 2, '', 'Depto', 'PARAM');
select pxp.f_insert_tgui ('PARAM', 'Parametros Generales', 'PARAM', 'si', 2, '', 1, '../../../lib/imagenes/param32x32.png', 'Sistema de Parametros', 'PARAM');
select pxp.f_insert_tgui ('Lugar', 'Lugar', 'LUG', 'si', 4, 'sis_parametros/vista/lugar/Lugar.php', 2, '', 'Lugar', 'PARAM');
select pxp.f_insert_tgui ('Institucion', 'Detalle de instituciones', 'INSTIT', 'si', 5, 'sis_parametros/vista/institucion/Institucion.php', 2, '', 'Institucion', 'PARAM');
select pxp.f_insert_tgui ('Proyecto EP', 'Proyecto EP proviene de ENDESIS', 'PRO', 'si', 5, 'sis_parametros/vista/proyecto/Proyecto.php', 2, '', 'Proyecto', 'PARAM');
select pxp.f_insert_tgui ('Proveedores', 'Registro de Proveedores', 'PROVEE', 'si', 5, 'sis_parametros/vista/proveedor/Proveedor.php', 2, '', 'proveedor', 'PARAM');
select pxp.f_insert_tgui ('Documentos', 'Documentos por Sistema', 'DOCUME', 'si', 4, 'sis_parametros/vista/documento/Documento.php', 2, '', 'Documento', 'PARAM');
select pxp.f_insert_tgui ('Configuracion Alarmas', 'Para configurar las alarmas', 'CONALA', 'si', 1, 'sis_parametros/vista/config_alarma/ConfigAlarma.php', 2, '', 'ConfigAlarma', 'PARAM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Registro de Unidades de Medida', 'UME', 'si', 10, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 2, '', 'UnidadMedida', 'PARAM');
select pxp.f_insert_tgui ('Gestion', 'Manejo de gestiones', 'GESTIO', 'si', 1, 'sis_parametros/vista/gestion/gestion.js', 2, '', 'gestion', 'PARAM');
select pxp.f_insert_tgui ('Catalogo', 'Catalogo', 'CATA', 'si', 4, 'sis_parametros/vista/catalogo/Catalogo.php', 2, '', 'Catalogo', 'PARAM');
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERIOD', 'si', 2, 'sis_parametros/vista/periodo/periodo.js', 2, '', 'periodo', 'PARAM');
select pxp.f_insert_tgui ('Moneda', 'Monedas', 'MONPAR', 'si', 3, 'sis_parametros/vista/moneda/moneda.js', 2, '', 'moneda', 'PARAM');
select pxp.f_insert_testructura_gui ('PARAM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CONALA', 'PARAM');
select pxp.f_insert_testructura_gui ('DOCUME', 'PARAM');
select pxp.f_insert_testructura_gui ('DEPTO', 'PARAM');
select pxp.f_insert_testructura_gui ('ALARM', 'PARAM');
select pxp.f_insert_testructura_gui ('PROVEE', 'PARAM');
select pxp.f_insert_testructura_gui ('PRO', 'PARAM');
select pxp.f_insert_testructura_gui ('INSTIT', 'PARAM');
select pxp.f_insert_testructura_gui ('LUG', 'PARAM');
select pxp.f_insert_testructura_gui ('MONPAR', 'PARAM');
select pxp.f_insert_testructura_gui ('PERIOD', 'PARAM');
select pxp.f_insert_testructura_gui ('CATA', 'PARAM');
select pxp.f_insert_testructura_gui ('GESTIO', 'PARAM');
select pxp.f_insert_testructura_gui ('UME', 'PARAM');






select pxp.f_add_catalog('PARAM','tunidad_medida','Longitud');
select pxp.f_add_catalog('PARAM','tunidad_medida','Masa');
select pxp.f_add_catalog('PARAM','tunidad_medida','Tiempo');
select pxp.f_add_catalog('PARAM','tunidad_medida','Intensidad electrica');
select pxp.f_add_catalog('PARAM','tunidad_medida','Temperatura');
select pxp.f_add_catalog('PARAM','tunidad_medida','Intensidad luminosa');
select pxp.f_add_catalog('PARAM','tunidad_medida','Cantidad de sustancia');

/* PARAM.TLUGAR*/
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:48:23.529', NULL, E'activo', 1, NULL, E'BOL', E'Bolivia', E'pais', E'no', E'no', E'BOL');

/* PARAM.TMONEDA*/
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:06:55.690', E'activo', 1, E'Bolivianos', E'Bs', NULL);
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:07:11.620', E'activo', 2, E'Dólares Americanos', E'USD', NULL);


/* UNIDADES DE MEDIDA*/ 
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2012-11-02 13:31:27', E'2012-11-02 13:31:27', E'activo', 9, E'Km.', E'Kilometro','Longitud');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-11-03 09:42:35.594', E'activo', 2, E'dia', E'Dia','Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:26:52', E'2012-11-03 09:42:43.275', E'activo', 1, E'Hr.', E'Hora','Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:30:42', E'2012-11-03 09:42:54.058', E'activo', 5, E'Año', E'Año','Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:29:13', E'2012-11-03 09:43:44.843', E'activo', 4, E'mes', E'Mes','Tiempo');
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, 1, E'2012-11-02 13:34:20', E'2012-11-03 09:46:29.882', E'activo', 3, E'sem', E'Semana','Tiempo');


--Menú
select pxp.f_insert_tgui ('Tipos de Catálogos', 'Tipos de Catálogos', 'PACATI', 'si', 11, 'sis_parametros/vista/catalogo_tipo/CatalogoTipo.php', 2, '', 'CatalogoTipo', 'PARAM');
select pxp.f_insert_testructura_gui ('PACATI', 'PARAM');
select pxp.f_insert_tgui ('Servicios', 'Para registro de los servicios', 'SERVIC', 'si', 1, 'sis_parametros/vista/servicio/Servicio.php', 2, '', 'Servicio', 'PARAM');
select pxp.f_insert_testructura_gui ('SERVIC','PARAM');



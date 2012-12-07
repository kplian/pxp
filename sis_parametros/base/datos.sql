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
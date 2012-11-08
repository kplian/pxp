/* PARAM.TLUGAR*/
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:48:23.529', NULL, E'activo', 1, NULL, E'BOL', E'Bolivia', E'pais', E'no', E'no', E'BOL');
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:48:47.273', NULL, E'activo', 2, 1, E'SCZ', E'Santa Cruz', E'departamento', E'no', E'no', E'BOL.SCZ');
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:49:10.032', NULL, E'activo', 3, 1, E'CBA', E'Cochabamba', E'departamento', E'no', E'no', E'BOL.CBA');

/*PARAM.TMONEDA*/
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:06:55.690', E'activo', 1, E'Bolivianos', E'Bs', NULL);
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:07:11.620', E'activo', 2, E'Dólares Amerricanos', E'USD', NULL);
/* PARAM.TLUGAR*/
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo") 
VALUES (1, NULL, E'2012-11-08 09:48:47.273', NULL, E'activo', 1, NULL, E'BOL', E'Bolivia', E'pais', E'no', E'no', E'BOL');
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:48:47.273', NULL, E'activo', 2, 1, E'SCZ', E'Santa Cruz', E'departamento', E'no', E'no', E'BOL.SCZ');
INSERT INTO param.tlugar ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_lugar", "id_lugar_fk", "codigo", "nombre", "tipo", "sw_municipio", "sw_impuesto", "codigo_largo")
VALUES (1, NULL, E'2012-11-08 09:49:10.032', NULL, E'activo', 3, 1, E'CBA', E'Cochabamba', E'departamento', E'no', E'no', E'BOL.CBA');


-- Institucion
INSERT INTO param.tinstitucion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_institucion, doc_id, nombre, casilla, telefono1, telefono2, celular1, celular2, fax, email1, email2, pag_web, observaciones, id_persona, direccion, codigo_banco, es_banco, codigo, cargo_representante)
VALUES (1, NULL, '2012-11-08 13:12:37.649563', '2012-11-08 13:12:37.649563', 'activo', 1, '234321', 'Los Alamos', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Av. América #349', NULL, 'NO', 'INS-01', 'Representante Legal');

INSERT INTO param.tinstitucion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_institucion, doc_id, nombre, casilla, telefono1, telefono2, celular1, celular2, fax, email1, email2, pag_web, observaciones, id_persona, direccion, codigo_banco, es_banco, codigo, cargo_representante)
VALUES (1, NULL, '2012-11-13 10:25:38', '2012-11-13 10:25:38', 'activo', 2, '123456', 'HANSA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 'Av. Blanco Galindo #567', NULL, 'NO', 'HNS-01', 'Representante Legal');

INSERT INTO param.tinstitucion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_institucion, doc_id, nombre, casilla, telefono1, telefono2, celular1, celular2, fax, email1, email2, pag_web, observaciones, id_persona, direccion, codigo_banco, es_banco, codigo, cargo_representante)
VALUES (1, NULL, '2012-11-13 11:43:13', '2012-11-13 11:43:13', 'activo', 3, '789456', '3M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'San Martin Nro 254', NULL, 'NO', '3M', 'Representante Legal');

INSERT INTO param.tinstitucion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_institucion", "doc_id", "nombre", "casilla", "telefono1", "telefono2", "celular1", "celular2", "fax", "email1", "email2", "pag_web", "observaciones", "id_persona", "direccion", "codigo_banco", "es_banco", "codigo", "cargo_representante")
VALUES (1, NULL, E'2012-12-29 13:05:11.340', NULL, E'activo', 4, E'196560027', E'Kplian LDTA', E'', E'', E'', E'', E'', E'', E'', E'', E'', E'', 6, E'Av. Antezana #947 Entre Ramon Rivera y Oruro', E'', E'NO', E'KPLIAN', E'Developer');

-- Proveedor
INSERT INTO param.tproveedor (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_proveedor, id_institucion, id_persona, tipo, numero_sigma, codigo, nit,id_lugar)
VALUES (1, NULL, '2012-11-13 10:31:22', '2012-11-13 10:31:22', 'activo', 1, null, 3, 'persona natural', NULL, NULL, '999',1);

INSERT INTO param.tproveedor (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_proveedor, id_institucion, id_persona, tipo, numero_sigma, codigo, nit,id_lugar)
VALUES (1, NULL, '2012-11-13 11:44:11', '2012-11-13 11:44:11', 'activo', 2, null, 2, 'persona natural', NULL, NULL, '998',1);


----------------------------
--- AAO - Datos TSERVICIO---
----------------------------

INSERT INTO param.tservicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_servicio", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-29 04:53:10.056', E'2012-12-29 12:55:06.688', E'activo', 1, E'SERV-01', E'Servicio de Transporte Aereo', E'Servicio de transporte aereo militar ñee');

INSERT INTO param.tservicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_servicio", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2012-12-29 04:53:45.282', E'2012-12-29 12:55:31.820', E'activo', 3, E'SERV-03', E'Servicio de Transporte Fluvial', E'Transporte por rio y por embarcaciones de tipo medio');

INSERT INTO param.tservicio ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_servicio", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2012-12-29 12:56:05.859', NULL, E'activo', 6, E'SERV-04', E'Servicio de Transporte Terrestre interprovincial', E'Transporte interprovincial por todo el territorio nacional');


/*MONEDAS*/
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:06:55.690', E'activo', 1, E'Bolivianos', E'Bs', NULL);

INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:07:11.620', E'activo', 2, E'Dólares Americanos', E'USD', NULL);


----------------------------
---FRH - Datos para Sistema de correspondecia---
----------------------------


-- Data for table param.tdepto (LIMIT 0,3)

INSERT INTO param.tdepto (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto, id_subsistema, codigo, nombre, nombre_corto)
VALUES (18, 18, '2011-06-04 00:00:00', '2011-06-04 21:26:26', 'activo', 1, 5, 'DC', 'Departamento de Cont', 'CBTE');

INSERT INTO param.tdepto (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto, id_subsistema, codigo, nombre, nombre_corto)
VALUES (18, 18, '2011-10-19 00:00:00', '2011-10-19 14:14:29', 'activo', 3, 5, 'DPE', 'Departamento de Personal', 'DEP-PER');

INSERT INTO param.tdepto (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto, id_subsistema, codigo, nombre, nombre_corto)
VALUES (18, 18, '2011-10-19 00:00:00', '2012-03-15 15:13:42', 'activo', 2, 5, 'COR', 'Departamento de Correspondencia.', 'DEP-COR');



-- Data for table param.tdocumento  (LIMIT 0,12)

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (18, 18, '2011-12-13 00:00:00', '2011-12-13 10:13:29', 'activo', 8, 5, 'IN', 'Informe', 'periodo', 'interna', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 03:18:18', 'activo', 9, 5, 'ME', 'Memoramdum', 'periodo', 'interna', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 03:18:35', 'activo', 10, 5, 'CI', 'Comunicacion Interna', 'periodo', 'interna', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 03:19:38', 'activo', 11, 5, 'IT', 'Informe Tecnico', 'periodo', 'interna', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 03:19:52', 'activo', 12, 5, 'CO', 'Comunicado', 'periodo', 'interna', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 03:23:58', 'activo', 13, 5, 'PLA', 'Planilla', 'gestion', '', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2012-04-18 00:00:00', '2012-04-18 00:19:03', 'activo', 18, 5, 'asdasd', 'sadsadsad', 'periodo', '', 'depto', '');

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2011-12-25 00:00:00', '2011-12-25 07:22:25', 'activo', 15, 5, 'CAR', 'Carta recibida', 'periodo', 'entrante', 'depto', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (18, NULL, '2011-12-29 00:00:00', '2011-12-29 10:59:45', 'activo', 16, 5, 'RE', 'Recibo', 'periodo', 'entrante', 'uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, 2, '2011-12-25 00:00:00', '2012-04-18 00:20:30', 'activo', 5, 5, 'CA', 'CARTA', 'periodo', 'saliente', 'depto_uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, NULL, '2012-04-18 00:00:00', '2012-04-18 00:19:33', 'activo', 19, 5, 'aaa', 'aaa', 'periodo', 'saliente', 'uo', NULL);

INSERT INTO param.tdocumento (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_documento, id_subsistema, codigo, descripcion, periodo_gestion, tipo, tipo_numeracion, formato)
VALUES (2, 2, '2012-04-18 00:00:00', '2012-04-18 01:20:06', 'activo', 20, 5, 'aaaaa', 'aaaaa', 'gestion', 'saliente', 'uo', '');


-- Data for table param.tdepto_uo (LIMIT 0,6)

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (2, NULL, '2011-12-25 00:06:40', NULL, 'activo', 4, 1, 3);

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (18, NULL, '2012-03-15 15:03:28', NULL, 'activo', 6, 3, 5);

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (2, 18, '2011-12-13 10:07:19', '2012-03-15 15:03:48', 'activo', 3, 2, 7);

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (18, 18, '2011-10-19 09:26:14', '2012-03-15 15:20:47', 'activo', 1, 1, 2);

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (18, NULL, '2012-04-14 23:06:11', NULL, 'activo', 7, 2, 5);

INSERT INTO param.tdepto_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_uo, id_depto, id_uo)
VALUES (18, NULL, '2012-04-14 23:06:15', NULL, 'activo', 8, 2, 7);

--
-- Data for table param.tdepto_usuario (OID = 429601) (LIMIT 0,4)
--
INSERT INTO param.tdepto_usuario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_usuario, id_depto, id_usuario, funcion, cargo)
VALUES (2, NULL, '2012-03-14 09:46:54', NULL, 'activo', 1, 2, 24, NULL, NULL);

INSERT INTO param.tdepto_usuario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_usuario, id_depto, id_usuario, funcion, cargo)
VALUES (18, NULL, '2012-03-15 14:55:08', NULL, 'activo', 2, 2, 18, NULL, '');

INSERT INTO param.tdepto_usuario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_usuario, id_depto, id_usuario, funcion, cargo)
VALUES (18, NULL, '2012-03-15 14:55:21', NULL, 'activo', 3, 3, 18, NULL, '');

INSERT INTO param.tdepto_usuario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_depto_usuario, id_depto, id_usuario, funcion, cargo)
VALUES (18, 18, '2012-03-15 15:20:09', '2012-03-15 15:20:18', 'activo', 4, 1, 21, NULL, 'administrador');

-- Data for table param.tgestion  (LIMIT 0,4)

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado)
VALUES (18, NULL, '2011-06-03 18:30:49', '2011-06-03 18:30:49', 'eliminado', 1, 2011, NULL);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 6, 2010, NULL);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 7, 2011, NULL);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado)
VALUES (2, NULL, '2012-02-26 00:00:00', '2012-02-26 03:48:14', 'activo', 8, 2012, NULL);



-- Data for table param.tperiodo (OID = 38449) (LIMIT 0,36)

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 11:09:18', 'activo', 124, 12, 8, '2012-12-01', '2011-12-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 113, 1, 8, '2012-01-01', '2012-01-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 114, 2, 8, '2012-02-01', '2012-02-29');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 115, 3, 8, '2012-03-01', '2012-03-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 116, 4, 8, '2012-04-01', '2012-04-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 118, 6, 8, '2012-06-01', '2012-06-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 121, 9, 8, '2012-09-01', '2012-09-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 122, 10, 8, '2012-10-01', '2012-10-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 123, 11, 8, '2012-11-01', '2012-11-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 120, 8, 8, '2012-08-01', '2012-08-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 22, 11, 6, '2010-11-01', '2010-11-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 23, 12, 6, '2010-12-01', '2010-12-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 12, 1, 6, '2010-01-01', '2010-01-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 13, 2, 6, '2010-02-01', '2010-02-28');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 14, 3, 6, '2010-03-01', '2010-03-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 15, 4, 6, '2010-04-01', '2010-04-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 16, 5, 6, '2010-05-01', '2010-05-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 17, 6, 6, '2010-06-01', '2010-06-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 18, 7, 6, '2010-07-01', '2010-07-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 19, 8, 6, '2010-08-01', '2010-08-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 20, 9, 6, '2010-09-01', '2010-09-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:39:35', 'activo', 21, 10, 6, '2010-10-01', '2010-10-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 24, 1, 7, '2011-01-01', '2011-01-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 25, 2, 7, '2011-02-01', '2011-02-28');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 26, 3, 7, '2011-03-01', '2011-03-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 27, 4, 7, '2011-04-01', '2011-04-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 28, 5, 7, '2011-05-01', '2011-05-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 29, 6, 7, '2011-06-01', '2011-06-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 30, 7, 7, '2011-07-01', '2011-07-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 31, 8, 7, '2011-08-01', '2011-08-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 32, 9, 7, '2011-09-01', '2011-09-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 33, 10, 7, '2011-10-01', '2011-10-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 34, 11, 7, '2011-11-01', '2011-11-30');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 11:09:18', 'activo', 40, 12, 7, '2011-12-01', '2011-12-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 119, 7, 8, '2012-07-01', '2012-07-31');

INSERT INTO param.tperiodo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_periodo, periodo, id_gestion, fecha_ini, fecha_fin)
VALUES (18, NULL, '2011-06-05 00:00:00', '2011-06-05 10:41:00', 'activo', 117, 5, 8, '2012-05-01', '2012-05-31');



----------------------
--EMPRESA
--------------
-- Data for table param.tempresa (OID = 4013755) (LIMIT 0,1)
/* Data for the 'param.tempresa' table  (Records 1 - 1) */

INSERT INTO param.tempresa ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "nombre", "logo", "nit", "codigo")
VALUES (1, 1, E'2013-02-21 16:19:33', E'2013-03-20 10:00:07.522', E'activo', E'Kplian Ltda', NULL, E'196560027', E'KPLIAN');


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
VALUES (1, NULL, '2012-11-13 10:31:22', '2012-11-13 10:31:22', 'activo', 1, null, 3, 'persona natural', NULL, 'asdf', '999',1);

INSERT INTO param.tproveedor (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_proveedor, id_institucion, id_persona, tipo, numero_sigma, codigo, nit,id_lugar)
VALUES (1, NULL, '2012-11-13 11:44:11', '2012-11-13 11:44:11', 'activo', 2, null, 2, 'persona natural', NULL, 'asdf', '998',1);

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

/* Data for the 'param.tmoneda' table  (Records 1 - 2) */
/*
INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "moneda", "codigo", "tipo_moneda", "prioridad", "tipo_actualizacion", "origen")
VALUES (1, NULL, E'2012-11-08 00:00:00', E'2012-11-08 12:07:11.620', E'activo', E'Dólares Americanos', E'USD', NULL, NULL, NULL, NULL);

INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "moneda", "codigo", "tipo_moneda", "prioridad", "tipo_actualizacion", "origen")
VALUES (1, 1, E'2012-11-08 00:00:00', E'2013-03-20 10:44:33.277', E'activo', E'Bolivianos', E'Bs', E'base', NULL, E'', E'');
*/

/* Data for the 'param.tmoneda' table  (Records 1 - 3) */

INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda", "prioridad", "tipo_actualizacion", "origen")
VALUES (1, NULL, E'2013-04-22 11:28:25.715', NULL, E'activo', 2, E'Dólares Americanos', E'US$', NULL, 2, E'por_saldo', E'extranjera');

INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda", "prioridad", "tipo_actualizacion", "origen")
VALUES (1, NULL, E'2013-04-22 11:28:25.715', NULL, E'activo', 3, E'Unidad de Fomento a la Vivienda', E'UFV', NULL, 3, E'por_transaccion', E'nacional');

INSERT INTO param.tmoneda ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_moneda", "moneda", "codigo", "tipo_moneda", "prioridad", "tipo_actualizacion", "origen")
VALUES (1, NULL, E'2013-04-22 11:28:25.715', NULL, E'activo', 1, E'Bolivianos', E'Bs', E'base', 1, E'sin_actualizacion', E'nacional');

-------------------------------------
-- ESTRUCTURA PROGRAMATICA
-------------------------------

/* Data for the 'param.tactividad' table  (Records 1 - 2) */

INSERT INTO param.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "codigo_actividad", "nombre_actividad", "descripcion_actividad")
VALUES (1, NULL, E'2013-03-20 10:18:05.186', NULL, E'activo', 1, E'DIS', E'DISENO', E'');

INSERT INTO param.tactividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_actividad", "codigo_actividad", "nombre_actividad", "descripcion_actividad")
VALUES (1, NULL, E'2013-03-20 10:19:00.798', NULL, E'activo', 2, E'DES', E'Desarrrollo', E'');


/* Data for the 'param.tfinanciador' table  (Records 1 - 2) */

INSERT INTO param.tfinanciador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_financiador", "codigo_financiador", "nombre_financiador", "descripcion_financiador", "id_financiador_actif")
VALUES (1, NULL, E'2013-03-20 10:05:15.439', NULL, E'activo', 1, E'BID', E'Banco Interamericano', E'', NULL);

INSERT INTO param.tfinanciador ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_financiador", "codigo_financiador", "nombre_financiador", "descripcion_financiador", "id_financiador_actif")
VALUES (1, NULL, E'2013-03-20 10:05:38.369', NULL, E'activo', 2, E'CAF', E'Corporacion Andina de Fomento', E'', NULL);

/* Data for the 'param.tprograma' table  (Records 1 - 1) */

INSERT INTO param.tprograma ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_programa", "codigo_programa", "nombre_programa", "descripcion_programa", "id_programa_actif")
VALUES (1, NULL, E'2013-03-20 10:17:18.203', NULL, E'activo', 1, E'DSOFT', E'Desarrollo de Software', E'', NULL);

/* Data for the 'param.tproyecto' table  (Records 1 - 1) */

INSERT INTO param.tproyecto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_proyecto", "codigo_proyecto", "nombre_proyecto", "descripcion_proyecto", "id_proyecto_actif", "nombre_corto", "codigo_sisin", "hidro", "id_proyecto_cat_prog")
VALUES (1, NULL, E'2013-03-20 10:17:50.969', NULL, E'activo', 1, E'ERP', E'Software de Administracion  Financiera', E'', NULL, E'ERP', NULL, E'no', NULL);


/* Data for the 'param.tregional' table  (Records 1 - 2) */

INSERT INTO param.tregional ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_regional", "codigo_regional", "nombre_regional", "descripcion_regional", "id_regional_actif")
VALUES (1, NULL, E'2013-03-20 10:16:53.340', NULL, E'activo', 1, E'CBA', E'Cochabamba', E'', NULL);

INSERT INTO param.tregional ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_regional", "codigo_regional", "nombre_regional", "descripcion_regional", "id_regional_actif")
VALUES (1, NULL, E'2013-03-20 10:17:00.129', NULL, E'activo', 2, E'LP', E'La Paz', E'', NULL);


/* Data for the 'param.tprograma_proyecto_acttividad' table  (Records 1 - 2) */

INSERT INTO param.tprograma_proyecto_acttividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_prog_pory_acti", "id_programa", "id_proyecto", "id_actividad")
VALUES (1, NULL, E'2013-03-20 10:19:13.016', NULL, E'activo', 1, 1, 1, 2);

INSERT INTO param.tprograma_proyecto_acttividad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_prog_pory_acti", "id_programa", "id_proyecto", "id_actividad")
VALUES (1, NULL, E'2013-03-20 10:19:16.854', NULL, E'activo', 2, 1, 1, 1);

/* Data for the 'param.tep' table  (Records 1 - 6) */

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:19:29.685', NULL, E'activo', 1, 1, 1, 1, NULL);

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:19:34.738', NULL, E'activo', 2, 2, 1, 1, NULL);

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:19:45.436', NULL, E'activo', 3, 1, 1, 2, NULL);

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:19:50.549', NULL, E'activo', 4, 2, 1, 2, NULL);

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:19:57.021', NULL, E'activo', 5, 1, 2, 2, NULL);

INSERT INTO param.tep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_ep", "id_prog_pory_acti", "id_regional", "id_financiador", "sw_presto")
VALUES (1, NULL, E'2013-03-20 10:20:00.936', NULL, E'activo', 6, 2, 2, 2, NULL);
 	

----------------------------
--  datos de gestion
----------------------------

/* Data for the 'param.tgestion' table  (Records 1 - 1) */

INSERT INTO param.tgestion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg",  "gestion", "estado", "id_moneda_base", "id_empresa")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo',  2013, E'abierto', 1, 1);

------------------------
--   PERIODOS
----------------------

/* Data for the 'param.tperiodo' table  (Records 1 - 12) */

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 1, 1, E'2013-01-01', E'2013-01-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 2, 1, E'2013-02-01', E'2013-02-28');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 3, 1, E'2013-03-01', E'2013-03-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 4, 1, E'2013-04-01', E'2013-04-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 5, 1, E'2013-05-01', E'2013-05-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 6, 1, E'2013-06-01', E'2013-06-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 7, 1, E'2013-07-01', E'2013-07-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 8, 1, E'2013-08-01', E'2013-08-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 9, 1, E'2013-09-01', E'2013-09-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 10, 1, E'2013-10-01', E'2013-10-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 11, 1, E'2013-11-01', E'2013-11-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-03-20 09:59:45.336', NULL, E'activo', 12, 1, E'2013-12-01', E'2013-12-31');


----------------------
--  CENTRO DE COSTO
-----------------------

/* Data for the 'param.tcentro_costo' table  (Records 1 - 9) */

/* Data for the 'param.tcentro_costo' table  (Records 1 - 16) */

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:37:51.042', NULL, E'activo', 1, 1, 2, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:00.335', NULL, E'activo', 2, 2, 9, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:10.580', NULL, E'activo', 3, 1, 7, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:24.455', NULL, E'activo', 4, 6, 7, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:28.717', NULL, E'activo', 5, 6, 9, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:32.950', NULL, E'activo', 6, 6, 2, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:39.488', NULL, E'activo', 7, 5, 7, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:44.083', NULL, E'activo', 8, 5, 9, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 10:38:48.719', NULL, E'activo', 9, 5, 2, 106);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:29:12.850', NULL, E'activo', 10, 2, 2, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:29:23.955', NULL, E'activo', 11, 2, 7, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:29:28.442', NULL, E'activo', 12, 2, 9, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:29:34.336', NULL, E'activo', 13, 3, 9, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:29:56.803', NULL, E'activo', 14, 5, 7, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:30:00.928', NULL, E'activo', 15, 5, 9, 1);

INSERT INTO param.tcentro_costo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_centro_costo", "id_ep", "id_uo", "id_gestion")
VALUES (1, NULL, E'2013-03-20 13:30:04.381', NULL, E'activo', 16, 5, 2, 1);


---------------------------
--  CONCEPTOS DE GASTO
--------------------------

/* Data for the 'param.tconcepto_ingas' table  (Records 1 - 7) */

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:34:38.790', NULL, E'activo', E'Bien', E'Computadora', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:34:50.944', NULL, E'activo', E'Bien', E'Impresora', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:35:11.981', NULL, E'activo', E'Bien', E'Mesas', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:35:21.479', NULL, E'activo', E'Bien', E'escritorios', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:35:39.796', NULL, E'activo', E'Servicio', E'Informatico Junior', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:35:46.512', NULL, E'activo', E'Servicio', E'Electricista', E'gasto', E'si', NULL);

INSERT INTO param.tconcepto_ingas ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "tipo", "desc_ingas", "movimiento", "sw_tes", "id_oec")
VALUES (1, NULL, E'2013-03-20 13:36:27.359', NULL, E'activo', E'Servicio', E'Desarrollo de Software', E'ingreso', E'no', NULL);


------------------------------
-- PLANTILLA
------------------------------

/* Data for the 'param.tplantilla' table  (Records 1 - 24) */

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 1, 3, E'Compra Con Credito Fiscal', 1, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 2, 5, E'Venta Con Debito Fiscal', 1, E'no', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 15, 3, E'Compra con Credito Fiscal Proyectos', 1, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 16, 3, E'Proforma de Factura', 3, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 3, 5, E'Venta Sin Debito Fiscal', 1, E'no', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 4, 1, E'Compra Sin Credito Fiscal (Factura Z F)', 1, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 5, 1, E'Notas de Debito Fiscal', 4, E'no', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 6, 6, E'Notas de Credito Fiscal', 4, E'no', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 7, 2, E'Boletos BSP', 1, E'si', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 8, 1, E'Recibo Sin Retenciones', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 9, 4, E'Recibo con Retenciones Bienes', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 10, 4, E'Recibo con Retenciones Servicios', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 11, 1, E'Recibo con Retenciones Bienes - ZF', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 12, 1, E'Recibo con Retenciones Servicios - ZF', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 13, 1, E'Retenciones RC-IVA', 4, E'no', E'no');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 14, 1, E'Retenciones Remesas', 4, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 17, 3, E'Recibo de Alquiler', 2, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 18, 1, E'Proforma Factura Proyectos', 3, E'si', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 19, 3, E'Proforma Retención Bienes', 3, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 20, 3, E'Proforma Retención Servicios', 3, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 21, 2, E'Proforma Retención Bienes - ZF', 3, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 22, 2, E'Proforma Retención Servicios - ZF', 3, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 23, 3, E'Proforma Recibo de Alquiler', 3, E'no', E'si');

INSERT INTO param.tplantilla ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_plantilla", "nro_linea", "desc_plantilla", "tipo", "sw_tesoro", "sw_compro")
VALUES (1, NULL, E'2013-04-10 05:26:43.945', NULL, E'activo', 24, 1, E'Póliza de Importación', 1, E'si', E'si');

----------------
--- GRUPO
----------------

INSERT INTO param.tgrupo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_grupo", "nombre", "obs")
VALUES (1, NULL, E'2013-05-08 15:17:58.245', NULL, E'activo', 1, E'grupo uno', E'');

----------------
--- GRUPO-EP
----------------

INSERT INTO param.tgrupo_ep ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_grupo_ep", "id_grupo", "id_ep")
VALUES (1, NULL, E'2013-05-08 15:18:16.256', NULL, E'activo', 1, 1, 2);

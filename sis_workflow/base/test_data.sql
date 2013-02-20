/*
*	Author: FRH
*	Date: 21-02-2013
*	Description: Test data
*/


-- Data for table param.tgestion (OID = 4013580) (LIMIT 0,4)

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado, id_moneda_base, id_empresa)
VALUES (1, NULL, '2013-02-21 16:23:40.302', '2011-06-03 18:30:49', 'eliminado', 101, 2011, NULL, 1, 1);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado, id_moneda_base, id_empresa)
VALUES (1, NULL, '2013-02-21 16:23:44.136', '2011-06-05 10:39:35', 'activo', 102, 2010, NULL, 1, 1);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado, id_moneda_base, id_empresa)
VALUES (1, NULL, '2013-02-21 16:23:47.2', '2011-06-05 10:41:00', 'activo', 103, 2011, NULL, 1, 1);

INSERT INTO param.tgestion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_gestion, gestion, estado, id_moneda_base, id_empresa)
VALUES (1, NULL, '2013-02-21 16:23:50.535', '2012-02-26 03:48:14', 'activo', 104, 2012, NULL, 1, 1);

-- Data for table param.tempresa (OID = 4013755) (LIMIT 0,1)

INSERT INTO param.tempresa (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, nombre, logo, nit)
VALUES (1, NULL, '2013-02-21 16:19:33', '2013-02-21 16:19:33', 'activo', 'Kplian Ltda', NULL, '196560027');

-- Data for table wf.tproceso_macro (OID = 4014129) (LIMIT 0,1)

INSERT INTO wf.tproceso_macro (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_proceso_macro, id_subsistema, codigo, nombre, inicio)
VALUES (1, NULL, '2013-02-21 16:22:01.747666', NULL, 'activo', 1, 6, 'COMINT', 'Compra internacional', 'SI');

-- Data for table wf.tnum_tramite (OID = 4014085) (LIMIT 0,2)

INSERT INTO wf.tnum_tramite (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_num_tramite, id_proceso_macro, id_gestion, num_siguiente)
VALUES (1, NULL, '2013-02-21 16:25:13.975162', NULL, 'activo', 1, 1, 103, 1);

INSERT INTO wf.tnum_tramite (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_num_tramite, id_proceso_macro, id_gestion, num_siguiente)
VALUES (1, NULL, '2013-02-21 16:25:41.633394', NULL, 'activo', 2, 1, 104, 1);


--
-- Data for table wf.ttipo_proceso (OID = 4234420) (LIMIT 0,2)
--
INSERT INTO wf.ttipo_proceso (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_proceso, id_tipo_estado, id_proceso_macro, nombre, tabla, columna_llave, codigo)
VALUES (1, NULL, '2013-02-21 16:40:53.050201', NULL, 'activo', 1, NULL, 1, 'Solicitud de compra', 'adq.tsolicitud', 'id_solicitud', 'SOLCO');

INSERT INTO wf.ttipo_proceso (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_proceso, id_tipo_estado, id_proceso_macro, nombre, tabla, columna_llave, codigo)
VALUES (1, NULL, '2013-02-22 10:24:16.438095', NULL, 'activo', 2, NULL, 1, 'Adjudicacion de compra', '', '', 'ADJCO');

--
-- Data for table wf.ttipo_estado (OID = 4234435) (LIMIT 0,7)
--
INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, 1, '2013-02-22 10:25:48.373906', '2013-02-22 10:51:17.195554', 'activo', 4, 2, 'SI', '', 'Elaboracion_Informe_Comision', '', 'f5');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, 1, '2013-02-21 16:53:08.728965', '2013-02-22 10:54:22.666851', 'activo', 1, 1, 'SI', 'NO', 'Borrador', 'listado', 'f1');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, 1, '2013-02-21 16:54:14.114248', '2013-02-22 10:54:32.382615', 'activo', 2, 1, 'NO', 'NO', 'En_Proceso', 'todos', 'f2');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, NULL, '2013-02-22 11:28:04.752809', NULL, 'activo', 7, 1, 'NO', 'NO', 'Pendiente_Aprobacion', 'listado', 'fxy');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, NULL, '2013-02-22 12:10:39.086278', NULL, 'activo', 8, 2, 'NO', 'NO', 'Firma_GG', 'listado', '');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, 1, '2013-02-22 10:26:18.357444', '2013-02-22 12:12:54.425059', 'activo', 5, 2, 'NO', 'NO', 'Elaboracion_Contrato', '', 'f4');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, 1, '2013-02-21 16:54:28.81435', '2013-02-22 12:13:20.160554', 'activo', 3, 1, 'NO', 'SI', 'Finalizado', '', 'f3');

--
-- Data for table wf.testructura_estado (OID = 4234449) (LIMIT 0,5)
--
INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, 1, '2013-02-21 16:54:58.599704', '2013-02-22 10:21:30.343555', 'activo', 1, 1, 2, 1, 'ff1');

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, 1, '2013-02-21 16:55:15.045367', '2013-02-22 11:28:24.003035', 'activo', 2, 2, 7, 2, 'ff2');

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, 1, '2013-02-22 11:28:54.57362', '2013-02-22 12:13:10.233573', 'activo', 4, 7, 3, 3, '');

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, 1, '2013-02-22 12:11:23.172477', '2013-02-22 12:13:50.635216', 'activo', 5, 5, 8, 1, '');

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, 1, '2013-02-22 10:26:44.211457', '2013-02-22 12:25:24.8933', 'activo', 3, 4, 5, 5, 'ff3');





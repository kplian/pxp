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

INSERT INTO param.tempresa (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, nombre, logo, nit, codigo)
VALUES (1, NULL, '2013-02-21 16:19:33', '2013-02-21 16:19:33', 'activo', 'Kplian Ltda', NULL, '196560027', NULL);

-- Data for table wf.tproceso_macro (OID = 4014129) (LIMIT 0,1)

INSERT INTO wf.tproceso_macro (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_proceso_macro, id_subsistema, codigo, nombre, inicio)
VALUES (1, NULL, '2013-02-21 16:22:01.747666', NULL, 'activo', 1, 6, 'COMINT', 'Compra internacional', 'SI');

-- Data for table wf.tnum_tramite (OID = 4014085) (LIMIT 0,2)

INSERT INTO wf.tnum_tramite (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_num_tramite, id_proceso_macro, id_gestion, num_siguiente)
VALUES (1, NULL, '2013-02-21 16:25:13.975162', NULL, 'activo', 1, 1, 103, 1);

INSERT INTO wf.tnum_tramite (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_num_tramite, id_proceso_macro, id_gestion, num_siguiente)
VALUES (1, NULL, '2013-02-21 16:25:41.633394', NULL, 'activo', 2, 1, 104, 1);


-- Data for table wf.ttipo_proceso (LIMIT 0,1)

INSERT INTO wf.ttipo_proceso (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_proceso, id_tipo_estado, id_proceso_macro, nombre, tabla, columna_llave, codigo)
VALUES (1, NULL, '2013-02-21 16:40:53.050201', NULL, 'activo', 1, NULL, 1, 'Solicitud de compra', 'adq.tsolicitud', 'id_solicitud', 'SOLCO');


-- Data for table wf.ttipo_estado (LIMIT 0,3)

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, NULL, '2013-02-21 16:53:08.728965', NULL, 'activo', 1, 1, 'SI', 'NO', 'Borrador', '', '');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, NULL, '2013-02-21 16:54:14.114248', NULL, 'activo', 2, 1, 'NO', 'NO', 'En Proceso', '', '');

INSERT INTO wf.ttipo_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_tipo_estado, id_tipo_proceso, inicio, disparador, nombre_estado, tipo_asignacion, nombre_func_list)
VALUES (1, NULL, '2013-02-21 16:54:28.81435', NULL, 'activo', 3, 1, 'NO', 'NO', 'Finalizado', '', '');


-- Data for table wf.testructura_estado (LIMIT 0,2)

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, NULL, '2013-02-21 16:54:58.599704', NULL, 'activo', 1, 1, 2, 1, '');

INSERT INTO wf.testructura_estado (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_estado, id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla)
VALUES (1, NULL, '2013-02-21 16:55:15.045367', NULL, 'activo', 2, 2, 3, 2, '');




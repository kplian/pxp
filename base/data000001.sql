/****************************I-DAT-JRR-PXP-2-19/11/2012*************/     


select pxp.f_crear_rol_sistema('conexion', '', true);

--
-- Data for table pxp.variable_global (OID = 306540) (LIMIT 0,6)
--
INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (2, 'sincronizar_base', 'dbendesis', 'nombre de la base dew datos a sincronizar');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (5, 'sincronizar_password', 'db_link', 'password para la sincronizacion de base de datos encriptado');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (4, 'sincronizar_user', 'db_link', 'nombre de usuario para sincronizar base de datos');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (6, 'sincroniza_ip', '10.172.0.13', 'ip de base de datos para sincronizacion');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (7, 'sincroniza_puerto', '5432', 'puesto de sincronizacion de base de datos postgres');

INSERT INTO pxp.variable_global (id_variable_global, variable, valor, descripcion)
VALUES (1, 'sincronizar', 'false', 'habilita la sincronización entre base de datos');


--
-- Data for sequence pxp.variable_global_id_variable_global_seq (OID = 306546)
--
SELECT pg_catalog.setval('pxp.variable_global_id_variable_global_seq', 7, true);

/****************************F-DAT-JRR-PXP-2-19/11/2012*************/ 
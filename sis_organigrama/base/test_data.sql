
-- Funcionario
INSERT INTO orga.tfuncionario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_funcionario, id_persona, codigo, email_empresa, interno, fecha_ingreso)
VALUES (1, NULL, '2012-11-10 12:56:13', '2012-11-10 12:56:13', 'activo', 1, 2, '1001', 'jperez@empresa.bo', '123', '2012-11-10');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:17:29.003', E'activo', 2, 6, E'GRODRIGUEZ', E'6', E'101', E'2013-01-02');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:18:12.431', E'activo', 3, 5, E'JFERNANDEZ', E'5', E'102', E'2013-01-01');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:19:50.693', E'activo', 4, 4, E'ggarcia', E'4', E'103', E'2013-01-01');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2013-01-24 00:00:00', E'2012-12-29 15:19:50', E'activo', 5, 1, E'frojas1', E'enzo@kplian.com', E'103', E'2013-01-01');

INSERT INTO orga.ttipo_horario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_horario", "codigo", "nombre")
VALUES (1, 1, E'2012-12-29 09:08:36.490', E'2012-12-29 13:22:16.039', E'activo', 3, E'TCOMP', E'Tiempo Completo');

INSERT INTO orga.ttipo_horario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_horario", "codigo", "nombre")
VALUES (1, 1, E'2012-12-29 09:08:46.898', E'2012-12-29 13:22:28.779', E'activo', 4, E'MTMP', E'Medio Tiempo');

INSERT INTO orga.ttipo_horario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_tipo_horario", "codigo", "nombre")
VALUES (1, 1, E'2012-12-29 09:08:53.601', E'2012-12-29 13:2:45.003', E'activo', 5, E'HREDU', E'Horario Reducido');

--NIVELES DE ESPECIALIDADES
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 1, 'PHD', 'Doctorado');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 2, 'MGR', 'Maestría');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 3, 'ING', 'Ingeniería');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 4, 'LIC', 'Licenciatura');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 5, 'UNI', 'Universitario');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 6, 'BAC', 'Bachiller');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 7, 'TSU', 'Técnico Superior');
INSERT INTO orga.tespecialidad_nivel(id_usuario_reg,fecha_reg,estado_reg, id_especialidad_nivel, codigo, nombre) VALUES (1, now(), 'activo', 8, 'TMD', 'Técnico Medio');

INSERT INTO orga.tespecialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_especialidad", "codigo", "nombre", "id_especialidad_nivel")
VALUES (1, NULL, E'2012-12-29 09:19:33.015', NULL, E'activo', 4, E'ESP02', E'Mantenimiento de Computadoras', 7);

INSERT INTO orga.tespecialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_especialidad", "codigo", "nombre", "id_especialidad_nivel")
VALUES (1, NULL, E'2012-12-29 09:19:55.361', NULL, E'activo', 6, E'ESP04', E'Reparacion de celulares', 1);

INSERT INTO orga.tespecialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_especialidad", "codigo", "nombre", "id_especialidad_nivel")
VALUES (1, 1, E'2012-12-29 09:19:14.600', E'2012-12-29 13:25:56.199', E'activo', 3, E'ESP01', E'Inspector de balbulas', 7);

INSERT INTO orga.tespecialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_especialidad", "codigo", "nombre", "id_especialidad_nivel")
VALUES (1, 1, E'2012-12-29 09:19:36.285', E'2012-12-29 13:26:16.556', E'activo', 5, E'ESP03', E'Mantenimiento de Servidores', 2);


-- FUNCIONARIO ESPECIALIDAD
INSERT INTO orga.tfuncionario_especialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_especialidad", "id_funcionario", "id_especialidad")
VALUES (1, NULL, E'2012-12-29 15:17:29.003', E'2012-12-29 15:17:29.003', E'activo', 1, 2, 3);

INSERT INTO orga.tfuncionario_especialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_especialidad", "id_funcionario", "id_especialidad")
VALUES (1, NULL, E'2012-12-29 15:17:29.003', E'2012-12-29 15:17:29.003', E'activo', 2, 2, 5);

INSERT INTO orga.tfuncionario_especialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_especialidad", "id_funcionario", "id_especialidad")
VALUES (1, NULL, E'2012-12-29 15:18:12.431', E'2012-12-29 15:18:12.431', E'activo', 3, 3, 4);

INSERT INTO orga.tfuncionario_especialidad ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario_especialidad", "id_funcionario", "id_especialidad")
VALUES (1, NULL, E'2012-12-29 15:19:50.693', E'2012-12-29 15:19:50.693', E'activo', 4, 4, 3);

------------I FRH ------------


--INSERT INTO orga.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "nombre", "nombre_corto", "id_subsistema", "codigo")
--VALUES (NULL, NULL, E'2013-01-24 18:58:56', E'2013-01-24 18:58:56', E'activo', 1, E'Gerencia General', E'GG', NULL, E'GG');


-- UO

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, 1, '2011-05-24 16:31:11', '2011-05-24 16:31:11', 'activo', 1, 'Empresa', 'Empresa XYZ', 'no', 'Nodo inicio de estructura uo', 'no', 'EMPRESA', 'si', 'no', NULL);

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, 1, '2011-05-24 16:38:52', '2011-05-24 16:38:52', 'inactivo', 3, 'UNIDAD 2', 'ENCARGADO UNIDAD 2', 'no', 'Nodo Unidad 2', 'no', 'U2', 'no', 'no', 'no');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, 1, '2011-05-24 16:35:45', '2011-05-24 16:35:45', 'activo', 2, 'GERENCIA GENERAL', 'GERENTE GENERA;', 'no', 'Nodo que depende de la raiz', 'si', 'GG', 'no', 'no', 'si');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:23:00', 'activo', 7, 'GERENCIA COMERCIAL', 'GERENTE COMERCIAL', 'si', '', 'si', 'GCM', 'no', 'no', 'si');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, NULL, '2011-05-25 00:00:00', '2011-05-25 00:06:20', 'activo', 5, 'GERENCIA DE TELECOMUNICACIONES', 'GERENTE DE TELECOMUNICACIONES', 'no', 'a', 'no', 'GTC', 'no', 'no', 'si');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:27:04', 'activo', 9, 'GERENCIA DE SISTEMA DE INFOMACION GEOGRAFICA', 'GERENTE DESIG', 'si', '', 'si', 'GSIG', 'no', 'no', 'no');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, NULL, '2011-05-25 00:00:00', '2011-05-25 00:08:19', 'activo', 6, 'DIVISION  DE XXX', 'JEFE DIVISION DE XXX', 'no', 'asd', 'no', 'RESPE', 'no', 'no', 'no');

INSERT INTO orga.tuo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_uo, nombre_unidad, nombre_cargo, cargo_individual, descripcion, presupuesta, codigo, nodo_base, gerencia, correspondencia)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:23:40', 'activo', 8, 'MARKETING', 'JEFE DE MARKETING', 'no', '', 'no', 'MARK', 'no', 'no', 'no');


-- ESTRUCTURA UO

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, 1, '2011-05-24 16:36:59', '2011-05-24 16:36:59', 'activo', 1, 1, 1);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, 1, '2011-05-24 16:37:13', '2011-05-24 16:37:13', 'activo', 2, 1, 2);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, NULL, '2011-05-25 00:00:00', '2011-05-25 00:06:20', 'activo', 4, 2, 5);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, NULL, '2011-05-25 00:00:00', '2011-05-25 00:08:19', 'activo', 5, 5, 6);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, 1, '2011-05-24 16:40:02', '2011-05-24 16:40:02', 'inactivo', 3, 1, 3);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:23:00', 'activo', 6, 2, 7);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:23:40', 'activo', 7, 7, 8);

INSERT INTO orga.testructura_uo (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_estructura_uo, id_uo_padre, id_uo_hijo)
VALUES (1, NULL, '2011-12-29 00:00:00', '2011-12-29 15:27:04', 'activo', 8, 2, 9);

------------F FRH ------------

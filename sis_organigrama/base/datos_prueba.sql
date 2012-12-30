
-- Funcionario
INSERT INTO orga.tfuncionario (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_funcionario, id_persona, codigo, email_empresa, interno, fecha_ingreso)
VALUES (1, NULL, '2012-11-10 12:56:13', '2012-11-10 12:56:13', 'activo', 1, 2, '1001', 'jperez@empresa.bo', '123', '2012-11-10');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:17:29.003', E'activo', 2, 6, E'GRODRIGUEZ', E'6', E'101', E'2013-01-02');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:18:12.431', E'activo', 3, 5, E'JFERNANDEZ', E'5', E'102', E'2013-01-01');

INSERT INTO orga.tfuncionario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_funcionario", "id_persona", "codigo", "email_empresa", "interno", "fecha_ingreso")
VALUES (1, NULL, E'2012-12-29 00:00:00', E'2012-12-29 15:19:50.693', E'activo', 4, 4, E'ggarcia', E'4', E'103', E'2013-01-01');

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
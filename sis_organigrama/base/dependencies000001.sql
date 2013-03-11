/********************************************I-DEP-RAC-ORGA-0-31/12/2012********************************************/

--
-- Definition for index fk_tdepto__id_subsistema (OID = 308873) : 
--
ALTER TABLE ONLY orga.tdepto
    ADD CONSTRAINT fk_tdepto__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
--
-- Definition for index fk_tusuario_uo__id_uo (OID = 308908) : 
--
ALTER TABLE ONLY orga.tusuario_uo
    ADD CONSTRAINT fk_tusuario_uo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
--
-- Definition for index fk_tusuario_uo__id_ususario (OID = 308913) : 
--
ALTER TABLE ONLY orga.tusuario_uo
    ADD CONSTRAINT fk_tusuario_uo__id_ususario
    FOREIGN KEY (id_usuario) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tfuncionario__id_persona (OID = 308948) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index fk_tfuncionario__id_usuario_mod (OID = 308953) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_usuario_mod
    FOREIGN KEY (id_usuario_mod) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tfuncionario__id_usuario_reg (OID = 308958) : 
--
ALTER TABLE ONLY orga.tfuncionario
    ADD CONSTRAINT fk_tfuncionario__id_usuario_reg
    FOREIGN KEY (id_usuario_reg) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tuo__id_uo_padre (OID = 414043) : 
--
ALTER TABLE ONLY orga.testructura_uo
    ADD CONSTRAINT fk_tuo__id_uo_padre
    FOREIGN KEY (id_uo_padre) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_testructura_uo__id_uo_hijo (OID = 414078) : 
--
ALTER TABLE ONLY orga.testructura_uo
    ADD CONSTRAINT fk_testructura_uo__id_uo_hijo
    FOREIGN KEY (id_uo_hijo) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_tuo_functionario__id_uo (OID = 414083) : 
--
ALTER TABLE ONLY orga.tuo_funcionario
    ADD CONSTRAINT fk_tuo_functionario__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo) ON UPDATE CASCADE;
--
-- Definition for index fk_tuo_functionario__id_funcionario (OID = 414088) : 
--
ALTER TABLE ONLY orga.tuo_funcionario
    ADD CONSTRAINT fk_tuo_functionario__id_funcionario
    FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario(id_funcionario) ON UPDATE CASCADE;



ALTER TABLE ONLY  orga.tespecialidad
 ADD  CONSTRAINT fk_tespecialidad__id_especialidad_nivel 
      FOREIGN KEY (id_especialidad_nivel)
      REFERENCES orga.tespecialidad_nivel (id_especialidad_nivel) 
      MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

--
-- Definition for view vfuncionario (OID = 306686) : 
--
CREATE VIEW orga.vfuncionario AS
SELECT funcio.id_funcionario, person.nombre_completo1 AS desc_funcionario1,
    person.nombre_completo2 AS desc_funcionario2, person.num_documento AS
    num_doc, person.ci, funcio.codigo, funcio.estado_reg
FROM (orga.tfuncionario funcio JOIN segu.vpersona person ON ((funcio.id_persona
    = person.id_persona)));

--
-- Definition for view vfuncionario_cargo (OID = 306690) : 
--
CREATE VIEW orga.vfuncionario_cargo AS
SELECT uof.id_uo_funcionario, funcio.id_funcionario,
    person.nombre_completo1 AS desc_funcionario1, person.nombre_completo2
    AS desc_funcionario2, uo.id_uo, uo.nombre_cargo, uof.fecha_asignacion,
    uof.fecha_finalizacion, person.num_documento AS num_doc, person.ci,
    funcio.codigo, funcio.email_empresa, funcio.estado_reg AS
    estado_reg_fun, uof.estado_reg AS estado_reg_asi
FROM (((orga.tfuncionario funcio JOIN segu.vpersona person ON
    ((funcio.id_persona = person.id_persona))) JOIN orga.tuo_funcionario uof ON
    ((uof.id_funcionario = funcio.id_funcionario))) JOIN orga.tuo uo ON
    ((uo.id_uo = uof.id_uo)));







/********************************************F-DEP-RAC-ORGA-0-31/12/2012********************************************/



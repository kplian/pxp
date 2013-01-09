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

--
-- Definition for index fk_tcorrelativo__id_depto (OID = 308838) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_depto
    FOREIGN KEY (id_depto) REFERENCES orga.tdepto(id_depto);

--
-- Definition for index fk_tcorrelativo__id_uo (OID = 308858) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
--
-- Definition for index tdepto_usuario_tdepto_usuairo_pkey (OID = 429272) : 
--
ALTER TABLE ONLY  orga.tespecialidad
 ADD  CONSTRAINT fk_tespecialidad__id_especialidad_nivel 
      FOREIGN KEY (id_especialidad_nivel)
      REFERENCES orga.tespecialidad_nivel (id_especialidad_nivel) 
      MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;








/********************************************F-DEP-RAC-ORGA-0-31/12/2012********************************************/



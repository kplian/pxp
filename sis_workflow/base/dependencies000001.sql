/********************************************I-DEP-FRH-WF-0-15/02/2013*************************************/

ALTER TABLE wf.testructura_estado ADD CONSTRAINT fk_estructura_estado__id_tipo_estado_padre FOREIGN KEY (id_tipo_estado_padre) REFERENCES wf.ttipo_estado (id_tipo_estado);
ALTER TABLE wf.testructura_estado ADD CONSTRAINT fk_estructura_estado__id_tipo_estado_hijo FOREIGN KEY (id_tipo_estado_hijo) REFERENCES wf.ttipo_estado (id_tipo_estado);
ALTER TABLE wf.ttipo_estado ADD CONSTRAINT fk_tipo_estado__id_tipo_proceso FOREIGN KEY (id_tipo_proceso) REFERENCES wf.ttipo_proceso (id_tipo_proceso);
ALTER TABLE wf.ttipo_proceso ADD CONSTRAINT fk_tipo_proceso__id_tipo_estado FOREIGN KEY (id_tipo_estado) REFERENCES wf.ttipo_estado (id_tipo_estado);
ALTER TABLE wf.testado_wf ADD CONSTRAINT fk_estado__id_estado_anterior FOREIGN KEY (id_estado_anterior) REFERENCES wf.testado_wf (id_estado_wf);
ALTER TABLE wf.testado_wf ADD CONSTRAINT fk_estado__id_tipo_estado FOREIGN KEY (id_tipo_estado) REFERENCES wf.ttipo_estado (id_tipo_estado);
ALTER TABLE wf.tcolumna_valor ADD CONSTRAINT fk_columna_valor__id_columna FOREIGN KEY (id_columna) REFERENCES wf.tcolumna (id_columna);
ALTER TABLE wf.tcolumna ADD CONSTRAINT fk_columna__id_tipo_proceso FOREIGN KEY (id_tipo_proceso) REFERENCES wf.ttipo_proceso (id_tipo_proceso);
ALTER TABLE wf.tproceso_wf ADD CONSTRAINT fk_proceso__id_tipo_proceso FOREIGN KEY (id_tipo_proceso) REFERENCES wf.ttipo_proceso (id_tipo_proceso);
ALTER TABLE wf.tcolumna_valor ADD CONSTRAINT fk_columna_valor__id_proceso FOREIGN KEY (id_proceso_wf) REFERENCES wf.tproceso_wf (id_proceso_wf);
ALTER TABLE wf.testado_wf ADD CONSTRAINT fk_estado__id_proceso FOREIGN KEY (id_proceso_wf) REFERENCES wf.tproceso_wf (id_proceso_wf);
ALTER TABLE wf.tproceso_macro ADD CONSTRAINT fk_proceso_macro__id_subsistema FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema (id_subsistema);
ALTER TABLE wf.ttipo_proceso ADD CONSTRAINT fk_tipo_proceso__id_proceso_macro FOREIGN KEY (id_proceso_macro) REFERENCES wf.tproceso_macro (id_proceso_macro);
ALTER TABLE wf.tnum_tramite ADD CONSTRAINT fk_num_tramite__id_proceso_macro FOREIGN KEY (id_proceso_macro) REFERENCES wf.tproceso_macro (id_proceso_macro);
ALTER TABLE wf.testado_wf ADD CONSTRAINT fk_estado__id_funcionario FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario (id_funcionario);
ALTER TABLE wf.tnum_tramite ADD CONSTRAINT fk_num_tramite__id_gestion FOREIGN KEY (id_gestion) REFERENCES param.tgestion (id_gestion);

/********************************************F-DEP-FRH-WF-0-15/02/2013*************************************/

/********************************************I-DEP-FRH-WF-0-18/02/2013*************************************/

ALTER TABLE wf.tfuncionario_tipo_estado ADD CONSTRAINT fk_funcionario_tipo_estado__id_funcionario FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario (id_funcionario);
ALTER TABLE wf.tfuncionario_tipo_estado ADD CONSTRAINT fk_funcionario_tipo_estado__id_tipo_estado FOREIGN KEY (id_tipo_estado) REFERENCES wf.ttipo_estado (id_tipo_estado);
ALTER TABLE wf.tfuncionario_tipo_estado ADD CONSTRAINT fk_funcionario_tipo_estado__id_depto FOREIGN KEY (id_depto) REFERENCES param.tdepto (id_depto);

ALTER TABLE wf.tlabores_tipo_proceso ADD CONSTRAINT fk_labores_tipo_proceso__id_tipo_proceso FOREIGN KEY (id_tipo_proceso) REFERENCES wf.ttipo_proceso (id_tipo_proceso);
ALTER TABLE wf.tfuncionario_tipo_estado ADD CONSTRAINT fk_funcionario_tipo_estado__id_labores_tipo_proceso FOREIGN KEY (id_labores_tipo_proceso) REFERENCES wf.tlabores_tipo_proceso (id_labores_tipo_proceso);

/********************************************F-DEP-FRH-WF-0-18/02/2013*************************************/


/********************************************I-DEP-RAC-WF-0-18/01/2014*************************************/

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD CONSTRAINT fk_tdocumento_wf__id_documento_wf FOREIGN KEY (id_proceso_wf)
    REFERENCES wf.tproceso_wf(id_proceso_wf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD CONSTRAINT fk_tdocumento_wf__if_tpo_documento FOREIGN KEY (id_tipo_documento)
    REFERENCES wf.ttipo_documento(id_tipo_documento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD CONSTRAINT fk_tdocumento_wf__id_ususerio FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;   
    
--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD CONSTRAINT fk_tdocumento_wf__id_usario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
 
--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento
  ADD CONSTRAINT fk_ttipo_documento__id_tipo_proceso FOREIGN KEY (id_tipo_proceso)
    REFERENCES wf.ttipo_proceso(id_tipo_proceso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 

--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento
  ADD CONSTRAINT fk_ttipo_documento__id_proceso_macro FOREIGN KEY (id_proceso_macro)
    REFERENCES wf.tproceso_macro(id_proceso_macro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 

--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento
  ADD CONSTRAINT fk_ttipo_documento__id_usuario FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento
  ADD CONSTRAINT fk_ttipo_documento__id_usuario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento_estado
  ADD CONSTRAINT fk_ttipo_documento_estado__id_usuario FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;      

--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento_estado
  ADD CONSTRAINT fk_ttipo_documento_estado__ud_usuario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento_estado
  ADD CONSTRAINT fk_ttipo_documento_estado__id_tipo_documento FOREIGN KEY (id_tipo_documento)
    REFERENCES wf.ttipo_documento(id_tipo_documento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;    

--------------- SQL ---------------

ALTER TABLE wf.ttipo_documento_estado
  ADD CONSTRAINT fk_ttipo_documento_estado__id_tipo_estado FOREIGN KEY (id_tipo_estado)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE wf.tdocumento_wf
  ADD CONSTRAINT fk_tdocumento_wf__id_estado_wf FOREIGN KEY (id_estado_ini)
    REFERENCES wf.testado_wf(id_estado_wf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;    
           
/*******************************************F-DEP-RAC-WF-0-18/01/2014*************************************/

/*******************************************I-DEP-JRR-WF-0-25/04/2014*************************************/
select pxp.f_insert_testructura_gui ('WF.1.2.2', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.3', 'WF.1.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1.2', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1', 'WF.1.2.1.3');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1', 'WF.1.2.1.3.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.2', 'WF.1.2.1.3.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1', 'WF.1.2.1.3.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1.1', 'WF.1.2.1.3.1.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.1.1.1.1', 'WF.1.2.1.3.1.1.1.1');
select pxp.f_insert_testructura_gui ('WF.1.2.2.1', 'WF.1.2.2');
select pxp.f_insert_testructura_gui ('INT.1', 'INT');
select pxp.f_insert_testructura_gui ('INT.2', 'INT');
select pxp.f_insert_testructura_gui ('INT.1.1', 'INT.1');
select pxp.f_insert_testructura_gui ('INT.2.1', 'INT.2');
select pxp.f_insert_testructura_gui ('STR.1', 'STR');
select pxp.f_insert_testructura_gui ('STR.2', 'STR');
select pxp.f_insert_testructura_gui ('STR.1.1', 'STR.1');
select pxp.f_insert_testructura_gui ('STR.2.1', 'STR.2');
select pxp.f_insert_testructura_gui ('WF.1.2.1.3.1.2.1', 'WF.1.2.1.3.1.2');
select pxp.f_insert_testructura_gui ('INT.2.1.1', 'INT.2.1');
select pxp.f_insert_testructura_gui ('STR.2.1.1', 'STR.2.1');
select pxp.f_insert_testructura_gui ('WF.1.2.1.4', 'WF.1.2.1');
select pxp.f_insert_testructura_gui ('INT.3', 'INT');
select pxp.f_insert_testructura_gui ('INT.4', 'INT');
select pxp.f_insert_testructura_gui ('INT.5', 'INT');
select pxp.f_insert_testructura_gui ('INT.3.1', 'INT.3');
select pxp.f_insert_testructura_gui ('INT.3.2', 'INT.3');
select pxp.f_insert_testructura_gui ('STR.3', 'STR');
select pxp.f_insert_testructura_gui ('STR.4', 'STR');
select pxp.f_insert_testructura_gui ('STR.5', 'STR');
select pxp.f_insert_testructura_gui ('STR.3.1', 'STR.3');
select pxp.f_insert_testructura_gui ('STR.3.2', 'STR.3');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'WF.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'WF.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_INS', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_MOD', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_ELI', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ESTES_SEL', 'WF.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_INS', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_MOD', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_ELI', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNCTEST_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'WF.1.2.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'WF.1.2.1.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'WF.1.2.1.3.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'WF.1.2.1.3.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_INS', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_MOD', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_ELI', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPDW_SEL', 'WF.1.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'WF.1.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_INS', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_MOD', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_ELI', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_LABTPROC_SEL', 'WF.1.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INT.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INT.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'STR.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'STR.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'WF.1.2.1.3.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INT.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'STR.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'INT', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'INT.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'INT.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'INT.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INT.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'STR', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'STR.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'STR.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'STR.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'STR.5', 'no');

/*******************************************F-DEP-JRR-WF-0-25/04/2014*************************************/

/*******************************************I-DEP-JRR-WF-0-07/05/2014*************************************/
DROP TABLE wf.tcolumna_valor;
DROP TABLE wf.tcolumna;

ALTER TABLE wf.ttabla
  ADD CONSTRAINT fk_ttabla__id_tipo_proceso FOREIGN KEY (id_tipo_proceso)
    REFERENCES wf.ttipo_proceso(id_tipo_proceso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE wf.ttabla
  ADD CONSTRAINT fk_ttabla__vista_id_tabla_maestro FOREIGN KEY (vista_id_tabla_maestro)
    REFERENCES wf.ttabla(id_tabla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

    
ALTER TABLE wf.ttipo_columna
  ADD CONSTRAINT fk_ttipo_columna__id_tabla FOREIGN KEY (id_tabla)
    REFERENCES wf.ttabla(id_tabla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE wf.tcolumna_estado
  ADD CONSTRAINT fk_tcolumna_estado__id_tipo_estado FOREIGN KEY (id_tipo_estado)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE wf.tcolumna_estado
  ADD CONSTRAINT fk_tcolumna_estado__id_tipo_columna FOREIGN KEY (id_tipo_columna)
    REFERENCES wf.ttipo_columna(id_tipo_columna)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/*******************************************F-DEP-JRR-WF-0-07/05/2014*************************************/







/*******************************************I-DEP-RAC-WF-0-09/05/2014*************************************/


--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen_id_tipo_proceso_fk FOREIGN KEY (id_tipo_proceso)
    REFERENCES wf.ttipo_proceso(id_tipo_proceso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen__id_tipo_estado_fk FOREIGN KEY (id_tipo_estado)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen__id_proceso_macro_fk FOREIGN KEY (id_proceso_macro)
    REFERENCES wf.tproceso_macro(id_proceso_macro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen__id_usuario_reg_fk FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen__id_usuario_mod_fk FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


--------------- SQL ---------------

ALTER TABLE wf.ttipo_proceso_origen
  ADD CONSTRAINT ttipo_proceso_origen__id_usuario_ai_fk FOREIGN KEY (id_usuario_ai)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/*******************************************F-DEP-RAC-WF-0-09/05/2014*************************************/

/*******************************************I-DEP-JRR-WF-0-12/08/2014*************************************/
CREATE TRIGGER trig_tproceso_macro BEFORE UPDATE 
ON wf.tproceso_macro FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_tproceso_macro ();

CREATE TRIGGER trig_ttipo_proceso BEFORE UPDATE 
ON wf.ttipo_proceso FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_proceso ();

CREATE TRIGGER trig_ttabla BEFORE UPDATE 
ON wf.ttabla FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttabla ();

CREATE TRIGGER trig_ttipo_estado BEFORE UPDATE 
ON wf.ttipo_estado FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_estado ();

CREATE TRIGGER trig_ttipo_columna BEFORE UPDATE 
ON wf.ttipo_columna FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_columna ();

CREATE TRIGGER trig_ttipo_documento BEFORE UPDATE 
ON wf.ttipo_documento FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_documento ();

CREATE TRIGGER trig_ttipo_documento_estado BEFORE UPDATE 
ON wf.ttipo_documento_estado FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_documento_estado ();

CREATE TRIGGER trig_tcolumna_estado BEFORE UPDATE 
ON wf.tcolumna_estado FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_tcolumna_estado ();

CREATE TRIGGER trig_testructura_estado BEFORE UPDATE 
ON wf.testructura_estado FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_testructura_estado ();

CREATE TRIGGER trig_tlabores_tipo_proceso BEFORE UPDATE 
ON wf.tlabores_tipo_proceso FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_tlabores_tipo_proceso ();

CREATE TRIGGER trig_ttipo_proceso_origen BEFORE UPDATE 
ON wf.ttipo_proceso_origen FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_proceso_origen ();

/*******************************************F-DEP-JRR-WF-0-12/08/2014*************************************/


/*******************************************I-DEP-JRR-WF-0-20/08/2014*************************************/
ALTER TABLE wf.tplantilla_correo
  ADD CONSTRAINT tplantilla_correo__id_tipo_estado FOREIGN KEY (id_tipo_estado)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/*******************************************F-DEP-JRR-WF-0-20/08/2014*************************************/

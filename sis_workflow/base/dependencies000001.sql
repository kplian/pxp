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


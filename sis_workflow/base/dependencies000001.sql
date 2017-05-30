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


/*******************************************I-DEP-JRR-WF-0-03/09/2014*************************************/
ALTER TABLE wf.ttipo_estado_rol
  ADD CONSTRAINT ttipo_estado_rol__id_tipo_estado FOREIGN KEY (id_tipo_estado)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE wf.ttipo_estado_rol
  ADD CONSTRAINT ttipo_estado_rol__id_rol FOREIGN KEY (id_rol)
    REFERENCES segu.trol(id_rol)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

CREATE TRIGGER trig_tplantilla_correo BEFORE UPDATE 
ON wf.tplantilla_correo FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_tplantilla_correo ();

CREATE TRIGGER trig_tfuncionario_tipo_estado BEFORE UPDATE 
ON wf.tfuncionario_tipo_estado FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_tfuncionario_tipo_estado ();

CREATE TRIGGER trig_ttipo_estado_rol BEFORE UPDATE 
ON wf.ttipo_estado_rol FOR EACH ROW 
EXECUTE PROCEDURE wf.ftrig_ttipo_estado_rol ();


/*******************************************F-DEP-JRR-WF-0-03/09/2014*************************************/

/*******************************************I-DEP-JRR-WF-0-27/03/2014*************************************/

CREATE TRIGGER trig_tcategoria_documento
  BEFORE UPDATE 
  ON wf.tcategoria_documento FOR EACH ROW 
  EXECUTE PROCEDURE wf.ftrig_tcategoria_documento();

/*******************************************F-DEP-JRR-WF-0-27/03/2014*************************************/


/*******************************************I-DEP-JRR-WF-0-22/04/2015*************************************/

CREATE TRIGGER trig_tobs
  AFTER INSERT OR UPDATE 
  ON wf.tobs FOR EACH ROW 
  EXECUTE PROCEDURE wf.ftrig_tobs();
  
/*******************************************F-DEP-JRR-WF-0-22/04/2015*************************************/

/*****************************I-DEP-JRR-WF-0-03/06/2015*************/

ALTER TABLE wf.ttipo_estado
  ADD CONSTRAINT ttipo_estado__id_tipo_estado_anterior FOREIGN KEY (id_tipo_estado_anterior)
    REFERENCES wf.ttipo_estado(id_tipo_estado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/*****************************F-DEP-JRR-WF-0-03/06/2015*************/

/*****************************I-DEP-JRR-WF-0-20/05/2016*************/
CREATE INDEX tdocumento_wf_idx ON wf.tdocumento_wf
  USING btree (id_proceso_wf);

CREATE INDEX testado_wf_idx ON wf.testado_wf
  USING btree (id_proceso_wf);
    
CREATE INDEX testado_wf_idx1 ON wf.testado_wf
  USING btree (id_tipo_estado);
  
/*****************************F-DEP-JRR-WF-0-20/05/2016*************/



/*****************************I-DEP-MMV-WF-0-29/05/2017*************/
CREATE OR REPLACE VIEW wf.vbitacotas_procesos(
    id_tipo_proceso,
    tipo_proceso,
    nro_tramite,
    nombre_estado,
    date_part,
    fecha_ini,
    fecha_fin,
    estado_sig,
    proveido,
    proceso_wf,
    id_proceso_wf,
    id_estado_wf,
    id_funcionario,
    desc_funcionario1,
    nombre_completo1)
AS
WITH hyomin AS(
  SELECT f_1.desc_funcionario1,
         e.id_estado_wf
  FROM wf.testado_wf e
       JOIN wf.ttipo_estado t ON t.id_tipo_estado = e.id_tipo_estado
       JOIN orga.vfuncionario f_1 ON f_1.id_funcionario = e.id_funcionario
  GROUP BY (t.nombre_estado::text = 'Borrador'::text),
           e.id_estado_wf,
           f_1.desc_funcionario1)
    SELECT tp.id_tipo_proceso,
           tp.nombre AS tipo_proceso,
           pf.nro_tramite,
           te1.nombre_estado,
           date_part('day'::text, est2.fecha_reg - est1.fecha_reg) AS date_part,
           est1.fecha_reg AS fecha_ini,
           est2.fecha_reg AS fecha_fin,
           te2.nombre_estado AS estado_sig,
           est2.obs AS proveido,
           pf.descripcion AS proceso_wf,
           pf.id_proceso_wf,
           est1.id_estado_wf,
           est1.id_funcionario,
           f.desc_funcionario1,
           h.desc_funcionario1 AS nombre_completo1
    FROM wf.testado_wf est1
         JOIN wf.testado_wf est2 ON est2.id_estado_anterior = est1.id_estado_wf
         JOIN wf.ttipo_estado te1 ON te1.id_tipo_estado = est1.id_tipo_estado
         JOIN wf.ttipo_estado te2 ON te2.id_tipo_estado = est2.id_tipo_estado
         JOIN wf.tproceso_wf pf ON pf.id_proceso_wf = est1.id_proceso_wf
         JOIN wf.ttipo_proceso tp ON tp.id_tipo_proceso = pf.id_tipo_proceso
         JOIN orga.vfuncionario f ON f.id_funcionario = est1.id_funcionario
         JOIN hyomin h ON h.id_estado_wf = est2.id_estado_wf
    ORDER BY est2.fecha_reg;

/*****************************F-DEP-MMV-WF-0-29/05/2017*************/
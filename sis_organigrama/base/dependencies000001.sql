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


CREATE OR REPLACE VIEW orga.vfuncionario(
    id_funcionario,
    desc_funcionario1,
    desc_funcionario2,
    num_doc,
    ci,
    codigo,
    estado_reg,
    nombre)
AS
  SELECT funcio.id_funcionario,
         person.nombre_completo1 AS desc_funcionario1,
         person.nombre_completo2 AS desc_funcionario2,
         person.num_documento AS num_doc,
         person.ci,
         funcio.codigo,
         funcio.estado_reg,
         person.nombre
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona;



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


/********************************************I-DEP-JRR-ORGA-0-9/01/2014********************************************/
ALTER TABLE orga.tescala_salarial
  ADD CONSTRAINT fk__tescala_salarial__id_categoria_salarial FOREIGN KEY (id_categoria_salarial)
    REFERENCES orga.tcategoria_salarial(id_categoria_salarial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_escala_salarial FOREIGN KEY (id_escala_salarial)
    REFERENCES orga.tescala_salarial(id_escala_salarial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_tipo_contrato FOREIGN KEY (id_tipo_contrato)
    REFERENCES orga.ttipo_contrato(id_tipo_contrato)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.ttemporal_cargo
  ADD CONSTRAINT fk__ttemporal_cargo_id_temporal_jerarquia_aprobacion FOREIGN KEY (id_temporal_jerarquia_aprobacion)
    REFERENCES orga.ttemporal_jerarquia_aprobacion(id_temporal_jerarquia_aprobacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_temporal_cargo FOREIGN KEY (id_temporal_cargo)
    REFERENCES orga.ttemporal_cargo(id_temporal_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo_centro_costo
  ADD CONSTRAINT fk__tcargo_centro_costo__id_cargo FOREIGN KEY (id_cargo)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo_centro_costo
  ADD CONSTRAINT fk__tcargo_centro_costo__id_centro_costo FOREIGN KEY (id_centro_costo)
    REFERENCES param.tcentro_costo(id_centro_costo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo_centro_costo
  ADD CONSTRAINT fk__tcargo_centro_costo__id_gestion FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo_presupuesto
  ADD CONSTRAINT fk__tcargo_presupuesto__id_cargo FOREIGN KEY (id_cargo)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE orga.tcargo_presupuesto
  ADD CONSTRAINT fk__tcargo_presupuesto__id_gestion FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo_presupuesto
  ADD CONSTRAINT fk__tcargo_presupuesto__id_centro_costo FOREIGN KEY (id_centro_costo)
    REFERENCES param.tcentro_costo(id_centro_costo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 

ALTER TABLE orga.tuo
  ADD CONSTRAINT fk__tuo__id_nivel_organizacional FOREIGN KEY (id_nivel_organizacional)
    REFERENCES orga.tnivel_organizacional(id_nivel_organizacional)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 


ALTER TABLE orga.toficina
  ADD CONSTRAINT fk__toficina__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_oficina FOREIGN KEY (id_oficina)
    REFERENCES orga.toficina(id_oficina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tcargo
  ADD CONSTRAINT fk__tcargo__id_uo FOREIGN KEY (id_uo)
    REFERENCES orga.tuo(id_uo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
CREATE OR REPLACE VIEW orga.vfuncionario_cargo(
    id_uo_funcionario,
    id_funcionario,
    desc_funcionario1,
    desc_funcionario2,
    id_uo,
    nombre_cargo,
    fecha_asignacion,
    fecha_finalizacion,
    num_doc,
    ci,
    codigo,
    email_empresa,
    estado_reg_fun,
    estado_reg_asi)
AS
  SELECT uof.id_uo_funcionario,
         funcio.id_funcionario,
         person.nombre_completo1 AS desc_funcionario1,
         person.nombre_completo2 AS desc_funcionario2,
         uo.id_uo,
         uo.nombre_cargo,
         uof.fecha_asignacion,
         uof.fecha_finalizacion,
         person.num_documento AS num_doc,
         person.ci,
         funcio.codigo,
         funcio.email_empresa,
         funcio.estado_reg AS estado_reg_fun,
         uof.estado_reg AS estado_reg_asi
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona
       JOIN orga.tuo_funcionario uof ON uof.id_funcionario =
        funcio.id_funcionario
       JOIN orga.tuo uo ON uo.id_uo = uof.id_uo
  where uof.estado_reg = 'activo';
  
ALTER TABLE orga.tfuncionario_cuenta_bancaria
  ADD CONSTRAINT fk__tfuncionario_cuenta_bancaria__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE orga.tfuncionario_cuenta_bancaria
  ADD CONSTRAINT fk__tfuncionario_cuenta_bancaria__id_institucion FOREIGN KEY (id_institucion)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/********************************************F-DEP-JRR-ORGA-0-9/01/2014********************************************/

/********************************************I-DEP-JRR-ORGA-0-24/01/2014********************************************/

ALTER TABLE orga.tuo_funcionario
  ADD CONSTRAINT fk__tuo_funcionario__id_cargo FOREIGN KEY (id_cargo)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/********************************************F-DEP-JRR-ORGA-0-24/01/2014********************************************/



/*********************************I-DEP-RAC-ORGA-0-25/05/2014***********************************/


ALTER TABLE orga.tinterinato
  ADD CONSTRAINT tinterinato_ed_usuario_fk FOREIGN KEY (id_usuario_reg)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
    
--------------- SQL ---------------

ALTER TABLE orga.tinterinato
  ADD CONSTRAINT fk_tinterinato__id_usuario_mod FOREIGN KEY (id_usuario_mod)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
    
--------------- SQL ---------------

ALTER TABLE orga.tinterinato
  ADD CONSTRAINT fk_tinterinato__id_cargo_titular FOREIGN KEY (id_cargo_titular)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
    
--------------- SQL ---------------

ALTER TABLE orga.tinterinato
  ADD CONSTRAINT fk_tinterinato__id_cargo_suplente FOREIGN KEY (id_cargo_suplente)
    REFERENCES orga.tcargo(id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/*********************************F-DEP-RAC-ORGA-0-25/05/2014***********************************/


/*****************************I-DEP-RAC-ORGA-0-31/07/2014*************/
--------------- SQL ---------------

CREATE OR REPLACE VIEW orga.vfuncionario_cargo(
    id_uo_funcionario,
    id_funcionario,
    desc_funcionario1,
    desc_funcionario2,
    id_uo,
    nombre_cargo,
    fecha_asignacion,
    fecha_finalizacion,
    num_doc,
    ci,
    codigo,
    email_empresa,
    estado_reg_fun,
    estado_reg_asi,
    id_cargo,
    descripcion_cargo,
    cargo_codigo)
AS
  SELECT uof.id_uo_funcionario,
         funcio.id_funcionario,
         person.nombre_completo1 AS desc_funcionario1,
         person.nombre_completo2 AS desc_funcionario2,
         uo.id_uo,
         uo.nombre_cargo,
         uof.fecha_asignacion,
         uof.fecha_finalizacion,
         person.num_documento AS num_doc,
         person.ci,
         funcio.codigo,
         funcio.email_empresa,
         funcio.estado_reg AS estado_reg_fun,
         uof.estado_reg AS estado_reg_asi,
         car.id_cargo,
         car.nombre AS descripcion_cargo,
         car.codigo AS cargo_codigo
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona
       JOIN orga.tuo_funcionario uof ON uof.id_funcionario =
        funcio.id_funcionario
       JOIN orga.tuo uo ON uo.id_uo = uof.id_uo
       JOIN orga.tcargo car ON car.id_cargo = uof.id_cargo
  WHERE uof.estado_reg::text = 'activo' ::text;


/*****************************F-DEP-RAC-ORGA-0-31/07/2014*************/

/*********************************I-DEP-JRR-ORGA-0-31/07/2014***********************************/

ALTER TABLE orga.toficina_cuenta
  ADD CONSTRAINT fk_toficina_cuenta__id_oficina FOREIGN KEY (id_oficina)
    REFERENCES orga.toficina(id_oficina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
    
/*********************************F-DEP-JRR-ORGA-0-31/07/2014***********************************/





/*********************************I-DEP-RAC-ORGA-0-19/08/2014***********************************/
--------------- SQL ---------------
CREATE OR REPLACE VIEW orga.vfuncionario_cargo(
    id_uo_funcionario,
    id_funcionario,
    desc_funcionario1,
    desc_funcionario2,
    id_uo,
    nombre_cargo,
    fecha_asignacion,
    fecha_finalizacion,
    num_doc,
    ci,
    codigo,
    email_empresa,
    estado_reg_fun,
    estado_reg_asi,
    id_cargo,
    descripcion_cargo,
    cargo_codigo)
AS
  SELECT uof.id_uo_funcionario,
         funcio.id_funcionario,
         person.nombre_completo1 AS desc_funcionario1,
         person.nombre_completo2 AS desc_funcionario2,
         uo.id_uo,
         uo.nombre_cargo,
         uof.fecha_asignacion,
         uof.fecha_finalizacion,
         person.num_documento AS num_doc,
         person.ci,
         funcio.codigo,
         funcio.email_empresa,
         funcio.estado_reg AS estado_reg_fun,
         uof.estado_reg AS estado_reg_asi,
         car.id_cargo,
         car.nombre AS descripcion_cargo,
         car.codigo AS cargo_codigo,
         uo.nombre_unidad
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona
       JOIN orga.tuo_funcionario uof ON uof.id_funcionario =
        funcio.id_funcionario
       JOIN orga.tuo uo ON uo.id_uo = uof.id_uo
       JOIN orga.tcargo car ON car.id_cargo = uof.id_cargo
  WHERE uof.estado_reg::text = 'activo' ::text;

/*********************************F-DEP-RAC-ORGA-0-19/08/2014***********************************/




/*********************************I-DEP-RAC-ORGA-0-09/10/2014***********************************/


CREATE OR REPLACE VIEW orga.vfuncionario_persona
AS
  SELECT funcio.id_funcionario,
         person.nombre_completo1 AS desc_funcionario1,
         person.nombre_completo2 AS desc_funcionario2,
         person.num_documento AS num_doc,
         person.ci,
         funcio.codigo,
         funcio.estado_reg,
         funcio.email_empresa,
         funcio.interno,
         funcio.telefono_ofi,
         person.celular1,
         person.celular2,
         person.telefono1,
         person.telefono2,
  		 person.correo,
         person.id_persona
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona;
       
/*********************************F-DEP-RAC-ORGA-0-09/10/2014***********************************/

/*********************************I-DEP-JRR-ORGA-0-05/03/2015***********************************/

CREATE TRIGGER ttemporal_cargo_tr AFTER UPDATE 
ON orga.ttemporal_cargo FOR EACH ROW 
EXECUTE PROCEDURE orga.f_tr_temporal_cargo();


CREATE TRIGGER tcargo_tr AFTER UPDATE 
ON orga.tcargo FOR EACH ROW 
EXECUTE PROCEDURE orga.f_tr_cargo();



/*********************************F-DEP-JRR-ORGA-0-05/03/2015***********************************/

/*********************************I-DEP-JRR-ORGA-0-16/03/2017***********************************/
DROP TRIGGER tcargo_tr ON orga.tcargo;

CREATE TRIGGER tcargo_tr
  AFTER INSERT
  ON orga.tcargo FOR EACH ROW
  EXECUTE PROCEDURE orga.f_tr_cargo();

/*********************************F-DEP-JRR-ORGA-0-16/03/2017***********************************/



/*********************************I-DEP-RAC-ORGA-0-01/12/2018***********************************/

DROP VIEW orga.vfuncionario_cargo_lugar;


CREATE OR REPLACE VIEW orga.vfuncionario_cargo_lugar (
    id_uo_funcionario,
    id_funcionario,
    desc_funcionario1,
    desc_funcionario2,
    id_uo,
    nombre_cargo,
    fecha_asignacion,
    fecha_finalizacion,
    num_doc,
    ci,
    codigo,
    email_empresa,
    estado_reg_fun,
    estado_reg_asi,
    id_cargo,
    descripcion_cargo,
    cargo_codigo,
    nombre_unidad,
    lugar_nombre,
    id_lugar,
    id_oficina,
    oficina_nombre,
    oficina_direccion)
AS
 SELECT uof.id_uo_funcionario,
    funcio.id_funcionario,
    person.nombre_completo1 AS desc_funcionario1,
    person.nombre_completo2 AS desc_funcionario2,
    uo.id_uo,
    uo.nombre_cargo,
    uof.fecha_asignacion,
    uof.fecha_finalizacion,
    person.num_documento AS num_doc,
    person.ci,
    funcio.codigo,
    funcio.email_empresa,
    funcio.estado_reg AS estado_reg_fun,
    uof.estado_reg AS estado_reg_asi,
    car.id_cargo,
    car.nombre AS descripcion_cargo,
    car.codigo AS cargo_codigo,
    uo.nombre_unidad,
    lu.nombre AS lugar_nombre,
    lu.id_lugar,
    of.id_oficina,
    of.nombre AS oficina_nombre,
    of.direccion AS oficina_direccion
   FROM orga.tfuncionario funcio
     JOIN segu.vpersona person ON funcio.id_persona = person.id_persona
     JOIN orga.tuo_funcionario uof ON uof.id_funcionario = funcio.id_funcionario
     JOIN orga.tuo uo ON uo.id_uo = uof.id_uo
     JOIN orga.tcargo car ON car.id_cargo = uof.id_cargo
     JOIN orga.toficina of ON of.id_oficina = car.id_oficina
     JOIN param.tlugar lu ON lu.id_lugar = of.id_lugar
  WHERE uof.estado_reg::text = 'activo'::text;
  
  
select pxp.f_insert_testructura_gui ('ESTORG', 'PARAMRH');
select pxp.f_insert_testructura_gui ('FUNCIO', 'PROCRH');
select pxp.f_insert_testructura_gui ('PARAMRH', 'ORGA');
select pxp.f_insert_testructura_gui ('PROCRH', 'ORGA');
select pxp.f_insert_testructura_gui ('REPRH', 'ORGA');
select pxp.f_insert_testructura_gui ('ORGA', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CARPCARG', 'PARAMRH');
select pxp.f_insert_testructura_gui ('JERAPRO', 'CARPCARG');
select pxp.f_insert_testructura_gui ('ESCASAL', 'CARPCARG');
select pxp.f_insert_testructura_gui ('NIVORGA', 'PARAMRH');
select pxp.f_insert_testructura_gui ('ORTIPCON', 'CARPCARG');
select pxp.f_insert_testructura_gui ('OFICI', 'PARAMRH');
select pxp.f_insert_testructura_gui ('Interinos', 'PROCRH');
select pxp.f_insert_testructura_gui ('NIVESPE', 'PARAMRH');
select pxp.f_insert_testructura_gui ('ASIGINGEN', 'PROCRH');



/*********************************F-DEP-RAC-ORGA-0-01/12/2018***********************************/


/********************************I-DEP-RAC-ORGA-24-26/16/2019***********************************/

CREATE OR REPLACE VIEW orga.vuo_centro(
    codigo_uo_centro,
    nombre_uo_centro,
    id_uo_centro,
    ids,
    id_uo,
    id_uo_padre,
    codigo,
    nombre_unidad,
    gerencia,
    correspondencia,
    uo_centro_orden)
AS
WITH RECURSIVE uo_centro(
    ids,
    id_uo,
    id_uo_padre,
    nombre_unidad,
    codigo,
    gerencia,
    correspondencia,
    uo_centro_orden) AS(
  SELECT ARRAY [ c_1.id_uo ] AS "array",
         c_1.id_uo,
         NULL::integer AS id_uo_padre,
         c_1.nombre_unidad,
         c_1.codigo,
         c_1.gerencia,
         c_1.correspondencia,
         c_1.orden_centro AS uo_centro_orden
  FROM orga.tuo c_1
  WHERE c_1.centro::text = 'si'::text AND
        c_1.estado_reg::text = 'activo'::text
  UNION
  SELECT pc.ids || c2.id_uo,
         c2.id_uo,
         euo.id_uo_padre,
         c2.nombre_unidad,
         c2.codigo,
         c2.gerencia,
         c2.correspondencia,
         c2.orden_centro AS uo_centro_orden
  FROM orga.tuo c2
       JOIN orga.testructura_uo euo ON euo.id_uo_hijo = c2.id_uo
       JOIN uo_centro pc ON pc.id_uo = euo.id_uo_padre
  WHERE c2.centro::text = 'no'::text AND
        c2.estado_reg::text = 'activo'::text)
      SELECT cl.codigo AS codigo_uo_centro,
             cl.nombre_unidad AS nombre_uo_centro,
             cl.id_uo AS id_uo_centro,
             c.ids,
             c.id_uo,
             c.id_uo_padre,
             c.codigo,
             c.nombre_unidad,
             c.gerencia,
             c.correspondencia,
             cl.orden_centro AS uo_centro_orden
      FROM uo_centro c
           JOIN orga.tuo cl ON cl.id_uo = c.ids [ 1 ];
           
  ----------------------------------------------
  
  CREATE OR REPLACE VIEW orga.vuo_gerencia(
    codigo_gerencia,
    nombre_unidad_gerencia,
    id_uo_gerencia,
    ids,
    id_uo,
    id_uo_padre,
    codigo,
    nombre_unidad,
    gerencia,
    correspondencia)
AS
WITH RECURSIVE uo_gerencia(
    ids,
    id_uo,
    id_uo_padre,
    nombre_unidad,
    codigo,
    gerencia,
    correspondencia) AS(
  SELECT ARRAY [ c_1.id_uo ] AS "array",
         c_1.id_uo,
         NULL::INTEGER AS id_uo_padre,
         c_1.nombre_unidad,
         c_1.codigo,
         c_1.gerencia,
         c_1.correspondencia
  FROM orga.tuo c_1
  WHERE c_1.gerencia::TEXT = 'si'::TEXT AND
        c_1.estado_reg::TEXT = 'activo'::TEXT
  UNION
  SELECT pc.ids || c2.id_uo,
         c2.id_uo,
         euo.id_uo_padre,
         c2.nombre_unidad,
         c2.codigo,
         c2.gerencia,
         c2.correspondencia
  FROM orga.tuo c2
       JOIN orga.testructura_uo euo ON euo.id_uo_hijo = c2.id_uo
       JOIN uo_gerencia pc ON pc.id_uo = euo.id_uo_padre
  WHERE c2.gerencia::TEXT = 'no'::TEXT AND
        c2.estado_reg::TEXT = 'activo'::TEXT)
      SELECT cl.codigo AS codigo_gerencia,
             cl.nombre_unidad AS nombre_unidad_gerencia,
             cl.id_uo AS id_uo_gerencia,
             c.ids,
             c.id_uo,
             c.id_uo_padre,
             c.codigo,
             c.nombre_unidad,
             c.gerencia,
             c.correspondencia
      FROM uo_gerencia c
           JOIN orga.tuo cl ON cl.id_uo = c.ids [ 1 ];
           
           -------------------------------------------------
  
  CREATE OR REPLACE VIEW orga.vuo_presu(
    codigo_uo_pre,
    nombre_uo_pre,
    id_uo_pre,
    ids,
    id_uo,
    id_uo_padre,
    codigo,
    nombre_unidad,
    gerencia,
    correspondencia)
AS
WITH RECURSIVE uo_presu(
    ids,
    id_uo,
    id_uo_padre,
    nombre_unidad,
    codigo,
    gerencia,
    correspondencia) AS(
  SELECT ARRAY [ c_1.id_uo ] AS "array",
         c_1.id_uo,
         NULL::INTEGER AS id_uo_padre,
         c_1.nombre_unidad,
         c_1.codigo,
         c_1.gerencia,
         c_1.correspondencia
  FROM orga.tuo c_1
  WHERE c_1.presupuesta::TEXT = 'si'::TEXT AND
        c_1.estado_reg::TEXT = 'activo'::TEXT
  UNION
  SELECT pc.ids || c2.id_uo,
         c2.id_uo,
         euo.id_uo_padre,
         c2.nombre_unidad,
         c2.codigo,
         c2.gerencia,
         c2.correspondencia
  FROM orga.tuo c2
       JOIN orga.testructura_uo euo ON euo.id_uo_hijo = c2.id_uo
       JOIN uo_presu pc ON pc.id_uo = euo.id_uo_padre
  WHERE c2.presupuesta::TEXT = 'no'::TEXT AND
        c2.estado_reg::TEXT = 'activo'::TEXT)
      SELECT cl.codigo AS codigo_uo_pre,
             cl.nombre_unidad AS nombre_uo_pre,
             cl.id_uo AS id_uo_pre,
             c.ids,
             c.id_uo,
             c.id_uo_padre,
             c.codigo,
             c.nombre_unidad,
             c.gerencia,
             c.correspondencia
      FROM uo_presu c
           JOIN orga.tuo cl ON cl.id_uo = c.ids [ 1 ];         
                    
/********************************F-DEP-RAC-ORGA-24-26/16/2019***********************************/
/********************************I-DEP-VAN-ORGA-0-11/05/2020***********************************/
CREATE TRIGGER trig_huo_funcionario
    AFTER INSERT OR UPDATE OR DELETE
    ON orga.tuo_funcionario
    FOR EACH ROW
EXECUTE PROCEDURE orga.f_trig_huo_funcionario();
/********************************F-DEP-VAN-ORGA-0-11/05/2020***********************************/

/********************************I-DEP-MMV-ORGA-MSA-60-11/05/2021***********************************/
ALTER TABLE orga.tuo
    ADD COLUMN tipo_unidad VARCHAR(20) DEFAULT 'no';
/********************************F-DEP-MMV-ORGA-MSA-60-11/05/2021***********************************/
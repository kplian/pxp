/***********************************I-DEP-RAC-PARAM-0-31/12/2012*****************************************/


--
-- Definition for index fk_tconfig_alarma__id_subsistema (OID = 308833) : 
--
ALTER TABLE ONLY param.tconfig_alarma
    ADD CONSTRAINT fk_tconfig_alarma__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);

--
-- Definition for index fk_tcorrelativo__id_documento (OID = 308843) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_documento
    FOREIGN KEY (id_documento) REFERENCES param.tdocumento(id_documento);
--
-- Definition for index fk_tcorrelativo__id_gestion (OID = 308848) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_gestion
    FOREIGN KEY (id_gestion) REFERENCES param.tgestion(id_gestion);
--
-- Definition for index fk_tcorrelativo__id_periodo (OID = 308853) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_periodo
    FOREIGN KEY (id_periodo) REFERENCES param.tperiodo(id_periodo);


--
-- Definition for index fk_tcorrelativo__id_usuario_mod (OID = 308863) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_usuario_mod
    FOREIGN KEY (id_usuario_mod) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tcorrelativo__id_usuario_reg (OID = 308868) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_usuario_reg
    FOREIGN KEY (id_usuario_reg) REFERENCES segu.tusuario(id_usuario);
--
-- Definition for index fk_tdocumento__id_subsistema (OID = 308878) : 
--
ALTER TABLE ONLY param.tdocumento
    ADD CONSTRAINT fk_tdocumento__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);
--
-- Definition for index fk_tproveedor__id_institucion (OID = 308898) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT fk_tproveedor__id_institucion
    FOREIGN KEY (id_institucion) REFERENCES param.tinstitucion(id_institucion);
--
-- Definition for index fk_tproveedor__id_persona (OID = 308903) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT fk_tproveedor__id_persona
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index tinstitucion_fk (OID = 308918) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_fk
    FOREIGN KEY (id_persona) REFERENCES segu.tpersona(id_persona);
--
-- Definition for index tlugar_fk (OID = 308923) : 
--
ALTER TABLE ONLY param.tlugar
    ADD CONSTRAINT tlugar_fk
    FOREIGN KEY (id_lugar_fk) REFERENCES param.tlugar(id_lugar);
--
-- Definition for index tperiodo_fk (OID = 308928) : 
--
ALTER TABLE ONLY param.tperiodo
    ADD CONSTRAINT tperiodo_fk
    FOREIGN KEY (id_gestion) REFERENCES param.tgestion(id_gestion);
--
-- Definition for index tunidad_medida_pkey (OID = 309535) : 
--
ALTER TABLE ONLY param.tunidad_medida
    ADD CONSTRAINT tunidad_medida_pkey
    PRIMARY KEY (id_unidad_medida);
    
    
    ------------
 alter table param.tcatalogo 
  add constraint fk_tcatalogo__id_catalogo_tipo foreign key (id_catalogo_tipo)
  references param.tcatalogo_tipo(id_catalogo_tipo);
  
  --------------
  
  
  ALTER TABLE param.tcatalogo_tipo
  ADD CONSTRAINT fk_tcatalogo_tipo__id_subsistema FOREIGN KEY (id_subsistema)
    REFERENCES segu.tsubsistema (id_subsistema) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION
    NOT DEFERRABLE; 
  
    
/***********************************F-DEP-RAC-PARAM-0-31/12/2012*****************************************/

   

/***********************************I-DEP-RAC-PARAM-0-04/01/2013*****************************************/

    
ALTER TABLE param.taprobador
  ADD CONSTRAINT fk_taprobador__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
    
ALTER TABLE param.taprobador
  ADD CONSTRAINT fk_taprobador__id_subsistema FOREIGN KEY (id_subsistema)
    REFERENCES segu.tsubsistema(id_subsistema)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE param.taprobador
  ADD CONSTRAINT fk_taprobador__id_uo FOREIGN KEY (id_uo)
    REFERENCES orga.tuo(id_uo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;         
    
--------------- SQL ---------------

ALTER TABLE param.tgestion
  ADD CONSTRAINT fk_tgestion__id_moneda_base FOREIGN KEY (id_moneda_base)
    REFERENCES param.tmoneda(id_moneda)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--
-- Definition for view vproveedor (OID = 306454) : 
--

--
-- Definition for index fk_tcorrelativo__id_depto (OID = 308838) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_depto
    FOREIGN KEY (id_depto) REFERENCES param.tdepto(id_depto);

--
-- Definition for index fk_tcorrelativo__id_uo (OID = 308858) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT fk_tcorrelativo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
--
-- Definition for index tdepto_usuario_tdepto_usuairo_pkey (OID = 429272) : 

CREATE OR REPLACE VIEW param.vproveedor (
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    desc_proveedor2,
    nit,
    id_lugar,
    lugar,
    pais,
    email,
    rotulo_comercial,
    ap_paterno,
    ap_materno,
    nombre,
    internacional,
    autorizacion)
AS
 SELECT provee.id_proveedor,
    provee.id_persona,
    provee.codigo,
    provee.numero_sigma,
    provee.tipo,
    provee.id_institucion,
    pxp.f_iif(provee.id_persona IS NOT NULL, pxp.f_iif(btrim(person.nombre_completo1) = btrim(provee.rotulo_comercial::text), person.nombre_completo1::character varying, (((person.nombre_completo1 || ' ('::text) || provee.rotulo_comercial::text) || ')'::text)::character varying), pxp.f_iif(btrim(instit.nombre::text) = btrim(provee.rotulo_comercial::text), instit.nombre, (((instit.nombre::text || ' ('::text) || btrim(provee.rotulo_comercial::text)) || ')'::text)::character varying)) AS desc_proveedor,
    pxp.f_iif(provee.id_persona IS NOT NULL, pxp.f_iif(btrim(person.nombre_completo1) = btrim(provee.rotulo_comercial::text), person.nombre_completo1::character varying, person.nombre_completo1::character varying), pxp.f_iif(btrim(instit.nombre::text) = btrim(provee.rotulo_comercial::text), instit.nombre, instit.nombre)) AS desc_proveedor2,
    provee.nit,
    provee.id_lugar,
    COALESCE(lug.nombre, ''::character varying)::character varying(100) AS lugar,
    param.f_obtener_padre_lugar(provee.id_lugar, 'pais'::character varying) AS pais,
    pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1) AS email,
    provee.rotulo_comercial,
    person.ap_paterno,
    person.ap_materno,
    person.nombre,
    provee.internacional,
    array_to_string(provee.autorizacion, ','::text)::character varying AS autorizacion
   FROM param.tproveedor provee
     LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
     LEFT JOIN param.tinstitucion instit ON instit.id_institucion = provee.id_institucion
     LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo'::text;
--




/***********************************F-DEP-RAC-PARAM-0-04/01/2013*****************************************/

/***********************************I-DEP-FRH-PARAM-0-04/02/2013*****************************************/

-- Definition for index fk_tdepto__id_subsistema 

--ALTER TABLE ONLY param.tdepto
--    ADD CONSTRAINT fk_tdepto__id_subsistema
--    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) MATCH FULL;
    
    
-- Definition for index fk_param.tdepto_uo__id_depto  

ALTER TABLE ONLY param.tdepto_uo
    ADD CONSTRAINT fk_tdepto_uo__id_depto
    FOREIGN KEY (id_depto) REFERENCES param.tdepto(id_depto);
    
    
-- Definition for index fk_param.tdepto_uo__id_uo 

ALTER TABLE ONLY param.tdepto_uo
    ADD CONSTRAINT fk_tdepto_uo__id_uo
    FOREIGN KEY (id_uo) REFERENCES orga.tuo(id_uo);
    


/***********************************F-DEP-FRH-PARAM-0-04/02/2013*****************************************/

/***********************************I-DEP-GSS-PARAM-0-14/02/2013*****************************************/

DROP INDEX param.tinstitucion_idx;

CREATE INDEX tinstitucion_idx ON param.tinstitucion
  USING btree (doc_id, estado_reg);

/***********************************F-DEP-GSS-PARAM-0-14/02/2013*****************************************/



/***********************************I-DEP-RAC-PARAM-0-22/02/2013*****************************************/

CREATE VIEW param.vep(
    id_ep,
    estado_reg,
    id_financiador,
    id_prog_pory_acti,
    id_regional,
    sw_presto,
    fecha_reg,
    id_usuario_reg,
    fecha_mod,
    id_usuario_mod,
    usr_reg,
    usr_mod,
    codigo_programa,
    codigo_proyecto,
    codigo_actividad,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    codigo_financiador,
    codigo_regional,
    nombre_financiador,
    nombre_regional,
    ep,
    desc_ppa)
AS
  SELECT frpp.id_ep,
         frpp.estado_reg,
         frpp.id_financiador,
         frpp.id_prog_pory_acti,
         frpp.id_regional,
         frpp.sw_presto,
         frpp.fecha_reg,
         frpp.id_usuario_reg,
         frpp.fecha_mod,
         frpp.id_usuario_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         prog.codigo_programa,
         proy.codigo_proyecto,
         act.codigo_actividad,
         prog.nombre_programa,
         proy.nombre_proyecto,
         act.nombre_actividad,
         fin.codigo_financiador,
         reg.codigo_regional,
         fin.nombre_financiador,
         reg.nombre_regional,
         (((((((fin.codigo_financiador::text || '-' ::text) ||
          reg.codigo_regional::text) || '-' ::text) ||
           prog.codigo_programa::text) || '-' ::text) ||
            proy.codigo_proyecto::text) || '-' ::text) ||
             act.codigo_actividad::text AS ep,
          prog.codigo_programa||'-'||	proy.codigo_proyecto||'-'||act.codigo_actividad as desc_ppa
  FROM param.tep frpp
       JOIN segu.tusuario usu1 ON usu1.id_usuario = frpp.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = frpp.id_usuario_mod
       JOIN param.tprograma_proyecto_acttividad ppa ON ppa.id_prog_pory_acti =
        frpp.id_prog_pory_acti
       JOIN param.tprograma prog ON prog.id_programa = ppa.id_programa
       JOIN param.tproyecto proy ON proy.id_proyecto = ppa.id_proyecto
       JOIN param.tactividad act ON act.id_actividad = ppa.id_actividad
       JOIN param.tregional reg ON reg.id_regional = frpp.id_regional
       JOIN param.tfinanciador fin ON fin.id_financiador = frpp.id_financiador;

--------------- SQL ---------------

CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((('(' ::text || uo.codigo::text) || ')-(' ::text) || ep.ep) || ')-('
          ::text) || ges.gestion) || ')' ::text AS codigo_cc
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo;  
       
 /***********************************F-DEP-RAC-PARAM-0-22/02/2013*****************************************/

/***********************************I-DEP-AAO-PARAM-62-19/03/2013*****************************************/
ALTER TABLE param.tperiodo_subsistema
  ADD CONSTRAINT fk_tperiodo_subsistema__id_periodo FOREIGN KEY (id_periodo)
    REFERENCES param.tperiodo(id_periodo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE param.tperiodo_subsistema
  ADD CONSTRAINT fk_tperiodo_subsistema__id_subsistema FOREIGN KEY (id_subsistema)
    REFERENCES segu.tsubsistema(id_subsistema)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-PARAM-62-19/03/2013*****************************************/


/***********************************I-DEP-JRR-PARAM-104-04/04/2013****************************************/

ALTER TABLE param.tasistente
  ADD CONSTRAINT fk_tasistente__id_uo FOREIGN KEY (id_uo)
    REFERENCES orga.tuo(id_uo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE param.tasistente
  ADD CONSTRAINT fk_tasistente__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-JRR-PARAM-104-04/04/2013****************************************/

/***********************************I-DEP-RCM-PARAM-85-03/04/2013*****************************************/
alter table param.tdocumento_fiscal
add constraint fk_tdocumento_fiscal__id_plantilla foreign key (id_plantilla)
references param.tplantilla(id_plantilla);
/***********************************F-DEP-RCM-PARAM-85-03/04/2013*****************************************/


/***********************************I-DEP-JRR-PARAM-0-29/04/2013*****************************************/

ALTER TABLE ONLY param.tdepto_ep
    ADD CONSTRAINT fk_tpm_depto_ep__id_depto FOREIGN KEY (id_depto) 
    REFERENCES param.tdepto(id_depto);
     
ALTER TABLE ONLY param.tdepto_ep
    ADD CONSTRAINT fk_tpm_depto_ep__id_ep FOREIGN KEY (id_ep)
    REFERENCES param.tep(id_ep);
/***********************************F-DEP-JRR-PARAM-0-29/04/2013*****************************************/
    
    

/***********************************I-DEP-JRR-PARAM-0-24/05/2013*****************************************/
CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    nombre_financiador,
    nombre_regional)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((('(' ::text || uo.codigo::text) || ')-(' ::text) || ep.ep) || ')-('
          ::text) || ges.gestion) || ')' ::text AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo;
/***********************************F-DEP-JRR-PARAM-0-24/05/2013*****************************************/
    
    

/***********************************I-DEP-RAC-PARAM-0-04/06/2013*****************************************/
    
    

ALTER TABLE param.tdepto_usuario
  ADD CONSTRAINT fk_tdepto_usuario__id_depto FOREIGN KEY (id_depto)
    REFERENCES param.tdepto(id_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
 ALTER TABLE param.tdepto_usuario
  ADD CONSTRAINT tfk_depto_usuario__id_usuario FOREIGN KEY (id_usuario)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
    
ALTER TABLE param.tproveedor
  ADD CONSTRAINT tproveedor_fk FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;  
  
 --------------- SQL ---------------

ALTER TABLE param.tproveedor
  ADD CONSTRAINT tproveedor__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


--------------- SQL ---------------

CREATE INDEX tpersona_idx ON segu.tpersona
  USING btree (nombre, apellido_paterno, apellido_materno);


/***********************************F-DEP-RAC-PARAM-0-04/06/2013*****************************************/

/***********************************I-DEP-JRR-PARAM-0-24/05/2013*****************************************/
CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    nombre_financiador,
    nombre_regional)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((('(' ::text || uo.codigo::text) || ')-(' ::text) || ep.ep) || ')-('
          ::text) || ges.gestion) || ')' ::text AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo;
/***********************************F-DEP-JRR-PARAM-0-24/05/2013*****************************************/










/***********************************I-DEP-RAC-PARAM-0-12/12/2013*****************************************/


--------------- SQL ---------------

CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    nombre_financiador,
    nombre_regional)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((('(' ::text || uo.codigo::text) || ')-(' ::text) || ep.ep) || ')-('
          ::text) || ges.gestion) || ') id:'||cec.id_centro_costo::text AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo;


/***********************************F-DEP-RAC-PARAM-0-12/12/2013*****************************************/


/***********************************I-DEP-JRR-PARAM-0-24/01/2014****************************************/

ALTER TABLE param.tinstitucion
  DROP CONSTRAINT tinstitucion_codigo_key RESTRICT;
/***********************************F-DEP-JRR-PARAM-0-24/01/2014****************************************/







/***********************************I-DEP-JRR-PARAM-0-23/10/2014****************************************/
ALTER TABLE param.tproveedor
  ADD CONSTRAINT fk__tproveedor__id_persona FOREIGN KEY (id_persona)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE param.tproveedor
  ADD CONSTRAINT fk__tproveedor__id_institucion FOREIGN KEY (id_institucion)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE param.tproveedor
  ADD CONSTRAINT fk__tproveedor__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

CREATE INDEX tproveedor_id_lugar ON param.tproveedor USING btree (id_lugar);
CREATE INDEX tlugar_id_lugar_fk ON param.tlugar USING btree (id_lugar_fk);

    
/***********************************F-DEP-JRR-PARAM-0-23/10/2014****************************************/


/***********************************I-DEP-RAC-PARAM-0-10/02/2015****************************************/

--------------- SQL ---------------

CREATE VIEW orga.vfuncionario_cargo_lugar 
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
         lu.nombre as lugar_nombre,
         lu.id_lugar,
         of.id_oficina,
         of.nombre as oficina_nombre
  FROM orga.tfuncionario funcio
       JOIN segu.vpersona person ON funcio.id_persona = person.id_persona
       JOIN orga.tuo_funcionario uof ON uof.id_funcionario =
         funcio.id_funcionario
       JOIN orga.tuo uo ON uo.id_uo = uof.id_uo
       JOIN orga.tcargo car ON car.id_cargo = uof.id_cargo
       JOIN orga.toficina of ON of.id_oficina = car.id_oficina
       JOIN param.tlugar lu ON lu.id_lugar = of.id_lugar
  WHERE uof.estado_reg = 'activo'; 
  
/***********************************F-DEP-RAC-PARAM-0-10/02/2015****************************************/

/***********************************I-DEP-JRR-PARAM-0-04/10/2015****************************************/

ALTER TABLE param.tconcepto_ingas
  ADD CONSTRAINT fk__tconcepto_ingas__id_entidad FOREIGN KEY (id_entidad)
    REFERENCES param.tentidad(id_entidad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-JRR-PARAM-0-04/10/2015****************************************/

/***********************************I-DEP-GSS-PARAM-0-04/11/2015****************************************/

ALTER TABLE param.tproveedor_cta_bancaria
  ADD CONSTRAINT fk_tproveedor_cta_bancaria__id_banco_beneficiario FOREIGN KEY (id_banco_beneficiario)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
	
ALTER TABLE param.tproveedor_cta_bancaria
  ADD CONSTRAINT fk_tproveedor_cta_bancaria__id_banco_intermediario FOREIGN KEY (id_banco_intermediario)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-GSS-PARAM-0-04/11/2015****************************************/



/***********************************I-DEP-RAC-PARAM-0-22/11/2016****************************************/

CREATE UNIQUE INDEX tsubsistema_var_idx ON param.tsubsistema_var
  USING btree (codigo, id_subsistema);
  
  --------------- SQL ---------------

ALTER TABLE param.tsubsistema_var
  ADD CONSTRAINT tsubsistema_var__id_subsistema_fk FOREIGN KEY (id_subsistema)
    REFERENCES segu.tsubsistema(id_subsistema)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


/***********************************F-DEP-RAC-PARAM-0-22/11/2016****************************************/

/***********************************I-DEP-GSS-PARAM-0-15/12/2016****************************************/

ALTER TABLE param.tcolumnas_archivo_excel
  ADD CONSTRAINT fk_tcolumnas_archivo_excel__id_plantilla_archivo_excel FOREIGN KEY (id_plantilla_archivo_excel)
    REFERENCES param.tplantilla_archivo_excel(id_plantilla_archivo_excel)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-GSS-PARAM-0-15/12/2016****************************************/

/***********************************I-DEP-MAM-PARAM-0-06/03/2017****************************************/
CREATE VIEW param.vgrupos (
    id_grupo,
    obs)
AS
SELECT gru.id_grupo,
    gru.obs
FROM param.tgrupo gru;
/***********************************F-DEP-MAN-PARAM-0-06/03/2017****************************************/




/***********************************I-DEP-RAC-PARAM-0-30/05/2017****************************************/

CREATE OR REPLACE VIEW param.vcentro_costo
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         (((((('('::text || uo.codigo::text) || ')-('::text) || ep.ep) || ')-('
           ::text) || ges.gestion) || ') id:'::text) || cec.id_centro_costo::
           text AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional,
         cec.id_tipo_cc,
         tcc.codigo as codigo_tcc,
         tcc.descripcion as descripcion_tcc,
         tcc.id_tipo_cc_fk,
         tcc.fecha_inicio,
         tcc.fecha_final
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg      
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       LEFT JOIN param.ttipo_cc tcc on tcc.id_tipo_cc = cec.id_tipo_cc ;
       
       
       
CREATE OR REPLACE VIEW param.vtipo_cc_mov(
    id_tipo_cc,
    codigo,
    control_techo,
    mov_pres,
    estado_reg,
    movimiento,
    id_ep,
    id_tipo_cc_fk,
    descripcion,
    tipo,
    control_partida,
    momento_pres,
    fecha_reg,
    usuario_ai,
    id_usuario_reg,
    id_usuario_ai,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    desc_ep,
    id_financiador,
    id_regional,
    id_prog_pory_acti,
    desc_ppa,
    fecha_inicio,
    fecha_final,
    gestion_ini,
    gestion_fin)
AS
  SELECT tcc.id_tipo_cc,
         tcc.codigo,
         tcc.control_techo,
         tcc.mov_pres,
         tcc.estado_reg,
         tcc.movimiento,
         tcc.id_ep,
         tcc.id_tipo_cc_fk,
         tcc.descripcion,
         tcc.tipo,
         tcc.control_partida,
         tcc.momento_pres,
         tcc.fecha_reg,
         tcc.usuario_ai,
         tcc.id_usuario_reg,
         tcc.id_usuario_ai,
         tcc.id_usuario_mod,
         tcc.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         ep.ep::character varying AS desc_ep,
         ep.id_financiador,
         ep.id_regional,
         ep.id_prog_pory_acti,
         ep.desc_ppa,
         tcc.fecha_inicio,
         tcc.fecha_final,
         gi.gestion AS gestion_ini,
         gf.gestion AS gestion_fin
  FROM param.ttipo_cc tcc
       JOIN segu.tusuario usu1 ON usu1.id_usuario = tcc.id_usuario_reg
       JOIN param.vep ep ON ep.id_ep = tcc.id_ep
       JOIN param.tperiodo pi ON tcc.fecha_inicio >= pi.fecha_ini AND
         tcc.fecha_inicio <= pi.fecha_fin
       JOIN param.tgestion gi ON pi.id_gestion = gi.id_gestion
       LEFT JOIN param.tperiodo pf ON tcc.fecha_final >= pf.fecha_ini AND
         tcc.fecha_final <= pf.fecha_fin
       LEFT JOIN param.tgestion gf ON pf.id_gestion = gf.id_gestion
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tcc.id_usuario_mod
  WHERE tcc.movimiento::text = 'si'::text;
  
/***********************************F-DEP-RAC-PARAM-0-30/05/2017****************************************/



/***********************************I-DEP-RAC-PARAM-0-05/06/2017****************************************/

CREATE OR REPLACE VIEW param.vcentro_costo
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         (((((('('::text || uo.codigo::text) || ')-('::text) || ep.ep) || ')-('
           ::text) || ges.gestion) || ') id:'::text) || cec.id_centro_costo::
           text AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional,
         cec.id_tipo_cc,
         tcc.codigo AS codigo_tcc,
         tcc.descripcion AS descripcion_tcc,
         tcc.id_tipo_cc_fk,
         tcc.fecha_inicio,
         tcc.fecha_final,
         tcc.mov_pres,
         tcc.momento_pres
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       LEFT JOIN param.ttipo_cc tcc ON tcc.id_tipo_cc = cec.id_tipo_cc;
       
   
/***********************************F-DEP-RAC-PARAM-0-05/06/2017****************************************/
       

/***********************************I-DEP-RAC-PARAM-0-12/06/2017****************************************/
CREATE OR REPLACE VIEW param.vtipo_cc(
    id_tipo_cc,
    codigo,
    control_techo,
    mov_pres,
    estado_reg,
    movimiento,
    id_ep,
    id_tipo_cc_fk,
    descripcion,
    tipo,
    control_partida,
    momento_pres,
    fecha_reg,
    usuario_ai,
    id_usuario_reg,
    id_usuario_ai,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    desc_ep,
    id_financiador,
    id_regional,
    id_prog_pory_acti,
    desc_ppa,
    fecha_inicio,
    fecha_final)
AS
  SELECT tcc.id_tipo_cc,
         tcc.codigo,
         tcc.control_techo,
         tcc.mov_pres,
         tcc.estado_reg,
         tcc.movimiento,
         tcc.id_ep,
         tcc.id_tipo_cc_fk,
         tcc.descripcion,
         tcc.tipo,
         tcc.control_partida,
         tcc.momento_pres,
         tcc.fecha_reg,
         tcc.usuario_ai,
         tcc.id_usuario_reg,
         tcc.id_usuario_ai,
         tcc.id_usuario_mod,
         tcc.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         ep.ep::character varying AS desc_ep,
         ep.id_financiador,
         ep.id_regional,
         ep.id_prog_pory_acti,
         ep.desc_ppa,
         tcc.fecha_inicio,
         tcc.fecha_final
  FROM param.ttipo_cc tcc
       JOIN segu.tusuario usu1 ON usu1.id_usuario = tcc.id_usuario_reg
       LEFT JOIN param.vep ep ON ep.id_ep = tcc.id_ep
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = tcc.id_usuario_mod;
/***********************************F-DEP-RAC-PARAM-0-12/06/2017****************************************/

/***********************************I-DEP-RAC-PARAM-0-29/06/2017****************************************/

CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    nombre_financiador,
    nombre_regional,
    id_tipo_cc,
    codigo_tcc,
    descripcion_tcc,
    id_tipo_cc_fk,
    fecha_inicio,
    fecha_final,
    mov_pres,
    momento_pres)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((tcc.codigo::text || ' - '::text) || ' '::text) || tcc.descripcion::
           text) || ' '::text) || ges.gestion AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional,
         cec.id_tipo_cc,
         tcc.codigo AS codigo_tcc,
         tcc.descripcion AS descripcion_tcc,
         tcc.id_tipo_cc_fk,
         tcc.fecha_inicio,
         tcc.fecha_final,
         tcc.mov_pres,
         tcc.momento_pres
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       LEFT JOIN param.ttipo_cc tcc ON tcc.id_tipo_cc = cec.id_tipo_cc;
       
 /***********************************F-DEP-RAC-PARAM-0-29/06/2017****************************************/
      
              

/***********************************I-DEP-RAC-PARAM-0-04/07/2017****************************************/
  

CREATE OR REPLACE VIEW param.vtipo_cc_raiz(
    codigo_raiz,
    descripcion_raiz,
    id_tipo_cc_raiz,
    control_techo,
    control_partida,
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    codigo,
    descripcion,
    movimiento)
AS
WITH RECURSIVE tipo_cc_raiz(
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    descripcion,
    codigo,
    control_techo,
    control_partida,
    movimiento) AS(
  SELECT ARRAY [ c_1.id_tipo_cc ] AS "array",
         c_1.id_tipo_cc,
         c_1.id_tipo_cc_fk,
         c_1.descripcion,
         c_1.codigo,
         c_1.control_techo,
         c_1.control_partida,
         c_1.movimiento
  FROM param.ttipo_cc c_1
  WHERE c_1.id_tipo_cc_fk IS NULL AND
        c_1.estado_reg::text = 'activo'::text
  UNION
  SELECT pc.ids || c2.id_tipo_cc,
         c2.id_tipo_cc,
         c2.id_tipo_cc_fk,
         c2.descripcion,
         c2.codigo,
         c2.control_techo,
         c2.control_partida,
         c2.movimiento
  FROM param.ttipo_cc c2,
       tipo_cc_raiz pc
  WHERE c2.id_tipo_cc_fk = pc.id_tipo_cc AND
        c2.estado_reg::text = 'activo'::text)
      SELECT cl.codigo AS codigo_raiz,
             cl.descripcion AS descripcion_raiz,
             cl.id_tipo_cc AS id_tipo_cc_raiz,
             cl.control_techo,
             cl.control_partida,
             c.ids,
             c.id_tipo_cc,
             c.id_tipo_cc_fk,
             c.codigo,
             c.descripcion,
             c.movimiento
      FROM tipo_cc_raiz c
           JOIN param.ttipo_cc cl ON cl.id_tipo_cc = c.ids [ 1 ];
           
/***********************************F-DEP-RAC-PARAM-0-04/07/2017****************************************/


/***********************************I-DEP-RAC-PARAM-0-05/07/2017****************************************/



CREATE OR REPLACE VIEW param.vtipo_cc_techo(
    codigo_techo,
    descripcion_techo,
    id_tipo_cc_techo,
    control_techo,
    control_partida,
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    codigo,
    descripcion,
    movimiento)
AS
WITH RECURSIVE tipo_cc_techo(
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    descripcion,
    codigo,
    control_techo,
    control_partida,
    movimiento) AS(
  SELECT ARRAY [ c_1.id_tipo_cc ] AS "array",
         c_1.id_tipo_cc,
         c_1.id_tipo_cc_fk,
         c_1.descripcion,
         c_1.codigo,
         c_1.control_techo,
         c_1.control_partida,
         c_1.movimiento
  FROM param.ttipo_cc c_1
  WHERE c_1.control_techo::text = 'si'::text AND
        c_1.estado_reg::text = 'activo'::text
  UNION
  SELECT pc.ids || c2.id_tipo_cc,
         c2.id_tipo_cc,
         c2.id_tipo_cc_fk,
         c2.descripcion,
         c2.codigo,
         c2.control_techo,
         c2.control_partida,
         c2.movimiento
  FROM param.ttipo_cc c2,
       tipo_cc_techo pc
  WHERE c2.id_tipo_cc_fk = pc.id_tipo_cc AND
        c2.estado_reg::text = 'activo'::text)
      SELECT cl.codigo AS codigo_techo,
             cl.descripcion AS descripcion_techo,
             cl.id_tipo_cc AS id_tipo_cc_techo,
             cl.control_techo,
             cl.control_partida,
             c.ids,
             c.id_tipo_cc,
             c.id_tipo_cc_fk,
             c.codigo,
             c.descripcion,
             c.movimiento
      FROM tipo_cc_techo c
           JOIN param.ttipo_cc cl ON cl.id_tipo_cc = c.ids [ 1 ]
      WHERE c.movimiento::text = 'si'::text;
      
  
/***********************************F-DEP-RAC-PARAM-0-05/07/2017****************************************/

/***********************************I-DEP-FFP-PARAM-0-11/07/2017****************************************/


      CREATE TRIGGER trig_talarma
BEFORE INSERT
  ON param.talarma FOR EACH ROW
EXECUTE PROCEDURE param.ftrig_talarma();

/***********************************F-DEP-FFP-PARAM-0-11/07/2017****************************************/


/***********************************I-DEP-FPC-PARAM-0-03/12/2017****************************************/
ALTER TABLE param.tinstitucion_persona
  ADD CONSTRAINT tinstitucion_persona_fk FOREIGN KEY (id_institucion)
    REFERENCES param.tinstitucion(id_institucion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE param.tinstitucion_persona
  ADD CONSTRAINT tinstitucion_persona_fk1 FOREIGN KEY (id_persona)
    REFERENCES segu.tpersona(id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
    
    

CREATE OR REPLACE VIEW param.vcentro_costo(
    id_centro_costo,
    estado_reg,
    id_ep,
    id_gestion,
    id_uo,
    id_usuario_reg,
    fecha_reg,
    id_usuario_mod,
    fecha_mod,
    usr_reg,
    usr_mod,
    codigo_uo,
    nombre_uo,
    ep,
    gestion,
    codigo_cc,
    nombre_programa,
    nombre_proyecto,
    nombre_actividad,
    nombre_financiador,
    nombre_regional,
    id_tipo_cc,
    codigo_tcc,
    descripcion_tcc,
    id_tipo_cc_fk,
    fecha_inicio,
    fecha_final,
    mov_pres,
    momento_pres,
    operativo)
AS
  SELECT cec.id_centro_costo,
         cec.estado_reg,
         cec.id_ep,
         cec.id_gestion,
         cec.id_uo,
         cec.id_usuario_reg,
         cec.fecha_reg,
         cec.id_usuario_mod,
         cec.fecha_mod,
         usu1.cuenta AS usr_reg,
         usu2.cuenta AS usr_mod,
         uo.codigo AS codigo_uo,
         uo.nombre_unidad AS nombre_uo,
         ep.ep,
         ges.gestion,
         ((((tcc.codigo::text || ' - '::text) || ' '::text) || tcc.descripcion::
           text) || ' '::text) || ges.gestion AS codigo_cc,
         ep.nombre_programa,
         ep.nombre_proyecto,
         ep.nombre_actividad,
         ep.nombre_financiador,
         ep.nombre_regional,
         cec.id_tipo_cc,
         tcc.codigo AS codigo_tcc,
         tcc.descripcion AS descripcion_tcc,
         tcc.id_tipo_cc_fk,
         tcc.fecha_inicio,
         tcc.fecha_final,
         tcc.mov_pres,
         tcc.momento_pres,
         COALESCE(tcc.operativo,'no')::varchar(4) as operativo
  FROM param.tcentro_costo cec
       JOIN segu.tusuario usu1 ON usu1.id_usuario = cec.id_usuario_reg
       JOIN param.vep ep ON ep.id_ep = cec.id_ep
       JOIN param.tgestion ges ON ges.id_gestion = cec.id_gestion
       JOIN orga.tuo uo ON uo.id_uo = cec.id_uo
       LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cec.id_usuario_mod
       LEFT JOIN param.ttipo_cc tcc ON tcc.id_tipo_cc = cec.id_tipo_cc;    
    
       
/***********************************F-DEP-FPC-PARAM-0-03/12/2017****************************************/


/***********************************I-DEP-RAC-PARAM-0-29/05/2018****************************************/


CREATE OR REPLACE VIEW param.v_tmp_tipo_cc_raiz (
    codigo_raiz,
    descripcion_raiz,
    id_tipo_cc_raiz,
    control_techo,
    control_partida,
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    codigo,
    descripcion,
    movimiento,
    tipo_cc_padre1,
    tipo_cc_padre2)
AS
 SELECT vtipo_cc_raiz.codigo_raiz,
    vtipo_cc_raiz.descripcion_raiz,
    vtipo_cc_raiz.id_tipo_cc_raiz,
    vtipo_cc_raiz.control_techo,
    vtipo_cc_raiz.control_partida,
    vtipo_cc_raiz.ids,
    vtipo_cc_raiz.id_tipo_cc,
    vtipo_cc_raiz.id_tipo_cc_fk,
    vtipo_cc_raiz.codigo,
    vtipo_cc_raiz.descripcion,
    vtipo_cc_raiz.movimiento,
    vtipo_cc_raiz.ids[1] AS tipo_cc_padre1,
    vtipo_cc_raiz.ids[2] AS tipo_cc_padre2
   FROM param.vtipo_cc_raiz;
   

select pxp.f_insert_testructura_gui ('PARAM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CCOM', 'PARAM');
select pxp.f_insert_testructura_gui ('CEP', 'PARAM');
select pxp.f_insert_testructura_gui ('APROC', 'CCOM');
select pxp.f_insert_testructura_gui ('FIN', 'CEP');
select pxp.f_insert_testructura_gui ('REGIO', 'CEP');
select pxp.f_insert_testructura_gui ('PROG', 'CEP');
select pxp.f_insert_testructura_gui ('ACT', 'CEP');
select pxp.f_insert_testructura_gui ('PPA', 'CEP');
select pxp.f_insert_testructura_gui ('FRPP', 'CEP');
select pxp.f_insert_testructura_gui ('CONIG', 'CCOM');
select pxp.f_insert_testructura_gui ('GQP', 'CEP');
select pxp.f_insert_testructura_gui ('WIDGET', 'OTROS');
select pxp.f_insert_testructura_gui ('ARXLS', 'OTROS');
select pxp.f_insert_testructura_gui ('COLXLS', 'ARXLS');
select pxp.f_insert_testructura_gui ('PROVEE', 'CCOM');
select pxp.f_insert_testructura_gui ('ASI', 'CCOM');
select pxp.f_insert_testructura_gui ('MNDS', 'PARAM');
select pxp.f_insert_testructura_gui ('MONPAR', 'MNDS');
select pxp.f_insert_testructura_gui ('TCB', 'MNDS');
select pxp.f_insert_testructura_gui ('ALRMS', 'PARAM');
select pxp.f_insert_testructura_gui ('ALARM', 'ALRMS');
select pxp.f_insert_testructura_gui ('GAL', 'ALRMS');
select pxp.f_insert_testructura_gui ('EMPS', 'PARAM');
select pxp.f_insert_testructura_gui ('ENT', 'EMPS');
select pxp.f_insert_testructura_gui ('EMP', 'EMPS');
select pxp.f_insert_testructura_gui ('DEPTO', 'EMPS');
select pxp.f_insert_testructura_gui ('GESTIO', 'EMPS');
select pxp.f_insert_testructura_gui ('PERIOD', 'EMPS');
select pxp.f_insert_testructura_gui ('CCOST', 'CEP');
select pxp.f_insert_testructura_gui ('CONALA', 'ALRMS');
select pxp.f_insert_testructura_gui ('CTLGS', 'PARAM');
select pxp.f_insert_testructura_gui ('CATA', 'CTLGS');
select pxp.f_insert_testructura_gui ('PACATI', 'CTLGS');
select pxp.f_insert_testructura_gui ('OTROS', 'PARAM');
select pxp.f_insert_testructura_gui ('PLANT', 'OTROS');
select pxp.f_insert_testructura_gui ('DF', 'OTROS');
select pxp.f_insert_testructura_gui ('UME', 'OTROS');
select pxp.f_insert_testructura_gui ('INSTIT', 'OTROS');
select pxp.f_insert_testructura_gui ('LUG', 'OTROS');
select pxp.f_insert_testructura_gui ('DOCUME', 'OTROS');
select pxp.f_insert_testructura_gui ('SERVIC', 'OTROS');
select pxp.f_insert_testructura_gui ('COMAL', 'ALRMS');
select pxp.f_insert_testructura_gui ('CONFLECT', 'OTROS');
select pxp.f_insert_testructura_gui ('TIPOAR', 'OTROS');
select pxp.f_insert_testructura_gui ('TIPCC', 'CEP');
select pxp.f_insert_testructura_gui ('TCC', 'CEP');
select pxp.f_insert_testructura_gui ('WSME', 'ALRMS');
select pxp.f_insert_testructura_gui ('VARDEP', 'EMPS');
select pxp.f_insert_testructura_gui ('PRO', 'CEP');

select pxp.f_insert_testructura_gui ('CATCON', 'CCOM');
select pxp.f_insert_testructura_gui ('PROVB', 'CCOM');
select pxp.f_insert_testructura_gui ('PROVINI', 'CCOM');
select pxp.f_insert_testructura_gui ('FERIADO', 'OTROS');
select pxp.f_insert_testructura_gui ('Adm', 'EMPS');
select pxp.f_insert_testructura_gui ('PTIPCC', 'CEP');
   
/***********************************F-DEP-RAC-PARAM-0-29/05/2018****************************************/

/***********************************I-DEP-EGS-PARAM-0-17/06/2019****************************************/

select pxp.f_insert_testructura_gui ('PLGR', 'OTROS');

/***********************************F-DEP-EGS-PARAM-0-17/06/2019****************************************/


/***********************************I-DEP-MANU-PARAM-0-25/07/2019****************************************/

ALTER TABLE param.tconcepto_ingas
  ADD CONSTRAINT tconcepto_ingas_fk FOREIGN KEY (id_tazas_impuesto)
    REFERENCES param.ttazas_impuesto(id_taza_impuesto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;  
    
select pxp.f_insert_testructura_gui ('TZIMP', 'OTROS');

/***********************************F-DEP-MANU-PARAM-0-25/07/2019****************************************/



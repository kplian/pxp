/***********************************I-DEP-RAC-PARAM-0-31/12/2012*****************************************/

--
-- Definition for index tinstitucion_idx (OID = 308254) : 
--
CREATE UNIQUE INDEX tinstitucion_idx ON param.tinstitucion USING btree (doc_id, estado_reg);
--
-- Definition for index tperiodo__gestion_per_estado__idx (OID = 308255) : 
--
CREATE UNIQUE INDEX tperiodo__gestion_per_estado__idx ON param.tperiodo USING btree (estado_reg, periodo, id_gestion);
--
-- Definition for index pk_pm_id_financiador (OID = 307978) : 
--
ALTER TABLE ONLY param.tfinanciador
    ADD CONSTRAINT pk_pm_id_financiador
    PRIMARY KEY (id_financiador);
--
-- Definition for index pk_pm_id_programa (OID = 307980) : 
--
ALTER TABLE ONLY param.tprograma
    ADD CONSTRAINT pk_pm_id_programa
    PRIMARY KEY (id_programa);
--
-- Definition for index pk_pm_id_proyecto (OID = 307982) : 
--
ALTER TABLE ONLY param.tproyecto
    ADD CONSTRAINT pk_pm_id_proyecto
    PRIMARY KEY (id_proyecto);
--
-- Definition for index pk_pm_id_regional (OID = 307984) : 
--
ALTER TABLE ONLY param.tregional
    ADD CONSTRAINT pk_pm_id_regional
    PRIMARY KEY (id_regional);
--
-- Definition for index talarma_pkey (OID = 307988) : 
--
ALTER TABLE ONLY param.talarma
    ADD CONSTRAINT talarma_pkey
    PRIMARY KEY (id_alarma);
--
-- Definition for index tcorrelativo_pkey (OID = 307990) : 
--
ALTER TABLE ONLY param.tcorrelativo
    ADD CONSTRAINT tcorrelativo_pkey
    PRIMARY KEY (id_correlativo);
--
-- Definition for index tdocumento_pkey (OID = 307996) : 
--
ALTER TABLE ONLY param.tdocumento
    ADD CONSTRAINT tdocumento_pkey
    PRIMARY KEY (id_documento);
--
-- Definition for index tgestion_pkey (OID = 307998) : 
--
ALTER TABLE ONLY param.tgestion
    ADD CONSTRAINT tgestion_pkey
    PRIMARY KEY (id_gestion);
--
-- Definition for index tinstitucion_codigo_key (OID = 308000) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_codigo_key
    UNIQUE (codigo);
--
-- Definition for index tinstitucion_pkey (OID = 308002) : 
--
ALTER TABLE ONLY param.tinstitucion
    ADD CONSTRAINT tinstitucion_pkey
    PRIMARY KEY (id_institucion);
--
-- Definition for index tlugas_pkey (OID = 308004) : 
--
ALTER TABLE ONLY param.tlugar
    ADD CONSTRAINT tlugas_pkey
    PRIMARY KEY (id_lugar);
--
-- Definition for index tmoneda_pkey (OID = 308006) : 
--
ALTER TABLE ONLY param.tmoneda
    ADD CONSTRAINT tmoneda_pkey
    PRIMARY KEY (id_moneda);
--
-- Definition for index tperiodo_pkey (OID = 308008) : 
--
ALTER TABLE ONLY param.tperiodo
    ADD CONSTRAINT tperiodo_pkey
    PRIMARY KEY (id_periodo);
--
-- Definition for index tpm_financiador_codigo_financiador_key (OID = 308010) : 
--
ALTER TABLE ONLY param.tfinanciador
    ADD CONSTRAINT tpm_financiador_codigo_financiador_key
    UNIQUE (codigo_financiador);
--
-- Definition for index tpm_programa_codigo_programa_key (OID = 308012) : 
--
ALTER TABLE ONLY param.tprograma
    ADD CONSTRAINT tpm_programa_codigo_programa_key
    UNIQUE (codigo_programa);
--
-- Definition for index tpm_proyecto_codigo_proyecto_key (OID = 308014) : 
--
ALTER TABLE ONLY param.tproyecto
    ADD CONSTRAINT tpm_proyecto_codigo_proyecto_key
    UNIQUE (codigo_proyecto);
--
-- Definition for index tpm_regional_codigo_regional_key (OID = 308016) : 
--
ALTER TABLE ONLY param.tregional
    ADD CONSTRAINT tpm_regional_codigo_regional_key
    UNIQUE (codigo_regional);
--
-- Definition for index tproveedor_idx (OID = 308018) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_idx
    UNIQUE (id_institucion, tipo, estado_reg);
--
-- Definition for index tproveedor_idx1 (OID = 308020) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_idx1
    UNIQUE (id_persona, tipo, estado_reg);
--
-- Definition for index tproveedor_pkey (OID = 308022) : 
--
ALTER TABLE ONLY param.tproveedor
    ADD CONSTRAINT tproveedor_pkey
    PRIMARY KEY (id_proveedor);
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
CREATE VIEW param.vproveedor AS
SELECT provee.id_proveedor, provee.id_persona, provee.codigo,
    provee.numero_sigma, provee.tipo, provee.id_institucion,
    pxp.f_iif((provee.id_persona IS NOT NULL),
    (person.nombre_completo1)::character varying, ((((instit.codigo)::text
    || '-'::text) || (instit.nombre)::text))::character varying) AS
    desc_proveedor, provee.nit
FROM ((param.tproveedor provee LEFT JOIN segu.vpersona person ON
    ((person.id_persona = provee.id_persona))) LEFT JOIN param.tinstitucion
    instit ON ((instit.id_institucion = provee.id_institucion)))
WHERE ((provee.estado_reg)::text = 'activo'::text);



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
--




/***********************************F-DEP-RAC-PARAM-0-04/01/2013*****************************************/

/***********************************I-DEP-FRH-PARAM-0-04/02/2013*****************************************/

-- Definition for index fk_tdepto__id_subsistema 

ALTER TABLE ONLY param.tdepto
    ADD CONSTRAINT fk_tdepto__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema) MATCH FULL;
    
    
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

/***********************************I-DEP-AAO-PARAM-0-07/03/2013*****************************************/
DROP VIEW param.vproveedor;

CREATE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL,
          person.nombre_completo1::character varying, ((instit.codigo::text ||
           '-' ::text) || instit.nombre::text) ::character varying) AS
            desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre as lugar,
         param.f_obtener_padre_lugar(provee.id_lugar,'pais') as pais
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion = provee.id_institucion
       LEFT JOIN param.tlugar lug on lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;

ALTER TABLE param.vproveedor
  OWNER TO postgres;

/***********************************F-DEP-AAO-PARAM-0-07/03/2013*****************************************/

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

/***********************************I-DEP-AAO-PARAM-72-23/04/2013*****************************************/
select pxp.f_insert_testructura_gui ('DEPTO.1', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.1.1', 'DEPTO.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.1', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.2', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.1.1', 'DEPTO.1.1.1');
select pxp.f_insert_testructura_gui ('LUG.1', 'LUG');
select pxp.f_insert_testructura_gui ('PROVEE.1', 'PROVEE');
select pxp.f_insert_testructura_gui ('GESTIO.1', 'GESTIO');
select pxp.f_insert_testructura_gui ('EMP.1', 'EMP');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_INS', 'ALARM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_MOD', 'ALARM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_ELI', 'ALARM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARMCOR_SEL', 'ALARM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_SEL', 'ALARM', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_INS', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_MOD', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_ELI', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_SEL', 'DEPTO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSU_INS', 'DEPTO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSU_MOD', 'DEPTO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSU_ELI', 'DEPTO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSU_SEL', 'DEPTO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_CLASIF_SEL', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_ROL_SEL', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_INS', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_MOD', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_ELI', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_SEL', 'DEPTO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'DEPTO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'DEPTO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'DEPTO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'DEPTO.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'DEPTO.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_ROL_SEL', 'DEPTO.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUROL_INS', 'DEPTO.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUROL_MOD', 'DEPTO.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUROL_ELI', 'DEPTO.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUROL_SEL', 'DEPTO.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_INS', 'LUG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_MOD', 'LUG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_ELI', 'LUG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_ARB_SEL', 'LUG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROY_INS', 'PRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROY_MOD', 'PRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROY_ELI', 'PRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROY_SEL', 'PRO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_SEL', 'PROVEE', 'no');
--select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LUG_ARB_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEE_INS', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEE_MOD', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEE_ELI', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEE_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'PROVEE', 'no');
--select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'PROVEE.1', 'no');
--select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_SEL', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PRITSE_INS', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PRITSE_MOD', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PRITSE_ELI', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PRITSE_SEL', 'PROVEE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'DOCUME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCUME_INS', 'DOCUME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCUME_MOD', 'DOCUME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCUME_ELI', 'DOCUME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCUME_SEL', 'DOCUME', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALATABLA_SEL', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONALA_INS', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONALA_MOD', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONALA_ELI', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONALA_SEL', 'CONALA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'UME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'UME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'UME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'UME', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_EMP_SEL', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_INS', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_MOD', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_ELI', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_INS', 'GESTIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_MOD', 'GESTIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_ELI', 'GESTIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_SEL', 'GESTIO.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CATA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_INS', 'PERIOD', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_MOD', 'PERIOD', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_ELI', 'PERIOD', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PER_SEL', 'PERIOD', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_INS', 'MONPAR', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_MOD', 'MONPAR', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_ELI', 'MONPAR', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'MONPAR', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'PACATI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_INS', 'PACATI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_MOD', 'PACATI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_ELI', 'PACATI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'PACATI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_INS', 'SERVIC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_MOD', 'SERVIC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_ELI', 'SERVIC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SERVIC_SEL', 'SERVIC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_APRO_INS', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_APRO_MOD', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_APRO_ELI', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_APRO_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_OBTARPOBA_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_fin_INS', 'FIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_fin_MOD', 'FIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_fin_ELI', 'FIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_fin_SEL', 'FIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_REGIO_INS', 'REGIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_REGIO_MOD', 'REGIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_REGIO_ELI', 'REGIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_REGIO_SEL', 'REGIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROG_INS', 'PROG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROG_MOD', 'PROG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROG_ELI', 'PROG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROG_SEL', 'PROG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ACT_INS', 'ACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ACT_MOD', 'ACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ACT_ELI', 'ACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ACT_SEL', 'ACT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PPA_INS', 'PPA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PPA_MOD', 'PPA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PPA_ELI', 'PPA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PPA_SEL', 'PPA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_INS', 'FRPP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_MOD', 'FRPP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_ELI', 'FRPP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'FRPP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_EMP_INS', 'EMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_EMP_MOD', 'EMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_EMP_ELI', 'EMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_EMP_SEL', 'EMP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_LOGMOD_IME', 'EMP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_INS', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_MOD', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_ELI', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_INS', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_MOD', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_ELI', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'TCB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_TCB_INS', 'TCB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_TCB_MOD', 'TCB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_TCB_ELI', 'TCB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_TCB_SEL', 'TCB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ASIS_INS', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ASIS_MOD', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ASIS_ELI', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ASIS_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PLT_SEL', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCFIS_INS', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCFIS_MOD', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCFIS_ELI', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCFIS_SEL', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_OBTNIT_GET', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PLT_INS', 'PLANT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PLT_MOD', 'PLANT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PLT_ELI', 'PLANT', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PLT_SEL', 'PLANT', 'no');
/***********************************F-DEP-AAO-PARAM-72-23/04/2013*****************************************/
/***********************************I-DEP-JRR-PARAM-0-29/04/2013*****************************************/

ALTER TABLE ONLY param.tdepto_ep
    ADD CONSTRAINT fk_tpm_depto_ep__id_depto FOREIGN KEY (id_depto) 
    REFERENCES param.tdepto(id_depto);
     
ALTER TABLE ONLY param.tdepto_ep
    ADD CONSTRAINT fk_tpm_depto_ep__id_ep FOREIGN KEY (id_ep)
    REFERENCES param.tep(id_ep);
/***********************************F-DEP-JRR-PARAM-0-29/04/2013*****************************************/
    
    
/***********************************I-DEP-RAC-PARAM-0-07/05/2013*****************************************/
  
  DROP VIEW param.vproveedor;
  
    CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL,
          person.nombre_completo1::character varying, ((instit.codigo::text ||
           '-' ::text) || instit.nombre::text) ::character varying) AS
            desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais' ::character varying
         ) AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
          AS email
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
        provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;
/***********************************F-DEP-RAC-PARAM-0-07/05/2013*****************************************/

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










/***********************************I-DEP-RAC-PARAM-0-24/12/2013*****************************************/


--------------- SQL ---------------

CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL,
          person.nombre_completo1::character varying,
           instit.nombre::text::character varying) AS desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais' ::character varying
         ) AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
          AS email
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
        provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;



/***********************************F-DEP-RAC-PARAM-0-24/12/2013*****************************************/


/***********************************I-DEP-JRR-PARAM-0-24/01/2014****************************************/

ALTER TABLE param.tinstitucion
  DROP CONSTRAINT tinstitucion_codigo_key RESTRICT;
/***********************************F-DEP-JRR-PARAM-0-24/01/2014****************************************/

/***********************************I-DEP-JRR-PARAM-0-20/03/2014****************************************/
  
CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email,
    rotulo_comercial)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL,
          person.nombre_completo1::character varying,
           instit.nombre::text::character varying) AS desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais' ::character varying
         ) AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
          AS email,
         provee.rotulo_comercial
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
        provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;

/***********************************F-DEP-JRR-PARAM-0-20/03/2014****************************************/



/***********************************I-DEP-RAC-PARAM-0-07/04/2014****************************************/
  

CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email,
    rotulo_comercial)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL,
          person.nombre_completo1::character varying, pxp.f_iif(btrim(
          instit.nombre::text) = btrim(provee.rotulo_comercial::text),
           instit.nombre, (((instit.nombre::text || '(' ::text) || btrim(
           provee.rotulo_comercial::text)) || ')' ::text) ::character varying))
            AS desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais' ::character varying
         ) AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
          AS email,
         provee.rotulo_comercial
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
        provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;

/***********************************F-DEP-RAC-PARAM-0-07/04/2014****************************************/
  
/***********************************I-DEP-JRR-PARAM-0-25/04/2014****************************************/

select pxp.f_insert_testructura_gui ('DEPTO.2', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.3', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.4', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.5', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.6', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.3', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('INSTIT.1', 'INSTIT');
select pxp.f_insert_testructura_gui ('INSTIT.1.1', 'INSTIT.1');
select pxp.f_insert_testructura_gui ('PROVEE.2', 'PROVEE');
select pxp.f_insert_testructura_gui ('PROVEE.3', 'PROVEE');
select pxp.f_insert_testructura_gui ('PROVEE.2.1', 'PROVEE.2');
select pxp.f_insert_testructura_gui ('PROVEE.3.1', 'PROVEE.3');
select pxp.f_insert_testructura_gui ('UME.1', 'UME');
select pxp.f_insert_testructura_gui ('GESTIO.2', 'GESTIO');
select pxp.f_insert_testructura_gui ('GESTIO.1.1', 'GESTIO.1');
select pxp.f_insert_testructura_gui ('PERIOD.1', 'PERIOD');
select pxp.f_insert_testructura_gui ('APROC.1', 'APROC');
select pxp.f_insert_testructura_gui ('APROC.1.1', 'APROC.1');
select pxp.f_insert_testructura_gui ('APROC.1.2', 'APROC.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1', 'APROC.1.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1.1', 'APROC.1.1.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1.1.1', 'APROC.1.1.1.1');
select pxp.f_insert_testructura_gui ('CONIG.1', 'CONIG');
select pxp.f_insert_testructura_gui ('ASI.1', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.2', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.3', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.1.1', 'ASI.1');
select pxp.f_insert_testructura_gui ('ASI.1.2', 'ASI.1');
select pxp.f_insert_testructura_gui ('ASI.1.1.1', 'ASI.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.1.2', 'ASI.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1', 'ASI.1.2');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1', 'ASI.1.2.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.2', 'ASI.1.2.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1', 'ASI.1.2.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1.1', 'ASI.1.2.1.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1.1.1', 'ASI.1.2.1.1.1.1');
select pxp.f_insert_testructura_gui ('DF.1', 'DF');
select pxp.f_insert_testructura_gui ('GQP.1', 'GQP');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'DEPTO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GRU_SEL', 'DEPTO.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_UEP_INS', 'DEPTO.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_UEP_MOD', 'DEPTO.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_UEP_ELI', 'DEPTO.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_UEP_SEL', 'DEPTO.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUO_INS', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUO_MOD', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUO_ELI', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUO_SEL', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'DEPTO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEEP_INS', 'DEPTO.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEEP_MOD', 'DEPTO.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEEP_ELI', 'DEPTO.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEEP_SEL', 'DEPTO.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'DEPTO.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DUE_INS', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DUE_MOD', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DUE_ELI', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DUE_SEL', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'DEPTO.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DOCUME_SEL', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FIR_INS', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FIR_MOD', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FIR_ELI', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FIR_SEL', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'DEPTO.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INSTIT', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INSTIT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INSTIT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INSTIT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INSTIT.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INSTIT.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'PROVEE', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'PROVEE.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'PROVEE.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'PROVEE.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'PROVEE.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'PROVEE.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'PROVEE.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'PROVEE.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'PROVEE.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'PROVEE.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'PROVEE.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'UME', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'UME.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PERSUB_SIN', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'GESTIO', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_INS', 'GESTIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_MOD', 'GESTIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_ELI', 'GESTIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_SEL', 'GESTIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SWESTPE_MOD', 'GESTIO.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'GESTIO.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_INS', 'PERIOD.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_MOD', 'PERIOD.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_ELI', 'PERIOD.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_SEL', 'PERIOD.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SWESTPE_MOD', 'PERIOD.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'APROC', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'APROC.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'APROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'APROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'APROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'APROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'APROC.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'APROC.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'APROC.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'APROC.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'APROC.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'APROC.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'APROC.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'APROC.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'APROC.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'APROC.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'APROC.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CONIG', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CONIG.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'CCOST', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'ASI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'ASI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_ESTRUO_SEL', 'ASI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_SEL', 'ASI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_SEL', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_SEL', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_SEL', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_SEL', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_INS', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_MOD', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_ELI', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ASI.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_INS', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_MOD', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_ELI', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ASI.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_INS', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_MOD', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_ELI', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ASI.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ASI.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ASI.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ASI.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ASI.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'ASI.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'ASI.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'ASI.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'ASI.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ASI.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ASI.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ASI.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ASI.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ASI.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ASI.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'ASI.1.2.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ASI.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ASI.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ASI.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ASI.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ASI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ASI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'DF', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'DF.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GAL_INS', 'GAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GAL_MOD', 'GAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GAL_ELI', 'GAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GAL_SEL', 'GAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GRU_INS', 'GQP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GRU_MOD', 'GQP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GRU_ELI', 'GQP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GRU_SEL', 'GQP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GQP_INS', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GQP_MOD', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GQP_ELI', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GQP_SEL', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_FRPP_SEL', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_UO_SEL', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'GQP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ESTORG.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ESTORG.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ESTORG.1.2', 'no');

/***********************************F-DEP-JRR-PARAM-0-25/04/2014****************************************/




/***********************************I-DEP-RAC-PARAM-0-19/05/2014****************************************/


--------------- SQL ---------------

CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email,
    rotulo_comercial)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL, pxp.f_iif(btrim(
         person.nombre_completo1) = btrim(provee.rotulo_comercial::text),
          person.nombre_completo1::character varying, (((person.nombre_completo1
           || ' (' ::text) || provee.rotulo_comercial::text) || ')' ::text)
            ::character varying), pxp.f_iif(btrim(instit.nombre::text) = btrim(
            provee.rotulo_comercial::text), instit.nombre, (((
            instit.nombre::text || ' (' ::text) || btrim(
            provee.rotulo_comercial::text)) || ')' ::text) ::character varying))
             AS desc_proveedor,
         provee.nit,
         provee.id_lugar,
         lug.nombre AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais' ::character varying
         ) AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
          AS email,
         provee.rotulo_comercial
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
        provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo' ::text;




/***********************************F-DEP-RAC-PARAM-0-19/05/2014****************************************/



/***********************************I-DEP-RAC-PARAM-0-29/05/2014****************************************/

--------------- SQL ---------------

CREATE OR REPLACE VIEW param.vproveedor(
    id_proveedor,
    id_persona,
    codigo,
    numero_sigma,
    tipo,
    id_institucion,
    desc_proveedor,
    nit,
    id_lugar,
    lugar,
    pais,
    email,
    rotulo_comercial)
AS
  SELECT provee.id_proveedor,
         provee.id_persona,
         provee.codigo,
         provee.numero_sigma,
         provee.tipo,
         provee.id_institucion,
         pxp.f_iif(provee.id_persona IS NOT NULL, pxp.f_iif(btrim(
           person.nombre_completo1) = btrim(provee.rotulo_comercial::text),
           person.nombre_completo1::character varying, (((
           person.nombre_completo1 || ' ('::text) || provee.rotulo_comercial::
           text) || ')'::text)::character varying), pxp.f_iif(btrim(
           instit.nombre::text) = btrim(provee.rotulo_comercial::text),
           instit.nombre, (((instit.nombre::text || ' ('::text) || btrim(
           provee.rotulo_comercial::text)) || ')'::text)::character varying)) AS
           desc_proveedor,
         provee.nit,
         provee.id_lugar,
         COALESCE(lug.nombre,'')::varchar(100) AS lugar,
         param.f_obtener_padre_lugar(provee.id_lugar, 'pais'::character varying)
           AS pais,
         pxp.f_iif(provee.id_persona IS NOT NULL, person.correo, instit.email1)
           AS email,
         provee.rotulo_comercial
  FROM param.tproveedor provee
       LEFT JOIN segu.vpersona person ON person.id_persona = provee.id_persona
       LEFT JOIN param.tinstitucion instit ON instit.id_institucion =
         provee.id_institucion
       LEFT JOIN param.tlugar lug ON lug.id_lugar = provee.id_lugar
  WHERE provee.estado_reg::text = 'activo'::text;

/***********************************F-DEP-RAC-PARAM-0-29/05/2014****************************************/

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

/***********************************I-DEP-RAC-PARAM-0-12/11/2015****************************************/

select pxp.f_insert_testructura_gui ('PARAM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CCOM', 'PARAM');
select pxp.f_insert_testructura_gui ('CEP', 'PARAM');
select pxp.f_delete_testructura_gui ('CONALA', 'PARAM');
select pxp.f_delete_testructura_gui ('DOCUME', 'PARAM');
select pxp.f_delete_testructura_gui ('DEPTO', 'PARAM');
select pxp.f_delete_testructura_gui ('ALARM', 'PARAM');
select pxp.f_delete_testructura_gui ('PROVEE', 'PARAM');
select pxp.f_delete_testructura_gui ('INSTIT', 'PARAM');
select pxp.f_delete_testructura_gui ('LUG', 'PARAM');
select pxp.f_delete_testructura_gui ('MONPAR', 'PARAM');
select pxp.f_delete_testructura_gui ('PERIOD', 'PARAM');
select pxp.f_delete_testructura_gui ('CATA', 'PARAM');
select pxp.f_delete_testructura_gui ('GESTIO', 'PARAM');
select pxp.f_delete_testructura_gui ('UME', 'PARAM');
select pxp.f_delete_testructura_gui ('PACATI', 'PARAM');
select pxp.f_delete_testructura_gui ('SERVIC', 'PARAM');
select pxp.f_insert_testructura_gui ('APROC', 'CCOM');
select pxp.f_insert_testructura_gui ('PRO', 'CEP');
select pxp.f_insert_testructura_gui ('FIN', 'CEP');
select pxp.f_insert_testructura_gui ('REGIO', 'CEP');
select pxp.f_insert_testructura_gui ('PROG', 'CEP');
select pxp.f_insert_testructura_gui ('ACT', 'CEP');
select pxp.f_insert_testructura_gui ('PPA', 'CEP');
select pxp.f_insert_testructura_gui ('FRPP', 'CEP');
select pxp.f_delete_testructura_gui ('EMP', 'PARAM');
select pxp.f_insert_testructura_gui ('CONIG', 'CCOM');
select pxp.f_delete_testructura_gui ('CCOST', 'PARAM');
select pxp.f_delete_testructura_gui ('TCB', 'PARAM');
select pxp.f_delete_testructura_gui ('ASI', 'PARAM');
select pxp.f_delete_testructura_gui ('DF', 'PARAM');
select pxp.f_delete_testructura_gui ('PLANT', 'PARAM');
select pxp.f_delete_testructura_gui ('GAL', 'PARAM');
select pxp.f_insert_testructura_gui ('GQP', 'CEP');
select pxp.f_insert_testructura_gui ('DEPTO.1', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.1.1', 'DEPTO.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.1', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.2', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.1.1', 'DEPTO.1.1.1');
select pxp.f_insert_testructura_gui ('LUG.1', 'LUG');
select pxp.f_insert_testructura_gui ('PROVEE.1', 'PROVEE');
select pxp.f_insert_testructura_gui ('GESTIO.1', 'GESTIO');
select pxp.f_insert_testructura_gui ('EMP.1', 'EMP');
select pxp.f_insert_testructura_gui ('DEPTO.2', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.3', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.4', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.5', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.6', 'DEPTO');
select pxp.f_insert_testructura_gui ('DEPTO.1.1.3', 'DEPTO.1.1');
select pxp.f_insert_testructura_gui ('INSTIT.1', 'INSTIT');
select pxp.f_insert_testructura_gui ('INSTIT.1.1', 'INSTIT.1');
select pxp.f_insert_testructura_gui ('PROVEE.2', 'PROVEE');
select pxp.f_insert_testructura_gui ('PROVEE.3', 'PROVEE');
select pxp.f_insert_testructura_gui ('PROVEE.2.1', 'PROVEE.2');
select pxp.f_insert_testructura_gui ('PROVEE.3.1', 'PROVEE.3');
select pxp.f_insert_testructura_gui ('UME.1', 'UME');
select pxp.f_insert_testructura_gui ('GESTIO.2', 'GESTIO');
select pxp.f_insert_testructura_gui ('GESTIO.1.1', 'GESTIO.1');
select pxp.f_insert_testructura_gui ('PERIOD.1', 'PERIOD');
select pxp.f_insert_testructura_gui ('APROC.1', 'APROC');
select pxp.f_insert_testructura_gui ('APROC.1.1', 'APROC.1');
select pxp.f_insert_testructura_gui ('APROC.1.2', 'APROC.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1', 'APROC.1.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1.1', 'APROC.1.1.1');
select pxp.f_insert_testructura_gui ('APROC.1.1.1.1.1', 'APROC.1.1.1.1');
select pxp.f_insert_testructura_gui ('CONIG.1', 'CONIG');
select pxp.f_insert_testructura_gui ('ASI.1', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.2', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.3', 'ASI');
select pxp.f_insert_testructura_gui ('ASI.1.1', 'ASI.1');
select pxp.f_insert_testructura_gui ('ASI.1.2', 'ASI.1');
select pxp.f_insert_testructura_gui ('ASI.1.1.1', 'ASI.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.1.2', 'ASI.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1', 'ASI.1.2');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1', 'ASI.1.2.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.2', 'ASI.1.2.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1', 'ASI.1.2.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1.1', 'ASI.1.2.1.1.1');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.1.1.1.1', 'ASI.1.2.1.1.1.1');
select pxp.f_insert_testructura_gui ('DF.1', 'DF');
select pxp.f_insert_testructura_gui ('GQP.1', 'GQP');
select pxp.f_insert_testructura_gui ('DEPTO.1.2', 'DEPTO.1');
select pxp.f_insert_testructura_gui ('PROVEE.3.1.1', 'PROVEE.3.1');
select pxp.f_insert_testructura_gui ('APROC.1.2.1', 'APROC.1.2');
select pxp.f_insert_testructura_gui ('ASI.1.2.1.2.1', 'ASI.1.2.1.2');
select pxp.f_insert_testructura_gui ('ASI.2.1', 'ASI.2');
select pxp.f_insert_testructura_gui ('ASI.2.2', 'ASI.2');
select pxp.f_insert_testructura_gui ('ASI.2.1.1', 'ASI.2.1');
select pxp.f_insert_testructura_gui ('ASI.2.1.1.1', 'ASI.2.1.1');
select pxp.f_insert_testructura_gui ('ASI.2.1.1.1.1', 'ASI.2.1.1.1');
select pxp.f_insert_testructura_gui ('ASI.2.2.1', 'ASI.2.2');
select pxp.f_insert_testructura_gui ('DEPTO.7', 'DEPTO');
select pxp.f_delete_testructura_gui ('ENT', 'PARAM');
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

/***********************************F-DEP-RAC-PARAM-0-12/11/2015****************************************/



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
       
              
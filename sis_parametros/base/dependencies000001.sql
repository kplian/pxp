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
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

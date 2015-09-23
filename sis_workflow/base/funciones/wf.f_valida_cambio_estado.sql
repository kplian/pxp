CREATE OR REPLACE FUNCTION wf.f_valida_cambio_estado (
  p_id_estado_wf integer,
  p_momento varchar = NULL::character varying,
  p_id_tipo_estado integer = NULL::integer,
  p_id_usuario integer = 1
)
RETURNS text AS
$body$
DECLARE
  v_id_tipo_proceso		integer;
  v_id_tipo_estado		integer;
  v_id_tabla			integer;
  v_columnas			record;
  v_nombre_tabla		varchar;
  v_condiciones			text;
  v_esquema				varchar;
  v_consulta			text;
  v_res					boolean;
  v_resp				varchar;
  v_nombre_funcion		varchar;
  v_id_proceso_wf		integer;
  v_id_tabla_instancia	integer;
  v_columna_bool		boolean;
  v_res_array			text[];
BEGIN
	v_nombre_funcion = 'wf.f_valida_cambio_estado';
      
  	select pwf.id_tipo_proceso,tab.id_tabla,tab.bd_nombre_tabla,
    		s.codigo,te.id_tipo_estado,pwf.id_proceso_wf
    into v_id_tipo_proceso,v_id_tabla,v_nombre_tabla,
    	v_esquema,v_id_tipo_estado,v_id_proceso_wf
    from wf.testado_wf ewf
  	inner join  wf.tproceso_wf pwf on ewf.id_proceso_wf = pwf.id_proceso_wf
    inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
    inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
    inner join wf.ttabla tab
    	on tab.id_tipo_proceso = pwf.id_tipo_proceso and tab.vista_id_tabla_maestro is null
    inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
	inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
    where ewf.id_estado_wf = p_id_estado_wf;
    
    if (v_id_tabla is null) then
    	return NULL;
    end if;
    if (p_id_tipo_estado is not null) then
    	v_id_tipo_estado = p_id_tipo_estado;
    end if;
    
    execute 'select id_' || v_nombre_tabla || '
    		 from ' || v_esquema || '.t' || v_nombre_tabla || '
             where id_proceso_wf = ' || v_id_proceso_wf || ' and 
             id_estado_wf = ' || p_id_estado_wf into v_id_tabla_instancia;    
    
    v_condiciones = ' 0=0 ';
    for v_columnas in (	select tc.*,ce.regla from wf.ttipo_columna tc
        						inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento = coalesce(p_momento,'exigir')
        						inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
            					where ce.estado_reg = 'activo' and tc.estado_reg = 'activo' and id_tabla = v_id_tabla and te.id_tipo_estado = v_id_tipo_estado) loop 
    	v_columna_bool = true;
        IF  (wf.f_evaluar_regla_wf ( p_id_usuario,
                                             v_id_proceso_wf,
                                             v_columnas.regla,
                                             v_id_tipo_estado,
                                             p_id_estado_wf))  THEN
            v_consulta = 'select 
                         (case when (' || v_columnas.bd_nombre_columna || ' IS NOT NULL) then
                              true
                         else
                              false
                         end)
                         from ' || v_esquema || '.t' || v_nombre_tabla || '
                         where id_' || v_nombre_tabla || ' = ' || v_id_tabla_instancia;
                     
            execute v_consulta into v_columna_bool;
        END IF;     
            if (v_columna_bool = FALSE) then
                v_res_array = v_res_array || v_columnas.form_label::text;
            end if;                     
    end loop;
    
    return array_to_string(v_res_array,',');
        
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
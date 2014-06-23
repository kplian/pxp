CREATE OR REPLACE FUNCTION wf.f_valida_cambio_estado (
  p_id_estado_wf integer
)
RETURNS boolean AS
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
BEGIN
	v_nombre_funcion = 'wf.ft_tabla_sel';
       
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
    	return true;
    end if;
    
    execute 'select id_' || v_nombre_tabla || '
    		 from ' || v_esquema || '.t' || v_nombre_tabla || '
             where id_proceso_wf = ' || v_id_proceso_wf || ' and 
             id_estado_wf = ' || p_id_estado_wf into v_id_tabla_instancia;    
    
    v_condiciones = ' 0=0 ';
    for v_columnas in (	select tc.* from wf.ttipo_columna tc
        						inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento in ('exigir')
        						inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
            					where id_tabla = v_id_tabla and te.id_tipo_estado = v_id_tipo_estado) loop 
    	v_condiciones = v_condiciones || ' and  ' || v_columnas.bd_nombre_columna || ' IS NOT NULL';                     
    end loop;
    --raise exception 'llega%', v_condiciones;
    v_consulta = 'select 
       (case when (' || v_condiciones || ') then
       		true
       else
       		false
       end)
       from ' || v_esquema || '.t' || v_nombre_tabla || '
       where id_' || v_nombre_tabla || ' = ' || v_id_tabla_instancia;
       
    execute v_consulta into v_res;
    return v_res;
        
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
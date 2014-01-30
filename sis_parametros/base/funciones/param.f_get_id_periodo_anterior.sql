CREATE OR REPLACE FUNCTION param.f_get_id_periodo_anterior (
  p_id_periodo integer
)
RETURNS integer AS
$body$
DECLARE
  	v_periodo		numeric;
    v_resp	            	varchar;
  	v_nombre_funcion      	text;
  	v_mensaje_error       	text;
    v_gestion		numeric;
    v_id_periodo_ant	integer;
BEGIN
	v_nombre_funcion = 'param.f_get_id_periodo_anterior';
    
    select p.periodo,g.gestion
    into v_periodo, v_gestion
    from param.tperiodo p
    inner join param.tgestion g on g.id_gestion = p.id_gestion
    where p.id_periodo = p_id_periodo and p.estado_reg = 'activo' and g.estado_reg = 'activo'; 
    
    if (v_periodo = 1)then
    	v_periodo = 12;
        v_gestion = v_gestion - 1;
    else
    	v_periodo = v_periodo - 1;
    end if;
    
    select p.id_periodo
    into v_id_periodo_ant
    from param.tperiodo p
    inner join param.tgestion g on g.id_gestion = p.id_gestion
    where p.periodo = v_periodo and g.gestion = v_gestion and p.estado_reg = 'activo' and g.estado_reg = 'activo';
    
    if (v_id_periodo_ant is null) then
    	raise exception 'No existe periodo anterior al: %/%',v_periodo,v_gestion;
    end if; 
    
    return v_id_periodo_ant;
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
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
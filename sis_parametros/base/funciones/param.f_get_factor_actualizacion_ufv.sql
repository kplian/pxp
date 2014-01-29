CREATE OR REPLACE FUNCTION param.f_get_factor_actualizacion_ufv (
  p_fecha_ini date,
  p_fecha_fin date
)
RETURNS numeric AS
$body$
DECLARE
  	v_tipo_cambio1		numeric;
    v_tipo_cambio2		numeric;
    v_resp	            	varchar;
  	v_nombre_funcion      	text;
  	v_mensaje_error       	text;
BEGIN
	v_nombre_funcion = 'param.f_get_factor_actualizacion_ufv';
    
    select oficial
    into v_tipo_cambio1
    from param.ttipo_cambio tc
    inner join param.tmoneda m on m.id_moneda = tc.id_moneda
    where m.codigo = 'UFV' and tc.fecha = p_fecha_ini and 
          tc.estado_reg = 'activo' and m.estado_reg = 'activo';
    
    select oficial
    into v_tipo_cambio2
    from param.ttipo_cambio tc
    inner join param.tmoneda m on m.id_moneda = tc.id_moneda
    where m.codigo = 'UFV' and tc.fecha = p_fecha_fin and 
          tc.estado_reg = 'activo' and m.estado_reg = 'activo';
    
    if (v_tipo_cambio1 is null) then
    	raise exception 'No existe tipo de cambio para la fecha: % , para la moneda: UFV',p_fecha_ini;
    end if;
    
    if (v_tipo_cambio2 is null) then
    	raise exception 'No existe tipo de cambio para la fecha: % , para la moneda: UFV',p_fecha_ini;
    end if;
    return v_tipo_cambio2/v_tipo_cambio1;
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
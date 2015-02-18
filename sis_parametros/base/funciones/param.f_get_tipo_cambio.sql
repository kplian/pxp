CREATE OR REPLACE FUNCTION param.f_get_tipo_cambio (
  p_id_moneda_1 integer,
  p_fecha date,
  p_tipo varchar
)
RETURNS numeric AS
$body$
/**************************************************************************
 FUNCION: 		param.f_get_tipo_cambio
 DESCRIPCION:   Devuelve el tipo de cambio de la moneda1 a la moneda2 con el tipo
                de cambio "O" Oficial "C" Compra y "V" venta por defecto "O" y con el redondeo
                p_num_decimales por defecto 2
 AUTOR: 	    RCM
 FECHA:			06/09/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
DECLARE

    v_resp                      varchar;
    v_nombre_funcion            text;
    v_mensaje_error             text;
    v_id_moneda_base            integer;
    v_tipo                      varchar;
    v_tipo_cambio				numeric;

BEGIN
    v_nombre_funcion:='param.f_get_tipo_cambio';
    
    /*Dar valores por defecto*/
    if(p_tipo is null)then
        v_tipo='O';
    end if;
    
    if(p_fecha is null)then
        raise exception 'Debe definir una fecha para obtener el tipo de cambio';
    end if;
    
    /*Obtener la moneda base*/
    v_id_moneda_base=param.f_get_moneda_base();

	/*Si la moneda 1 y la 2 son la misma se devuelve el mismo tipo de cambio*/
    if(p_id_moneda_1=v_id_moneda_base)then
        v_tipo_cambio = 1;
    else
    	select tc.oficial
        into v_tipo_cambio
        from param.ttipo_cambio tc
        where tc.id_moneda=p_id_moneda_1
        and tc.fecha=p_fecha;
    end if;
    
	return v_tipo_cambio;

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
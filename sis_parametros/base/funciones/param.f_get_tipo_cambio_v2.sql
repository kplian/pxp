--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_get_tipo_cambio_v2 (
  p_id_moneda_1 integer,
  p_id_moneda_2 integer,
  p_fecha date,
  p_tipo varchar
)
RETURNS numeric AS
$body$
/**************************************************************************
 FUNCION: 		param.f_get_tipo_cambio_v2
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
    v_nombre_funcion:='param.f_get_tipo_cambio_v2';
    
     v_id_moneda_base = param.f_get_moneda_base();
   
  
     
    -- calula tipo de cambio
    IF v_id_moneda_base != p_id_moneda_1 and v_id_moneda_base != p_id_moneda_2 THEN
    	RETURN  param.f_convertir_moneda (p_id_moneda_1,p_id_moneda_2, 1.00, p_fecha,p_tipo,50,1.00, 'no'); 
   
    ELSE
       
       IF v_id_moneda_base = p_id_moneda_1 THEN
          
          RETURN  param.f_get_tipo_cambio(p_id_moneda_2, p_fecha, p_tipo);
       
       ELSE
         
         RETURN  param.f_get_tipo_cambio(p_id_moneda_1, p_fecha, p_tipo);
       
       END IF;
    
    END IF;
   
    
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
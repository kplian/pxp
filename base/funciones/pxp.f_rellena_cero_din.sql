CREATE OR REPLACE FUNCTION pxp.f_rellena_cero_din (
  p_numero integer,
  p_longitud integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		Rellena la cadena con ceros a la izquierda hasta una longitud definida
 AUTOR: 		RCM
 FECHA:	        30/12/2015
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/
DECLARE

	v_cad_numero 		varchar;
	v_resp		        varchar;
	v_nombre_funcion    text;
	v_mensaje_error     text;
    
BEGIN
	
    v_nombre_funcion = 'pxp.f_rellena_cero_din';
    v_cad_numero = cast(p_numero as varchar);
    
    if length(v_cad_numero) >= p_longitud then
    	return v_cad_numero;
    end if;
    
    for i in 1..p_longitud - length(v_cad_numero) loop
    	v_cad_numero = '0'||v_cad_numero;
    end loop;
    
    return v_cad_numero;

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
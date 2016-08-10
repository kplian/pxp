CREATE OR REPLACE FUNCTION pxp.f_rellena_cero (
  cadena varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_rellena_cero
 DESCRIPCION:   Rellena con ceros la cadena para que tenga 2 caracteres
 AUTOR: 		 (jrivera)
 FECHA:	        05-11-2014 21:58:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/
DECLARE
  res varchar;
  v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
BEGIN
	v_nombre_funcion = 'pxp.f_rellena_cero';
 if (char_length(cadena)=1) THEN
 return '0' || cadena;
 elsif  (char_length(cadena)=0) THEN      
     return '00';
 else  
 return cadena;
 
 end if;
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
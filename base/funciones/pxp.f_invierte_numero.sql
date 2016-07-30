CREATE OR REPLACE FUNCTION pxp.f_invierte_numero (
  cifra varchar
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_invierte_numero
 DESCRIPCION:   Invierte la cadena recibida como parametro
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
  inver varchar;
  cont integer;
  v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
BEGIN
	v_nombre_funcion = 'pxp.f_invierte_numero';
  inver='';
 
  cont=1;
  while (cont<=char_length(cifra))loop
     inver=SUBSTRING(cifra,cont,1) || inver;
     cont=cont+1 ;
  end loop; 
  return inver;
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
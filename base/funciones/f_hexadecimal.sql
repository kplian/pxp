CREATE OR REPLACE FUNCTION pxp.f_hexadecimal (
  numero integer
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_hexadecimal
 DESCRIPCION:   Convierte un numero a hexadecimal
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
  hexa text;
  digito integer; 
  numero_sc integer;
  v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
BEGIN
	v_nombre_funcion = 'pxp.f_base64';
numero_sc=numero;
if(numero=0)THEN
hexa=0;
else
hexa='';
end if;
  WHILE (numero_sc >0) LOOP
   digito=numero_sc % 16;
   if (digito<10) then
      hexa= text(digito) || hexa;
   
   elsif (digito=10) then  
      hexa= 'A' || hexa;
    elsif (digito=11) then
      hexa= 'B' || hexa;
     elsif (digito=12) then
      hexa= 'C' || hexa;
      elsif (digito=13) then
      hexa= 'D' || hexa;
       elsif (digito=14) then
       hexa= 'E' || hexa;
        elsif (digito=15) then 
         hexa= 'F' || hexa;
     end if;
     numero_sc=numero_sc/16;
  END LOOP;
  return hexa;
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
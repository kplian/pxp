CREATE OR REPLACE FUNCTION pxp.f_rc4 (
  mensaje text,
  key text
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_rc4
 DESCRIPCION:   Devuelve rc4
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

   State	 	integer[]; 
   X			integer; 
   Y			integer; 
   Index1 		integer;
   Index2		integer;
   NMen			integer;
   aux			integer;
   v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
   
MensajeCifrado text;
    

BEGIN
	v_nombre_funcion = 'pxp.f_rc4';   
X=0; 	Y=0;  Index1=0;  Index2=0;
MensajeCifrado='';
FOR I IN 0..255 Loop
    State[I]=I;
END LOOP;

 FOR I IN 0..255 Loop
    Index2=(ascii(SUBSTRING(key,Index1+1,1)) + State[I] + Index2) % 256;
    aux=State[I];
    State[I]=State[Index2];
    State[Index2]=aux;
    Index1=(Index1+1)% char_length(key);
   
END LOOP;

FOR I IN 0..char_length(Mensaje)-1 LOOP
	X = (X + 1) % 256;
	Y = (State[X] + Y) % 256;
	aux=State[X];
   	State[X]=State[Y];
    State[Y]=aux;
	
    NMen =  ascii(SUBSTRING(mensaje,I+1,1)) # State[(State[X] + State[Y]) % 256];
	MensajeCifrado = MensajeCifrado ||  pxp.f_rellena_cero(pxp.f_hexadecimal(NMen));
END LOOP;

return MensajeCifrado;
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
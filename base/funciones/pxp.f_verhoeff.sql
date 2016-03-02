CREATE OR REPLACE FUNCTION pxp.f_verhoeff (
  cifra varchar
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_verhoeff
 DESCRIPCION:   Devuelve verhoeff de cadena
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

    
    Inv 		integer[];
    NumeroInvertido	varchar; 
    check_var			integer; 
    Mul				Integer[][]; 
    Per				Integer[][];
    v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
  
    

BEGIN
	v_nombre_funcion = 'pxp.f_verhoeff';
Mul:='{{0,1,2,3,4,5,6,7,8,9},{1,2,3,4,0,6,7,8,9,5},{2,3,4,0,1,7,8,9,5,6},{3,4,0,1,2,8,9,5,6,7},{4,0,1,2,3,9,5,6,7,8},{5,9,8,7,6,0,4,3,2,1},{6,5,9,8,7,1,0,4,3,2},{7,6,5,9,8,2,1,0,4,3},{8,7,6,5,9,3,2,1,0,4},{9,8,7,6,5,4,3,2,1,0}}';
Per:='{{0,1,2,3,4,5,6,7,8,9},{1,5,7,6,2,8,3,0,9,4},{5,8,0,3,7,9,6,1,4,2},{8,9,1,6,0,4,3,5,2,7},{9,4,5,3,1,2,6,8,7,0},{4,2,8,6,5,7,3,9,0,1},{2,7,9,3,8,0,6,4,1,5},{7,0,4,6,9,1,3,2,5,8}}';

Inv[0]=0;Inv[1]=4;Inv[2]=3;Inv[3]=2;Inv[4]=1;Inv[5]=5;Inv[6]=6;Inv[7]=7;Inv[8]=8;Inv[9]=9;
check_var=0;
NumeroInvertido = pxp.f_invierte_numero(cifra);
FOR I  IN 0..char_length(NumeroInvertido)-1 LOOP
	check_var = Mul[check_var+1][Per[((I+1) % 8)+1][(int4(SUBSTRING(NumeroInvertido,I+1,1)))+1]+1];
    --raise notice '%',SUBSTRING(NumeroInvertido,I+1,1);
    --CHECK:= Per[((I+1) % 8)+1][(int4(SUBSTRING(NumeroInvertido,I+1,1)))+1]   ;
End loop;
	return Inv[check_var];



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
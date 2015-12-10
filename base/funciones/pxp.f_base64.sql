CREATE OR REPLACE FUNCTION pxp.f_base64 (
  numero bigint
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_base64
 DESCRIPCION:   Devuelve el numero en base 64
 AUTOR: 		 (jrivera)
 FECHA:	        05-11-2014 21:58:35
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

-----------------------------------------
-- CUERPO DE LA FUNCIÓN --
-----------------------------------------

DECLARE

    diccionario varchar[];
    cociente 	bigint;
    resto		bigint;
    palabra		text; 
    aux			bigint;
    v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    

BEGIN
	v_nombre_funcion = 'pxp.f_base64';
   diccionario[0]='0';
    diccionario[1]='1'; 
    diccionario[2]='2'; 
    diccionario[3]='3'; 
    diccionario[4]='4'; 
    diccionario[5]='5'; 
    diccionario[6]='6'; 
    diccionario[7]='7';
    diccionario[8]= '8';
    diccionario[9]= '9';
diccionario[10]='A';
 diccionario[11]='B'; 
 diccionario[12]='C';
 diccionario[13]= 'D';
 diccionario[14] ='E'; 
 diccionario[15]='F';
 diccionario[16]= 'G';
 diccionario[17] ='H';
 diccionario[18] ='I'; 
 diccionario[19]='J';
diccionario[20]='K';
diccionario[21] ='L';
diccionario[22] ='M'; 
diccionario[23]='N';
diccionario[24]= 'O'; 
diccionario[25]='P';
diccionario[26] ='Q';
diccionario[27]= 'R'; 
diccionario[28]='S';
diccionario[29]= 'T';
diccionario[30]='U';
diccionario[31]= 'V'; 
diccionario[32]='W';
diccionario[33]= 'X';
diccionario[34]= 'Y';
diccionario[35]= 'Z';
diccionario[36]= 'a'; 
diccionario[37]='b';
diccionario[38]= 'c';
diccionario[39]= 'd';
diccionario[40]='e';
diccionario[41]= 'f';
diccionario[42]= 'g'; 
diccionario[43]='h';
diccionario[44]= 'i'; 
diccionario[45]='j';
diccionario[46]= 'k';
diccionario[47]= 'l';
diccionario[48]= 'm';
diccionario[49]= 'n';
diccionario[50]='o';
diccionario[51]= 'p'; 
diccionario[52]='q'; 
diccionario[53]='r'; 
diccionario[54]='s';
diccionario[55]= 't'; 
diccionario[56]='u';
diccionario[57]= 'v';
diccionario[58]= 'w';
diccionario[59]= 'x';
diccionario[60]='y';
diccionario[61]= 'z';
diccionario[62]= '+'; 
diccionario[63]='/' ;

cociente=1;
palabra='';
aux=numero;

while(cociente>0) loop
     cociente=aux/64;
     resto=aux%64;
     palabra=diccionario[resto] || palabra;
     aux=cociente;
end loop;
  
     return palabra;
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
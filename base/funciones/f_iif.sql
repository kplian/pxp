CREATE OR REPLACE FUNCTION pxp.f_iif (
  condicion boolean,
  op1 character varying,
  op2 character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_iif
 DESCRIPCION:   Si la condicion es verdadera devuelve laop1 sino devuelve op2
 AUTOR: 	    KPLIAN (jrr)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
BEGIN
if(condicion) then
return op1;
else
return op2;
end if;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_intermediario_ime (OID = 304235) : 
--

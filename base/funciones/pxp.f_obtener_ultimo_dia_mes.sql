CREATE OR REPLACE FUNCTION pxp.f_obtener_ultimo_dia_mes (
  par_mes numeric,
  par_anio numeric
)
RETURNS date
AS 
$body$
/**************************************************************************
 documento: 	pxp.f_obtener_ultimo_dia_mes
 DESCRIPCION:   Funcion que obtiene el ultimo dia de un mes y anio especifico
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************/

DECLARE

g_mes      integer;
g_fecha    date;

BEGIN
    g_mes:=par_mes+1;
    if (g_mes<10)then
        g_fecha:=(select cast(par_anio || '-0' || g_mes || '-01' as date)-1);
    elsif(g_mes=13)THEN
        g_fecha:=(select cast(par_anio || '-12-31' as date));
    ELSE
        g_fecha:=(select cast(par_anio || '-' || g_mes || '-01' as date)-1);
    end if;
    return g_fecha;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_obtiene_clave_valor (OID = 304244) : 
--

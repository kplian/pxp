CREATE OR REPLACE FUNCTION pxp.f_obtener_primer_dia_mes (
  par_mes numeric,
  par_anio numeric
)
RETURNS date
AS 
$body$
/**************************************************************************
 documento: 	pxp.f_obtener_primer_dia_mes
 DESCRIPCION:   Funcion que obtiene el primer dia de un mes y anio especifico
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************/
DECLARE

g_mes      numeric;
g_fecha    date;

BEGIN
    g_mes:=par_mes;
    if (g_mes<10)then
        g_fecha:=(select cast(par_anio || '-0' || g_mes || '-01' as date));

    ELSE
        g_fecha:=(select cast(par_anio || '-' || g_mes || '-01' as date));
    end if;
    raise notice '%',g_fecha;
    return g_fecha;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_obtener_ultimo_dia_mes (OID = 304243) : 
--

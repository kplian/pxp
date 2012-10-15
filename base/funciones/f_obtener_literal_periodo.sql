CREATE OR REPLACE FUNCTION pxp.f_obtener_literal_periodo (
  par_mes integer,
  par_nro integer
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 documento: 	pxp.f_obtener_literal_periodo
 DESCRIPCION:   Funcion que obtiene el literal de un periodo (mes)
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************/
DECLARE
  g_mes_lite varchar;
BEGIN
    IF par_mes = 1 THEN
        g_mes_lite := 'Enero';
    ELSIF par_mes = 2 THEN
    	g_mes_lite := 'Febrero';
    ELSIF par_mes = 3 THEN
    	g_mes_lite := 'Marzo';
    ELSIF par_mes = 4 THEN
    	g_mes_lite := 'Abril';
    ELSIF par_mes = 5 THEN
    	g_mes_lite := 'Mayo';
    ELSIF par_mes = 6 THEN
    	g_mes_lite := 'Junio';
	ELSIF par_mes = 7 THEN
    	g_mes_lite := 'Julio';
	ELSIF par_mes = 8 THEN
    	g_mes_lite := 'Agosto';
    ELSIF par_mes = 9 THEN
    	g_mes_lite := 'Septiembre';
    ELSIF par_mes = 10 THEN
    	g_mes_lite := 'Octubre';
    ELSIF par_mes = 11 THEN
    	g_mes_lite := 'Noviembre';
   ELSIF par_mes = 12 THEN
    	g_mes_lite := 'Diciembre';
   END IF;

   IF par_nro > 0 THEN
        g_mes_lite := substr(g_mes_lite, 1, par_nro);
   END IF;

   return g_mes_lite;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_obtener_primer_dia_mes (OID = 304242) : 
--

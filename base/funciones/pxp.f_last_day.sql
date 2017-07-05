CREATE OR REPLACE FUNCTION pxp.f_last_day(DATE)
RETURNS DATE AS
$$
/*
Autor: RCM
Fecha: 14-06-2017
Descripcion: Devuelve la fecha con el último día del mes en función de la fecha recibida
*/
  SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::DATE;
$$ LANGUAGE 'sql' IMMUTABLE STRICT;
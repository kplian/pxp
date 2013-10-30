CREATE OR REPLACE FUNCTION pxp.f_get_fecha_ult_pri (
  p_mes integer,
  p_gestion integer,
  p_tipo varchar,
  p_separador varchar = '/'::character varying
)
RETURNS date AS
$body$
/*
Autor: RCM
Fecha: 21-04-2013
Descripcion: Devuelve la fecha del primer dia o del ultimo dia en funcion del mes y anio que reciba
*/
DECLARE

  v_fecha date;
    v_dia integer;

BEGIN

  if p_tipo = 'ultimo' then
      if p_mes in (1,3,5,7,8,10,12) then
          v_dia = 31;
        elsif p_mes in (4,6,9,11) then
          v_dia = 30;
        elsif p_mes in (4,6,9,11) then
          v_dia = 28;
        else
          raise exception 'Mes no valido';
        end if;
    
    else
      v_dia = 1;
    end if;
    
    v_fecha = (v_dia::varchar||p_separador||p_mes::varchar||p_separador||p_gestion::varchar)::varchar;
  
    return v_fecha;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
CREATE OR REPLACE FUNCTION pxp.f_ultimo_dia_habil_mes (
  p_fecha date
)
RETURNS date AS
$body$
DECLARE
	v_fecha date;

BEGIN
   
    if (select to_char(p_fecha,'DY') in ('SAT','SÁB'))then
        v_fecha:=p_fecha-1;
    elsif(select to_char(p_fecha,'DY') in ('SUN','DOM'))THEN
        v_fecha:=p_fecha-2;
    ELSE
        v_fecha:=p_fecha;
    end if;
    return v_fecha;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
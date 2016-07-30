CREATE OR REPLACE FUNCTION param.f_get_id_lugar_pais (
  p_id_lugar integer
)
RETURNS integer AS
$body$
DECLARE
  v_tipo	varchar;
  v_id_lugar_fk integer;
BEGIN
	select l.id_lugar_fk, l.tipo into v_id_lugar_fk ,v_tipo
    from param.tlugar l 
    where l.id_lugar = p_id_lugar;
    
    if (v_tipo = 'pais' or v_id_lugar_fk is null) then
          return p_id_lugar;
    else
          return param.f_get_id_lugar_pais(v_id_lugar_fk);
    end if;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
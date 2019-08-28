CREATE OR REPLACE FUNCTION param.f_get_id_lugar_tipo (
  p_id_lugar integer,
  p_tipo varchar = 'pais'::character varying
)
RETURNS integer AS
$body$
DECLARE
  v_tipo	varchar;
  v_id_lugar_fk integer;
  v_id_lugar	integer;
BEGIN


	select l.id_lugar_fk, l.tipo, l.id_lugar into v_id_lugar_fk ,v_tipo, v_id_lugar
    from param.tlugar l 
    where l.id_lugar = p_id_lugar;


    
    if (v_tipo = p_tipo or v_id_lugar_fk is null) then
          return v_id_lugar;
    else
          return param.f_get_id_lugar_tipo(v_id_lugar_fk, p_tipo);
    end if;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
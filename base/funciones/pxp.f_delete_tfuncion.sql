CREATE OR REPLACE FUNCTION pxp.f_delete_tfuncion (
  par_nombre varchar,
  par_subsistema varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
BEGIN
	select id_subsistema into v_id_subsistema
    from segu.tsubsistema s
    where s.codigo = par_subsistema;
    ALTER TABLE segu.tfuncion DISABLE TRIGGER USER; 
    update segu.tfuncion set estado_reg = 'inactivo',modificado = 1 
    where nombre = par_nombre and  id_subsistema = v_id_subsistema and estado_reg = 'activo';
    ALTER TABLE segu.tfuncion ENABLE TRIGGER USER; 
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
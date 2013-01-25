CREATE OR REPLACE FUNCTION pxp.f_delete_trol (
  par_rol varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
   
BEGIN
	
    select id_subsistema into v_id_subsistema
    from segu.tsubsistema s
    where s.codigo = par_subsistema;
    
    update segu.trol set estado_reg = 'inactivo'
    where estado_reg = 'activo' and rol = par_rol;

    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
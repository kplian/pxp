CREATE OR REPLACE FUNCTION wf.f_insert_testructura_estado (
  par_nombre_tipo_estado_padre varchar,
  par_nombre_tipo_estado_hijo varchar,
  par_prioridad integer,
  par_regla varchar,
  par_estado_reg varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_tipo_estado_padre	integer;
    v_id_tipo_estado_hijo	integer;
BEGIN
  select id_tipo_estado into v_id_tipo_estado_padre
    from wf.ttipo_estado te
    where te.nombre_estado = par_nombre_tipo_estado_padre;
    
    select id_tipo_estado into v_id_tipo_estado_hijo
    from wf.ttipo_estado te
    where te.nombre_estado = par_nombre_tipo_estado_hijo;
    
    insert into wf.testructura_estado (id_tipo_estado_padre, id_tipo_estado_hijo, prioridad, regla, estado_reg, id_usuario_reg)
    values (v_id_tipo_estado_padre, v_id_tipo_estado_hijo, par_prioridad, par_regla, par_estado_reg,1);
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
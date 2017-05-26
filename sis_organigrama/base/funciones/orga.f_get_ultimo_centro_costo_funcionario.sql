CREATE OR REPLACE FUNCTION orga.f_get_ultimo_centro_costo_funcionario (
  p_id_funcionario integer,
  p_id_periodo integer,
  out po_id_centro_costo integer,
  out po_id_cargo integer,
  out po_id_ot integer
)
RETURNS record AS
$body$
DECLARE
  	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_consulta				text;
    v_id_uo					integer;
    v_planilla			varchar;
    v_id_uo_hijo		integer;
    v_periodo			record;
    v_id_centro_costo	integer;
BEGIN
  	v_nombre_funcion = 'orga.f_get_ultimo_centro_costo_funcionario';
    select per.* into v_periodo
    from param.tperiodo per
    where id_periodo = p_id_periodo;
    

    select car.id_cargo,carpre.id_centro_costo,carpre.id_ot into po_id_cargo,po_id_centro_costo,po_id_ot
    from orga.tuo_funcionario uofun
    inner join orga.tcargo car
        on car.id_cargo = uofun.id_cargo
    inner join orga.tcargo_presupuesto carpre
        on carpre.id_cargo = car.id_cargo and carpre.id_gestion = v_periodo.id_gestion
    where carpre.estado_reg = 'activo' and uofun.estado_reg = 'activo' and
        uofun.id_funcionario = p_id_funcionario and uofun.fecha_asignacion <= v_periodo.fecha_fin and
        (uofun.fecha_finalizacion >= v_periodo.fecha_ini or uofun.fecha_finalizacion is null)
        and carpre.fecha_ini<=v_periodo.fecha_fin
    order by uofun.fecha_asignacion,carpre.fecha_ini desc limit 1;   
                       
               
EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
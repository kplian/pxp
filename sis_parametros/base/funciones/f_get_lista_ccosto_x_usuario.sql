CREATE OR REPLACE FUNCTION param.f_get_lista_ccosto_x_usuario (
  p_id_usuario integer,
  p_codigo_subsistema varchar
)
RETURNS text AS
$body$
DECLARE
  v_depto_ep 					text;
  v_usuario_ep 					text;
  v_resp                      	varchar;
  v_nombre_funcion            	text;
  v_mensaje_error             	text;
  
BEGIN
	v_nombre_funcion:='param.f_get_lista_ccosto_x_usuario';
    --raise exception '%,%',p_codigo_subsistema,p_id_usuario;
	--Obtener deptos por usuarios
    if (p_codigo_subsistema is not null)then
    	select pxp.list(dep.id_ep::text)
    	into v_depto_ep
    	from param.tdepto d
    	inner join param.tdepto_usuario du on du.id_depto = d.id_depto and du.estado_reg = 'activo'
        inner join param.tdepto_ep dep on dep.id_depto = d.id_depto and dep.estado_reg = 'activo'
    	inner join segu.tsubsistema s on s.id_subsistema = d.id_subsistema 
    	where du.id_usuario = p_id_usuario  and s.codigo = p_codigo_subsistema and d.estado_reg = 'activo';
    end if;
    
    
    --Obtener deptos por eps
    select pxp.list(distinct ge.id_ep::text)
    into v_usuario_ep
    from segu.tusuario u
    inner join segu.tusuario_grupo_ep uge on u.id_usuario = uge.id_usuario and uge.estado_reg = 'activo' 
    inner join param.tgrupo_ep ge on uge.id_grupo = ge.id_grupo and ge.estado_reg = 'activo'
    where uge.id_usuario = p_id_usuario;
    
    if (v_depto_ep is not null) then
    	v_depto_ep = v_depto_ep || ',';
    end if;
   -- raise exception '%',v_depto_ep;
    return COALESCE(v_depto_ep, '') || COALESCE(v_usuario_ep, '-1'); 
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
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
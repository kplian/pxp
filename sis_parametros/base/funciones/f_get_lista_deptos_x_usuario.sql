CREATE OR REPLACE FUNCTION param.f_get_lista_deptos_x_usuario (
  p_id_usuario integer,
  p_codigo_subsistema varchar
)
RETURNS text AS
$body$
DECLARE
  v_depto_usuario 	text;
  v_depto_ep 		text;
  v_resp                      varchar;
  v_nombre_funcion            text;
  v_mensaje_error             text;
  
BEGIN
	v_nombre_funcion:='param.f_get_lista_deptos_x_usuario';
	--Obtener deptos por usuarios
    select pxp.list(d.id_depto::text)
    into v_depto_usuario
    from param.tdepto d
    inner join param.tdepto_usuario du on du.id_depto = d.id_depto
    inner join segu.tsubsistema s on s.id_subsistema = d.id_subsistema
    where du.id_usuario = p_id_usuario and du.estado_reg = 'activo' and s.codigo = p_codigo_subsistema;
    
    
    --Obtener deptos por eps
    select pxp.list(distinct d.id_depto::text)
    into v_depto_ep
    from param.tdepto d
    inner join param.tdepto_ep dep on dep.id_depto = d.id_depto and dep.estado_reg = 'activo'
    inner join param.tgrupo_ep ge on dep.id_ep = ge.id_ep and ge.estado_reg = 'activo'
    inner join segu.tusuario_grupo_ep uge on ge.id_grupo = uge.id_grupo and uge.estado_reg = 'activo' 
    inner join segu.tsubsistema s on s.id_subsistema = d.id_subsistema 
    where uge.id_usuario = p_id_usuario and s.codigo = p_codigo_subsistema;
    if (v_depto_usuario is not null) then
    	v_depto_usuario = v_depto_usuario || ',';
    end if;
    
    return COALESCE(v_depto_usuario, '') || COALESCE(v_depto_ep, '-1'); 
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
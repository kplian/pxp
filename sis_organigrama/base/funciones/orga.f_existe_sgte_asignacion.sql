CREATE OR REPLACE FUNCTION orga.f_existe_sgte_asignacion (
  p_fecha_fin date,
  p_id_funcionario integer
)
RETURNS integer AS
$body$
DECLARE
	v_resp		            	varchar;
  	v_nombre_funcion        	text; 
BEGIN  
	v_nombre_funcion = 'orga.f_existe_sgte_asignacion';
    if exists (select 1
              from orga.tuo_funcionario uofun 
              where uofun.id_funcionario = p_id_funcionario and uofun.fecha_asignacion = p_fecha_fin + interval '1 day'
                  and uofun.estado_reg = 'activo' and uofun.tipo = 'oficial')then
      return 1;
    else
      return 0;
    end if;  
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
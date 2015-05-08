CREATE OR REPLACE FUNCTION orga.f_get_uos_x_planilla (
  p_id_uo integer
)
RETURNS varchar AS
$body$
DECLARE
  	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
BEGIN
	v_nombre_funcion = 'orga.f_get_uos_x_planilla';
	WITH RECURSIVE recursetree(id_hijo,id_padre) AS (
              SELECT es.id_uo_hijo ,es.id_uo_padre
              FROM orga.testructura_uo es
              inner join orga.tuo uo on es.id_uo_hijo = uo.id_uo
              WHERE uo.planilla = 'no' and es.id_uo_padre = p_id_uo
              
              UNION
              
              SELECT es.id_uo_hijo ,es.id_uo_padre
              FROM orga.testructura_uo es
              inner join recursetree rt on rt.id_hijo = es.id_uo_padre
              inner join orga.tuo uo on es.id_uo_hijo = uo.id_uo
              where uo.planilla = 'no'
                             
          )
    SELECT pxp.list(id_hijo::text)::varchar into v_resp 
    FROM recursetree;
    return v_resp;
  
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
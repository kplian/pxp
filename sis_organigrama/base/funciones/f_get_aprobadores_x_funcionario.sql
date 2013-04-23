CREATE OR REPLACE FUNCTION orga.f_get_aprobadores_x_funcionario (
  par_fecha date,
  par_id_funcionario integer
)
RETURNS SETOF record AS
$body$
DECLARE
  	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_consulta				text;
    v_id_funcionario		integer;
BEGIN
  	v_nombre_funcion = 'orga.f_get_aprobadores_x_funcionario';
    
    
    
        --Obtener todos los empleados de la asignacion
        v_consulta := '
            WITH RECURSIVE path(id_funcionario,id_uo,presupuesta) AS (
                SELECT uofun.id_funcionario,uo.id_uo,uo.presupuesta
                from orga.tuo_funcionario uofun
                inner join orga.tuo uo
                	on uo.id_uo = uofun.id_uo
                where uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                and uofun.estado_reg = ''activo'' and uofun.id_funcionario = ' || par_id_funcionario || '
            UNION
                SELECT uofun.id_funcionario,euo.id_uo_padre,uo.presupuesta
                from orga.testructura_uo euo
                inner join orga.tuo uo
                	on uo.id_uo = euo.id_uo_padre
                inner join path hijo
                    on hijo.id_uo = euo.id_uo_hijo
                left join orga.tuo_funcionario uofun
                    on uo.id_uo = uofun.id_uo and uofun.estado_reg = ''activo'' and
                    	uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                                
            )
            SELECT id_funcionario FROM path where id_funcionario is not null and presupuesta = ''si'' and id_funcionario != ' || par_id_funcionario;                
             
        return query execute (v_consulta);
    
                     
               
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
COST 100 ROWS 1000;
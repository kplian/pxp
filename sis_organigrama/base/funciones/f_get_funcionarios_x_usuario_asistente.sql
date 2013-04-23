CREATE OR REPLACE FUNCTION orga.f_get_funcionarios_x_usuario_asistente (
  par_fecha date,
  par_id_usuario integer
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
  	v_nombre_funcion = 'orga.f_get_funcionarios_x_usuario_asistente';
    --obtener el id_funcionario del empleado actual
    select id_funcionario
    into v_id_funcionario
    from segu.tusuario u
    inner join orga.tfuncionario f
        on f.id_persona = u.id_persona    
    where u.id_usuario = par_id_usuario;
    
    if (exists (select 1
    			from segu.tusuario_rol ur
    			inner join segu.trol r on ur.id_rol = r.id_rol and ur.estado_reg = 'activo'
                where r.id_rol = 1 and ur.id_usuario = par_id_usuario))then
                
    		return query execute ('select id_funcionario from orga.vfuncionario');            
	end if;
    
    if (v_id_funcionario is not null) then
        --Obtener todos los empleados de la asignacion
        v_consulta := '
            WITH RECURSIVE path(id_funcionario,id_uo) AS (
                SELECT uofun.id_funcionario,asi.id_uo
                from param.tasistente asi
                left join orga.tuo_funcionario uofun
                    on asi.id_uo = uofun.id_uo and uofun.estado_reg = ''activo'' and
                    	uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                where asi.estado_reg = ''activo'' and asi.id_funcionario = ' || v_id_funcionario || '
            UNION
                SELECT uofun.id_funcionario,euo.id_uo_hijo
                from orga.testructura_uo euo
                inner join orga.tuo uo
                	on uo.id_uo = euo.id_uo_hijo and uo.presupuesta = ''no''
                inner join path padre
                    on padre.id_uo = euo.id_uo_padre
                left join orga.tuo_funcionario uofun
                    on euo.id_uo_hijo = uofun.id_uo and uofun.estado_reg = ''activo'' and
                    	uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                                
            )
            SELECT id_funcionario FROM path where id_funcionario is not null';                
             raise notice '%',v_consulta;        
        v_consulta := v_consulta || ' UNION select ' || v_id_funcionario;
        return query execute (v_consulta);
     end if;
     return;
                     
               
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
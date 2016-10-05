--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_dashboard_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_dashboard_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdashboard'
 AUTOR: 		 (admin)
 FECHA:	        10-09-2016 11:29:58
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_dashboard_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DAS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:29:58
	***********************************/

	if(p_transaccion='PM_DAS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						das.id_dashboard,
						das.estado_reg,
						das.id_usuario,
						das.nombre,
						das.usuario_ai,
						das.fecha_reg,
						das.id_usuario_reg,
						das.id_usuario_ai,
						das.id_usuario_mod,
						das.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tdashboard das
						inner join segu.tusuario usu1 on usu1.id_usuario = das.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = das.id_usuario_mod
				        where  das.id_usuario = '||p_id_usuario::varchar ||'
                        order by id_dashboard asc';
			
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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
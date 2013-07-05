--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_grupo_ep_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_grupo_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tgrupo_ep'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 14:49:40
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

	v_nombre_funcion = 'param.ft_grupo_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GQP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:49:40
	***********************************/

	if(p_transaccion='PM_GQP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						gqp.id_grupo_ep,
						gqp.estado_reg,
						gqp.id_grupo,
						gqp.id_ep,
						gqp.fecha_reg,
						gqp.id_usuario_reg,
						gqp.fecha_mod,
						gqp.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        e.ep,
                        uo.id_uo,
                        ''(''||uo.codigo||'')-''||uo.nombre_unidad as desc_uo
						from param.tgrupo_ep gqp
                        left join orga.tuo uo on uo.id_uo = gqp.id_uo
						inner join segu.tusuario usu1 on usu1.id_usuario = gqp.id_usuario_reg
                        left join param.vep e on e.id_ep = gqp.id_ep
						left join segu.tusuario usu2 on usu2.id_usuario = gqp.id_usuario_mod
						  where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GQP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:49:40
	***********************************/

	elsif(p_transaccion='PM_GQP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_grupo_ep)
					    from param.tgrupo_ep gqp
                        left join orga.tuo uo on uo.id_uo = gqp.id_uo
						inner join segu.tusuario usu1 on usu1.id_usuario = gqp.id_usuario_reg
                        left join param.vep e on e.id_ep = gqp.id_ep
						left join segu.tusuario usu2 on usu2.id_usuario = gqp.id_usuario_mod
						where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

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
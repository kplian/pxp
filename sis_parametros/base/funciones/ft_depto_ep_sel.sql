CREATE OR REPLACE FUNCTION "param"."ft_depto_ep_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_ep'
 AUTOR: 		 (admin)
 FECHA:	        29-04-2013 20:34:21
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

	v_nombre_funcion = 'param.ft_depto_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEEP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		29-04-2013 20:34:21
	***********************************/

	if(p_transaccion='PM_DEEP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						deep.id_depto_ep,
						deep.estado_reg,
						deep.id_ep,
						deep.id_depto,
						deep.fecha_reg,
						deep.id_usuario_reg,
						deep.fecha_mod,
						deep.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						ep.ep	
						from param.tdepto_ep deep
						inner join param.vep as ep on ep.id_ep = deep.id_ep
						inner join segu.tusuario usu1 on usu1.id_usuario = deep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = deep.id_usuario_mod
				        where  deep.estado_reg = ''activo'' and  deep.id_depto =  '|| v_parametros.id_depto || ' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEEP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
vep 	#FECHA:		29-04-2013 20:34:21
	***********************************/

	elsif(p_transaccion='PM_DEEP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_depto_ep)
					    from param.tdepto_ep deep
					    inner join param.vep as ep on ep.id_ep = deep.id_ep
					    inner join segu.tusuario usu1 on usu1.id_usuario = deep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = deep.id_usuario_mod
					    where  deep.estado_reg = ''activo'' and  deep.id_depto =  '|| v_parametros.id_depto || ' and ';
			
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_depto_ep_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

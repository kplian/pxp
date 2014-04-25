CREATE OR REPLACE FUNCTION "segu"."ft_video_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_video_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tvideo'
 AUTOR: 		 (admin)
 FECHA:	        23-04-2014 13:14:54
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

	v_nombre_funcion = 'segu.ft_video_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_TUTO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		23-04-2014 13:14:54
	***********************************/

	if(p_transaccion='SG_TUTO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tuto.id_video,
						tuto.id_subsistema,
						tuto.estado_reg,
						tuto.url,
						tuto.descripcion,
						tuto.titulo,
						tuto.id_usuario_reg,
						tuto.fecha_reg,
						tuto.id_usuario_mod,
						tuto.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.tvideo tuto
						inner join segu.tusuario usu1 on usu1.id_usuario = tuto.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuto.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SG_TUTO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		23-04-2014 13:14:54
	***********************************/

	elsif(p_transaccion='SG_TUTO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_video)
					    from segu.tvideo tuto
					    inner join segu.tusuario usu1 on usu1.id_usuario = tuto.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tuto.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "segu"."ft_video_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

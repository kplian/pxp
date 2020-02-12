CREATE OR REPLACE FUNCTION "segu"."ft_programador_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_programador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tprogramador'
 AUTOR: 		 (rarteaga)
 FECHA:	        08-01-2020 19:46:59
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #102		08-01-2020 19:46:59		RAC					Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tprogramador'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'segu.ft_programador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_PRG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rarteaga	
 	#FECHA:		08-01-2020 19:46:59
	***********************************/

	if(p_transaccion='SG_PRG_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						prg.id_programador,
						prg.usuario_ldap,
						prg.alias_git,
						prg.alias_codigo_1,
						prg.nombre_completo,
						prg.organizacion,
						prg.correo_personal,
						prg.fecha_inicio,
						prg.estado_reg,
						prg.alias_codigo_2,
						prg.obs_dba,
						prg.correo,
						prg.fecha_fin,
						prg.id_usuario_ai,
						prg.fecha_reg,
						prg.usuario_ai,
						prg.id_usuario_reg,
						prg.id_usuario_mod,
						prg.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.tprogramador prg
						inner join segu.tusuario usu1 on usu1.id_usuario = prg.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prg.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SG_PRG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rarteaga	
 	#FECHA:		08-01-2020 19:46:59
	***********************************/

	elsif(p_transaccion='SG_PRG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_programador)
					    from segu.tprogramador prg
					    inner join segu.tusuario usu1 on usu1.id_usuario = prg.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = prg.id_usuario_mod
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
ALTER FUNCTION "segu"."ft_programador_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

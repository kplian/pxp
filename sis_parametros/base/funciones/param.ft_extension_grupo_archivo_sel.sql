CREATE OR REPLACE FUNCTION "param"."ft_extension_grupo_archivo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_extension_grupo_archivo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.textension_grupo_archivo'
 AUTOR: 		 (admin)
 FECHA:	        23-12-2013 20:33:46
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

	v_nombre_funcion = 'param.ft_extension_grupo_archivo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_EXT_G_AR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:33:46
	***********************************/

	if(p_transaccion='PM_EXT_G_AR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ext_g_ar.id_extension_grupo_archivo,
						ext_g_ar.id_extension,
						ext_g_ar.id_grupo_archivo,
						ext_g_ar.estado_reg,
						ext_g_ar.fecha_reg,
						ext_g_ar.id_usuario_reg,
						ext_g_ar.fecha_mod,
						ext_g_ar.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						ext.extension as desc_extension,
						grupo_ar.nombre as desc_grupo_archivo 	
						from param.textension_grupo_archivo ext_g_ar
						inner join segu.tusuario usu1 on usu1.id_usuario = ext_g_ar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ext_g_ar.id_usuario_mod
						inner join param.textension ext on ext.id_extension = ext_g_ar.id_extension
						inner join param.tgrupo_archivo grupo_ar on grupo_ar.id_grupo_archivo = ext_g_ar.id_grupo_archivo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_EXT_G_AR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:33:46
	***********************************/

	elsif(p_transaccion='PM_EXT_G_AR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_extension_grupo_archivo)
					    from param.textension_grupo_archivo ext_g_ar
					    inner join segu.tusuario usu1 on usu1.id_usuario = ext_g_ar.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ext_g_ar.id_usuario_mod
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
ALTER FUNCTION "param"."ft_extension_grupo_archivo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

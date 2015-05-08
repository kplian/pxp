CREATE OR REPLACE FUNCTION "segu"."ft_tabla_migrar_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_tabla_migrar_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.ttabla_migrar'
 AUTOR: 		 (admin)
 FECHA:	        16-01-2014 18:06:08
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

	v_nombre_funcion = 'segu.ft_tabla_migrar_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_TBLMIG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		16-01-2014 18:06:08
	***********************************/

	if(p_transaccion='SG_TBLMIG_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tblmig.id_tabla_migrar,
						tblmig.nombre_tabla,
						tblmig.nombre_funcion,
						tblmig.estado_reg,
						tblmig.id_usuario_reg,
						tblmig.fecha_reg,
						tblmig.fecha_mod,
						tblmig.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.ttabla_migrar tblmig
						inner join segu.tusuario usu1 on usu1.id_usuario = tblmig.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tblmig.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SG_TBLMIG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		16-01-2014 18:06:08
	***********************************/

	elsif(p_transaccion='SG_TBLMIG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tabla_migrar)
					    from segu.ttabla_migrar tblmig
					    inner join segu.tusuario usu1 on usu1.id_usuario = tblmig.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tblmig.id_usuario_mod
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
ALTER FUNCTION "segu"."ft_tabla_migrar_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

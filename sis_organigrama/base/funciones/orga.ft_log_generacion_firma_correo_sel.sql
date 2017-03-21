CREATE OR REPLACE FUNCTION "orga"."ft_log_generacion_firma_correo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_log_generacion_firma_correo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tlog_generacion_firma_correo'
 AUTOR: 		 (admin)
 FECHA:	        06-03-2017 21:21:37
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

	v_nombre_funcion = 'orga.ft_log_generacion_firma_correo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_LOGFIR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		06-03-2017 21:21:37
	***********************************/

	if(p_transaccion='OR_LOGFIR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						logfir.id_log_generacion_firma_correo,
						logfir.telefono_interno,
						logfir.id_funcionario,
						logfir.telefono_personal,
						logfir.telefono_corporativo,
						logfir.estado_reg,
						logfir.direccion,
						logfir.cargo,
						logfir.cargo_ingles,
						logfir.nombre,
						logfir.fecha_reg,
						logfir.usuario_ai,
						logfir.id_usuario_reg,
						logfir.id_usuario_ai,
						logfir.fecha_mod,
						logfir.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from orga.tlog_generacion_firma_correo logfir
						inner join segu.tusuario usu1 on usu1.id_usuario = logfir.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = logfir.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_LOGFIR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		06-03-2017 21:21:37
	***********************************/

	elsif(p_transaccion='OR_LOGFIR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_log_generacion_firma_correo)
					    from orga.tlog_generacion_firma_correo logfir
					    inner join segu.tusuario usu1 on usu1.id_usuario = logfir.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = logfir.id_usuario_mod
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
ALTER FUNCTION "orga"."ft_log_generacion_firma_correo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

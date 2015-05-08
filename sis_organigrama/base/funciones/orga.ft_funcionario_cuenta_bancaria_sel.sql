CREATE OR REPLACE FUNCTION "orga"."ft_funcionario_cuenta_bancaria_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_funcionario_cuenta_bancaria_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tfuncionario_cuenta_bancaria'
 AUTOR: 		 (admin)
 FECHA:	        20-01-2014 14:16:37
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

	v_nombre_funcion = 'orga.ft_funcionario_cuenta_bancaria_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_FUNCUE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-01-2014 14:16:37
	***********************************/

	if(p_transaccion='OR_FUNCUE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						funcue.id_funcionario_cuenta_bancaria,
						funcue.id_funcionario,
						funcue.id_institucion,
						funcue.nro_cuenta,
						funcue.fecha_fin,
						funcue.fecha_ini,
						funcue.estado_reg,
						funcue.fecha_reg,
						funcue.id_usuario_reg,
						funcue.fecha_mod,
						funcue.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						instit.nombre
						from orga.tfuncionario_cuenta_bancaria funcue
						inner join segu.tusuario usu1 on usu1.id_usuario = funcue.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = funcue.id_usuario_mod
						inner join param.tinstitucion instit on instit.id_institucion = funcue.id_institucion
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_FUNCUE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-01-2014 14:16:37
	***********************************/

	elsif(p_transaccion='OR_FUNCUE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_funcionario_cuenta_bancaria)
					    from orga.tfuncionario_cuenta_bancaria funcue
					    inner join segu.tusuario usu1 on usu1.id_usuario = funcue.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = funcue.id_usuario_mod
						inner join param.tinstitucion instit on instit.id_institucion = funcue.id_institucion
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
ALTER FUNCTION "orga"."ft_funcionario_cuenta_bancaria_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

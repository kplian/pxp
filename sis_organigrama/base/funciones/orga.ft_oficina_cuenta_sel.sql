CREATE OR REPLACE FUNCTION "orga"."ft_oficina_cuenta_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_oficina_cuenta_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.toficina_cuenta'
 AUTOR: 		 (jrivera)
 FECHA:	        31-07-2014 22:57:29
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

	v_nombre_funcion = 'orga.ft_oficina_cuenta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_OFCU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		jrivera	
 	#FECHA:		31-07-2014 22:57:29
	***********************************/

	if(p_transaccion='OR_OFCU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ofcu.id_oficina_cuenta,
						ofcu.id_oficina,
						ofcu.descripcion,
						ofcu.estado_reg,
						ofcu.nro_medidor,
						ofcu.nro_cuenta,
						ofcu.tiene_medidor,
						ofcu.nombre_cuenta,
						ofcu.usuario_ai,
						ofcu.fecha_reg,
						ofcu.id_usuario_reg,
						ofcu.id_usuario_ai,
						ofcu.fecha_mod,
						ofcu.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						of.nombre,
						lug.nombre	
						from orga.toficina_cuenta ofcu
						inner join segu.tusuario usu1 on usu1.id_usuario = ofcu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ofcu.id_usuario_mod
						inner join orga.toficina of on of.id_oficina = ofcu.id_oficina
						inner join param.tlugar lug on lug.id_lugar = of.id_lugar
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_OFCU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		jrivera	
 	#FECHA:		31-07-2014 22:57:29
	***********************************/

	elsif(p_transaccion='OR_OFCU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_oficina_cuenta)
					    from orga.toficina_cuenta ofcu
					    inner join segu.tusuario usu1 on usu1.id_usuario = ofcu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ofcu.id_usuario_mod
						inner join orga.toficina of on of.id_oficina = ofcu.id_oficina
						inner join param.tlugar lug on lug.id_lugar = of.id_lugar
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
ALTER FUNCTION "orga"."ft_oficina_cuenta_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "tesor"."f_concepto_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Tesoreria
 FUNCION: 		tesor.f_concepto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'tesor.tconcepto'
 AUTOR: 		 (rac)
 FECHA:	        16-08-2012 01:18:04
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

	v_nombre_funcion = 'tesor.f_concepto_sel';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TSR_CON_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 01:18:04
	***********************************/

	if(p_transaccion='TSR_CON_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						con.id_concepto,
						con.estado_reg,
						con.nombre,
						con.descripcion,
						con.fecha_reg,
						con.id_usuario_reg,
						con.id_usuario_mod,
						con.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from tesor.tconcepto con
						inner join segu.tusuario usu1 on usu1.id_usuario = con.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = con.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'TSR_CON_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 01:18:04
	***********************************/

	elsif(p_transaccion='TSR_CON_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_concepto)
					    from tesor.tconcepto con
					    inner join segu.tusuario usu1 on usu1.id_usuario = con.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = con.id_usuario_mod
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
			v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "tesor"."f_concepto_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

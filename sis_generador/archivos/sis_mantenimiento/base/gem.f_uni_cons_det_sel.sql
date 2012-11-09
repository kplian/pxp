CREATE OR REPLACE FUNCTION "gem"."f_uni_cons_det_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_uni_cons_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'gem.tuni_cons_det'
 AUTOR: 		 (admin)
 FECHA:	        08-11-2012 21:12:55
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

	v_nombre_funcion = 'gem.f_uni_cons_det_sel';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_UCDET_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 21:12:55
	***********************************/

	if(p_transaccion='GM_UCDET_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ucdet.id_uni_cons_det,
						ucdet.id_unidad_medida,
						ucdet.id_uni_cons,
						ucdet.codigo,
						ucdet.nombre,
						ucdet.descripcion,
						ucdet.valor,
						ucdet.estado_reg,
						ucdet.fecha_reg,
						ucdet.id_usuario_reg,
						ucdet.id_usuario_mod,
						ucdet.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from gem.tuni_cons_det ucdet
						inner join segu.tusuario usu1 on usu1.id_usuario = ucdet.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ucdet.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'GM_UCDET_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 21:12:55
	***********************************/

	elsif(p_transaccion='GM_UCDET_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_uni_cons_det)
					    from gem.tuni_cons_det ucdet
					    inner join segu.tusuario usu1 on usu1.id_usuario = ucdet.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ucdet.id_usuario_mod
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
ALTER FUNCTION "gem"."f_uni_cons_det_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

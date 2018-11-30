CREATE OR REPLACE FUNCTION param.ft_buzon_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_buzon_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tbuzon'
 AUTOR: 		 (eddy.gutierrez)
 FECHA:	        25-07-2018 23:43:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				25-07-2018 23:43:03								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tbuzon'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_buzon_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_BUZ_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		eddy.gutierrez	
 	#FECHA:		25-07-2018 23:43:03
	***********************************/

	if(p_transaccion='PM_BUZ_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						buz.id_buzon,
						buz.fecha,
						buz.estado_reg,
						buz.sugerencia,
						buz.id_usuario_ai,
						buz.usuario_ai,
						buz.fecha_reg,
						buz.id_usuario_reg,
						buz.id_usuario_mod,
						buz.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tbuzon buz
						inner join segu.tusuario usu1 on usu1.id_usuario = buz.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = buz.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_BUZ_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		eddy.gutierrez	
 	#FECHA:		25-07-2018 23:43:03
	***********************************/

	elsif(p_transaccion='PM_BUZ_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_buzon)
					    from param.tbuzon buz
					    inner join segu.tusuario usu1 on usu1.id_usuario = buz.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = buz.id_usuario_mod
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
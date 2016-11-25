--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_subsistema_var_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_subsistema_var_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tsubsistema_var'
 AUTOR: 		 (admin)
 FECHA:	        22-11-2016 19:19:08
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

	v_nombre_funcion = 'param.ft_subsistema_var_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_VARI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 19:19:08
	***********************************/

	if(p_transaccion='PM_VARI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						vari.id_subsistema_var,
						vari.id_subsistema,
						vari.estado_reg,
						vari.descripcion,
						vari.nombre,
						vari.valor_def,
						vari.codigo,
						vari.id_usuario_reg,
						vari.fecha_reg,
						vari.usuario_ai,
						vari.id_usuario_ai,
						vari.id_usuario_mod,
						vari.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tsubsistema_var vari
						inner join segu.tusuario usu1 on usu1.id_usuario = vari.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = vari.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_VARI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 19:19:08
	***********************************/

	elsif(p_transaccion='PM_VARI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_subsistema_var)
					    from param.tsubsistema_var vari
					    inner join segu.tusuario usu1 on usu1.id_usuario = vari.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = vari.id_usuario_mod
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
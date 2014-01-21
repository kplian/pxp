--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_documento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_documento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_documento'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 17:43:47
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

	v_nombre_funcion = 'wf.ft_tipo_documento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPDW_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 17:43:47
	***********************************/

	if(p_transaccion='WF_TIPDW_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipdw.id_tipo_documento,
						tipdw.nombre,
						tipdw.id_proceso_macro,
						tipdw.codigo,
						tipdw.descripcion,
						tipdw.estado_reg,
						tipdw.tipo,
						tipdw.id_tipo_proceso,
						
						tipdw.action,
						tipdw.id_usuario_reg,
						tipdw.fecha_reg,
						tipdw.id_usuario_mod,
						tipdw.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from wf.ttipo_documento tipdw
						inner join segu.tusuario usu1 on usu1.id_usuario = tipdw.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipdw.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPDW_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 17:43:47
	***********************************/

	elsif(p_transaccion='WF_TIPDW_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_documento)
					    from wf.ttipo_documento tipdw
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipdw.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipdw.id_usuario_mod
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
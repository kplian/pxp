--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_var_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_var_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_var'
 AUTOR: 		 (admin)
 FECHA:	        22-11-2016 20:17:52
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

	v_nombre_funcion = 'param.ft_depto_var_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEVA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 20:17:52
	***********************************/

	if(p_transaccion='PM_DEVA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select deva.id_depto_var,
                                 deva.valor,
                                 deva.id_depto,
                                 deva.estado_reg,
                                 deva.id_subsistema_var,
                                 deva.id_usuario_ai,
                                 deva.id_usuario_reg,
                                 deva.fecha_reg,
                                 deva.usuario_ai,
                                 deva.id_usuario_mod,
                                 deva.fecha_mod,
                                 usu1.cuenta as usr_reg,
                                 usu2.cuenta as usr_mod,
                                 (''(''||sv.codigo||'') ''||sv.nombre)::varchar as desc_subsistema_var
                          from param.tdepto_var deva
                               inner join segu.tusuario usu1 on usu1.id_usuario = deva.id_usuario_reg
                               inner join param.tsubsistema_var sv on sv.id_subsistema_var = deva.id_subsistema_var
                               left join segu.tusuario usu2 on usu2.id_usuario = deva.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEVA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 20:17:52
	***********************************/

	elsif(p_transaccion='PM_DEVA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_depto_var)
					    from param.tdepto_var deva
                               inner join segu.tusuario usu1 on usu1.id_usuario = deva.id_usuario_reg
                               inner join param.tsubsistema_var sv on sv.id_subsistema_var = deva.id_subsistema_var
                               left join segu.tusuario usu2 on usu2.id_usuario = deva.id_usuario_mod
				        where  ';
			
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
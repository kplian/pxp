--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_cat_concepto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_cat_concepto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcat_concepto'
 AUTOR: 		 (admin)
 FECHA:	        27-10-2016 06:32:37
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

	v_nombre_funcion = 'param.ft_cat_concepto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CACO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-10-2016 06:32:37
	***********************************/

	if(p_transaccion='PM_CACO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                            caco.id_cat_concepto,
                            caco.habilitado,
                            caco.nombre,
                            caco.estado_reg,
                            caco.codigo,
                            caco.id_usuario_ai,
                            caco.id_usuario_reg,
                            caco.fecha_reg,
                            caco.usuario_ai,
                            caco.id_usuario_mod,
                            caco.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod	
						from param.tcat_concepto caco
						inner join segu.tusuario usu1 on usu1.id_usuario = caco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = caco.id_usuario_mod
				        where  caco.estado_reg = ''activo''  and  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CACO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2016 06:32:37
	***********************************/

	elsif(p_transaccion='PM_CACO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cat_concepto)
					    from param.tcat_concepto caco
						inner join segu.tusuario usu1 on usu1.id_usuario = caco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = caco.id_usuario_mod
				        where  caco.estado_reg = ''activo''  and ';
			
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
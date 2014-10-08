CREATE OR REPLACE FUNCTION param.ft_documento_categoria_clasificacion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_documento_categoria_clasificacion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdocumento_categoria_clasificacion'
 AUTOR: 		 (gsarmiento)
 FECHA:	        06-10-2014 16:00:33
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

	v_nombre_funcion = 'param.ft_documento_categoria_clasificacion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DOCATCLA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 16:00:33
	***********************************/

	if(p_transaccion='PM_DOCATCLA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						docatcla.id_documento_categoria_clasificacion,
						docatcla.id_categoria,
                        catpr.nombre_categoria,
						docatcla.id_clasificacion,
                        clapr.nombre_clasificacion,
						docatcla.estado_reg,
						docatcla.documento,
						docatcla.presentar_legal,
						docatcla.id_usuario_reg,
						docatcla.fecha_reg,
						docatcla.usuario_ai,
						docatcla.id_usuario_ai,
						docatcla.fecha_mod,
						docatcla.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tdocumento_categoria_clasificacion docatcla
                        inner join param.tcategoria_proveedor catpr on catpr.id_categoria_proveedor=docatcla.id_categoria
                        inner join param.tclasificacion_proveedor clapr on clapr.id_clasificacion_proveedor=docatcla.id_clasificacion
						inner join segu.tusuario usu1 on usu1.id_usuario = docatcla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = docatcla.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DOCATCLA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 16:00:33
	***********************************/

	elsif(p_transaccion='PM_DOCATCLA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_documento_categoria_clasificacion)
					    from param.tdocumento_categoria_clasificacion docatcla
					    inner join segu.tusuario usu1 on usu1.id_usuario = docatcla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = docatcla.id_usuario_mod
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
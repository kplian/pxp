CREATE OR REPLACE FUNCTION wf.ft_tabla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tabla_instancia_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttabla'
 AUTOR: 		 (admin)
 FECHA:	        07-05-2014 21:39:40
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

	v_nombre_funcion = 'wf.ft_tabla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_tabla_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	if(p_transaccion='WF_tabla_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tabla.id_tabla,
						tabla.id_tipo_proceso,
						tabla.vista_id_tabla_maestro,
						tabla.bd_scripts_extras,
						tabla.vista_campo_maestro,
						tabla.vista_scripts_extras,
						tabla.bd_descripcion,
						tabla.vista_tipo,
						tabla.menu_icono,
						tabla.menu_nombre,
						tabla.vista_campo_ordenacion,
						tabla.vista_posicion,
						tabla.estado_reg,
						tabla.menu_codigo,
						tabla.bd_nombre_tabla,
						tabla.bd_codigo_tabla,
						tabla.vista_dir_ordenacion,
						tabla.fecha_reg,
						tabla.id_usuario_reg,
						tabla.id_usuario_mod,
						tabla.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						maestro.bd_nombre_tabla	
						from wf.ttabla tabla
						inner join segu.tusuario usu1 on usu1.id_usuario = tabla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tabla.id_usuario_mod
						left join wf.ttabla maestro on tabla.vista_id_tabla_maestro = maestro.id_tabla
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = tabla.id_tipo_proceso
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_tabla_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_tabla_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tabla.id_tabla)
					    from wf.ttabla tabla
					    inner join segu.tusuario usu1 on usu1.id_usuario = tabla.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tabla.id_usuario_mod
						left join wf.ttabla maestro on tabla.vista_id_tabla_maestro = maestro.id_tabla
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = tabla.id_tipo_proceso
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
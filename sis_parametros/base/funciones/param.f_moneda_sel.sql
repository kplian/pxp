--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_moneda_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_moneda_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tmoneda'
 AUTOR: 		 (admin)
 FECHA:	        05-02-2013 18:17:03
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

	v_nombre_funcion = 'param.f_moneda_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	if(p_transaccion='PM_MONEDA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                            moneda.id_moneda,
                            moneda.prioridad,
                            moneda.origen,
                            moneda.tipo_actualizacion,
                            moneda.estado_reg,
                            moneda.codigo,
                            moneda.moneda,
                            moneda.tipo_moneda,
                            moneda.id_usuario_reg,
                            moneda.fecha_reg,
                            moneda.id_usuario_mod,
                            moneda.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            moneda.triangulacion,
                            moneda.contabilidad,
                            moneda.codigo_internacional,
                            moneda.show_combo,
                            moneda.actualizacion
						from param.tmoneda moneda
						inner join segu.tusuario usu1 on usu1.id_usuario = moneda.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = moneda.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	elsif(p_transaccion='PM_MONEDA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_moneda)
					    from param.tmoneda moneda
					    inner join segu.tusuario usu1 on usu1.id_usuario = moneda.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = moneda.id_usuario_mod
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
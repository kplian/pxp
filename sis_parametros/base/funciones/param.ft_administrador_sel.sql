CREATE OR REPLACE FUNCTION param.ft_administrador_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_administrador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tadministrador'
 AUTOR: 		 (admin)
 FECHA:	        29-12-2017 16:10:32
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				29-12-2017 16:10:32								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tadministrador'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_administrador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ADMFUNLU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		29-12-2017 16:10:32
	***********************************/

	if(p_transaccion='PM_ADMFUNLU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                        admfunlu.id_administrador,
                        admfunlu.id_funcionario,
                        admfunlu.id_lugar,
                        admfunlu.estado_reg,
                        admfunlu.id_usuario_ai,
                        admfunlu.id_usuario_reg,
                        admfunlu.fecha_reg,
                        admfunlu.usuario_ai,
                        admfunlu.id_usuario_mod,
                        admfunlu.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        lug.nombre as nombre,
                        func.desc_funcionario1::VARCHAR as desc_funcionario
                        from param.tadministrador admfunlu
                        inner join segu.tusuario usu1 on usu1.id_usuario = admfunlu.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = admfunlu.id_usuario_mod 
                        left join orga.vfuncionario func on func.id_funcionario=admfunlu.id_funcionario    
                        join param.tlugar lug on lug.id_lugar= admfunlu.id_lugar                   
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ADMFUNLU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		29-12-2017 16:10:32
	***********************************/

	elsif(p_transaccion='PM_ADMFUNLU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_administrador)
					    from param.tadministrador admfunlu
					    inner join segu.tusuario usu1 on usu1.id_usuario = admfunlu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = admfunlu.id_usuario_mod
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
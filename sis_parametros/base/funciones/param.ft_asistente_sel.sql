CREATE OR REPLACE FUNCTION param.ft_asistente_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_asistente_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tasistente'
 AUTOR: 		 (admin)
 FECHA:	        05-04-2013 14:02:14
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

	v_nombre_funcion = 'param.ft_asistente_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ASIS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		05-04-2013 14:02:14
	***********************************/

	if(p_transaccion='PM_ASIS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						asis.id_asistente,
						asis.id_uo,
						asis.id_funcionario,
						asis.estado_reg,
						asis.fecha_reg,
						asis.id_usuario_reg,
						asis.id_usuario_mod,
						asis.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        fun.desc_funcionario1,
                        uo.codigo||''-''||uo.nombre_unidad as desc_uo,
                        asis.recursivo
						from param.tasistente asis
						inner join segu.tusuario usu1 on usu1.id_usuario = asis.id_usuario_reg
                         inner join orga.vfuncionario fun on fun.id_funcionario = asis.id_funcionario
                        inner join orga.tuo uo on uo.id_uo = asis.id_uo
						left join segu.tusuario usu2 on usu2.id_usuario = asis.id_usuario_mod
				        where asis.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ASIS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		05-04-2013 14:02:14
	***********************************/

	elsif(p_transaccion='PM_ASIS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_asistente)
					    from param.tasistente asis
					    inner join segu.tusuario usu1 on usu1.id_usuario = asis.id_usuario_reg
                         inner join orga.vfuncionario fun on fun.id_funcionario = asis.id_funcionario
                        inner join orga.tuo uo on uo.id_uo = asis.id_uo
						left join segu.tusuario usu2 on usu2.id_usuario = asis.id_usuario_mod
					    where asis.estado_reg = ''activo'' and ';
			
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_uo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_uo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_uo'
 AUTOR: 		 (m)
 FECHA:	        19-10-2011 12:59:45
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

	v_nombre_funcion = 'param.ft_depto_uo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_DEPUO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		m	
 	#FECHA:		19-10-2011 12:59:45
	***********************************/

	if(p_transaccion='PM_DEPUO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						depuo.id_depto_uo,
						depuo.estado_reg,
						depuo.id_depto,
						depuo.id_uo,
						depuo.fecha_reg,
						depuo.id_usuario_reg,
						depuo.fecha_mod,
						depuo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						depto.nombre as desc_depto,
						uo.nombre_unidad as desc_uo,
						depto.nombre||''-''||uo.nombre_unidad as desc_depto_uo
						from param.tdepto_uo depuo
						inner join segu.tusuario usu1 on usu1.id_usuario = depuo.id_usuario_reg
						inner join param.tdepto depto on depto.id_depto=depuo.id_depto
						inner join orga.tuo uo on uo.id_uo=depuo.id_uo
                        left join segu.tusuario usu2 on usu2.id_usuario = depuo.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			if(pxp.f_existe_parametro(p_tabla,'id_depto'))then
                 v_consulta:=v_consulta|| ' and depuo.id_depto= '|| v_parametros.id_depto;
            end if;

			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************
 	#TRANSACCION:  'PM_DEPUO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		m	
 	#FECHA:		19-10-2011 12:59:45
	***********************************/

	elsif(p_transaccion='PM_DEPUO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_depto_uo)
					    from param.tdepto_uo depuo
					    inner join segu.tusuario usu1 on usu1.id_usuario = depuo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = depuo.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		
			v_consulta:=v_consulta||v_parametros.filtro;
			if(pxp.f_existe_parametro(p_tabla,'id_depto'))then
               v_consulta:=v_consulta|| ' and depuo.id_depto= '|| v_parametros.id_depto;
            end if;
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
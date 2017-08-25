--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_depto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_depto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_depto'
 AUTOR: 		 (admin)
 FECHA:	        08-09-2015 14:02:42
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

	v_nombre_funcion = 'param.ft_depto_depto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEDE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		08-09-2015 14:02:42
	***********************************/

	if(p_transaccion='PM_DEDE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						dede.id_depto_depto,
						dede.id_depto_origen,
						dede.estado_reg,
						dede.obs,
						dede.id_depto_destino,
						dede.fecha_reg,
						dede.usuario_ai,
						dede.id_usuario_reg,
						dede.id_usuario_ai,
						dede.fecha_mod,
						dede.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,	
                        ddes.nombre as desc_depto_destino
						from param.tdepto_depto dede
						inner join param.tdepto ddes on ddes.id_depto = dede.id_depto_destino
                        inner join segu.tusuario usu1 on usu1.id_usuario = dede.id_usuario_reg
                        inner join segu.tsubsistema sdes on sdes.id_subsistema = ddes.id_subsistema
                        left join segu.tusuario usu2 on usu2.id_usuario = dede.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEDE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		08-09-2015 14:02:42
	***********************************/

	elsif(p_transaccion='PM_DEDE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_depto_depto)
					    from param.tdepto_depto dede
						inner join param.tdepto ddes on ddes.id_depto = dede.id_depto_destino
                        inner join segu.tusuario usu1 on usu1.id_usuario = dede.id_usuario_reg
                        inner join segu.tsubsistema sdes on sdes.id_subsistema = ddes.id_subsistema
                        left join segu.tusuario usu2 on usu2.id_usuario = dede.id_usuario_mod
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
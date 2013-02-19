CREATE OR REPLACE FUNCTION wf.f_proceso_macro_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_macro_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.proceso_macro'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 13:51:29
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

	v_nombre_funcion = 'wf.f_proceso_macro_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	if(p_transaccion='WF_PROMAC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						promac.id_proceso_macro,
						promac.id_subsistema,
						promac.nombre,
						promac.codigo,
						promac.inicio,
						promac.estado_reg,
						promac.id_usuario_reg,
						promac.fecha_reg,
						promac.id_usuario_mod,
						promac.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        subs.nombre AS desc_subsistema	
						from wf.tproceso_macro promac
						inner join segu.tusuario usu1 on usu1.id_usuario = promac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = promac.id_usuario_mod
                        INNER JOIN segu.tsubsistema subs on subs.id_subsistema = promac.id_subsistema
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proceso_macro)
					    from wf.tproceso_macro promac
					    inner join segu.tusuario usu1 on usu1.id_usuario = promac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = promac.id_usuario_mod
                        INNER JOIN segu.tsubsistema subs on subs.id_subsistema = promac.id_subsistema
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
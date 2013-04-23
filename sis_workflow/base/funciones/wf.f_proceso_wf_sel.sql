--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_proceso_wf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_wf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tproceso_wf'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 09:01:51
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

	v_nombre_funcion = 'wf.f_proceso_wf_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PWF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	if(p_transaccion='WF_PWF_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						
                        pwf.id_proceso_wf,
						pwf.id_tipo_proceso,
						pwf.nro_tramite,
						pwf.id_estado_wf_prev,
						pwf.estado_reg,						
						pwf.id_persona,
						pwf.valor_cl,
						pwf.id_institucion,
						pwf.id_usuario_reg,
						pwf.fecha_reg,
						pwf.fecha_mod,
						pwf.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.nombre as desc_tipo_proceso
						from wf.tproceso_wf pwf
                        inner join  wf.ttipo_proceso tp on pwf.id_tipo_proceso=tp.id_tipo_proceso
						inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                        inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
						left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                        where ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proceso_wf)
					    from wf.tproceso_wf pwf
                        inner join  wf.ttipo_proceso tp on pwf.id_tipo_proceso=tp.id_tipo_proceso
						inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                        inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
						left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
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
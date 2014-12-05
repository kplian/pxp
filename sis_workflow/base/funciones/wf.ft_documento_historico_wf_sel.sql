--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_documento_historico_wf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_documento_historico_wf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tdocumento_historico_wf'
 AUTOR: 		 (admin)
 FECHA:	        04-12-2014 20:11:08
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

	v_nombre_funcion = 'wf.ft_documento_historico_wf_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DHW_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		04-12-2014 20:11:08
	***********************************/

	if(p_transaccion='WF_DHW_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						dhw.id_documento_historico_wf,
						dhw.id_documento,
						dhw.url,
						dhw.estado_reg,
						dhw.url_old,
						dhw.version,
						dhw.vigente,
						dhw.id_usuario_reg,
						dhw.usuario_ai,
						dhw.fecha_reg,
						dhw.id_usuario_ai,
						dhw.fecha_mod,
						dhw.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        dhw.extension	
						from wf.tdocumento_historico_wf dhw
						inner join segu.tusuario usu1 on usu1.id_usuario = dhw.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dhw.id_usuario_mod
				        where  vigente = ''no'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_DHW_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		04-12-2014 20:11:08
	***********************************/

	elsif(p_transaccion='WF_DHW_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_documento_historico_wf)
					    from wf.tdocumento_historico_wf dhw
					    inner join segu.tusuario usu1 on usu1.id_usuario = dhw.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dhw.id_usuario_mod
					    where  vigente = ''no'' and';
			
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
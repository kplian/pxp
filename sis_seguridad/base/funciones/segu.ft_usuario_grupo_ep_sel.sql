--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_usuario_grupo_ep_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_usuario_grupo_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tusuario_grupo_ep'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 15:53:08
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

	v_nombre_funcion = 'segu.ft_usuario_grupo_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_UEP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 15:53:08
	***********************************/

	if(p_transaccion='SG_UEP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select uep.id_usuario_grupo_ep,
                               uep.estado_reg,
                               uep.id_usuario,
                               uep.id_grupo,
                               uep.fecha_reg,
                               uep.id_usuario_reg,
                               uep.fecha_mod,
                               uep.id_usuario_mod,
                               usu1.cuenta as usr_reg,
                               usu2.cuenta as usr_mod,
                               gr.nombre as desc_grupo
                        from segu.tusuario_grupo_ep uep
                             inner join segu.tusuario usu1 on usu1.id_usuario = uep.id_usuario_reg
                             inner join param.tgrupo gr on gr.id_grupo = uep.id_grupo
                             left join segu.tusuario usu2 on usu2.id_usuario = uep.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SG_UEP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 15:53:08
	***********************************/

	elsif(p_transaccion='SG_UEP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_usuario_grupo_ep)
					     from segu.tusuario_grupo_ep uep
                             inner join segu.tusuario usu1 on usu1.id_usuario = uep.id_usuario_reg
                             inner join param.tgrupo gr on gr.id_grupo = uep.id_grupo
                             left join segu.tusuario usu2 on usu2.id_usuario = uep.id_usuario_mod
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
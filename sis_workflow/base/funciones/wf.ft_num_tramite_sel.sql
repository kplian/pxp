CREATE OR REPLACE FUNCTION wf.ft_num_tramite_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_num_tramite_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tnum_tramite'
 AUTOR: 		 (FRH)
 FECHA:	        19-02-2013 13:51:54
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

	v_nombre_funcion = 'wf.ft_num_tramite_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_NUMTRAM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:54
	***********************************/

	if(p_transaccion='WF_NUMTRAM_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						numtram.id_num_tramite,
						numtram.id_proceso_macro,
						numtram.estado_reg,
						numtram.id_gestion,
						numtram.num_siguiente,
						numtram.fecha_reg,
						numtram.id_usuario_reg,
						numtram.id_usuario_mod,
						numtram.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        ges.gestion::varchar AS desc_gestion,
                        (prom.codigo||lpad(COALESCE(numtram.num_siguiente, 0)::varchar,6,''0'')||ges.gestion)::varchar AS codificacion_siguiente                      
						from wf.tnum_tramite numtram
						inner join segu.tusuario usu1 on usu1.id_usuario = numtram.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = numtram.id_usuario_mod
                        INNER JOIN param.tgestion ges on ges.id_gestion = numtram.id_gestion
                        INNER JOIN wf.tproceso_macro prom on prom.id_proceso_macro =  numtram.id_proceso_macro
				        WHERE  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_NUMTRAM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:54
	***********************************/

	elsif(p_transaccion='WF_NUMTRAM_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_num_tramite)
					    from wf.tnum_tramite numtram
					    inner join segu.tusuario usu1 on usu1.id_usuario = numtram.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = numtram.id_usuario_mod
                        INNER JOIN param.tgestion ges on ges.id_gestion = numtram.id_gestion
                        INNER JOIN wf.tproceso_macro prom on prom.id_proceso_macro =  numtram.id_proceso_macro
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
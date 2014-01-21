--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_documento_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_documento_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_documento_estado'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 03:12:38
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

	v_nombre_funcion = 'wf.ft_tipo_documento_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	if(p_transaccion='WF_DES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						des.id_tipo_documento_estado,
						des.id_tipo_estado,
						des.id_tipo_documento,
						des.id_tipo_proceso,
						des.estado_reg,
						des.momento,
						des.fecha_reg,
						des.id_usuario_reg,
						des.fecha_mod,
						des.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.codigo||''-''||tp.nombre as desc_tipo_proceso,
                        te.codigo||''-''||te.nombre_estado as desc_tipo_estado
                        	
						from wf.ttipo_documento_estado des
						inner join segu.tusuario usu1 on usu1.id_usuario = des.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = des.id_usuario_mod
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = des.id_tipo_proceso
                        inner join wf.ttipo_estado te on te.id_tipo_estado = des.id_tipo_estado
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_DES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	elsif(p_transaccion='WF_DES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_documento_estado)
					    from wf.ttipo_documento_estado des
						inner join segu.tusuario usu1 on usu1.id_usuario = des.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = des.id_usuario_mod
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = des.id_tipo_proceso
                        inner join wf.ttipo_estado te on te.id_tipo_estado = des.id_tipo_estado
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
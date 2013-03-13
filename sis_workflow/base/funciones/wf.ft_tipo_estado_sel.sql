--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_estado'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:36:11
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

	v_nombre_funcion = 'wf.ft_tipo_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);
   
    /*********************************    
 	#TRANSACCION:  'WF_FUNTIPES_SEL'
 	#DESCRIPCION:	Consulta los funcionarios correpondientes con el tipo de estado
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	if(p_transaccion='WF_FUNTIPES_SEL')then
     				
    	begin
        
            --llamada a la funcion del tipo estado
            
            
            
            
        
    		--Sentencia de la consulta
			v_consulta:='select
						tipes.id_tipo_estado,
						tipes.nombre_estado,
						tipes.id_tipo_proceso,
						tipes.inicio,
						tipes.disparador,
						tipes.tipo_asignacion,
						tipes.nombre_func_list,
						tipes.estado_reg,
						tipes.fecha_reg,
						tipes.id_usuario_reg,
						tipes.fecha_mod,
						tipes.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.nombre AS desc_tipo_proceso,
                        tipes.codigo as codigo_estado	
						from wf.ttipo_estado tipes
						inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;


	/*********************************    
 	#TRANSACCION:  'WF_TIPES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elseif(p_transaccion='WF_TIPES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipes.id_tipo_estado,
						tipes.nombre_estado,
						tipes.id_tipo_proceso,
						tipes.inicio,
						tipes.disparador,
						tipes.tipo_asignacion,
						tipes.nombre_func_list,
						tipes.estado_reg,
						tipes.fecha_reg,
						tipes.id_usuario_reg,
						tipes.fecha_mod,
						tipes.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.nombre AS desc_tipo_proceso,
                        tipes.codigo as codigo_estado	
						from wf.ttipo_estado tipes
						inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_TIPES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tipes.id_tipo_estado)
					    from wf.ttipo_estado tipes
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
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
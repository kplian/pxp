--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_proceso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_proceso_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_proceso'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:52:52
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

	v_nombre_funcion = 'wf.ft_tipo_proceso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPPROC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:52:52
	***********************************/

	if(p_transaccion='WF_TIPPROC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipproc.id_tipo_proceso,
						tipproc.nombre,
						tipproc.codigo,
						tipproc.id_proceso_macro,
						tipproc.tabla,
						tipproc.columna_llave,
						tipproc.estado_reg,
						tipproc.id_tipo_estado,
						tipproc.fecha_reg,
						tipproc.id_usuario_reg,
						tipproc.fecha_mod,
						tipproc.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        pm.nombre AS desc_proceso_macro,
                        te.nombre_estado AS desc_tipo_estado,
                        tipproc.inicio 		
						from wf.ttipo_proceso tipproc
						inner join segu.tusuario usu1 on usu1.id_usuario = tipproc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipproc.id_usuario_mod
                        INNER JOIN wf.tproceso_macro pm on pm.id_proceso_macro = tipproc.id_proceso_macro
                        LEFT JOIN wf.ttipo_estado te on te.id_tipo_estado = tipproc.id_tipo_estado
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPPROC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:52:52
	***********************************/

	elsif(p_transaccion='WF_TIPPROC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tipproc.id_tipo_proceso)
					    from wf.ttipo_proceso tipproc
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipproc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipproc.id_usuario_mod
                        INNER JOIN wf.tproceso_macro pm on pm.id_proceso_macro = tipproc.id_proceso_macro
                        LEFT JOIN wf.ttipo_estado te on te.id_tipo_estado = tipproc.id_tipo_estado
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
            
    /*******************************    
	 #TRANSACCION:  WF_EXPTIPPROC_SEL
	 #DESCRIPCION:	Listado de tipos de proceso de un proceso macro para exportar
	 #AUTOR:		Gonzalo Sarmiento Sejas
	 #FECHA:		19/03/2013	
	***********************************/

     elsif(p_transaccion='WF_EXPTIPPROC_SEL')then

          BEGIN
               v_consulta:= 'select ''tipo_proceso''::varchar,
				                te.nombre_estado as nombre_tipo_estado,
								tipproc.nombre,
								tipproc.codigo,
								tipproc.tabla,
                                tipproc.columna_llave,
                                tipproc.estado_reg,
                                tipproc.inicio,
                                pm.codigo AS cod_proceso_macro	                                
                                from wf.ttipo_proceso tipproc
                        		inner join wf.tproceso_macro pm on pm.id_proceso_macro = tipproc.id_proceso_macro
                                left join wf.ttipo_estado te on te.id_tipo_estado=tipproc.id_tipo_estado
                        		where tipproc.id_proceso_macro='|| v_parametros.id_proceso_macro ||
                             ' order by tipproc.id_tipo_proceso ASC'; 
               return v_consulta;
         END;
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
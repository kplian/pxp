CREATE OR REPLACE FUNCTION "wf"."ft_tabla_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tabla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttabla'
 AUTOR: 		 (admin)
 FECHA:	        07-05-2014 21:39:40
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
	v_tabla				record;
	v_joins_adicionales text;
	v_columnas			record;
			    
BEGIN

	v_nombre_funcion = 'wf.ft_tabla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TABLAINS_SEL'
 	#DESCRIPCION:	Consulta de datos de la instancia de una tabla
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	if(p_transaccion='WF_TABLAINS_SEL')then
     				
    	begin
    		--Obtener esquema, datos de tabla            
            select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = v_parametros.id_tabla;
    		
    		--Sentencia de la consulta
			v_consulta = 'select id_' || v_tabla.bd_nombre_tabla || ', ';
			v_joins_adicionales = '';
			--campos y campos adicionales
			for v_columnas in (	select * from wf.ttipo_columna 
            					where id_tabla = v_parametros.id_tabla) loop
            	v_consulta = v_consulta || 	v_tabla.bd_codigo_tabla || '.' || v_columnas.bd_nombre_columna || ', ' || 
            				 coalesce(v_columnas.bd_campos_adicionales|| ', ', '');
            				 
            	v_joins_adicionales = 	v_joins_adicionales || coalesce(v_columnas.bd_joins_adicionales, '') || ' ';	
            end loop;
			
			v_consulta = v_consulta || 
							v_tabla.bd_codigo_tabla || '.estado_reg,'||
							v_tabla.bd_codigo_tabla || '.fecha_reg,'||
							v_tabla.bd_codigo_tabla || '.id_usuario_reg,'||
							v_tabla.bd_codigo_tabla || '.id_usuario_mod,'||
							v_tabla.bd_codigo_tabla || '.fecha_mod,
							usu1.cuenta as usr_reg,
							usu1.cuenta as usr_mod
						from ' || v_tabla.esquema || '.' || v_tabla.bd_nombre_tabla || ' ' || v_tabla.bd_codigo_tabla || '
						inner join segu.tusuario usu1 on usu1.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_mod ' ||
						v_joins_adicionales;
						
				        
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TABLAINS_CONT'
 	#DESCRIPCION:	Conteo de registros de la instancia de tabla
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_TABLAINS_CONT')then

		begin
			--Obtener esquema, datos de tabla            
            select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = v_parametros.id_tabla;
            
			--Sentencia de la consulta de conteo de registros
			v_consulta = 'select count(id_' || v_tabla.bd_nombre_tabla || ') ';
			v_joins_adicionales = '';
			
			--campos y campos adicionales
			for v_columnas in (	select * from wf.ttipo_columna 
            					where id_tabla = v_parametros.id_tabla) loop            	
            	v_joins_adicionales = 	v_joins_adicionales || coalesce(v_columnas.bd_joins_adicionales, '') || ' ';	
            end loop;
			
			v_consulta =' from ' || v_tabla.esquema || '.' || v_tabla.bd_nombre_tabla || ' ' || v_tabla.bd_codigo_tabla || '
						inner join segu.tusuario usu1 on usu1.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_mod ' ||
						v_joins_adicionales;
			
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "wf"."ft_tabla_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

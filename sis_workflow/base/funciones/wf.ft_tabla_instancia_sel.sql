CREATE OR REPLACE FUNCTION wf.ft_tabla_instancia_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tabla_instancia_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttabla_instancia'
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
    v_joins_wf			text;
    v_filtro			varchar;
    v_id_funcionario_usuario	integer;
    var					text;
    array_campos_adicionales text[];
    
			    
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
        	
        	select f.id_funcionario into v_id_funcionario_usuario
            from segu.tusuario u
            inner join orga.tfuncionario f 
            	on f.id_persona = u.id_persona
            where u.id_usuario = p_id_usuario;
            
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
            v_joins_wf = '';
            v_filtro = ' 0 = 0 and ';
            if (v_tabla.vista_tipo = 'maestro') then
            
				v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado, ' ||
						 	v_tabla.bd_codigo_tabla || '.id_estado_wf, ' ||
						 	v_tabla.bd_codigo_tabla || '.id_proceso_wf,
                            ew.obs,
                            pw.nro_tramite, ';
                v_joins_wf = ' inner join wf.testado_wf ew on ew.id_estado_wf = ' || v_tabla.bd_codigo_tabla || '.id_estado_wf ';
                v_joins_wf = v_joins_wf ||  'inner join wf.tproceso_wf pw on pw.id_proceso_wf = ' || v_tabla.bd_codigo_tabla || '.id_proceso_wf ';
                IF p_administrador !=1  then                	
                    v_filtro = ' (ew.id_funcionario='||coalesce(v_id_funcionario_usuario::varchar,'0')||' )   and ';
                END IF;
			end if;			 	 
			v_joins_adicionales = '';
			--campos y campos adicionales
			for v_columnas in (	select * from wf.ttipo_columna 
            					where id_tabla = v_parametros.id_tabla and estado_reg = 'activo' order by id_tipo_columna asc) loop
            	v_consulta = v_consulta || 	v_tabla.bd_codigo_tabla || '.' || v_columnas.bd_nombre_columna || ', ';
            	
            	if (v_columnas.bd_campos_adicionales is not null and v_columnas.bd_campos_adicionales != '')then
                	array_campos_adicionales = string_to_array(v_columnas.bd_campos_adicionales, ',');
                    
                    FOREACH var IN ARRAY array_campos_adicionales
                    LOOP
                        v_consulta = v_consulta || split_part(var,' ',1)|| ', ';
                    END LOOP;                	
            		
            	end if;
            	
            	if (v_columnas.bd_joins_adicionales is not null and v_columnas.bd_joins_adicionales != '')then
            		v_joins_adicionales = v_joins_adicionales || v_columnas.bd_joins_adicionales|| ' ';
            	end if;           				 
            		
            end loop;
			
			v_consulta = v_consulta || 
							v_tabla.bd_codigo_tabla || '.estado_reg,'||
							v_tabla.bd_codigo_tabla || '.fecha_reg,'||
							v_tabla.bd_codigo_tabla || '.id_usuario_reg,'||
							v_tabla.bd_codigo_tabla || '.id_usuario_mod,'||
							v_tabla.bd_codigo_tabla || '.fecha_mod,
							usu1.cuenta as usr_reg,
							usu1.cuenta as usr_mod
                            
						from ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' ' || v_tabla.bd_codigo_tabla || '
						inner join segu.tusuario usu1 on usu1.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_mod ' ||
						v_joins_adicionales || v_joins_wf ||' where  ' || v_tabla.bd_codigo_tabla || '.estado_reg !=''inactivo'' and '; 
            if (v_tabla.vista_tipo = 'maestro') then            				 
            	v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado != ''anulado'' and ';
                
                IF  (pxp.f_existe_parametro(p_tabla,'historico')= false) THEN
             		v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado = ''' || v_parametros.tipo_estado || ''' and ';
             	end if; 
                
                IF  (pxp.f_existe_parametro(p_tabla,'historico')) THEN
                	if (v_parametros.historico != 'si')then
             			v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado = ''' || v_parametros.tipo_estado || ''' and ';
                    end if;
             	end if;                
                v_consulta = v_consulta || v_filtro;
            end if;			
				        
			--raise exception '%',v_joins_adicionales;
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
			select f.id_funcionario into v_id_funcionario_usuario
            from segu.tusuario u
            inner join orga.tfuncionario f 
            	on f.id_persona = u.id_persona
            where u.id_usuario = p_id_usuario;
            
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
            v_joins_wf = '';
            v_filtro = ' 0 = 0 and ';
            if (v_tabla.vista_tipo = 'maestro') then
            	v_joins_wf = ' inner join wf.testado_wf ew on ew.id_estado_wf = ' || v_tabla.bd_codigo_tabla || '.id_estado_wf ';
                v_joins_wf = v_joins_wf ||  'inner join wf.tproceso_wf pw on pw.id_proceso_wf = ' || v_tabla.bd_codigo_tabla || '.id_proceso_wf ';            
                IF p_administrador !=1  then
                	--v_joins_wf = ' inner join wf.testado_wf ew on ew.id_estado_wf = ' || v_tabla.bd_codigo_tabla || '.id_estado_wf ';
                    v_filtro = ' (ew.id_funcionario='||coalesce(v_id_funcionario_usuario::varchar,'0')||' )   and ';
                END IF;
			end if;
            
			v_joins_adicionales = '';
			
			--campos y campos adicionales
			for v_columnas in (	select * from wf.ttipo_columna 
            					where id_tabla = v_parametros.id_tabla and estado_reg = 'activo') loop            	
            	if (v_columnas.bd_joins_adicionales is not null and v_columnas.bd_joins_adicionales != '')then
            		v_joins_adicionales = v_joins_adicionales || v_columnas.bd_joins_adicionales|| '  ';
            	end if;  	
            end loop;
			
			v_consulta = v_consulta || ' from ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' ' || v_tabla.bd_codigo_tabla || '
						inner join segu.tusuario usu1 on usu1.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ' || v_tabla.bd_codigo_tabla || '.id_usuario_mod ' ||
						v_joins_adicionales || v_joins_wf || ' where  ' || v_tabla.bd_codigo_tabla || '.estado_reg !=''inactivo'' and ';
                        
            if (v_tabla.vista_tipo = 'maestro') then            				 
            	v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado != ''anulado'' and ';
                
                IF  (pxp.f_existe_parametro(p_tabla,'historico')= false) THEN
             		v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado = ''' || v_parametros.tipo_estado || ''' and ';
             	end if; 
                
                IF  (pxp.f_existe_parametro(p_tabla,'historico')) THEN
                	if (v_parametros.historico != 'si')then
             			v_consulta = v_consulta || v_tabla.bd_codigo_tabla || '.estado = ''' || v_parametros.tipo_estado || ''' and ';
                    end if;
             	end if;                
                v_consulta = v_consulta || v_filtro;
            end if;		
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;
			--raise exception '%',v_consulta;
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
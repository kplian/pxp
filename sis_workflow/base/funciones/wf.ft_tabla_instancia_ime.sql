CREATE OR REPLACE FUNCTION wf.ft_tabla_instancia_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tabla_instancia_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla autogenerada del workflow
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

	v_nro_requerimiento    	integer;
	v_parametros           	json;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;	
    v_tabla					record;
    v_fields				text;
    v_values				text;
    v_query					text;
    v_codigo_tipo_proceso	varchar;
    v_id_proceso_macro		integer;
    v_num_tramite			varchar;
	v_id_proceso_wf			integer;
	v_id_estado_wf			integer;
	v_codigo_estado			varchar;
	v_id_gestion			integer;
    v_columnas				record;
    v_id_tabla				integer;
    v_id_tipo_estado		integer;
    v_id_estado_actual		integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tabla_instancia_ime';
    v_parametros = pxp.f_get_json(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TABLAINS_INS'
 	#DESCRIPCION:	Insercion de registros en tabla autogenerada del workflow
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	if(p_transaccion='WF_TABLAINS_INS')then
					
        begin
        
        	select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer;
            if (v_tabla.vista_tipo = 'maestro') then
                select po_id_gestion into v_id_gestion from param.f_get_periodo_gestion(now()::date);
                
                -- obtener el codigo del tipo_proceso
           
                select   tp.codigo, tp.id_proceso_macro 
                    into v_codigo_tipo_proceso, v_id_proceso_macro
                from  wf.ttabla tabla
                inner join wf.ttipo_proceso tp
                    on tabla.id_tipo_proceso =  tp.id_tipo_proceso
                where   tabla.id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer;
    	            
    	         
                IF v_codigo_tipo_proceso is NULL THEN	        
                   raise exception 'No existe un proceso inicial para la tabla (Revise la configuración)';	        
                END IF;
    	        
                 -- inciiar el tramite en el sistema de WF
               SELECT 
                     ps_num_tramite ,
                     ps_id_proceso_wf ,
                     ps_id_estado_wf ,
                     ps_codigo_estado 
                  into
                     v_num_tramite,
                     v_id_proceso_wf,
                     v_id_estado_wf,
                     v_codigo_estado   
    	              
                FROM wf.f_inicia_tramite(
                     p_id_usuario,
                     json_extract_path_text(v_parametros,'_id_usuario_ai')::integer,
                     json_extract_path_text(v_parametros,'_nombre_usuario_ai')::varchar,                 
                     v_id_gestion, 
                     v_codigo_tipo_proceso, 
                     NULL,
                     NULL,
                     NULL,
                     ' ');
            end if;
           
        	v_fields = 'insert into ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '(
        					estado_reg,
        					fecha_reg,
							id_usuario_reg,
							id_usuario_mod,
							fecha_mod,';
            if (v_tabla.vista_tipo = 'maestro') then
				v_fields =	v_fields || 'id_estado_wf,
							id_proceso_wf,
							estado';
            else
            	v_fields =	v_fields || v_tabla.vista_campo_maestro;							
            end if;
        					
        	v_values = 'values(
        				''activo'',''' ||
        				now()::date || ''',' ||
        				p_id_usuario || ',
        				NULL,
        				NULL,';
            if (v_tabla.vista_tipo = 'maestro') then
				v_values =	v_values ||v_id_estado_wf || ', '||
        				v_id_proceso_wf || ','''||
        				v_codigo_estado || '''';
            else
            	v_values =	v_values || json_extract_path_text(v_parametros,v_columnas.vista_campo_maestro);							
            end if;			
        			
        	for v_columnas in (	select tc.* from wf.ttipo_columna tc
        						inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento in ('registrar', 'exigir')
        						inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
            					where id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer and tc.estado_reg = 'activo' 
                                and te.codigo = json_extract_path_text(v_parametros,'tipo_estado')::varchar) loop
            		
                v_fields = v_fields || ',' || v_columnas.bd_nombre_columna;
            	if (v_columnas.bd_tipo_columna in ('integer', 'bigint', 'boolean', 'numeric')) then
            		v_values = v_values || ',' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna);
            	else                	
            		v_values = v_values || ',''' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna)|| '''';                    
            	end if;	
            end loop;
        	
        	v_fields = v_fields || ')';
        	
        	v_values = v_values || ') returning id_' || v_tabla.bd_nombre_tabla;
        	--raise exception '% %',v_fields,v_values;
        	execute (v_fields || v_values) into v_id_tabla;
        	        	
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',v_tabla.bd_nombre_tabla  || ' almacenado(a) con exito (id_'||v_tabla.bd_nombre_tabla || v_id_tabla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_' ||v_tabla.bd_nombre_tabla ,v_id_tabla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TABLAINS_UPD'
 	#DESCRIPCION:	Modificacion de registros en tabla autogenerada del workflow
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_TABLAINS_MOD')then

		begin
			--raise exception 'llega';
			select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer;
            
            v_query = ' update ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' set 
            			id_usuario_mod = ' || p_id_usuario || ',
						fecha_mod = ''' || now()::date  || '''';
            
            for v_columnas in (	select tc.* from wf.ttipo_columna tc
        						inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento in ('registrar', 'exigir')
                                inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
        						where id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer and tc.estado_reg = 'activo' 
                                and te.codigo = json_extract_path_text(v_parametros,'tipo_estado')::varchar) loop
            	
            	if (v_columnas.bd_tipo_columna in ('integer', 'bigint', 'boolean', 'numeric')) then
            		v_query = v_query || ',' || v_columnas.bd_nombre_columna  || '=' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna);
            	else
            		v_query = v_query || ',' || v_columnas.bd_nombre_columna  || '=''' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna) || '''';
            	end if;	
            end loop;
            
            v_query = v_query || ' where id_' || v_tabla.bd_nombre_tabla || '=' || json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla);			
            --raise exception '%',v_query;
            execute (v_query);
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_' ||v_tabla.bd_nombre_tabla,json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla)::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TABLAINS_ELI'
 	#DESCRIPCION:	Eliminacion de registros de tabla autogenerada en el sistema de workflow
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_TABLAINS_ELI')then

		begin
		
			select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer;
            
            if (v_tabla.vista_tipo != 'maestro') then
                v_query = ' update  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '  
                            set estado_reg = ''inactivo'' 
                            where id_' || v_tabla.bd_nombre_tabla || '=' || json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla);
                
                execute (v_query);
    		else
                select 
                  te.id_tipo_estado
                 into
                  v_id_tipo_estado
                 from wf.ttipo_estado te                
                 where te.id_tipo_proceso = v_tabla.id_tipo_proceso and te.codigo = 'anulado';
                 
                 IF v_id_tipo_estado is NULL  THEN             
                    raise exception 'No se parametrizo el estado "anulado" para el proceso';                 
                 END IF;
                 
                 execute ('	select id_estado_wf, id_proceso_wf
                 			from  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' 
                 			where id_' || v_tabla.bd_nombre_tabla || '=' || json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla)) 
                            into v_id_estado_wf,v_id_proceso_wf;
                
                 
                 v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                           NULL, 
                                                           v_id_estado_wf, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           json_extract_path_text(v_parametros,'_id_usuario_ai')::integer,
                 											json_extract_path_text(v_parametros,'_nombre_usuario_ai')::varchar,
                                                           NULL,
                                                           'Eliminacion del proceso');
                                                           
                  v_query = ' update  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '  
                            set estado = ''anulado'',
                            id_estado_wf = ' ||  v_id_estado_actual || ',
                            id_usuario_mod = ' ||  p_id_usuario || ',
                            fecha_mod=now()
                            where id_' || v_tabla.bd_nombre_tabla || '=' || json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla);
                                                          
                   execute (v_query);           
                 
            end if;		
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_' ||v_tabla.bd_nombre_tabla,(json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla))::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;	
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
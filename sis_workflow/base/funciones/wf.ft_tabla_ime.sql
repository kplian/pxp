CREATE OR REPLACE FUNCTION wf.ft_tabla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tabla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttabla'
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
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tabla				integer;
    v_tabla					record;
    v_query					varchar;
    v_col_ejecutadas		integer;
    v_ejecuta_tabla			integer;
    v_ejecuta_script		integer;
    v_columnas				record;
    v_mensaje				varchar;
    v_tamano				varchar;
    v_registros				record;
    v_respuesta				integer;
    v_nombre_tabla_maestro	varchar;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tabla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_tabla_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	if(p_transaccion='WF_tabla_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttabla(
			id_tipo_proceso,
			vista_id_tabla_maestro,
			bd_scripts_extras,
			vista_campo_maestro,
			vista_scripts_extras,
			bd_descripcion,
			vista_tipo,
			menu_icono,
			menu_nombre,
			vista_campo_ordenacion,
			vista_posicion,
			estado_reg,
			menu_codigo,
			bd_nombre_tabla,
			bd_codigo_tabla,
			vista_dir_ordenacion,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
			vista_estados_new,
			vista_estados_delete
          	) values(
			v_parametros.id_tipo_proceso,
			v_parametros.vista_id_tabla_maestro,
			v_parametros.bd_scripts_extras,
			v_parametros.vista_campo_maestro,
			v_parametros.vista_scripts_extras,
			v_parametros.bd_descripcion,
			v_parametros.vista_tipo,
			v_parametros.menu_icono,
			v_parametros.menu_nombre,
			v_parametros.vista_campo_ordenacion,
			v_parametros.vista_posicion,
			'activo',
			v_parametros.menu_codigo,
			v_parametros.bd_nombre_tabla,
			v_parametros.bd_codigo_tabla,
			v_parametros.vista_dir_ordenacion,
			now(),
			p_id_usuario,
			null,
			null,
			string_to_array(v_parametros.vista_estados_new, ','),
			string_to_array(v_parametros.vista_estados_delete, ',')
							
			)RETURNING id_tabla into v_id_tabla;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla almacenado(a) con exito (id_tabla'||v_id_tabla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_id_tabla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_tabla_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_tabla_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttabla set
			id_tipo_proceso = v_parametros.id_tipo_proceso,
			vista_id_tabla_maestro = v_parametros.vista_id_tabla_maestro,
			bd_scripts_extras = v_parametros.bd_scripts_extras,
			vista_campo_maestro = v_parametros.vista_campo_maestro,
			vista_scripts_extras = v_parametros.vista_scripts_extras,
			bd_descripcion = v_parametros.bd_descripcion,
			vista_tipo = v_parametros.vista_tipo,
			menu_icono = v_parametros.menu_icono,
			menu_nombre = v_parametros.menu_nombre,
			vista_campo_ordenacion = v_parametros.vista_campo_ordenacion,
			vista_posicion = v_parametros.vista_posicion,
			menu_codigo = v_parametros.menu_codigo,
			bd_nombre_tabla = v_parametros.bd_nombre_tabla,
			bd_codigo_tabla = v_parametros.bd_codigo_tabla,
			vista_dir_ordenacion = v_parametros.vista_dir_ordenacion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			vista_estados_new = string_to_array(v_parametros.vista_estados_new, ','),
			vista_estados_delete = string_to_array(v_parametros.vista_estados_delete, ',')
			where id_tabla=v_parametros.id_tabla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_parametros.id_tabla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_tabla_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_tabla_ELI')then

		begin
        	if (exists (select 1 
            			from wf.ttipo_columna t
                        where t.id_tabla = v_parametros.id_tabla and
                        t.estado_reg = 'activo'))then
            	raise exception 'Existe(n) Tipos de columna que depende(n) de esta babla';
            end if;
            
			--Sentencia de la eliminacion
			update wf.ttabla
            set estado_reg = 'inactivo'
            where id_tabla=v_parametros.id_tabla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_parametros.id_tabla::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'WF_EJSCTABLA_PRO'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:39:40
	***********************************/

	elsif(p_transaccion='WF_EJSCTABLA_PRO')then

		begin
        	
        	v_col_ejecutadas = 0;
    		v_ejecuta_tabla = 0;
    		v_ejecuta_script = 0;
            
        	--Obtener esquema, datos de tabla            
            select lower(s.codigo) as esquema, t.*,tp.codigo as codigo_proceso
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = v_parametros.id_tabla;
            
            /*v_respuesta = wf.f_registra_gui_tabla(v_tabla.codigo_proceso,v_tabla.menu_nombre, NULL, NULL);
            
            for v_registros in (select *
            					from wf.ttipo_estado  te
                                where te.id_tipo_proceso = v_tabla.id_tipo_proceso and te.fin='no') loop
            
            	v_respuesta = wf.f_registra_gui_tabla(v_tabla.codigo_proceso,v_tabla.menu_nombre, v_registros.codigo,v_registros.nombre_estado);	
            end loop;*/
            
            if (v_tabla.ejecutado = 'no')then
            
            	--Crear Tabla
                v_query = 'CREATE TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' (' ||
                            'id_' || v_tabla.bd_nombre_tabla || ' SERIAL NOT NULL,
                            PRIMARY KEY (id_' || v_tabla.bd_nombre_tabla || ')) INHERITS (pxp.tbase);';
                
                execute (v_query);
                update wf.ttabla set ejecutado = 'si' where id_tabla = v_parametros.id_tabla;
                
                v_ejecuta_tabla = 1;
                
                if (v_tabla.vista_tipo != 'maestro') then
                	--obtener nombre_tabla_maestro
                    SELECT t.bd_nombre_tabla into v_nombre_tabla_maestro
                    from wf.ttabla t
                    where t.id_tabla = v_tabla.vista_id_tabla_maestro;
                     
                    --anadiendo el maestro en la tabla
                    v_query = '	ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '
                                ADD COLUMN ' || v_tabla.vista_campo_maestro || ' INTEGER NOT NULL;';
                    execute (v_query);
                    v_query = 'ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' ADD CONSTRAINT fk_' || v_tabla.bd_nombre_tabla || '__' || v_tabla.vista_campo_maestro || ' FOREIGN
 								KEY( ' || v_tabla.vista_campo_maestro || ') REFERENCES ' || v_tabla.esquema || '.t' ||v_nombre_tabla_maestro || '( ' || v_tabla.vista_campo_maestro || ')';
                    
                    execute (v_query);
                ELSE
                	v_query = '	ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '
                                ADD COLUMN id_estado_wf INTEGER NOT NULL,
	  							ADD COLUMN id_proceso_wf INTEGER NOT NULL,  
                                ADD COLUMN estado VARCHAR(50) NOT NULL;';
                    execute (v_query);
                    
                    v_query = 'ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' ADD CONSTRAINT fk_' || v_tabla.bd_nombre_tabla || '__id_estado_wf FOREIGN
 								KEY(id_estado_wf) REFERENCES wf.testado_wf( id_estado_wf)';
                    
                    execute (v_query);
                    
                    v_query = 'ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || ' ADD CONSTRAINT fk_' || v_tabla.bd_nombre_tabla || '__id_proceso_wf FOREIGN
 								KEY(id_proceso_wf) REFERENCES wf.tproceso_wf( id_proceso_wf)';
                    
                    execute (v_query);
                    
                end if;
            end if;
                     
			-- Crear Columnas
            for v_columnas in (	select * from wf.ttipo_columna 
            					where id_tabla = v_parametros.id_tabla and ejecutado = 'no') loop
            	v_tamano = '';
                if (v_columnas.bd_tamano_columna is not null and v_columnas.bd_tamano_columna != '') then
                	v_tamano = '(' || replace(v_columnas.bd_tamano_columna, '_', ',') || ')';
                end if;
                v_query = '	ALTER TABLE ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '
  							ADD COLUMN ' || v_columnas.bd_nombre_columna || ' ' || v_columnas.bd_tipo_columna || v_tamano || ';';
                             
                execute (v_query);            
                update wf.ttipo_columna set ejecutado = 'si' where id_tipo_columna = v_columnas.id_tipo_columna;
                
                v_col_ejecutadas = v_col_ejecutadas + 1;
            end loop;              
            
            --Ejecutar Scripts Adicionales
            if (v_tabla.script_ejecutado = 'no' and (
            			v_tabla.bd_scripts_extras is not null and trim(both ' ' from v_tabla.bd_scripts_extras) != '') )then 
                        
            	execute (v_tabla.bd_scripts_extras);
                
                update wf.ttabla set script_ejecutado = 'si' where id_tabla = v_parametros.id_tabla;
                v_ejecuta_script = 1;
            end if;
            
            if (v_ejecuta_script = 0 and v_col_ejecutadas = 0 and v_ejecuta_tabla = 0) then
            	raise exception 'No hay ningun script, tabla o columna para ejecutar. En caso de querer adicionar scripts, guardelos en el campo de texto y ejecutelos directamente en la base de datos';
            end if;            
            
            if (v_ejecuta_script = 1) then
            	v_mensaje =  'Se han creado la tabla correctamente';
            ELSE
            	v_mensaje = 'No se ha creado la tabla, debido a que ya se encontraba creada. ';
            end if;
            
            v_mensaje =  v_mensaje || 'Se han creado ' || v_col_ejecutadas || ' columnas en al tabla. ' ;        
                       
            if (v_ejecuta_script = 1) then
            	v_mensaje =  v_mensaje || 'Se han ejecutado los scripts adicionales.';
            ELSE
            	v_mensaje = v_mensaje || 'No se han ejecutado los scripts adicionales, debido a que ya fueron ejecutados.';
            end if;                      
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje',v_mensaje); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla',v_parametros.id_tabla::varchar);
              
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
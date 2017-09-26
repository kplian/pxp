--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_intermediario_ime (
  par_id_usuario integer,
  par_id_usuario_ai integer,
  par_nom_usuario_ai varchar,
  par_sid_web varchar,
  par_pid_web integer,
  par_ip varchar,
  par_mac macaddr,
  par_procedimiento varchar,
  par_transaccion varchar,
  par_id_categoria integer,
  es_matriz varchar,
  ip_admin varchar [],
  variables varchar [],
  valores varchar [],
  tipos varchar [],
  par_consulta varchar,
  par_files bytea,
  variable_files varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_intermediario_ime
 DESCRIPCIÃ“N: 	Recibe las peticiones del servidor web y las encamina 
  				hacia el procedimiento almacenado correspondiente
 AUTOR: 		KPLIAN(jrr)
 FECHA:			26/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:
 DESCRIPCION:	Revison y documentacion
 AUTOR:			 KPLIAN(rac)
 FECHA:			 26-11-10
***************************************************************************
 DESCRIPCION:	Valida si el usuario tiene permiso para ejecutar la transaccion
 AUTOR:			 KPLIAN(rac)
 FECHA:			 29-11-10
***************************************************************************
 DESCRIPCION:	Agregar array de direcciones IP para uso administrativo
 AUTOR:			 KPLIAN(rac)
 FECHA:			 25-12-10
**************************************************************************
DESCRIPCION:	Cuando campo tipo date viene vacio lo convierte en null
 AUTOR:			 KPLIAN(rac)
 FECHA:			 12/09/2011
***************************************************************************
DESCRIPCION:	Se introduce funcion  f_get_id_usuario  para aginarle persmisos de ejecucion
				del dueño de la funciona para no asginar permisos directos sobre la tabal
                tusuario por motivos de seguridad
 AUTOR:			 KPLIAN(rac)
 FECHA:			 29/02/2012
***************************************************************************
 */


DECLARE
 
    v_consulta          varchar;
    v_secuencia         integer;
    v_tamano            integer;
    v_retorno           varchar;
    v_mensaje           text;
    v_nombre_funcion    text;
    v_id_log       		integer;
    v_administrador     integer;
    v_valores_array     varchar[];
    v_tamano_matriz     integer;
    v_linea             varchar;
    v_resp				varchar;
    v_tiene_permisos    boolean;
    v_habilitar_log     integer;
    v_administrador_bool boolean;
    v_hora_ini          timestamp;
    v_hora_fin          timestamp;
    v_nivel_error        integer;
    v_tipo_error        varchar;
    v_id_usuario        integer;
    v_id_subsistema     integer;
    v_resp_error        record;
    v_upload_file        boolean;
    v_uf_count integer;
    v_id_subsistema_cade	varchar;
    v_cadena_log		varchar;
    
    --1 tipo: ERROR|EXITO
    --2 codigo_error: P0001
    --3 procedimientos: funciones
    --4 id_log
    --5 mensaje
    --6 ...
    --7 ..
    
    
    --TODO: falta concatenar procedimientos y eliminar los codigos de procedimientos

BEGIN
	
    v_nombre_funcion:='pxp.f_intermediario_ime';
    v_nivel_error=2;
    v_hora_ini = clock_timestamp();
    
    SET datestyle = "ISO, DMY";
    v_linea=null;
    v_secuencia:=(nextval('pxp.parametro'));
    v_resp=pxp.f_runtime_config('LOG_STATEMENT','LOCAL','none');
    
    v_resp_error=pxp.f_ejecutar_dblink('('||pg_backend_pid()::varchar||',
            '''||par_sid_web||''','||par_pid_web||','''||par_transaccion||''','''||par_procedimiento||''')'
            ,'sesion');
       
    if(par_transaccion='SEG_VALUSU_SEG' or par_transaccion='SEG_LISTUSU_SEG')then
       v_id_usuario:= segu.f_get_id_usuario(valores[6]::varchar);
    else
        v_id_usuario=par_id_usuario;
    end if;
    
    
   
    
    --1) verifica si es administrador, si tiene permisos y si habilita el log
       v_administrador = 0;
       
       v_nivel_error=0;
       v_resp=pxp.f_validar_bloqueos(v_id_usuario,par_ip);
       v_nivel_error=1;
      SELECT po_administrador,po_habilitar_log,po_tiene_permisos,po_id_subsistema
           into v_administrador_bool,v_habilitar_log,v_tiene_permisos,v_id_subsistema
       FROM pxp.f_verifica_permisos(par_id_usuario, par_transaccion, ''::varchar,ip_admin,par_ip::varchar);
       v_nivel_error=2;
      if(v_administrador_bool) THEN
        v_administrador = 1;
      END IF;
          
    -- 2) crea una tabla temportal con los parametros, valores y tipo de datos 
    -- 	  que seran direcciionado al procedimiento almacenado 
    --    concatena con el numero de secuencia para generar nombre de tabla unicos

    v_consulta:='create temporary table tt_parametros_'||v_secuencia||'(';
    v_tamano:=array_upper(tipos,1);
             --   raise exception 'aa%',variable_files;          

    for i in 1..(v_tamano-1) loop
        v_consulta:=v_consulta || variables[i] || ' ' || tipos[i] || ',';
    end loop;
      
    --verifica si recibe archivos tipo bytea
    if( variable_files !='') THEN
      v_upload_file=true;
      v_consulta:=v_consulta || variables[v_tamano] || ' ' || tipos[v_tamano] || ','||variable_files||' bytea) on commit drop';
    ELSE
    v_upload_file=false;
      v_consulta:=v_consulta || variables[v_tamano] || ' ' || tipos[v_tamano] || ') on commit drop';
    END IF;
  
   
    
    execute(v_consulta);
    
        
    
	-- 3) IF verifica si los resultados a ser enviados deben estar en formato de matriz o no
    --    Si no es formato de matriz es una llamada sencilla con un unico regisotr en la tabla temporal
    if(es_matriz='no') then
         
        -- 3.1)  prepara una cadena con un insert para la tabla temporal con los valores recibidos
        v_consulta:='insert into tt_parametros_'||v_secuencia||' values(';

        -- 3.2) FOR  recorre el array de  valores armando la cadena de insercion 
        
        for i in 1..(v_tamano-1) loop
            -- 3.2.1)IF si los valores son del tipo numeric o integer los espacios se insertan con valores nulos
            IF lower(tipos[i]) in ('numeric','integer','int4', 'int8', 'bigint' ) then
                if(valores[i]='')THEN
                    v_consulta:=v_consulta || 'null' || ',';
                else
                    v_consulta:=v_consulta || valores[i] || ',';
                end if;
            ELSE
                --RAC 12/09/2011 validacion para campo date vacio 
                if ((lower(tipos[i]) in ('date','timestamp','time','bool','boolean')) and  valores[i]='')THEN
                    v_consulta:=v_consulta || 'null' || ',';
                else
                   v_consulta:=v_consulta ||''''|| replace(valores[i],'''','''''') || ''',';
                end if;
            

            END IF;

        end loop; -- END FOOR 3.2)
        
        --   raise exception 'cons%',v_consulta;
         -- 3.3) introduce el final de la cadena de insercion
         
 
        
         --encode(par_files,'escape')
        if  lower(tipos[v_tamano]) in ('numeric' ,'integer' ,'int4' ,'int8','bigint') then
            
             if(v_upload_file)THEN
                 if(valores[v_tamano]='')THEN
               
                     v_consulta:=v_consulta || 'null' || ','''||par_files||'''::bytea)';
                      
                else
                    v_consulta:=v_consulta || valores[v_tamano]|| ','''||par_files||'''::bytea)';
                end if;
             
             ELSE
                  
                if(valores[v_tamano]='')THEN
                    v_consulta:=v_consulta || 'null' || ')';
                else
                    v_consulta:=v_consulta || valores[v_tamano] || ')';
                end if;
            END IF;
        
        else
           --RAC 12/09/2011 validacion para campo date vacio 
           if(v_upload_file)THEN
              if( (lower(tipos[v_tamano]) in ('date' ,'timestamp','time','bool','boolean')) and  valores[v_tamano]='')THEN
                  v_consulta:=v_consulta || 'null' || ','''||par_files||'''::bytea)';
              else
                 v_consulta:=v_consulta ||''''|| valores[v_tamano] || ''','''||par_files||'''::bytea)';
              end if;
           
           ELSE
              if((lower(tipos[v_tamano]) in ('date' ,'timestamp','time','bool','boolean')) and  valores[v_tamano]='')THEN
                  v_consulta:=v_consulta || 'null' || ')';
              else
                v_consulta:=v_consulta ||''''|| replace(valores[v_tamano],'''','''''') ||  ''')';
              end if;
            
           END IF;
        
        end if;
      -- 3.4  Ejecuta la cadena de insercion  en la tabla temporal con los datos recibidos del servidor
    
        execute v_consulta;
        
       --3.5) Arma en una cadena  la llamada al  procedimiento almacenado destino, le envia
       --     como parametro el nombre de la tabla temporal, el id_usuario,si es administrador 
       --     y la transaccion que se quiere ejecutar   

        v_consulta:='select ' || par_procedimiento || '('||v_administrador||','||coalesce(par_id_usuario,0)||',''tt_parametros_'||v_secuencia||''','''||par_transaccion||''')';
       
   
        -- 3.6)ejecuta la cadena de llamada al procedimiento almacenado el valor de respuesta lo introduce
        --     en la variable tipo varchar v_retorno en formato JSON (o XML)
        execute v_consulta into v_retorno;
        
    
      -- 4) ELSE Si  es formato de matriz,   un for recorre la misma haciendo por cada vuelta
      --  un llamada al procedimiento almacenado con esto logramamos,  por ejemplo varias inserciones en una misma tabla
      -- y dentro de una misma transaccion, si tenemos algun error se corre un rollback para todo 
    else
    
    
          
    
     
        --4.1) calcula el tamano de la matriz
        v_tamano_matriz:=array_upper(valores,1);
        
        --4.2) recorre las filas de la matriz 
       for j in 1..(v_tamano_matriz) loop
            -- 4.2.1) prepara una cadena de insercion para la tabla temporal
            
            v_consulta='insert into tt_parametros_'||v_secuencia||' values(';
            
            --4.2.2)  FOR  recorre el array  de  valores (para la fila [j] de la matriz) armando la cadena de insercion con 
                  --  los valores  correpondientes a la fila [j]
        
          for i in 1..(v_tamano-1) loop
            
                --4.2.2.1) botiene el numero de fila por si acaso ocurriera un error tenerla identificada
                if(variables[i]='_fila')then
                    v_linea='Ocurrido en la linea # '||valores[j][i];
                end if;
                
               -- 4.2.2.2)IF si los valores son del tipo numeric o integer los espacios se insertan con valores nulos
                 
                if(lower(tipos[i]) in ('numeric','integer','int4','int8'))then
                    if(valores[j][i]='')THEN
                        v_consulta:=v_consulta || 'null' || ',';
                    else
                        v_consulta:=v_consulta || valores[j][i] || ',';
                    end if;
                ELSE
                
                --RAC 12/09/2011 validacion para campo date vacio 
                  if((lower(tipos[i]) in ('date','timestamp','time')) and  valores[j][i]='')THEN
                       v_consulta:=v_consulta || 'null' || ',';
                  else
                    v_consulta:=v_consulta ||''''|| valores[j][i] || ''',';
                  end if;
                
                
                    
                end if;

            end loop;
            
            --4.2.3) inserta el ultimo valor en la cadena de insercion para la tabla temporal

            if(lower(tipos[v_tamano]) in ('numeric','integer','int4','int8'))then
                if(valores[j][v_tamano]='')THEN
                    v_consulta:=v_consulta || 'null' || ')';
                else
                    v_consulta:=v_consulta || valores[j][v_tamano] || ')';
                end if;

            ELSE
            
                --RAC 12/09/2011 validacion para campo date vacio 
                  if((lower(tipos[v_tamano]) in ('date','timestamp','time')) and  valores[j][v_tamano]='')THEN
                      v_consulta:=v_consulta || 'null' || ')';
                  else
                    v_consulta:=v_consulta ||''''|| valores[j][v_tamano] || ''')';
                  end if;
                
            end if;
          
            
          -- 4.2.4  Ejecuta la cadena de insercion  en la tabla temporal con los datos recibidos del servidor

      
            execute v_consulta;
        
           --4.2.5) Arma en una cadena  la llamada al  procedimiento almacenado destino, le envia
           --     como parametro el nombre de la tabla temporal, el id_usuario,si es administrador 
           --     y la transaccion que se quiere ejecutar   
      
            v_consulta:='select ' || par_procedimiento || '('||v_administrador||','||coalesce(par_id_usuario,0)||',''tt_parametros_'||v_secuencia||''','''||par_transaccion||''')';

     
          -- 4.2.6) ejecuta la cadena de llamada al procedimiento almacenado el valor de respuesta lo introduce
          --     en la variable tipo varchar v_retorno en formato JSON (o XML)
            
              v_consulta:='select ' || par_procedimiento || '('||v_administrador||','||coalesce(par_id_usuario,0)||',''tt_parametros_'||v_secuencia||''','''||par_transaccion||''')';

            execute v_consulta into v_retorno;
          -- 4.2.7) vacia la tabla temporal para prepararla para la proxima fila de la matriz  
            execute('truncate table tt_parametros_'||v_secuencia);
            
            
        end loop; -- END FOR 4.2.2)
        
        
    end if;
    
    
    --Procesamiento de la respuesta de la funcion ejecutada
    --rcm
    
    
    --5) REgistra en LOG las trasacciones ejecutadas como exitosas
    
    v_id_log=0;
 
    
 
        
        
      v_hora_fin=clock_timestamp();
      v_id_log:=pxp.f_registrar_log(par_id_usuario,
    							par_ip,
                                par_mac::varchar,
                                'LOG_TRANSACCION',
                                pxp.f_obtiene_clave_valor(v_retorno,'mensaje','','','valor')::text,
                                par_procedimiento,
                                par_transaccion,
                                par_consulta,
                                to_char((v_hora_fin-v_hora_ini),'MS')::integer,
                                getpgusername()::varchar,
                                NULL,
                                pg_backend_pid(),
                                par_sid_web,
                                par_pid_web,
                                v_id_subsistema,
                                v_habilitar_log,
                                par_id_usuario_ai,
                                par_nom_usuario_ai);
                                
                                                               
 
 
    v_resp='';
    v_resp = pxp.f_agrega_clave(v_resp,'tipo_respuesta','EXITO');
    v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
    v_resp = pxp.f_agrega_clave(v_resp,'id_log',v_id_log::varchar);
    
    v_resp = pxp.f_agrega_clave_multiple(v_resp,v_retorno);
    
    v_resp =  replace(v_resp,'\#*#','''');
    v_resp =  replace(v_resp,'#*#','\"');
   
    return pxp.f_resp_to_json(v_resp);

EXCEPTION
	WHEN OTHERS THEN
    
			v_resp='';
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp,'tipo_respuesta','ERROR'::varchar);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
  		
        v_tipo_error='ERROR_TRANSACCION_BD';
         
        --RAC 07/09/2013 para escapar comillas simples en el registro de  log
         v_retorno:=replace(par_consulta,'''','''''');
        
         if(v_nivel_error=0)then
            v_tipo_error='ERROR_BLOQUEO';
         elsif(v_nivel_error=1)then
            v_tipo_error='ERROR_PERMISOS';
         elsif(par_transaccion='SEG_VALUSU_SEG')then
            v_tipo_error='ERROR_ACCESO';
         elsif (SQLSTATE='P0001')THEN
            v_tipo_error='ERROR_CONTROLADO_BD';
         end if;
        --Registro en el log
        
        if(v_id_subsistema is null)then
            v_id_subsistema_cade='null';
         else
            v_id_subsistema_cade=v_id_subsistema::varchar;
         end if;

         v_cadena_log='('||
         		coalesce(v_id_usuario,0)||',''' ||
                par_ip::varchar||''','''||
             	par_mac::varchar||''','''||
             	v_tipo_error ||''','''||
                pxp.f_obtiene_clave_valor(v_resp,'mensaje','','','valor')||''','''||
             	pxp.f_obtiene_clave_valor(v_resp,'procedimientos','','','valor')||''','''||
                par_transaccion||''','''||
                coalesce (v_retorno,' ')||''',NULL,''' ||
                getpgusername()||''','''||
                SQLSTATE||''','||
                pg_backend_pid()||','''||
                par_sid_web||''','||
                par_pid_web||','||
                v_id_subsistema_cade||
                ',1)';

		--RCM 31/01/2012: Cuando la llamada a esta funcion devuelve error, el manejador de excepciones de esa función da el resultado,
        --por lo que se modifica para que devuelva un json direcamente
         v_resp_error=pxp.f_ejecutar_dblink(v_cadena_log,'log');
                
         v_resp = pxp.f_agrega_clave(v_resp,'id_log',v_resp_error.id_log::varchar);
           
              
  		return pxp.f_resp_to_json(v_resp);
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
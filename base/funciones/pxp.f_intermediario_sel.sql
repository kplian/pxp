--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_intermediario_sel (
  par_id_usuario integer,
  par_id_usuario_ai integer,
  par_nom_usuario varchar,
  par_sid_web varchar,
  par_pid_web integer,
  par_ip varchar,
  par_mac macaddr,
  par_procedimiento varchar,
  par_transaccion varchar,
  par_id_categoria integer,
  ip_admin varchar [],
  variables varchar [],
  valores varchar [],
  tipos varchar [],
  par_permiso boolean,
  tipo_retorno varchar = 'varchar'::character varying,
  datos_retorno varchar = NULL::character varying
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 FUNCION: 		pxp.f_intermediario_sel
 DESCRIPCIÓN: 	Recibe las peticiones del servidor web y las encamina 
  				hacia el procedimiento almacenado correspondiente
 AUTOR: 		KPLIAN (jrr)
 FECHA:			26/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	Revison y documentacion
 AUTOR:			 KPLIAN (rac)
 FECHA:			 26-11-10
***************************************************************************
 DESCRIPCION:	Valida si el usuario tiene permiso para ejecutar la transaccion
 AUTOR:			 KPLIAN (rac)
 FECHA:			 29-11-10
****************************************************************************
 DESCRIPCION:	Agregar array de direcciones IP para uso administrativo
 AUTOR:			 KPLIAN (rac)
 FECHA:			 25-12-10
 ****************************************************************************
 DESCRIPCION:	Aumenta variable tipo retorno para definir se 
 				la funcion regresa su resultado como consulta o como record
                los record se utilizan cuando tenemos tablas temporales
 AUTOR:			 KPLIAN (rac)
 FECHA:			 19-03-12
***************************************************************************/

DECLARE
 
v_consulta    varchar;
v_secuencia   integer;
v_tamano      integer;
v_retorno     varchar;
v_mensaje    text;
v_mensaje_log   varchar;
v_nombre_funcion    text;
v_administrador     integer;

v_id_log integer;
v_resp_error record;
v_administrador_bool boolean;
v_tiene_permisos    boolean;
v_habilitar_log     integer;
v_database          varchar;
v_resp				varchar;
v_hora_ini          timestamp;
v_hora_fin          timestamp;
v_nivel_error    integer;
v_tipo_error        varchar;
v_id_subsistema     integer;
v_id_subsistema_cade varchar;
v_cadena_log        varchar;
v_retorno_record record;
v_exception_detail			varchar;
v_exception_context			varchar;



BEGIN
	
    v_nombre_funcion:='pxp.f_intermediario_sel';
    v_resp=pxp.f_runtime_config('LOG_STATEMENT','LOCAL','none');
    v_nivel_error=2;
    v_hora_ini = clock_timestamp();
    raise notice 'ini:%',v_hora_ini;
    v_retorno='';    
        	
    v_resp_error=pxp.f_ejecutar_dblink('('||pg_backend_pid()::varchar||',
            '''||par_sid_web||''','||par_pid_web||','''||par_transaccion||''','''||par_procedimiento||''')'
            ,'sesion');
    
    
    --1) verifica si es administrador, si tiene permisos y si habilita el log
       
       
       v_administrador = 0;
       v_nivel_error=0;
       v_resp=pxp.f_validar_bloqueos(par_id_usuario,par_ip);
       v_nivel_error=1;
       SELECT po_administrador,po_habilitar_log,po_tiene_permisos,po_id_subsistema
           into v_administrador_bool,v_habilitar_log,v_tiene_permisos,v_id_subsistema
       FROM pxp.f_verifica_permisos( par_id_usuario, par_transaccion, ''::varchar,ip_admin,par_ip::varchar, par_permiso);
       v_nivel_error=2;
       --raise exception 'permisos ->  %,%,%,%',v_tiene_permisos,v_habilitar_log,v_administrador_bool,v_id_subsistema;
    
     
      if(v_administrador_bool) THEN
        v_administrador = 1;
      END IF;
       
       
      
    
       
    v_secuencia:=(nextval('pxp.parametro'));
    
    v_consulta:='create temporary table tt_parametros_'||v_secuencia||'(';
    v_tamano:=array_upper(variables,1);
    for i in 1..(v_tamano-1) loop
        v_consulta:=v_consulta || variables[i] || ' ' || tipos[i] || ',';

    end loop;
     
    v_consulta:=v_consulta || variables[v_tamano] || ' ' || tipos[v_tamano] || ') on commit drop';
    
    execute(v_consulta);
    
    
    v_consulta:='insert into tt_parametros_'||v_secuencia||' values(';
    
    for i in 1..(v_tamano-1) loop
          tipos[i] = lower(tipos[i]); 
         IF(lower(tipos[i]) in ('numeric' ,'integer','int4','int8','bigint'))then
            if(valores[i]='')then
                v_consulta:=v_consulta || 'null' || ',';
            else
                v_consulta:=v_consulta || valores[i] || ',';
            end if;
        ELSE
           
            --RAC 12/09/2011 validacion para campo date vacio 
            if((lower(tipos[i]) in  ('date','timestamp','time','bool','boolean')) and  valores[i]='')THEN
                     v_consulta:=v_consulta || 'null' || ',';
            else
                  
                v_consulta:=v_consulta ||''''|| replace(valores[i],'''','''''') || ''',';
            end if;
            
            
            
        end if;

    end loop;

      IF(lower(tipos[v_tamano]) in ('numeric','integer','int4','int8','bigint'))then
        if(valores[v_tamano]='')then
            v_consulta:=v_consulta || 'null'|| ')';
        else
            v_consulta:=v_consulta || valores[v_tamano] || ')';
        end if;
   
     ELSE
     
     --RAC 12/09/2011 validacion para campo date vacio 
            if((lower(tipos[v_tamano]) in ('date','timestamp','time','bool','boolean')) and  valores[v_tamano]='')THEN
                 v_consulta:=v_consulta || 'null' || ')';
            else
                  v_consulta:=v_consulta ||''''|| replace(valores[v_tamano],'''','''''') || ''')';
            end if;
     
    
    end if;
   
    execute v_consulta;
    
  
     
     v_id_log=0;
   
  	
     v_mensaje:=pxp.f_get_mensaje_exi('Exito en la consulta',v_nombre_funcion,par_transaccion);
    
   /*
   RAC 19032012
   aumentamos el tipo de dato de retorno
   para poder ejecutar consultar que retornan un tipo record
   */ 
    
   
   if(tipo_retorno='varchar')THEN
   
     v_consulta:='select ' || par_procedimiento || '('||v_administrador||','||coalesce(par_id_usuario,0)||',''tt_parametros_'||v_secuencia||''','''||par_transaccion||''')';
    
    --raise notice 'prueba:%',v_consulta;
    execute v_consulta into v_retorno;
    
    
    --RAC  >>>> OJO me parece que este registro de LOG nunca se EJECUTA
    v_hora_fin=clock_timestamp();
    --raise exception 'gfdsgfsd: %',v_habilitar_log;
        v_id_log:=pxp.f_registrar_log(par_id_usuario,
    							par_ip,
                                par_mac::varchar,
                                'LOG_TRANSACCION',
                                v_mensaje,
                                par_procedimiento,
                                par_transaccion,
                                v_retorno,
                                to_char((v_hora_fin-v_hora_ini),'MS')::integer,
                                getpgusername()::varchar,
                                NULL,
                                pg_backend_pid(),
                                par_sid_web,
                                par_pid_web,
                                v_id_subsistema,
                                v_habilitar_log,
                                par_id_usuario_ai,
                                par_nom_usuario
                                );
                                
                                
     return query execute (v_retorno);                          
                                
     ELSE
     
     --en caso que el tipo de retorno sea un record
     v_consulta:='select * from ' || par_procedimiento || '('||v_administrador||','||coalesce(par_id_usuario,0)||',''tt_parametros_'||v_secuencia||''','''||par_transaccion||''') '||datos_retorno;
    
     
     
      for v_retorno_record in execute (v_consulta) LOOP
          RETURN NEXT v_retorno_record;
      END LOOP;
     
    
     END IF;


    EXCEPTION

       WHEN OTHERS THEN
       
        v_resp='';
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp,'tipo_respuesta','ERROR'::varchar);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);

        
         v_retorno:=replace(v_retorno,'''','''''');
         
         v_tipo_error='ERROR_TRANSACCION_BD';
         if(v_nivel_error=0)then
            v_tipo_error='ERROR_BLOQUEO';
         elsif(v_nivel_error=1)then
            v_tipo_error='ERROR_PERMISOS';
         elsif (SQLSTATE='P0001')THEN
            v_tipo_error='ERROR_CONTROLADO_BD';
         end if;
         
         if(v_id_subsistema is null)then
            v_id_subsistema_cade='null';
         else
            v_id_subsistema_cade=v_id_subsistema::varchar;
         end if;

         v_cadena_log='('||
         		coalesce(par_id_usuario,0)||',''' ||
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
         


         raise exception '%',pxp.f_resp_to_json(v_resp);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;
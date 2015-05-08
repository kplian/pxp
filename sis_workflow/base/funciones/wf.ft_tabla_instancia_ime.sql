CREATE OR REPLACE FUNCTION wf.ft_tabla_instancia_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Work Flow
 FUNCION:       wf.ft_tabla_instancia_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla autogenerada del workflow
 AUTOR:          (admin)
 FECHA:         07-05-2014 21:39:40
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:         
 FECHA:     
***************************************************************************/

DECLARE

    v_nro_requerimiento     integer;
    v_parametros            json;
    v_id_requerimiento      integer;
    v_resp                  varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;   
    v_tabla                 record;
    v_fields                text;
    v_values                text;
    v_query                 text;
    v_codigo_tipo_proceso   varchar;
    v_id_proceso_macro      integer;
    v_num_tramite           varchar;
    v_id_proceso_wf         integer;
    v_id_estado_wf          integer;
    v_codigo_estado         varchar;
    v_id_gestion            integer;
    v_columnas              record;
    v_id_tabla              integer;
    v_id_tipo_estado        integer;
    v_id_estado_actual      integer;
    v_id_tipo_proceso       integer;
    v_id_tipo_estado_next   integer;
    v_codigo_estado_next    varchar;
    v_resp_doc              boolean;
    v_id_funcionario_usuario    integer;
    v_cadena                varchar;
                
BEGIN

    v_nombre_funcion = 'wf.ft_tabla_instancia_ime';
    v_parametros = pxp.f_get_json(p_tabla);

    /*********************************    
    #TRANSACCION:  'WF_TABLAINS_INS'
    #DESCRIPCION:   Insercion de registros en tabla autogenerada del workflow
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:39:40
    ***********************************/

    if(p_transaccion='WF_TABLAINS_INS')then
                    
        begin
            --RCM: Obtiene el funcionario a partir del usuario que ejecuta la función
            select f.id_funcionario
            into v_id_funcionario_usuario
            from segu.tusuario u
            inner join orga.tfuncionario f 
            on f.id_persona = u.id_persona
            where u.id_usuario = p_id_usuario;

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
           
                select   tp.id_tipo_proceso, tp.codigo, tp.id_proceso_macro 
                    into v_id_tipo_proceso, v_codigo_tipo_proceso, v_id_proceso_macro
                from  wf.ttabla tabla
                inner join wf.ttipo_proceso tp
                    on tabla.id_tipo_proceso =  tp.id_tipo_proceso
                where   tabla.id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer;
                    
                 
                IF v_codigo_tipo_proceso is NULL THEN           
                   raise exception 'No existe un proceso inicial para la tabla (Revise la configuración)';          
                END IF;
                --si existe el nro de tramite entonces
                if (not pxp.f_existe_parametro(p_tabla,'nro_tramite')) then                
             
                       -- iniciar el tramite en el sistema de WF
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
                           v_id_funcionario_usuario,
                           NULL,
                           NULL,
                           ' ');
                else
                    select 
                       te.id_tipo_estado,
                       te.codigo
                     into
                       v_id_tipo_estado_next,
                       v_codigo_estado
                     from wf.ttipo_estado te
                     where te.id_tipo_proceso = v_id_tipo_proceso and te.inicio = 'si' and te.estado_reg = 'activo'; 
                     
                     if v_id_tipo_estado_next is NULL THEN
                           raise exception 'El WF esta mal parametrizado verifique a que tipo_proceso apunto el tipo_estado previo';
                     END IF;
                     
                     -- inserta el proceso con el numero de tramite
                     INSERT INTO 
                      wf.tproceso_wf
                    (
                      id_usuario_reg,
                      fecha_reg,
                      estado_reg,
                      id_tipo_proceso,
                      nro_tramite, 
                      codigo_proceso,
                      id_usuario_ai,
                      usuario_ai
                      
                    ) 
                    VALUES (
                      p_id_usuario,
                      now(),
                      'activo',
                      v_id_tipo_proceso,
                      json_extract_path_text(v_parametros,'nro_tramite')::varchar,                       
                      v_codigo_tipo_proceso,
                      NULL,
                      NULL
                    ) RETURNING id_proceso_wf into v_id_proceso_wf;


      
                    -- inserta el primer estado del proceso 
                       INSERT INTO 
                        wf.testado_wf
                      (
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_estado_anterior,
                        id_tipo_estado,
                        id_proceso_wf,
                        id_funcionario,
                        id_depto,
                        id_usuario_ai,
                        usuario_ai
                      ) 
                      VALUES (
                        p_id_usuario,
                        now(),
                        'activo',
                        NULL,
                        v_id_tipo_estado_next,
                        v_id_proceso_wf,
                        v_id_funcionario_usuario,
                        NULL,
                        NULL,
                        NULL
                      )RETURNING id_estado_wf into v_id_estado_wf;  
      
                       -- inserta documentos en estado borrador si estan configurados
                       v_resp_doc =  wf.f_inserta_documento_wf(p_id_usuario, v_id_proceso_wf, v_id_estado_wf);
                       
                       
                         
                       -- verificar documentos
                       v_resp_doc = wf.f_verifica_documento(p_id_usuario, v_id_estado_wf);
                end if;
            end if;
           
            v_fields = 'insert into ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '(
                            estado_reg,
                            fecha_reg,
                            id_usuario_reg,
                            id_usuario_mod,
                            fecha_mod,';
            if (v_tabla.vista_tipo = 'maestro') then
                v_fields =  v_fields || 'id_estado_wf,
                            id_proceso_wf,
                            estado';
            else
                v_fields =  v_fields || v_tabla.vista_campo_maestro;                            
            end if;
                            
            v_values = 'values(
                        ''activo'',''' ||
                        now()::date || ''',' ||
                        p_id_usuario || ',
                        NULL,
                        NULL,';
            if (v_tabla.vista_tipo = 'maestro') then
                v_values =  v_values ||v_id_estado_wf || ', '||
                        v_id_proceso_wf || ','''||
                        v_codigo_estado || '''';
            else
            /*************/
                v_values =  v_values || json_extract_path_text(v_parametros,v_tabla.vista_campo_maestro);                           
            end if;         

            for v_columnas in ( select tc.* from wf.ttipo_columna tc
                                inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento in ('registrar', 'exigir')
                                inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
                                where id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer and tc.estado_reg = 'activo' and ce.estado_reg = 'activo'
                                and te.codigo = json_extract_path_text(v_parametros,'tipo_estado')::varchar) loop
                    
                v_fields = v_fields || ',' || v_columnas.bd_nombre_columna;
                if (v_columnas.bd_tipo_columna in ('integer', 'bigint', 'boolean', 'numeric')) then
                    v_values = v_values || ',' || coalesce (json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna),'NULL');
                elsif (v_columnas.bd_tipo_columna in ('integer[]', 'bigint[]', 'numeric[]','varchar[]')) then                   
                    --Obtiene el valor del array en una variable temporal, para verificar si es array vacío y mandar null en ese caso
                    
                    v_cadena = 'array[' || coalesce (json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna),'NULL')||']';
                    if v_cadena = 'array[]' then
                        v_values = v_values || ',NULL';
                    else
                        v_values = v_values || ',' || v_cadena;
                    end if;
                    
                else
                    v_values = v_values || ',' || coalesce ('''' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna) || '''','NULL');                    
                end if;
               
            end loop;

            v_fields = v_fields || ')';
            
            v_values = v_values || ') returning id_' || v_tabla.bd_nombre_tabla;
--raise exception 'ddddd:::: % %',v_fields, v_values;
            execute (v_fields || v_values) into v_id_tabla;
                    
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje',v_tabla.bd_nombre_tabla  || ' almacenado(a) con exito (id_'||v_tabla.bd_nombre_tabla || v_id_tabla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_' ||v_tabla.bd_nombre_tabla ,v_id_tabla::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
    #TRANSACCION:  'WF_TABLAINS_UPD'
    #DESCRIPCION:   Modificacion de registros en tabla autogenerada del workflow
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:39:40
    ***********************************/

    elsif(p_transaccion='WF_TABLAINS_MOD')then

        begin

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
                        
            
            v_values = ''; 
            for v_columnas in ( select tc.* from wf.ttipo_columna tc
                                inner join wf.tcolumna_estado ce on ce.id_tipo_columna = tc.id_tipo_columna and ce.momento in ('registrar', 'exigir')
                                inner join wf.ttipo_estado te on ce.id_tipo_estado = te.id_tipo_estado
                                where id_tabla = json_extract_path_text(v_parametros,'id_tabla')::integer and tc.estado_reg = 'activo' and ce.estado_reg = 'activo'
                                and te.codigo = json_extract_path_text(v_parametros,'tipo_estado')::varchar) loop
                
                if (v_columnas.bd_tipo_columna in ('integer', 'bigint', 'boolean', 'numeric')) then
                    v_values = v_values || ',' ||v_columnas.bd_nombre_columna || '=' || coalesce (json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna),'NULL');
                elsif (v_columnas.bd_tipo_columna in ('integer[]', 'bigint[]', 'numeric[]','varchar[]')) then                   
                    
                    v_cadena = 'array[' || coalesce (json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna),'NULL')||']';
                    /*if (v_columnas.bd_nombre_columna = 'id_orden_trabajo') then
                    	raise exception 'llega%',v_cadena;
                    end if;*/
                    if v_cadena = 'array[]' or v_cadena = 'array[[]]' then
                        v_values = v_values || ',' ||v_columnas.bd_nombre_columna || '=NULL';
                    else
                        v_values = v_values || ',' ||v_columnas.bd_nombre_columna || '=' || v_cadena;
                    end if;
                    
                else                    
                    v_values = v_values || ',' ||v_columnas.bd_nombre_columna || '=' || coalesce ('''' || json_extract_path_text(v_parametros,v_columnas.bd_nombre_columna) || '''','NULL');                    
                end if;                 
                --raise notice 'A: %',v_values;
            end loop;
            
            v_query = v_query || v_values|| ' where id_' || v_tabla.bd_nombre_tabla || '=' || json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla);         

            execute (v_query);
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tabla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_' ||v_tabla.bd_nombre_tabla,json_extract_path_text(v_parametros,'id_' ||v_tabla.bd_nombre_tabla)::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
    #TRANSACCION:  'WF_TABLAINS_ELI'
    #DESCRIPCION:   Eliminacion de registros de tabla autogenerada en el sistema de workflow
    #AUTOR:     admin   
    #FECHA:     07-05-2014 21:39:40
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
                 
                 execute (' select id_estado_wf, id_proceso_wf
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
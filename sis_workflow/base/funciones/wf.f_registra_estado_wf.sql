CREATE OR REPLACE FUNCTION wf.f_registra_estado_wf (
  p_id_tipo_estado_siguiente integer,
  p_id_funcionario integer,
  p_id_estado_wf_anterior integer,
  p_id_proceso_wf integer,
  p_id_usuario integer,
  p_id_usuario_ai integer,
  p_usuario_ai varchar,
  p_id_depto integer = NULL::integer,
  p_obs text = ''::text,
  p_acceso_directo varchar = ''::character varying,
  p_clase varchar = NULL::character varying,
  p_parametros varchar = '{}'::character varying,
  p_tipo varchar = 'notificacion'::character varying,
  p_titulo varchar = 'Visto Bueno'::character varying
)
RETURNS integer AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_registra_estado_wf
 DESCRIPCION: 	Devuelve:
 				ID del estado actual o -1 si los parametros introduciodos no son correctos.
				
                Recibe:
 				estado_proceso -> nombre del estado actual
                id_funcionario
                id_estado_wf --> id_estado anterior
                id_proceso_wf --> permite reconocer univocamente un proceso
 AUTOR: 		KPLIAN(FRH)
 FECHA:			26/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:  

 DESCRIPCION:   Se solucionaron varios errores de logica	
 AUTOR:			RAC
 FECHA:			11/03/2013

***************************************************************************/
DECLARE	

    v_nombre_funcion varchar;
    v_resp varchar;

    g_registros			record;   
    v_consulta			varchar;
    v_id_estado_actual	integer;
    v_registros record;
    v_id_tipo_estado integer;
    v_desc_alarma varchar;
    v_id_alarma integer;
    v_alarmas_con integer[];
    v_cont_alarma  integer;
    
    v_registros_ant record;
    v_registros_depto record;
    v_resp_doc boolean;
    
    v_plantilla_correo  varchar;
    v_plantilla_asunto  varchar;
    
    va_id_tipo_estado integer[];
    va_codigo_estado varchar[];
    v_resgistros_prod_dis   record;
    v_sw_error  boolean;
    v_mensaje_error    varchar;
    v_alarma		integer;
    v_documentos	text;
    v_res_validacion	text;
    
    va_id_alarmas  INTEGER[];
    va_verifica_documento 	varchar;
    
    v_i integer;
    v_registros_correo	record;

    --correos con copia y copia oculta
    v_cc	text;
    v_bcc	text;
	
    
BEGIN

     v_nombre_funcion ='f_registra_estado_wf';

   
    select 
    ew.estado_reg,
    ew.id_funcionario,
    ew.id_depto,
    tew.alerta,
    ew.id_depto,
    tew.id_tipo_estado,
    tew.nombre_estado,
    tew.disparador,
    ew.id_estado_wf
    into
    v_registros_ant
    from wf.testado_wf ew
    inner join wf.ttipo_estado tew on tew.id_tipo_estado = ew.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf_anterior;
    
    
    --revisar que el estado se encuentre activo, en caso contrario puede
    --se una orden desde una pantalla desactualizada
    --raise exception '%,%',v_registros_ant.nombre_estado,v_registros_ant.id_estado_wf;
    IF (v_registros_ant.estado_reg !='activo') THEN
       raise exception 'El estado se encuentra inactivo, actualice sus datos' ;
    END IF;

    



   
    v_id_estado_actual = -1;
      
    if( p_id_tipo_estado_siguiente is null 
        OR p_id_estado_wf_anterior is null 
        OR p_id_proceso_wf is null
        )then
    	raise exception 'Faltan parametros, existen parametros nulos o en blanco, para registrar el estado en el WF.';
      
    end if;
    
    --recupera datos del tipo estado siguiente
    
    SELECT 
     te.alerta,
     s.nombre,
     s.codigo,
     s.id_subsistema,
     te.nombre_estado,
     pm.nombre as nombre_proceso_macro,
     te.plantilla_mensaje,
     te.plantilla_mensaje_asunto,
     te.disparador,
     te.cargo_depto,
     te.titulo_alerta,
     te.acceso_directo_alerta,
     te.nombre_clase_alerta,
     te.parametros_ad,
     te.tipo_noti
    INTO
     v_registros
    FROM wf.ttipo_estado te
    inner join wf.ttipo_proceso tp on tp.id_tipo_proceso  = te.id_tipo_proceso
    left join wf.ttipo_documento td on td.id_tipo_proceso = tp.id_tipo_proceso
    inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
    inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema 
    WHERE te.id_tipo_estado = p_id_tipo_estado_siguiente;
    
    -- TODO,  verificar si esta retrocediendo ...
    
    --------------------------------------------------------
    --  VERIFICAR  PROCESOS DISPARDO EN EL CASO DE RETROCEDER
    --------------------------------------------------------
    
       -- OJO  cosideramos que esta funcion es para pasar de uno en uno
       
       --   el estado actual es disparado??
       IF v_registros_ant.disparador = 'si' THEN
           
            -- obtener los tipos del estado padre
             SELECT 
                ps_id_tipo_estado,
                ps_codigo_estado
             into
                va_id_tipo_estado,
                va_codigo_estado 
             FROM wf.f_obtener_cadena_tipos_estados_anteriores_wf(v_registros_ant.id_tipo_estado);
             
             --  si el tipo del estado siguiente se corrsponde con un estado anterior,  diferente del actual,
             --  esta retrocediento
            
             IF      p_id_tipo_estado_siguiente=ANY(va_id_tipo_estado)  
                 and p_id_tipo_estado_siguiente != v_registros_ant.id_tipo_estado THEN
               
                     --  revisamos los  procesos disparados en el estado actual 
               
                     v_sw_error = false;
                     v_mensaje_error='';
                     
                     FOR v_resgistros_prod_dis in (select 
                           ewf.id_estado_wf,
                           te.codigo,
                           te.nombre_estado,
                           tp.nombre
                          FROM wf.tproceso_wf pwf
                          inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                          inner join  wf.testado_wf ewf on ewf.id_proceso_wf = pwf.id_proceso_wf and ewf.estado_reg = 'activo'
                          inner join  wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado 
                          WHERE pwf.id_estado_wf_prev = p_id_estado_wf_anterior AND
                          te.codigo not in ('cancelado','anulado','eliminado','desierto','anulada','cancelada','eliminada','desierta')
                          ) LOOP
                         
                         --  si tiene procesos disparados que no esten en estado:  cancelado o  eliminado o anulado o desierto, 
                         -- marcamos que existe un error
                         v_sw_error = true;
                         
                         IF v_mensaje_error='' THEN
                            v_mensaje_error = v_resgistros_prod_dis.nombre||'('||v_resgistros_prod_dis.codigo||')';
                         ELSE
                            v_mensaje_error = v_mensaje_error||', <br>'||v_resgistros_prod_dis.nombre||'('||v_resgistros_prod_dis.codigo||')';
                         END IF;
                     
                     
                     
                     END LOOP;
                     
                     IF v_sw_error THEN
                       raise exception 'No puede revertir revise los sigueintes procesos anexos:<br>%',v_mensaje_error;
                     END IF;
                   
                 
             END IF ;
        
        END IF;
    
    
    
    IF(v_registros.id_subsistema is NULL ) THEN
    
       raise exception  'El proceso macro no esta relacionado con ningun sistema';
    
    END IF;
    
     --verificamos si requiere manejo de alerta
    if(v_registros.alerta = 'si' and  (p_id_funcionario is not NULL or  p_id_depto is not NULL )) THEN
 			   
           v_desc_alarma =  'Cambio al estado ('||v_registros.nombre_estado||'), con las siguiente observaciones: '||p_obs;
           v_cont_alarma = 1;
           v_plantilla_asunto = p_titulo;
           
            --  si tiene plantilla de correo la procesamos
            IF v_registros.plantilla_mensaje is not null and v_registros.plantilla_mensaje != '' THEN
             
                  v_plantilla_correo =  wf.f_procesar_plantilla(p_id_usuario, p_id_proceso_wf, v_registros.plantilla_mensaje, p_id_tipo_estado_siguiente, p_id_estado_wf_anterior, p_obs,p_id_funcionario);
                  v_plantilla_asunto =  wf.f_procesar_plantilla(p_id_usuario, p_id_proceso_wf, v_registros.plantilla_mensaje_asunto, p_id_tipo_estado_siguiente, p_id_estado_wf_anterior, p_obs,p_id_funcionario);
                  
                  v_desc_alarma = v_plantilla_correo;
           
            END IF;
            
            --si no tenemos acceso directo como parametro p_acceso_directo,  buscamos en la configuracion del tipo estado
            p_titulo = wf.f_procesar_plantilla(p_id_usuario, p_id_proceso_wf, '{DEPTO_PREVIO} {FUNCIONARIO_PREVIO}', p_id_tipo_estado_siguiente, p_id_estado_wf_anterior, p_obs,p_id_funcionario);
                 
           if (p_titulo = ' ') then
              select u.desc_persona into p_titulo 
              from segu.vusuario u 
              where u.id_usuario = p_id_usuario ;
           end if;
            IF p_acceso_directo = '' and  v_registros.acceso_directo_alerta is not NULL and v_registros.acceso_directo_alerta != '' THEN
                 
                 p_acceso_directo = v_registros.acceso_directo_alerta;
                 
                 
                 p_clase = v_registros.nombre_clase_alerta;
                 p_parametros = v_registros.parametros_ad;
                 p_tipo = v_registros.tipo_noti;
                 p_parametros = '{filtro_directo:{campo:"'||v_registros.parametros_ad||'",valor:"'||p_id_proceso_wf::varchar||'"}}';
            
            END IF;
            
            
           
           IF p_id_funcionario is not NULL and (v_registros_ant.id_funcionario is null or v_registros_ant.id_funcionario != p_id_funcionario)  THEN
          
          
                   /*
                        par_id_funcionario :   indica el funcionario para el que se genera la alrma
                        par_descripcion:       una descripcion de la alarma
                        par_acceso_directo:    es el link que lleva a la relacion de la alarma generada
                        par_fecha:             Indica la fecha de vencimiento de la alarma
                        par_tipo:              indica el tipo de alarma, puede ser alarma o notificacion
                        par_obs:               son las observaciones de la alarma
                        par_id_usuario:        integer,   el usuario que registra la alarma
                        
                        par_clase varchar,        clases a ejecutar en interface deacceso directo
                        par_titulo varchar,       titulo de la interface de acceso directo
                        par_parametros varchar,   parametros a mandar a la interface de acceso directo
                        par_id_usuario_alarma integer,dica el usuario para que se cre la alarma (solo si funcionario es NULL)
                        par_titulo_correo varchar,   titulo de correo
                   
                   */
                   
                  v_alarmas_con[v_cont_alarma]:=param.f_inserta_alarma(
                                                      p_id_funcionario,
                                                      v_desc_alarma,    --descripcion alarmce
                                                      p_acceso_directo,--acceso directo
                                                      now()::date,
                                                      p_tipo,
                                                      '',   -->
                                                      p_id_usuario,
                                                      p_clase,
                                                      p_titulo,--titulo
                                                      p_parametros::varchar,
                                                      NULL::integer,
                                                      v_plantilla_asunto
                                                     );
                                                     
                                                      
                   v_cont_alarma = v_cont_alarma +1;
             
              END IF;
              
              
             --manejo de alertas para departamentos
              
               IF (p_id_depto is not NULL and p_id_funcionario is NULL)  THEN
                
                  -- buscamos entre los usarios del depto quien puede recibir alerta
              
                FOR  v_registros_depto in  ( 
                       select  du.id_usuario 
                       from  param.tdepto_usuario du 
                       where du.id_depto = p_id_depto 
                         and du.sw_alerta = 'si'
                         and ( du.cargo=ANY(v_registros.cargo_depto) or v_registros.cargo_depto is NULL or array_to_string(v_registros.cargo_depto, ',') = '' )
                         
                         ) LOOP
                         
                   
                  
                     v_alarmas_con[v_cont_alarma]:=param.f_inserta_alarma(
                                                        NULL,
                                                        v_desc_alarma,
                                                        p_acceso_directo,--acceso directo
                                                        now()::date,
                                                        p_tipo,
                                                        '',
                                                        p_id_usuario,
                                                        p_clase,
                                                        p_titulo,--titulo
                                                        p_parametros::varchar,
                                                        v_registros_depto.id_usuario::integer,
                                                        v_plantilla_asunto
                                                       ); 
             
                     
                    v_cont_alarma = v_cont_alarma +1;
                   
                   END LOOP;
                   
                  
             
             END IF;
             
              
    END IF;
    
    
     
   
    INSERT INTO wf.testado_wf(
     id_estado_anterior, 
     id_tipo_estado, 
     id_proceso_wf, 
     id_funcionario, 
     fecha_reg,
     estado_reg,
     id_usuario_reg,
     id_depto,
     obs,
     id_alarma,
     id_usuario_ai,
     usuario_ai) 
    values(
       p_id_estado_wf_anterior, 
       p_id_tipo_estado_siguiente, 
       p_id_proceso_wf, 
       p_id_funcionario, 
       now(),
       'activo',
       p_id_usuario,
       p_id_depto,
       p_obs,
       v_alarmas_con,
       p_id_usuario_ai,
       p_usuario_ai) 
    RETURNING id_estado_wf INTO v_id_estado_actual;  
    
    
    --inserta log de estado en el proceso_wf
    update wf.tproceso_wf SET
    id_tipo_estado_wfs =  array_append(id_tipo_estado_wfs, p_id_tipo_estado_siguiente)
    where id_proceso_wf = p_id_proceso_wf;
    
    
    
    --recuperar  alarmas del estado anterior
    
    select 
     ew.id_alarma
    into
     va_id_alarmas
    from wf.testado_wf ew 
    where ew.id_estado_wf = p_id_estado_wf_anterior;
    
    --eliminar alarmas del estado anterior
    
    IF va_id_alarmas is not null THEN
     	 
    
      FOR v_i IN 1 .. array_upper(va_id_alarmas, 1)
      LOOP
        
           delete  from param.talarma  a where a.id_alarma = va_id_alarmas[v_i]; 
      
      END LOOP;
      
    
    END IF;
    
            
    UPDATE wf.testado_wf 
    SET estado_reg = 'inactivo'
    WHERE id_estado_wf = p_id_estado_wf_anterior;
    
    select 
     ew.verifica_documento
    into
     va_verifica_documento
    from wf.testado_wf ew 
    where ew.id_estado_wf = p_id_estado_wf_anterior;
    
    /*Se registra las alarmas que se encuentran en plantilla correo que cumplan con la regla*/
             
     for v_registros_correo in (select pc.*,sub.nombre as nombre_subsistema,sub.codigo as codigo_subsistema 
             					from wf.tplantilla_correo pc
                                inner join wf.ttipo_estado te
                                	on te.id_tipo_estado = pc.id_tipo_estado
                                inner join wf.ttipo_proceso tp
                                	on tp.id_tipo_proceso = te.id_tipo_proceso
                                inner join wf.tproceso_macro pm
                                	on tp.id_proceso_macro = pm.id_proceso_macro
                                inner join segu.tsubsistema sub
                                	on pm.id_subsistema = sub.id_subsistema                                 
             					 where pc.id_tipo_estado = p_id_tipo_estado_siguiente and pc.estado_reg = 'activo') loop
             	
                if (wf.f_evaluar_regla_wf(p_id_usuario,p_id_proceso_wf,v_registros_correo.regla,
                		p_id_tipo_estado_siguiente,v_registros_ant.id_tipo_estado)) then	
                    
                    if (v_registros_correo.plantilla is not null and v_registros_correo.plantilla != '') then
                        v_desc_alarma = wf.f_procesar_plantilla(p_id_usuario, p_id_proceso_wf, v_registros_correo.plantilla, p_id_tipo_estado_siguiente, p_id_estado_wf_anterior, p_obs,p_id_funcionario);
                    end if;
                    /*Se obtiene los documentos a colocar como adjuntos en el siguiente formato:
                    	url|id_proceso_wf,url,url,url|id_proceso_wf
                      Donde las comas separan las urls de los documentos y un documento generado ademas de la url contiene el id_proceso_wf separado por |
                    */
                    select pxp.list((case when td.tipo = 'escaneado' then
                                            dwf.url || '|' ||td.codigo || '.' || dwf.extension
                                            else
                                            td.action || '|' || dwf.id_proceso_wf || '|' ||td.nombre || '.pdf'
                                            end)::varchar) into v_documentos
                                    from wf.tdocumento_wf dwf 
                                    inner join wf.ttipo_documento td 
                                    on dwf.id_tipo_documento = td.id_tipo_documento
                                    where dwf.id_proceso_wf = p_id_proceso_wf and td.id_tipo_documento = ANY(v_registros_correo.documentos::int[]) and td.estado_reg = 'activo' and
                                    dwf.estado_reg = 'activo' and ((td.tipo = 'escaneado' and dwf.url is not null and dwf.url != '') or 
                                    td.tipo = 'generado');
                    
                    if (v_registros_correo.asunto is not null) then
                    	v_plantilla_asunto =  wf.f_procesar_plantilla(p_id_usuario, p_id_proceso_wf, v_registros_correo.asunto, p_id_tipo_estado_siguiente, p_id_estado_wf_anterior, p_obs,p_id_funcionario);
                    end if;
                    -- SEGMENTO QUE ME PERMITE VERIFICAR SI TENGO CORREOS CON COPIA, CON COPIA OCULTA,
                    --O SOLAMENTE PARA UN O VARIOS DESTINATARIO.
                    IF ((length(array_to_string( v_registros_correo.cc,',')) <> '0' OR v_registros_correo.cc <>'{}') OR (length(array_to_string( v_registros_correo.bcc,',')) <> '0' OR v_registros_correo.bcc <> '{}'))THEN
                        --CADENA PARA RECONOCER QUE SON CON COPIA

                        v_cc = wf.f_procesar_plantilla(
                                                       p_id_usuario,
                                                       p_id_proceso_wf,
                                                       array_to_string(v_registros_correo.cc, ';')::text,
                                                       p_id_tipo_estado_siguiente,
                                                       p_id_estado_wf_anterior,
                                                       p_obs);
                        IF (length(v_cc)>'0')THEN
                        	v_cc = ',('||v_cc||')';
                        ELSE
                        	v_cc =  '';
                        END IF;
                        --CADENA PARA RECONOCER QUE SON CON COPIA OCULTA
                        v_bcc = wf.f_procesar_plantilla(
                                                       p_id_usuario,
                                                       p_id_proceso_wf,
                                                       array_to_string(v_registros_correo.bcc, ';')::text,
                                                       p_id_tipo_estado_siguiente,
                                                       p_id_estado_wf_anterior,
                                                       p_obs);
                        IF (length(v_bcc)>'0')THEN
                        	v_bcc = ',['||v_bcc||']';
                        ELSE
                        	v_bcc =  '';
                        END IF;
                        --INSERTAMOS ALARMA CON CC Y BCC Y ADDRESS
                        v_alarma = param.f_inserta_alarma(
                                                          NULL,
                                                          v_desc_alarma,
                                                          NULL,--acceso directo
                                                          now()::date,
                                                          'notificacion',
                                                          '',
                                                          p_id_usuario,
                                                          NULL,
                                                          p_titulo,--titulo
                                                          p_parametros::varchar,
                                                          NULL,
                                                          v_plantilla_asunto,
                                                          wf.f_procesar_plantilla(
                                                             p_id_usuario,
                                                             p_id_proceso_wf,
                                                             array_to_string(v_registros_correo.correos, ',')::text,
                                                             p_id_tipo_estado_siguiente,
                                                             p_id_estado_wf_anterior,
                                                             p_obs)||v_cc||v_bcc,
                                                          v_documentos,
                                                          p_id_proceso_wf,
                                                          v_id_estado_actual,
                                                          v_registros_correo.id_plantilla_correo,
                                                          v_registros_correo.mandar_automaticamente

                                                         );
                    ELSE
                    --REGISTRA UNA ALARMA NORMAL SI NO TENEMOS 'CC' CON COPIA O 'BCC' COPIA OCULTA
                    --raise exception '%',p_id_proceso_wf;
                      v_alarma = param.f_inserta_alarma(
                                                        NULL,
                                                        v_desc_alarma,
                                                        NULL,--acceso directo
                                                        now()::date,
                                                        'notificacion',
                                                        '',
                                                        p_id_usuario,
                                                        NULL,
                                                        p_titulo,--titulo
                                                        p_parametros::varchar,
                                                        NULL,
                                                        v_plantilla_asunto,
                                                        wf.f_procesar_plantilla(
                                                           p_id_usuario,
                                                           p_id_proceso_wf,
                                                           array_to_string(v_registros_correo.correos, ',')::text,
                                                           p_id_tipo_estado_siguiente,
                                                           p_id_estado_wf_anterior,
                                                           p_obs),
                                                        v_documentos,
                                                        p_id_proceso_wf,
                                                        v_id_estado_actual,
                                                        v_registros_correo.id_plantilla_correo,
                                                        v_registros_correo.mandar_automaticamente

                                                       );
                    END IF;
                         --si teiene funcion de acuse parametrizada la ejecuta            
                         IF  v_registros_correo.funcion_creacion_correo is not NULL THEN
                               EXECUTE ( 'select ' || v_registros_correo.funcion_creacion_correo  ||'('||v_alarma::varchar||','||COALESCE(p_id_proceso_wf::varchar,'NULL')||','||COALESCE(p_id_estado_wf_anterior::varchar,'NULL')||')');
                         END IF; 
                end if;
                 
     end loop;
    
    -- inserta documentos en estado borrador si estan configurados
     v_resp_doc =  wf.f_inserta_documento_wf(p_id_usuario, p_id_proceso_wf, v_id_estado_actual);
    
    -- verificar documentos
    IF(va_verifica_documento='si')THEN    	
	    v_resp_doc = wf.f_verifica_documento(p_id_usuario, v_id_estado_actual);
    END IF;
        
     -- verificar observaciones abiertas
    v_resp_doc = wf.f_verifica_observaciones(p_id_usuario, p_id_estado_wf_anterior);
    
    --valida datos de los formularios
    v_res_validacion = wf.f_valida_cambio_estado(p_id_estado_wf_anterior,'preregistro',p_id_tipo_estado_siguiente);
    IF  (v_res_validacion IS NOT NULL AND v_res_validacion != '') THEN
          
        raise exception 'Es necesario registrar los siguientes campos en el formulario: % . Antes de pasar al estado : %',v_res_validacion,v_registros.nombre_estado;
          
    END IF;
    
    return v_id_estado_actual;
  
    
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
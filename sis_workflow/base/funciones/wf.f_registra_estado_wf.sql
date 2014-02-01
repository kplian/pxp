--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_registra_estado_wf (
  p_id_tipo_estado_siguiente integer,
  p_id_funcionario integer,
  p_id_estado_wf_anterior integer,
  p_id_proceso_wf integer,
  p_id_usuario integer,
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
	
    
BEGIN

  --raise exception 'p_id_tipo_estado_siguiente %, p_id_funcionario %   ,p_id_estado_wf_anterior %   ,%',p_id_tipo_estado_siguiente,p_id_funcionario,p_id_estado_wf_anterior,p_id_proceso_wf;
    
    --revisar que el estado se encuentre activo, en caso contrario puede
    --se una orden desde una pantalla desactualizada
    
    select 
    ew.estado_reg,
    ew.id_funcionario,
    ew.id_depto,
    tew.alerta
    into
    v_registros_ant
    from wf.testado_wf ew
    inner join wf.ttipo_estado tew on tew.id_tipo_estado = ew.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf_anterior;
    
    
    
    
    if (v_registros_ant.estado_reg ='inactivo') THEN
    
    	raise exception 'El estado se encuentra inactivo, actualice sus datos' ;
    
    END IF;


    v_nombre_funcion ='f_registra_estado_wf';
    v_id_estado_actual = -1;
      
    if( p_id_tipo_estado_siguiente is null 
        OR p_id_estado_wf_anterior is null 
        OR p_id_proceso_wf is null
        )then
    	raise exception 'Faltan parametros, existen parametros nulos o en blanco, para registrar el estado en el WF.';
      
    end if;
    
    --verificamos si requiere manejo de alerta
    
    SELECT 
     te.alerta,
     s.nombre,
     s.codigo,
     s.id_subsistema,
     te.nombre_estado,
     pm.nombre as nombre_proceso_macro
    INTO
     v_registros
    FROM wf.ttipo_estado te
    inner join wf.ttipo_proceso tp on tp.id_tipo_proceso  = te.id_tipo_proceso
    inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
    inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema 
    WHERE te.id_tipo_estado = p_id_tipo_estado_siguiente;
    
    
    IF(v_registros.id_subsistema is NULL ) THEN
    
       raise exception  'El proceso macro no esta relacionado con ningun sistema';
    
    END IF;
    
    
    if(v_registros.alerta = 'si' and  p_id_funcionario is not NULL) THEN
        
           v_desc_alarma =  'Cambio al estado ('||v_registros.nombre_estado||'), con las siguiente observaciones: '||p_obs;
                 
         
        v_cont_alarma = 1;
        IF p_id_funcionario is not NULL and (v_registros_ant.id_funcionario is null or v_registros_ant.id_funcionario != p_id_funcionario)  THEN
          
          
                   /*
                        par_id_funcionario : indica el funcionario para el que se genera la alrma
                        par_descripcion: una descripcion de la alarma
                        par_acceso_directo: es el link que lleva a la relacion de la alarma generada
                        par_fecha: Indica la fecha de vencimiento de la alarma
                        par_tipo: indica el tipo de alarma, puede ser alarma o notificacion
                        par_obs: son las observaciones de la alarma
                        par_id_usuario: integer,   el usuario que registra la alarma
                        
                        par_clase varchar,        clases a ejecutar en interface deacceso directo
                        par_titulo varchar,       titulo de la interface de acceso directo
                        par_parametros varchar,   parametros a mandar a la interface de acceso directo
                        par_id_usuario_alarma integer,dica el usuario para que se cre la alarma (solo si funcionario es NULL)
                        par_titulo_correo varchar,   titulo de correo
                   
                   */
                   
                   v_alarmas_con[v_cont_alarma]:=param.f_inserta_alarma(
                                                      p_id_funcionario,
                                                      v_desc_alarma,
                                                      p_acceso_directo,--acceso directo
                                                      now()::date,
                                                      p_tipo,
                                                      p_titulo,
                                                      p_id_usuario,
                                                      p_clase,
                                                      p_titulo,--titulo
                                                      p_parametros::varchar,
                                                      NULL::integer,
                                                      ('Alerta del sistema '||v_registros.nombre||'('||v_registros.codigo||') '||'['|| v_registros.nombre_proceso_macro  ||']')::varchar
                                                     );
                                                     
                                                      
                   v_cont_alarma = v_cont_alarma +1;
             
              END IF;
              
              
            --raise exception  'id_depto % ,%',v_registros_ant.id_depto   ,p_id_depto;  
        
              IF p_id_depto is not NULL  and  (v_registros_ant.id_depto is null or v_registros_ant.id_depto != p_id_depto)  THEN
               
              -- buscamos entre los usarios del depto quien puede recibir alerta
               
                 FOR  v_registros_depto in  ( 
                       select  du.id_usuario 
                       from  param.tdepto_usuario du 
                       where du.id_depto = p_id_depto 
                         and du.sw_alerta = 'si') LOOP
                  
                     v_alarmas_con[v_cont_alarma]:=param.f_inserta_alarma(
                                                        NULL,
                                                        v_desc_alarma,
                                                        p_acceso_directo,--acceso directo
                                                        now()::date,
                                                        p_tipo,
                                                        p_titulo,
                                                        p_id_usuario,
                                                        p_clase,
                                                        p_titulo,--titulo
                                                        p_parametros::varchar,
                                                        v_registros_depto.id_usuario::integer,
                                                        ('Alerta del sistema '||v_registros.nombre||'('||v_registros.codigo||')')::varchar
                                                       ); 
             
                     
                    v_cont_alarma = v_cont_alarma +1;
                   
                   END LOOP;
                   
                  
             
             END IF;
              
    END IF;
    
    --todo manejo de alertas para departamentos
    
     
   
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
     id_alarma) 
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
       v_alarmas_con) 
    RETURNING id_estado_wf INTO v_id_estado_actual;  
            
    UPDATE wf.testado_wf 
    SET estado_reg = 'inactivo'
    WHERE id_estado_wf = p_id_estado_wf_anterior;
    
   
    
    -- inserta documentos en estado borrador si estan configurados
     v_resp_doc =  wf.f_inserta_documento_wf(p_id_usuario, p_id_proceso_wf, v_id_estado_actual);
    
    
    -- verificar documentos
    v_resp_doc = wf.f_verifica_documento(p_id_usuario, v_id_estado_actual);
    
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
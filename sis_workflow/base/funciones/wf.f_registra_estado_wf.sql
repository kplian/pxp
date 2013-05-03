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
	
    
BEGIN

  --raise exception 'p_id_tipo_estado_siguiente %, p_id_funcionario %   ,p_id_estado_wf_anterior %   ,%',p_id_tipo_estado_siguiente,p_id_funcionario,p_id_estado_wf_anterior,p_id_proceso_wf;
    
    --revisar que el estado se encuentre activo, en caso contrario puede
    --se una orden desde una pantalla desactualizada
    
    if ( exists (select 1
    from wf.testado_wf ew
    where ew.id_estado_wf = p_id_estado_wf_anterior and ew.estado_reg ='inactivo')) THEN
    
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
     te.nombre_estado
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
        
    
       /*
            par_id_funcionario : indica el funcionario para el que se genera la alrma
            par_descripcion: una descripciÃ³n de la alarma
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
       
       v_desc_alarma =  'Cambio al estado ('||v_registros.nombre_estado||'), con las siguiente observaciones: '||p_obs;
     
        v_alarmas_con[1]:=param.f_inserta_alarma(
                                          p_id_funcionario,
                                          v_desc_alarma,
                                         '',--acceso directo
                                          now()::date,
                                          p_tipo,
                                          p_titulo,
                                          p_id_usuario,
                                          p_clase,
                                          p_titulo,--titulo
                                          p_parametros::varchar,
                                          NULL::integer,
                                          ('Alerta del sistema '||v_registros.nombre||'('||v_registros.codigo||')')::varchar
                                         ); 
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
    
    --raise notice 'estado actual, %', v_id_estado_actual;
    
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
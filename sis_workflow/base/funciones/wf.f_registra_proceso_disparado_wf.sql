--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_registra_proceso_disparado_wf (
  p_id_usuario_reg integer,
  p_id_usuario_ai integer,
  p_usuario_ai varchar,
  p_id_estado_wf_dis integer,
  p_id_funcionario integer,
  p_id_depto integer,
  p_descripcion varchar = '---'::character varying,
  p_codigo_tipo_proceso varchar = ''::character varying,
  p_codigo_proceso_wf varchar = NULL::character varying,
  out ps_id_proceso_wf integer,
  out ps_id_estado_wf integer,
  out ps_codigo_estado varchar,
  out ps_nro_tramite varchar
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_registra_proceso_disparado_wf
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
 AUTOR: 		KPLIAN(RAC)
 FECHA:			25/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	Se considera la configuracion de la tablas wf.ttipo_procesos_origen
 AUTOR:			RAC
 FECHA:			17/11/2014

***************************************************************************/
DECLARE

   v_resp varchar;
   v_nombre_funcion varchar;
   
   v_id_tipo_estado_prev integer;
   v_disparador varchar;
   v_id_tipo_proceso_next integer;
   v_codigo_prev varchar;
   v_id_tipo_estado_next integer;
   v_codigo_estado_next varchar;
   v_id_proceso_wf_prev integer;
   v_nro_tramite varchar;
   
   v_cantidad_disparos integer;
   v_resp_doc  boolean;
   
   v_array_codigo_tipo_proceso varchar[];
   v_cantidad_disparos_origenes integer;
 
  
BEGIN

    v_nombre_funcion='wf.f_registra_proceso_disparado_wf';
    
    --verificamos si el estado previo es un disparador
    
    select 
      te.codigo,
      ew.id_proceso_wf,
      te.id_tipo_estado,
      te.disparador
      
    into 
       v_codigo_prev,
       v_id_proceso_wf_prev,
       v_id_tipo_estado_prev,
       v_disparador
    
    from wf.ttipo_estado te 
    inner join wf.testado_wf ew  on ew.id_tipo_estado = te.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf_dis;
    
   


    ---------------------------------------
    -- IDentifica siguiente proceso al que se dispara
    -----------------------------------------
    
    
    --p_codigo_tipo_proceso por defecto tiene el valor '' 
    -- si tuviera mas de un proceso disparado idntifica por que camino debe seguir
    
    
    --primero preguntar  si tiene al menos un proceso 
    -- si solo tiene uno,  no  se utiliza el codigo, 
    -- si tiene mas de uno se utiliza el codigo
    -- si no tiene ninguno sale un error
    
    
     
     
     --cuenta cuantos procesos de dispara
      select 
       count(tp.codigo)    
      into 
      v_cantidad_disparos
      from wf.ttipo_proceso tp
      where id_tipo_estado = v_id_tipo_estado_prev and tp.estado_reg = 'activo';
     
       
      
      select 
       count(tpo.id_tipo_proceso_origin)    
      into 
      v_cantidad_disparos_origenes
      from wf.ttipo_proceso_origen tpo
      where tpo.id_tipo_estado = v_id_tipo_estado_prev and tpo.estado_reg = 'activo'; 
   
    v_cantidad_disparos = COALESCE(v_cantidad_disparos,0) + COALESCE(v_cantidad_disparos_origenes,0);

   
    -- si solo tiene un proceso disparado
    if v_cantidad_disparos = 1 then
    	
         select
         tp.id_tipo_proceso
        into 
          v_id_tipo_proceso_next
        from wf.ttipo_proceso tp 
        where   tp.estado_reg = 'activo'  and  tp.id_tipo_estado=v_id_tipo_estado_prev;
       
        
        if  v_id_tipo_proceso_next is NULL then
          select
           tp.id_tipo_proceso
          into 
            v_id_tipo_proceso_next
          from wf.ttipo_proceso_origen tp 
          where  tp.estado_reg = 'activo' and   tp.id_tipo_estado=v_id_tipo_estado_prev;
        end if;
        
       
    
    -- si el proceso no apunta a ningun lado
    elsif v_cantidad_disparos = 0 then
    
    
        raise exception 'El estado %, no apunta  a ningun proceso, %',v_codigo_prev, v_id_tipo_estado_prev;
    
    --si tiene mas de uno se busca el camino segun el codigo
    else
    
       if  p_codigo_tipo_proceso = '' then
       
         raise exception 'El proceso tiene % destino(s) posible(s), y no se especifico por cual camino se debe seguir. (ADMIN: Considere agregar el codigo de proceso nuevo a la llamada)) ',v_cantidad_disparos;
       
       else
       
        
          
          v_array_codigo_tipo_proceso = regexp_split_to_array(p_codigo_tipo_proceso, E',');
       
    
          select
           tp.id_tipo_proceso
          into 
            v_id_tipo_proceso_next
          from wf.ttipo_proceso tp 
          where   tp.id_tipo_estado=v_id_tipo_estado_prev and tp.estado_reg = 'activo'
          and tp.codigo = ANY (v_array_codigo_tipo_proceso);
          
        
          --si no existe un camino oese a tener codigo se lanza un error
          if  v_id_tipo_proceso_next is NULL then
             
              -- chequear en la tabla de procesos origen
               select
                 tp.id_tipo_proceso
                into 
                  v_id_tipo_proceso_next
                from wf.ttipo_proceso_origen tpo 
                inner join wf.ttipo_proceso tp on  tp.id_tipo_proceso = tpo.id_tipo_proceso   and tp.estado_reg = 'activo' 
                                                    
                where   tpo.id_tipo_estado=v_id_tipo_estado_prev
                and tp.codigo = ANY (v_array_codigo_tipo_proceso) and tpo.estado_reg = 'activo';
              
              if  v_id_tipo_proceso_next is NULL then
                   raise exception 'El proceso tiene % destino(s) posible(s), y entre ellos no se encuentra %',v_cantidad_disparos, p_codigo_tipo_proceso;
              end if;
              
             
                
          end if;
      
      
      end if;
    
    
    end if;
            
   
    IF v_id_tipo_proceso_next is NULL THEN 
    
      raise exception 'El estado (- % -) no apunta a ningun proceso ',v_codigo_prev;
    
    END IF;

     --recupera datos del primer estado del siguiente proceso
     select 
       te.id_tipo_estado,
       te.codigo
     into
       v_id_tipo_estado_next,
       v_codigo_estado_next
     from wf.ttipo_estado te
     where te.id_tipo_proceso = v_id_tipo_proceso_next and te.inicio = 'si' and te.estado_reg = 'activo'; 
     
     if v_id_tipo_estado_next is NULL THEN
           raise exception 'El WF esta mal parametrizado verifique a que tipo_proceso apunto el tipo_estado previo';
     END IF;
     --recupera el numero de tramite
    
      select 
        pw.nro_tramite
      into
        v_nro_tramite
      from wf.tproceso_wf pw
      where pw.id_proceso_wf = v_id_proceso_wf_prev;
      
      ps_nro_tramite = v_nro_tramite;
     
     
     
     --inserta el nuevo proceso
     
      
     
     -- inserta el proceso con el numero de tramite
         INSERT INTO 
          wf.tproceso_wf
        (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_tipo_proceso,
          nro_tramite,
          id_estado_wf_prev,
          descripcion,
          codigo_proceso,
          id_usuario_ai,
          usuario_ai
          
        ) 
        VALUES (
          p_id_usuario_reg,
          now(),
          'activo',
          v_id_tipo_proceso_next,
          v_nro_tramite,
          p_id_estado_wf_dis,
          p_descripcion,
          p_codigo_proceso_wf,
          p_id_usuario_ai,
          p_usuario_ai
        ) RETURNING id_proceso_wf into ps_id_proceso_wf;
        

      
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
          p_id_usuario_reg,
          now(),
          'activo',
          NULL,
          v_id_tipo_estado_next,
          ps_id_proceso_wf,
          p_id_funcionario,
          p_id_depto,
          p_id_usuario_ai,
          p_usuario_ai
        )RETURNING id_estado_wf into ps_id_estado_wf;  
        
        
          
        
       ps_codigo_estado  = v_codigo_estado_next;
        
      
       -- inserta documentos en estado borrador si estan configurados
       v_resp_doc =  wf.f_inserta_documento_wf(p_id_usuario_reg, ps_id_proceso_wf, ps_id_estado_wf);
       
       
         
       -- verificar documentos
       v_resp_doc = wf.f_verifica_documento(p_id_usuario_reg, ps_id_estado_wf);
        
      return;
 

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
SECURITY DEFINER
COST 100;
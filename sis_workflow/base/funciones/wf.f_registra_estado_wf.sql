--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_registra_estado_wf (
  p_id_tipo_estado_siguiente integer,
  p_id_funcionario integer,
  p_id_estado_wf_anterior integer,
  p_id_proceso_wf integer,
  p_id_usuario integer,
  p_id_depto integer = NULL::integer,
  p_obs text = ''::text
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
    v_id_tipo_estado integer;
	
    
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
    
     
   
    INSERT INTO wf.testado_wf(
     id_estado_anterior, 
     id_tipo_estado, 
     id_proceso_wf, 
     id_funcionario, 
     fecha_reg,
     estado_reg,
     id_usuario_reg,
     id_depto,
     obs) 
    values(
       p_id_estado_wf_anterior, 
       p_id_tipo_estado_siguiente, 
       p_id_proceso_wf, 
       p_id_funcionario, 
       now(),
       'activo',
       p_id_usuario,
       p_id_depto,
       p_obs) 
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
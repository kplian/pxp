--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_registra_estado_wf (
  p_id_tipo_estado_siguiente integer,
  p_id_funcionario integer,
  p_id_estado_wf_anterior integer,
  p_id_proceso_wf integer,
  p_id_usuario integer
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
    g_registros			record;   
    v_consulta			varchar;
    v_id_estado_actual	integer;
    v_id_tipo_estado integer;
	
    
BEGIN

	BEGIN   
    v_id_estado_actual = -1;
      
    if( p_id_tipo_estado_siguiente is null 
        OR p_id_funcionario is null 
        OR p_id_estado_wf_anterior is null 
        OR p_id_proceso_wf is null
        )then
    	raise exception 'Faltan parametros, existen parametros nulos o en blanco.';
      
    end if;
    
     
   
    INSERT INTO wf.testado_wf(
     id_estado_anterior, 
     id_tipo_estado, 
     id_proceso_wf, 
     id_funcionario, 
     fecha,
     estado_reg,
     id_usuario_reg) 
    values(
       p_id_estado_wf_anterior, 
       p_id_tipo_estado_siguiente, 
       p_id_proceso_wf, 
       p_id_funcionario, 
       now(),
       'activo',
       p_id_usuario) 
    RETURNING id_estado_wf INTO v_id_estado_actual;  
            
    UPDATE wf.testado_wf 
    SET estado_reg = 'inactivo'
    WHERE id_estado_wf = p_id_estado_wf_anterior;
    
    --raise notice 'estado actual, %', v_id_estado_actual;
    
    return v_id_estado_actual;
    END;   
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
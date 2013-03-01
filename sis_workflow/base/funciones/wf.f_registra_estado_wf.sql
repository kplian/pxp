CREATE OR REPLACE FUNCTION wf.f_registra_estado_wf (
  p_estado_proceso	varchar,
  p_id_funcionario integer,
  p_id_estado_wf_anterior integer,
  p_id_proceso_wf integer  
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

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE	
    g_registros			record;   
    v_consulta			varchar;
    v_id_estado_actual	integer;
    v_id_tipo_estado integer;
	
    
BEGIN

	BEGIN   
    v_id_estado_actual = -1;
      
    if((p_estado_proceso is null OR p_id_funcionario is null OR p_id_estado_wf_anterior is null OR p_id_proceso_wf is null)
        OR rtrim(p_estado_proceso,' ') = '' )then
    	raise notice 'Faltan parametros, existen parametros nulos o en blanco.';
        return v_id_estado_actual;
    end if;
    
    /*SELECT array_to_string(p_estado,',', '*') 
    INTO v_estado_siguiente
    FROM wf.f_obtener_estado_tipo_proceso('','SOLCO','borrador4544'	,'siguiente');
    
    if(v_estado_siguiente is null)then 
    	return v_id_estado_actual;
    end if;
    */   
         
    SELECT te.id_tipo_estado FROM wf.ttipo_estado te
    INTO v_id_tipo_estado
    WHERE te.nombre_estado ilike p_estado_proceso;
   
   
    INSERT INTO wf.testado_wf(id_estado_anterior, id_tipo_estado, id_proceso_wf, id_funcionario, fecha) 
    values(p_id_estado_wf_anterior, v_id_tipo_estado, p_id_proceso_wf, p_id_funcionario, now()) 
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
SECURITY INVOKER;
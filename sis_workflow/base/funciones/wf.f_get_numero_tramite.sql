--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_get_numero_tramite (
  p_codigo_proceso varchar,
  p_id_gestion integer,
  p_id_usuario integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_get_numero_tramite
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
 AUTOR: 		KPLIAN(FRH)
 FECHA:			20/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
  v_num_siguiente INTEGER;
  v_gestion varchar;
  v_id_gestion integer;
  v_cont_gestion integer;
  v_codigo_siguiente VARCHAR(30);
  
  
  v_codigo_proceso_macro varchar;
  v_id_proceso_macro integer;
  
BEGIN
      

   -- recupera datos del proceso macro
   
     select 
        pm.id_proceso_macro
     into
        v_id_proceso_macro
     from wf.tproceso_macro pm
     where pm.codigo =  p_codigo_proceso;
   
     
    IF v_id_proceso_macro is NULL THEN
      
     raise exception 'No existe el codigo de Proceso Macro solicitado en sistema de work flow';
     
    END IF;
    
   --recupera la gestion
   
    select nt.gestion
        into v_gestion
        from wf.tnum_tramite nt
        where nt.id_num_tramite=v_id_num_tramite; 
  
  IF gestion is null THEN
   
   raise exception 'No se encontro la gestion solicitada' ;
  
  END IF;   
 

  -- verifica si existe numeracion para la gestion solicitada

        select nt.num_siguiente
        into v_num_siguiente
        from wf.tnum_tramite nt
        where nt.id_gestion = p_id_gestion
             and nt.id_proceso_macro = v_id_proceso_macro;
             
   IF v_num_siguiente is NULL THEN
     
        INSERT INTO 
            wf.tnum_tramite
          (
            id_usuario_reg,
            id_usuario_mod,
            fecha_reg,
            fecha_mod,
            estado_reg,
           
            id_proceso_macro,
            id_gestion,
            num_siguiente
          ) 
          VALUES (
            p_id_usuario,
            NULL,
            NULL,
            'activo',
           
            v_id_proceso_macro,
            p_id_gestion,
            1
          );
          
          v_num_siguiente=1;
   END IF;


--p_codigo_proceso 
        
         
            
        
        UPDATE wf.tnum_tramite set			
            num_siguiente = v_num_siguiente	+1		
        WHERE nt.id_gestion = p_id_gestion
           and nt.id_proceso_macro = v_id_proceso_macro;
        
        
        v_codigo_siguiente := (v_codigo_proceso_macro||'-'||lpad(COALESCE(v_num_siguiente, 0)::varchar,6,'0')||'-'||v_id_gestion::varchar);
       
        
   RETURN v_codigo_siguiente;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;
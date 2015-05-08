--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_encontrar_proceso_wf (
  p_id_tipo_proceso integer,
  p_id_estado_wf integer,
  p_tipo_busqueda varchar = 'superior'::character varying
)
RETURNS integer [] AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_encontrar_proceso_wf
 DESCRIPCION: 	Encuentra recursivamente el proceso_wf correpondiente con el tipo_proceso que entra como parametro, 
                a partir del p_id_estado_wf introducido
 AUTOR: 		KPLIAN(RAC)
 FECHA:			20/01/2014
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/


DECLARE


v_parametros  		record;
v_nombre_funcion   	text;
v_resp				varchar;


v_sw integer;
v_sw2 integer;
v_count integer;
v_consulta varchar;
v_consulta2 varchar;
v_registros  record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_tabla varchar;
v_valor_nivel varchar;
v_nivel varchar;
v_niveles_acsi varchar;

pm_criterio_filtro varchar;
v_id integer;


v_registro_proceso_wf  record;
v_fecha_ini_proc timestamp;
v_fecha_fin_proc timestamp;
v_id_procesos_sig integer[];
v_id_almacenado  integer[];
v_fecha_fin_ant TIMESTAMP;
v_id_proceso integer;
v_id_estado integer;
v_id_proceso_ant integer;

v_i integer;
v_temp_fin varchar;


v_id_proceso_wf  integer[];
v_id_proceso_wf_ini  integer;
 

BEGIN


    v_nombre_funcion = 'wf.f_encontrar_proceso_wf';
    
      IF p_tipo_busqueda = 'superior' THEN
      
      -- buscar el tipo de proceso entre los nodos superiores
            
                WITH RECURSIVE path_rec(id_estado_wf, id_estado_wf_prev,id_proceso_wf,id_tipo_proceso ) AS (
                  SELECT  
                    ewfini.id_estado_wf,
                    pwf.id_estado_wf_prev,
                    pwf.id_proceso_wf ,
                    pwf.id_tipo_proceso
                  FROM wf.tproceso_wf pwf
                  inner join wf.testado_wf ewfini on ewfini.id_proceso_wf = pwf.id_proceso_wf
                  WHERE ewfini.id_estado_wf = p_id_estado_wf
          	
                  UNION
                  SELECT
                  ewf2.id_estado_wf, 
                  pwf2.id_estado_wf_prev,
                  pwf2.id_proceso_wf,
                  pwf2.id_tipo_proceso
                  FROM wf.tproceso_wf pwf2
                  inner join wf.testado_wf ewf2 on ewf2.id_proceso_wf = pwf2.id_proceso_wf
                  inner join path_rec  pr on ewf2.id_estado_wf = pr.id_estado_wf_prev
          	   
          	     
              )
              SELECT 
                 pxp.aggarray(id_proceso_wf)
              into 
                 v_id_proceso_wf 
              FROM path_rec where id_tipo_proceso = p_id_tipo_proceso;
      
      
      
      ELSEIF  p_tipo_busqueda = 'inferior'  THEN
      
         -- buscar el tipo de proceso entre los nodos inferiores
         
           --obtenermos el proceso wf del estado
             select  
               ewf.id_proceso_wf
             into
                v_id_proceso_wf_ini
             from  wf.testado_wf ewf  where  ewf.id_estado_wf =  p_id_estado_wf;
         
      
           WITH RECURSIVE path_rec(id_proceso_wf_sig, id_tipo_proceso) AS (
        	    
                select 
                  pwf.id_proceso_wf as id_proceso_wf_sig,
                  pwf.id_tipo_proceso
                from wf.testado_wf  ewf
                inner join wf.tproceso_wf  pwf on pwf.id_estado_wf_prev = ewf.id_estado_wf
                where  ewf.id_proceso_wf = v_id_proceso_wf_ini
                
            UNION
                select 
                  pwf2.id_proceso_wf as id_proceso_wf_sig,
                  pwf2.id_tipo_proceso
                
                from wf.testado_wf  ewf2
                inner join wf.tproceso_wf  pwf2 on pwf2.id_estado_wf_prev = ewf2.id_estado_wf
                inner join path_rec  pr on ewf2.id_proceso_wf = pr.id_proceso_wf_sig 
                
                
           )
            SELECT 
             pxp.aggarray(id_proceso_wf_sig)
            into 
             v_id_proceso_wf 
            FROM path_rec where id_tipo_proceso = p_id_tipo_proceso; 
             
            
      
      
      END IF;
      
      
      
    RETURN v_id_proceso_wf;


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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_gant_wf (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
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
p_id_proceso_wf integer;
 

BEGIN



    v_nombre_funcion = 'wf.f_gant_wf';
    
    
     v_parametros = pxp.f_get_record(p_tabla);
    
    
    /*********************************    
 	#TRANSACCION:  'WF_GATNREP_SEL'
 	#DESCRIPCION:	Consulta del diagrama gant del WF
 	#AUTOR:		rac	
 	#FECHA:		16-03-2012 17:06:17
	***********************************/

	IF(p_transaccion='WF_GATNREP_SEL')then
    
    
    p_id_proceso_wf = v_parametros.id_proceso_wf;


   -- 0) Crea una tabla temporal con los datos que se utilizaran 

 
   
    
        CREATE TEMPORARY TABLE temp_gant_wf (
                                      id serial,
                                      id_proceso_wf integer,
                                      id_estado_wf integer,
                                      tipo varchar, 
                                      nombre VARCHAR, 
                                      fecha_ini TIMESTAMP, 
                                      fecha_fin TIMESTAMP, 
                                      descripcion VARCHAR, 
                                      id_siguiente integer,
                                      tramite varchar,
                                      codigo varchar,
                                      id_funcionario integer,
                                      funcionario text,
                                      id_usuario INTEGER,
                                      cuenta varchar,
                                      id_depto integer,
                                      depto varchar
                                     ) ON COMMIT DROP;
    
    
                 
      IF not ( wf.f_gant_wf_recursiva(p_id_proceso_wf,NULL ,p_id_usuario)) THEN
                
        raise exception 'Error al recuperar los datos del diagrama gant';
                
      END IF;
          
         
       raise notice 'consulta tabla temporal';   
  
   FOR v_registros in (SELECT                                   
                        id ,
                        id_proceso_wf ,
                        id_estado_wf ,
                        tipo , 
                        nombre , 
                        fecha_ini , 
                        fecha_fin , 
                        descripcion , 
                        id_siguiente ,
                        tramite ,
                        codigo ,
                        COALESCE(id_funcionario,0) ,
                        funcionario ,
                        COALESCE(id_usuario,0),
                        cuenta ,
                        COALESCE(id_depto,0),
                        depto
                      FROM temp_gant_wf 
                      order by id) LOOP
     RETURN NEXT v_registros;
   END LOOP;


END IF;

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
COST 100 ROWS 1000;
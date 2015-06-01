--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_gant_wf_recursiva_dinamico (
  p_id_proceso_wf integer,
  p_id_estado_wf integer,
  p_id_usuario integer,
  p_id_padre integer,
  p_id_anterior integer
)
RETURNS boolean AS
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


v_registro_proceso_wf   record;
v_registros_dips 		record;
v_fecha_ini_proc 		timestamp;
v_fecha_fin_proc		timestamp;
v_id_procesos_sig 		integer[];
v_id_almacenado  		integer[];
v_id_disparador	 		integer[];
v_fecha_fin_ant 		TIMESTAMP;
v_id_proceso 			integer;
v_id_estado 			integer;
v_id_proceso_ant 		integer;

v_i 					integer;
v_temp_fin 				varchar;
v_registros_obs 		record;
v_id_obs 				integer;
v_id_anterior 			integer;
 

BEGIN



    v_nombre_funcion = 'wf.f_gant_wf_recursiva_dinamico';


       --recuperamos datos del proceso wf
       select  
        pwf.id_proceso_wf,
        pwf.fecha_ini,
        pwf.nro_tramite,
        pwf.descripcion,
        pwf.id_estado_wf_prev,
        pwf.id_tipo_proceso,
        tp.codigo,
        tp.nombre,
        te.codigo as codigo_estado
       
       into
         v_registro_proceso_wf
       from wf.tproceso_wf pwf
       inner join wf.testado_wf ewf on ewf.id_proceso_wf = pwf.id_proceso_wf and ewf.estado_reg = 'activo'
       inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
       inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
       where  pwf.id_proceso_wf = p_id_proceso_wf;
       
      -- if (v_registro_proceso_wf.codigo_estado in('anulado','anulada','cancelado','cancelada', 'eliminado', 'eliminada')) then
      -- 	return true;
     --  end if;
       
       raise notice 'antes del insert';
       
       -------------------------------
       --inserta el proceso basico
       -------------------------------
       
       INSERT INTO      
           temp_gant_wf (
                    id_proceso_wf,
                    id_estado_wf,
                    tipo, 
                    nombre, 
                    fecha_ini, 
                    fecha_fin, 
                    descripcion, 
                    id_siguiente,
                    tramite,
                    codigo,
                    id_padre,
                    id_anterior
                   )
                   VALUES(
                   
                    v_registro_proceso_wf.id_proceso_wf,
                    NULL,--id_estado_wf,
                    'proceso', 
                    v_registro_proceso_wf.nombre, 
                    NULL,--fecha_ini, 
                    NULL,--fecha_fin, 
                    COALESCE(v_registro_proceso_wf.descripcion,''), 
                    NULL,-- id_siguiente,
                    v_registro_proceso_wf.nro_tramite,
                    v_registro_proceso_wf.codigo,
                    p_id_padre,
                    p_id_anterior
                   ) RETURNING id into v_id_proceso;
       
         raise notice 'inicio ';
       
       --------------------------------------
       --consulta los estados del proceso
       -------------------------------------
       
           v_sw = 0;
           v_i =1;
           v_id_anterior = v_id_proceso;
          FOR  v_registros in (
           	           SELECT  
                         ewf.id_estado_wf,
                         ewf.obs as descripcion,
                         te.codigo,
                         te.disparador,
                         te.fin,
                         ewf.fecha_reg as fecha_ini,
                         te.nombre_estado as nombre,
                         usu.id_usuario,
                         usu.cuenta,
                         fun.id_funcionario,
                         fun.desc_funcionario1  as funcionario,
                         depto.id_depto,
                         depto.codigo as departamento,
                         ewf.usuario_ai,
                         te.etapa,
                         te.disparador,
                         ewf.estado_reg
                         
                         
                       FROM  wf.testado_wf ewf
                       INNER JOIN  wf.ttipo_estado te on ewf.id_tipo_estado = te.id_tipo_estado
                       LEFT JOIN   segu.tusuario usu on usu.id_usuario = ewf.id_usuario_reg
                       LEFT JOIN  orga.vfuncionario fun on fun.id_funcionario = ewf.id_funcionario
                       LEFT JOIN  param.tdepto depto on depto.id_depto = ewf.id_depto
                     
                       WHERE 
                          ewf.id_proceso_wf = v_registro_proceso_wf.id_proceso_wf
                      
                          ORDER BY ewf.fecha_reg,ewf.id_estado_wf) LOOP
                          
                        raise notice 'loop  v_sw %,  v_i % ',v_sw,v_i;
       
                     
                     --inserta el estado  
                     
                     INSERT INTO      
                     temp_gant_wf (
                              id_proceso_wf,
                              id_estado_wf,
                              tipo, 
                              nombre, 
                              fecha_ini, 
                              fecha_fin, 
                              descripcion, 
                              id_siguiente,
                              tramite ,
                              codigo,
                              
                              id_funcionario,
                              funcionario,
                              id_usuario,
                              cuenta,
                              id_depto,
                              depto,
                              nombre_usuario_ai,
                              id_padre,
                              id_anterior,
                              etapa,
                              estado_reg,
                              disparador
                             )
                             VALUES(
                                       
                              NULL,
                              v_registros.id_estado_wf,
                              'estado', 
                              v_registros.nombre, 
                              v_registros.fecha_ini, 
                              NULL,--fecha_fin, 
                              COALESCE(v_registros.descripcion,''), 
                              NULL,-- id_siguiente, no lo conocemos todavia
                              v_registro_proceso_wf.nro_tramite,
                              v_registro_proceso_wf.codigo,                              
                              v_registros.id_funcionario,
                              v_registros.funcionario,
                              v_registros.id_usuario,
                              v_registros.cuenta,
                              v_registros.id_depto,
                              v_registros.departamento,
                              v_registros.usuario_ai,
                              v_id_proceso,
                              v_id_anterior,
                              v_registros.etapa,
                              v_registros.estado_reg,
                              v_registros.disparador
                             ) RETURNING id into v_id_estado;
                      
                          v_id_anterior = v_id_estado;
                       --si es un nodo disparador buscamos almacenamos la referencia
                       
                         IF v_registros.disparador = 'si' THEN
                        	
                            v_id_almacenado [v_i] = v_registros.id_estado_wf;
                            v_i = v_i +1;
                            
                       
                           --busca recursivamente los procesos disparados
                            FOR  v_registros_dips in (
                                         SELECT
                                            pwf.id_proceso_wf,
                                            pwf.id_estado_wf_prev
                                         FROM wf.tproceso_wf  pwf
                                         WHERE pwf.id_estado_wf_prev = v_registros.id_estado_wf
                                         ORDER BY pwf.fecha_reg ) LOOP
                                         
                                    
                                   
                                  IF not ( wf.f_gant_wf_recursiva_dinamico(v_registros_dips.id_proceso_wf, v_registros_dips.id_estado_wf_prev ,p_id_usuario, v_id_estado, NULL)) THEN
                                  
                                    raise exception 'Error al recuperar los datos del diagrama gant';
                                  
                                  END IF;
                            
                            END LOOP;
                          END IF;
                   
                        IF v_sw = 1 THEN
                        
                           update temp_gant_wf set
                             id_siguiente = v_id_estado,
                             fecha_fin =  v_registros.fecha_ini
                            
                           where
                           id = v_id_proceso_ant;
                        
                        END IF; 
                        
                         --definir las fecha del proceso
                      IF v_sw = 0 THEN
                        v_fecha_ini_proc = v_registros.fecha_ini;
                        v_fecha_fin_proc = v_registros.fecha_ini;
                        v_sw = 1;
                      ELSE
                       v_fecha_fin_proc = v_registros.fecha_ini;
                      END IF;
                        
                        
                         --almacena variable temporales para el siguiente ciclo
                      v_id_proceso_ant =  v_id_estado;
                      v_temp_fin = v_registros.fin;
                      
                      --------------------------------------------
                      -- registro de observaciones por estado
                      -----------------------------------------
                       FOR  v_registros_obs in (
                                           SELECT  
                                             o.id_obs,
                                             o.id_estado_wf,
                                             o.descripcion as descripcion,
                                             o.titulo,
                                             o.fecha_reg as fecha_ini,
                                             o.fecha_fin,
                                             o.id_usuario_reg,
                                             usu.cuenta,
                                             fun.id_funcionario,
                                             fun.desc_funcionario1  as funcionario,
                                             o.usuario_ai,
                                             o.estado,
                                             o.num_tramite
                                           
                                           FROM  wf.tobs o
                                           INNER JOIN  orga.vfuncionario fun on fun.id_funcionario = o.id_funcionario_resp
                                           INNER JOIN   segu.tusuario usu on usu.id_usuario = o.id_usuario_reg
                                         
                                           WHERE 
                                                   o.id_estado_wf = v_registros.id_estado_wf
                                              AND  o.estado_reg = 'activo'
                                           ORDER BY o.fecha_reg) LOOP
                                           
                       
                                INSERT INTO      
                                           temp_gant_wf (
                                                    id_proceso_wf,
                                                    id_estado_wf,
                                                    tipo, 
                                                    nombre, 
                                                    fecha_ini, 
                                                    fecha_fin, 
                                                    descripcion, 
                                                    id_siguiente,
                                                    tramite ,
                                                    codigo,
                                                    id_funcionario,
                                                    funcionario,
                                                    id_usuario,
                                                    cuenta,
                                                    id_depto,
                                                    depto,
                                                    nombre_usuario_ai,
                                                    id_padre,
                                                    arbol,
                                                    id_anterior,
                                                    etapa
                                                   )
                                                   VALUES(
                                                             
                                                    NULL,
                                                    NULL,
                                                    'obs', 
                                                    v_registros_obs.titulo, 
                                                    v_registros_obs.fecha_ini, 
                                                    COALESCE(v_registros_obs.fecha_fin, now()),--fecha_fin, 
                                                    COALESCE(v_registros_obs.descripcion,'')||' ['||v_registros_obs.estado||']', 
                                                    0,-- id_siguiente, no lo conocemos todavia
                                                    v_registros_obs.num_tramite,
                                                    'obs',                              
                                                    v_registros_obs.id_funcionario,
                                                    v_registros_obs.funcionario,
                                                    v_registros_obs.id_usuario_reg,
                                                    v_registros_obs.cuenta,
                                                    NULL,
                                                    NULL,
                                                    v_registros_obs.usuario_ai,
                                                    v_id_estado,   -- el padre es el estado observado
                                                    'close',
                                                    v_id_estado,
                                                    v_registros.etapa
                                                   ) RETURNING id into v_id_obs;
                       
                       
                       END LOOP;
       
       
          END LOOP;
          
          raise notice 'Sale del foor';
          
          --si es el ultimo ciclo, le cambia el tipo al ultimo estado
          
         IF  v_temp_fin = 'si' THEN
          
              update temp_gant_wf set
               tipo = 'estado_final',
               id_siguiente = 0,
               fecha_fin = NULL
                                
              where
               id = v_id_proceso_ant;
       
         ELSE 
           
              update temp_gant_wf set
               fecha_fin = now(),
               id_siguiente = 0
                                
              where
               id = v_id_proceso_ant;
               
               v_fecha_fin_proc = now();
         
          END IF;
          
          --modifica las fecha inicial y fin del proceso
          
             update temp_gant_wf set
                fecha_ini = v_fecha_ini_proc,
                fecha_fin = v_fecha_fin_proc
                                
             where
             id = v_id_proceso;
          
          --llamada recursica de los procesos disparados
          
           raise notice 'inicia recursividad';
          
         
          
  
   RETURN TRUE;


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
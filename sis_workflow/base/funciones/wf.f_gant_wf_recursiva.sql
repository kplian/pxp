--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_gant_wf_recursiva (
  p_id_proceso_wf integer,
  p_id_estado_wf integer,
  p_id_usuario integer
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
 

BEGIN



    v_nombre_funcion = 'wf.f_gant_wf_recursiva';


       --recuperamos datos del proceso wf
       select  
        pwf.id_proceso_wf,
        pwf.fecha_ini,
        pwf.nro_tramite,
        pwf.descripcion,
        pwf.id_estado_wf_prev,
        pwf.id_tipo_proceso,
        tp.codigo,
        tp.nombre
       
       into
         v_registro_proceso_wf
       from wf.tproceso_wf pwf
       inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
       where  pwf.id_proceso_wf = p_id_proceso_wf;
       
       
       raise notice 'antes del insert';
       
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
                    codigo
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
                    v_registro_proceso_wf.codigo
                   ) RETURNING id into v_id_proceso;
       
         raise notice 'inicio ';
       
           v_sw = 0;
           v_i =1;
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
                         ewf.usuario_ai
                         
                         
                       FROM  wf.testado_wf ewf
                       INNER JOIN  wf.ttipo_estado te on ewf.id_tipo_estado = te.id_tipo_estado
                       LEFT JOIN   segu.tusuario usu on usu.id_usuario = ewf.id_usuario_reg
                       LEFT JOIN  orga.vfuncionario fun on fun.id_funcionario = ewf.id_funcionario
                       LEFT JOIN  param.tdepto depto on depto.id_depto = ewf.id_depto
                     
                       WHERE 
                          ewf.id_proceso_wf = v_registro_proceso_wf.id_proceso_wf
                      
                          ORDER BY ewf.fecha_reg) LOOP
                          
                        raise notice 'loop  v_sw %,  v_i % ',v_sw,v_i;
       
                     
                      
                     
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
                              nombre_usuario_ai
                              
                               
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
                              v_registros.usuario_ai 
                             ) RETURNING id into v_id_estado;
                      
                       
                       --si es un nodo disparador buscamos almacenamos la referencia
                       
                         IF v_registros.disparador = 'si' THEN
                        	v_id_almacenado [v_i] = v_registros.id_estado_wf;
                            v_i = v_i +1;
                            
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
          
          FOR  v_registros in (
                       SELECT
                          pwf.id_proceso_wf,
                          pwf.id_estado_wf_prev
                       FROM wf.tproceso_wf  pwf
                       WHERE pwf.id_estado_wf_prev =ANY (v_id_almacenado)
                       ORDER BY pwf.fecha_reg ) LOOP
             
                 --llamada recursiva
                 
                   raise notice 'llamada recursiva %',v_registros.id_proceso_wf ;
                 
                IF not ( wf.f_gant_wf_recursiva(v_registros.id_proceso_wf, v_registros.id_estado_wf_prev ,p_id_usuario)) THEN
                
                
                  raise exception 'Error al recuperar los datos del diagrama gant';
                
                END IF;
          
          END LOOP;
          
  
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
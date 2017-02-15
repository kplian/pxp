--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_uo_tmp (
)
RETURNS boolean AS
$body$
DECLARE
 
v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
  
BEGIN
 
   
   
   
   FOR v_registros in (select 
                           uot.nro,
                           uot.codigo_padre,
                           uot.codigo,
                           uot.estado,
                           uot.padre,
                           uot.unidad
                        from orga.tuo_tmp uot
                        WHERE uot.migrado = 'no' )LOOP
                        
                        
              --verificamos si el codigo ya existe
               if exists (select 1 from orga.tuo where codigo=v_registros.codigo and estado_reg='activo') then                  
                   raise notice 'Insercion no realizada. CODIGO DE UO EN USO %', v_registros.codigo;               
               ELSE
               
                    v_id_uo_padre = NULL;
                    v_id_uo = NULL;
               
                   -- insertamos registro
                   
                   IF (v_registros.codigo_padre is null or  v_registros.codigo_padre = '0' or  v_registros.codigo_padre = '') and (v_registros.padre is null or  v_registros.padre = '0' or  v_registros.padre = '') THEN
                      
                       -- recupera el nivel organizacional de empresa
                        select 
                           id_nivel_organizacional
                          into
                            v_id_nivel_organizacional
                         from orga.tnivel_organizacional no
                         where no.nombre_nivel ilike 'EMPRESA';
                      
                        --es un nodo base
                       insert into orga.tuo( 
                           codigo,      
                           nombre_unidad,
                           nombre_cargo,   
                           descripcion, 
                           cargo_individual,
                           presupuesta,    
                           estado_reg,  
                           fecha_reg,
                           id_usuario_reg, 
                           nodo_base, 
                           correspondencia, 
                           gerencia,
                           id_nivel_organizacional,
                           codigo_alterno)
                       values(
                         upper(v_registros.codigo), 
                         upper(v_registros.unidad), 
                         upper(v_registros.unidad), 
                         upper(v_registros.unidad),
                         'no',
                         'no', --v_parametros.presupuesta, 
                         'activo', 
                         now()::date, 
                         1, --par_id_usuario, 
                         'si',--v_parametros.nodo_base, 
                         'no',--v_parametros.correspondencia, 
                         'no',--v_parametros.gerencia,
                         v_id_nivel_organizacional,
                         upper(v_registros.codigo));
                         
                         
                         update orga.tuo_tmp set
                              migrado = 'si'
                         WHERE unidad = v_registros.unidad
                                  and migrado = 'no';
                      
                   ELSE
                   
                      -- Si es un nodo hijo
                      
                          select 
                           id_nivel_organizacional
                          into
                            v_id_nivel_organizacional
                         from orga.tnivel_organizacional no
                         where no.nombre_nivel ilike 'UNIDAD';
                      
                       
                      -- recupera el id del nodo padre
                      IF v_registros.codigo_padre is not null and v_registros.codigo_padre != '' THEN
                            select 
                               uo.id_uo
                              into
                                v_id_uo_padre
                            
                            from orga.tuo uo
                            where uo.codigo = pper(v_registros.codigo_padre) and
                                 uo.estado_reg = 'activo';
                      ELSE
                               select 
                               uo.id_uo
                              into
                                v_id_uo_padre
                            
                            from orga.tuo uo
                            where uo.nombre_unidad = upper(v_registros.padre) and
                                 uo.estado_reg = 'activo';
                      
                      END IF;
                      
                      
                      IF v_id_uo_padre is not null THEN
                          -- inserta uo
                          
                           if exists (select 1 from orga.tuo where codigo=v_registros.codigo and estado_reg='activo') then
                  
                                   raise notice 'Insercion no realizada. CODIGO DE UO EN USO %', v_registros.codigo;
                           else 
                          
                                insert into orga.tuo( 
                                   codigo,      
                                   nombre_unidad,
                                   nombre_cargo,   
                                   descripcion, 
                                   cargo_individual,
                                   presupuesta,    
                                   estado_reg,  
                                   fecha_reg,
                                   id_usuario_reg, 
                                   nodo_base, 
                                   correspondencia, 
                                   gerencia,
                                   id_nivel_organizacional,
                                   codigo_alterno)
                               values(
                                   upper(v_registros.codigo), 
                                   upper(v_registros.unidad), 
                                   upper(v_registros.unidad), 
                                   upper(v_registros.unidad),
                                  'no',
                                  'no', --v_parametros.presupuesta, 
                                  'activo', 
                                  now()::date, 
                                  1, --par_id_usuario, 
                                  'no',--v_parametros.nodo_base, 
                                  'no',--v_parametros.correspondencia, 
                                  'no',--v_parametros.gerencia,
                                  v_id_nivel_organizacional,
                                  upper(v_registros.codigo)) RETURNING id_uo into v_id_uo; 
                          
                              -- insetar estructura uo
                              
                               INSERT INTO orga.testructura_uo(
                                   id_uo_hijo, 
                                   id_uo_padre, 
                                   estado_reg, 
                                   id_usuario_reg, 
                                   fecha_reg)
                                 values
                                   ( v_id_uo, 
                                   (v_id_uo_padre)::integer,
                                    'activo',    
                                    1, 
                                  now()::date);
                          
                          
                          end if;
                          
                           update orga.tuo_tmp set
                              migrado = 'si'
                            
                            WHERE unidad = v_registros.unidad
                                  and migrado = 'no';
                          
                      ELSE
                          raise notice 'No se encontro el nodo padre %, no se inserta nada en la linea %', v_registros.codigo_padre, v_registros.nro;
                      END IF;
                   
                   END IF;
               
               END IF;

              
              
             
          
                        
      
    
   
   END LOOP;
  

reTURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
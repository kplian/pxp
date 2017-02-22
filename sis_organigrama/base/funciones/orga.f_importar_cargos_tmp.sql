--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_cargos_tmp (
)
RETURNS boolean AS
$body$
DECLARE
 
v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
v_id_cargo		integer;
v_id_tipo_contrato  integer;
v_id_uo_cargo		integer;
v_id_lugar			integer;
  
BEGIN
 
   
   
   
   FOR v_registros in ( select 
                         ct.cargo,
                         ct.codigo_uo,
                         ct.item,
                         ct.migrado,
                         ct.uo,
                         ct.individual,
                         ct.contrato,
                         ct.lugar
                       from orga.tcargo_tmp ct
                       where ct.migrado = 'no')LOOP
                       
             v_id_uo = NULL;
             v_id_uo_cargo = NULL;
			 v_id_lugar = NULL;	             
             
             
            --recupera el lugar
             
            select 
              l.id_lugar
            into
              v_id_lugar
            from param.tlugar l
            where  upper(l.nombre) = upper(v_registros.lugar);
            
            IF v_id_lugar is null THEN
              raise exception 'no se encontro lugar para %',v_registros.lugar;
            END IF;
             
              
             
             
            --recupera el tipo de contrato
            
            select
                tc.id_tipo_contrato
              into
                v_id_tipo_contrato
            from orga.ttipo_contrato tc
            where upper(tc.nombre) = upper(v_registros.contrato);
                    
                       
            --recuperar el ID DE la UO 
            
             select 
                  uo.id_uo
                 into
                  v_id_uo
                from orga.tuo uo
                where uo.codigo = v_registros.codigo_uo;
                
                
            IF v_registros.individual = 'si' THEN
                
               v_id_uo_cargo = v_id_uo;
            
            ELSE                
                -- verifica si existe una uo con el mismo nombre y con el m mismo padre
                
                select 
                   uo.id_uo
                  into
                   v_id_uo_cargo
                from orga.tuo uo
                inner join orga.testructura_uo euo on euo.id_uo_hijo = uo.id_uo
                where euo.id_uo_padre = v_id_uo 
                      and upper(uo.nombre_cargo) = upper(v_registros.cargo); 
                
                --si no encontramos una uo para el cargo la creamos
                IF v_id_uo_cargo is NULL THEN
                
                        -- Si es un nodo hijo
                      
                          select 
                           id_nivel_organizacional
                          into
                            v_id_nivel_organizacional
                         from orga.tnivel_organizacional no
                         where no.nombre_nivel ilike 'UNIDAD';
                         
                         
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
                                   upper(v_registros.item), 
                                   upper(v_registros.cargo), 
                                   upper(v_registros.cargo), 
                                   upper(v_registros.cargo),
                                  'no',
                                  'no', --v_parametros.presupuesta, 
                                  'activo', 
                                  now()::date, 
                                  1, --par_id_usuario, 
                                  'no',--v_parametros.nodo_base, 
                                  'no',--v_parametros.correspondencia, 
                                  'no',--v_parametros.gerencia,
                                  v_id_nivel_organizacional,
                                  upper(v_registros.item)) RETURNING id_uo into v_id_uo_cargo; 
                                  
                                  
                           
                               INSERT INTO orga.testructura_uo(
                                   id_uo_hijo, 
                                   id_uo_padre, 
                                   estado_reg, 
                                   id_usuario_reg, 
                                   fecha_reg)
                                 values(
                                    v_id_uo_cargo, 
                                    (v_id_uo)::integer,
                                    'activo',    
                                     1, 
                                  now()::date);   
                                  
                                  raise notice 'se creo una uo dependiente de % con el codigo % (%)', v_registros.codigo_uo,v_registros.item ,v_registros.cargo;    
                   
                
                END IF;
            
            END IF;
  
            
            IF v_id_uo is not null and v_id_uo_cargo is not null THEN   
                     
                 --Sentencia de la insercion
                  insert into orga.tcargo(
                      id_tipo_contrato,
                      id_lugar,
                      id_uo,			
                      id_escala_salarial,
                      codigo,
                      nombre,
                      fecha_ini,
                      estado_reg,
                      fecha_fin,
                      fecha_reg,
                      id_usuario_reg,
                      fecha_mod,
                      id_usuario_mod,
                      id_oficina
                  ) values(
                      v_id_tipo_contrato,
                      v_id_lugar,
                      v_id_uo_cargo,			
                      2,--v_parametros.id_escala_salarial,
                      v_registros.item,
                      v_registros.cargo,
                      '01/01/2015',
                      'activo',
                      NULL,--v_parametros.fecha_fin,
                      now(),
                      1,--p_id_usuario,
                      null,
                      null,
                      null--v_parametros.id_oficina
      							
                  )RETURNING id_cargo into v_id_cargo;
                  
                  
                  update orga.tcargo_tmp set
                     migrado = 'si',
                     id_cargo = v_id_cargo
                   where codigo_uo = v_registros.codigo_uo
                         and cargo = v_registros.cargo
                         and item = v_registros.item;
                          
                  
                  
                  
           ELSE
              raise notice 'no se encontro la UO %',v_registros.codigo_uo;
                
           END IF;           
      
   
   END LOOP;
  

RETURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
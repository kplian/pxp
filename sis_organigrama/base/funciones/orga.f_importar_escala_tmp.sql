--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_importar_escala_tmp (
)
RETURNS boolean AS
$body$
DECLARE
 
v_registros record;
v_id_nivel_organizacional	integer;
v_id_uo	integer;
v_id_uo_padre	integer;
v_id_escala_salarial	integer;
  
BEGIN
 
   
   
   
   FOR v_registros in (select
     et.codigo,
     et.nombre,
     et.monto
   from orga.tescala_salarial_tmp et
   where et.migrado = 'no')LOOP
   
   
                     
   --Sentencia de la insercion
        	insert into orga.tescala_salarial(
                aprobado,
                id_categoria_salarial,
                estado_reg,
                haber_basico,
                nombre,
                nro_casos,
                codigo,
                fecha_reg,
                id_usuario_reg,
                id_usuario_mod,
                fecha_mod,
                fecha_ini
          	) values(
			
                'si',
                1,
                'activo',
                v_registros.monto,
                v_registros.codigo||v_registros.nombre,
                0,
                v_registros.codigo||v_registros.nombre,
                now(),
                1,
                null,
                null,
                now()
							
			)RETURNING id_escala_salarial into v_id_escala_salarial;   
             
              
           update orga.tescala_salarial_tmp set
             id_escala_salarial = v_id_escala_salarial,
             migrado = 'si'
           where   codigo = v_registros.codigo
                 and nombre = v_registros.nombre ;
             
          
                        
      
    
   
   END LOOP;
  

reTURN TRUE;
  

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
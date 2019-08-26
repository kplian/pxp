--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.f_grant_privileges_only_read (
  p_user varchar,
  p_esquema varchar
)
RETURNS void AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE SSS
***************************************************************************
 SCRIPT: 		segu.f_grant_privileges_only_read
 DESCRIPCIÓN: 	Función para asignar  privilegios  de solo lectura
               objetos de esquema sobre un usuario o rol
 AUTOR: 		RAC
 FECHA:			26/08/2019
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

 HISTORIAL DE MODIFICACIONES:
 ISUUE			FECHA			 AUTHOR 		 DESCRIPCION	
#54 ETR  26/08/2019     RAC  Funcion apra asignacion de permisos de solo lectura
***************************************************************************/

DECLARE
   objeto              record;
   v_record            record;
   x	               varchar;
   consulta            varchar;
   v_conjunto_esquemas varchar;
BEGIN
 

/*

tambien se puede usar el siguiente comando 


*/

   IF p_esquema = 'todos' THEN
      --listas esquemas
     v_conjunto_esquemas='';
      FOR v_record IN (select * from segu.tsubsistema  s where s.estado_reg = 'activo' ) LOOP
             x=' GRANT USAGE   ON SCHEMA '||v_record.codigo||' TO "'||p_user||'"';
              RAISE NOTICE  '> %',x;
              EXECUTE (x);              
              if(v_conjunto_esquemas='') THEN
	              v_conjunto_esquemas=''''|| lower(v_record.codigo)||'''';
              ELSE
                 v_conjunto_esquemas=v_conjunto_esquemas||','''||lower(v_record.codigo)||'''';
              END IF;
              
      END LOOP;
      
      
               consulta:= 'SELECT viewname as d , schemaname as c FROM pg_views WHERE schemaname IN ('||v_conjunto_esquemas||')
               UNION
               SELECT tablename as d, schemaname as c FROM pg_tables WHERE schemaname IN ('||v_conjunto_esquemas||')
               UNION
               SELECT relname as d, schemaname as c FROM pg_statio_all_sequences WHERE schemaname IN ('||v_conjunto_esquemas||')';

      
       
   ELSE
   
  
  
       x='GRANT USAGE   ON SCHEMA "'||p_esquema||'" TO "'||p_user'"';   
       RAISE NOTICE  '%',x;
       EXECUTE (x);
       
       
   consulta:= 'SELECT viewname as d, schemaname as c FROM pg_views WHERE schemaname='''||p_esquema||'''
               UNION
               SELECT tablename as d, schemaname as c FROM pg_tables WHERE schemaname='''||p_esquema||'''
               UNION
               SELECT relname as d, schemaname as c FROM pg_statio_all_sequences WHERE schemaname='''||p_esquema||'''';
   
   END IF;
    
    raise notice '%',consulta;

   FOR objeto IN   EXECUTE (consulta)   LOOP
    --  RAISE NOTICE 'Asignando todos los privilegios a % sobre %  en el esquema %', p_user,? objeto.d, p_esquema;
      

       if((objeto.c||'.'||objeto.d) not in ('segu.tusuario','segu.tlog')
        
       ) THEN
       
         x= 'GRANT SELECT   ON  "'||objeto.c||'"."'|| objeto.d ||'"  TO "'||p_user||'"';
         RAISE NOTICE  '%',x;
         EXECUTE (x);
         
       ELSE
         raise notice '>>>>>>>>>>>>>>>>>>   Ingnorar %.%',objeto.c,objeto.d;
       END IF;
       
   END LOOP;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
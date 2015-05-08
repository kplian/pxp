CREATE OR REPLACE FUNCTION segu.f_grant_all_privileges (
  p_user text,
  p_esquema text
)
RETURNS void
AS 
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE SSS
***************************************************************************
 SCRIPT: 		segu.f_grant_all_privileges
 DESCRIPCIÓN: 	Función para asignar todos los privilegios 
               objetos de esquema sobre un usuario o rol
 AUTOR: 		RAC
 FECHA:			29/02/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/

DECLARE
   objeto record;
   v_record record;
   x	varchar;
   consulta varchar;
   v_conjunto_esquemas varchar;
BEGIN
   IF p_esquema = 'todos' THEN
      --listas esquemas
     v_conjunto_esquemas='';
      FOR v_record IN (select * from segu.tsubsistema) LOOP
             x=' GRANT ALL PRIVILEGES ON SCHEMA '||v_record.codigo||' TO "'||p_user||'"';
              RAISE NOTICE  '%',x;
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
   
  
  
       x='GRANT ALL PRIVILEGES ON SCHEMA "'||p_esquema||'" TO "'||p_user'"';   
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
    --  RAISE NOTICE 'Asignando todos los privilegios a % sobre %  en el esquema %', p_user, objeto.d, p_esquema;
      

       if((objeto.c||'.'||objeto.d) not in ('segu.tusuario','segu.tlog')
        
       ) THEN
       
         x= 'GRANT ALL PRIVILEGES ON  "'||objeto.c||'"."'|| objeto.d ||'"  TO "'||p_user||'"';
         RAISE NOTICE  '%',x;
         EXECUTE (x);
         
       ELSE
         raise notice '>>>>>>>>>>>>>>>>>>   Ingnorar %.%',objeto.c,objeto.d;
       END IF;
       
   END LOOP;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_importar_menu (OID = 305032) : 
--

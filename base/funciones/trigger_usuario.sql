CREATE OR REPLACE FUNCTION pxp.trigger_usuario (
)
RETURNS trigger
AS 
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE SEGURIDAD (SSS)
***************************************************************************
 SCRIPT: 		trisg_usuario
 DESCRIPCIÓN: 	Permite insertar, modificar y eliminar usuarios de la base
                de datos
 AUTOR: 		KPLIAN(rac)
 FECHA:			11-09-2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:
 
 DESCRIPCION:	cambio que permite crear nombre de usuario con .
 AUTOR:			KPLIAN (rac)
 FECHA:			26/11/2011

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

--**** DECLARACION DE VARIABLES DE LA FUNCIÓN (LOCALES) ****---


DECLARE

    --PARÁMETROS FIJOS

    g_consulta         text;    -- VARIABLE QUE CONTENDRÁ LA CONSULTA DINÁMICA PARA EL FILTRO
    g_new_login            text;
    g_old_login            text;
    y varchar;
    
    _SEMILLA varchar;
BEGIN

      --*** EJECUCIÓN DEL PROCEDIMIENTO ESPECÍFICO

  --procedimiento de creación de base de datos

_SEMILLA = '+_)(*&^%$#@!@TERPODO';


    IF TG_OP = 'INSERT' THEN

                BEGIN
                select (current_database()::text)||'_'||NEW.cuenta into g_new_login;
                IF  EXISTS (
                  SELECT *
                  FROM   pg_catalog.pg_user
                  WHERE  usename = g_new_login) THEN
                  
                	EXECUTE('DROP USER "'||g_new_login||'"');                 
                END IF;
                
                     -- Creación Usuario
                     g_consulta := 'CREATE USER'||' "'||g_new_login||'"';
                     g_consulta := g_consulta||' '||'WITH SUPERUSER ENCRYPTED PASSWORD '''||md5(_SEMILLA||NEW.contrasena)||'''';
                     g_consulta := g_consulta||' '||'VALID UNTIL '''||NEW.fecha_caducidad||'''';

                     EXECUTE(g_consulta);

                  
                     --ASGINACION DE ROLES
                     
                     --y:='ALTER GROUP rol_usuario_'||current_database()::text||'
                     --ADD USER  "'||g_new_login||'"';
                     --EXECUTE (y); 
                     
         
                END;

          --procedimiento de modificacion de usuario

     

     
   ELSIF TG_OP = 'UPDATE' THEN

        BEGIN
        
            --raise exception  'llega';
            --Modificación de login
               select (current_database()::text)||'_'||NEW.cuenta into g_new_login;
               select (current_database()::text)||'_'||OLD.cuenta into g_old_login;
                 
                
           
                
             IF (OLD.cuenta != NEW.cuenta) THEN
               		 g_consulta := 'ALTER USER "'||g_old_login||'" RENAME TO "'||g_new_login||'"';
          
           		     EXECUTE(g_consulta);
                   
             END IF; 

             -- Modificación de la contraseña

            IF (OLD.contrasena != NEW.contrasena) THEN

                    g_consulta := NULL;
                    g_consulta := 'ALTER USER "'||g_new_login||'" ';
                    g_consulta := g_consulta||' '||'WITH ENCRYPTED PASSWORD '''||md5(_SEMILLA||NEW.contrasena)||'''';

                    EXECUTE(g_consulta);
                    
                   
                    
            END IF;

                 -- Modificación de la Fecha de Validez del usuario

            IF (OLD.fecha_caducidad != NEW.fecha_caducidad) THEN

                    g_consulta := NULL;
                    g_consulta := 'ALTER USER "'||g_new_login||'" ';
                    g_consulta := g_consulta||' '||'VALID UNTIL '''||NEW.fecha_caducidad||'''';

                    EXECUTE(g_consulta);

            END IF;
            
            
                   -- Modificación de la Fecha de Validez del usuario

           IF (NEW.estado_reg != OLD.estado_reg) THEN

                  IF (NEW.estado_reg = 'inactivo') THEN

                          g_consulta := NULL;
                          g_consulta := 'ALTER USER "'||g_new_login||'" ';
                          g_consulta := g_consulta||' '||'VALID UNTIL '''||now()||'''';
                          
                          EXECUTE(g_consulta);
                   ELSE      
                   
                          g_consulta := NULL;
                          g_consulta := 'ALTER USER "'||g_new_login||'"';
                          g_consulta := g_consulta||' '||'VALID UNTIL '''||NEW.fecha_caducidad||'''';

                          EXECUTE(g_consulta);
                   END IF;
            END IF;


        END;

  --procedimiento de eliminación de usuario

   ELSIF TG_OP = 'DELETE' THEN

        BEGIN
        /*select (current_database()::text)||'_'||OLD.cuenta into g_old_login;
             g_consulta := 'DROP USER "'||g_old_login||'"';
            
             EXECUTE(g_consulta);
*/
        END;
        --*/

   END IF;

   RETURN NULL;

END;
$body$
    LANGUAGE plpgsql;

--
-- Definition for function f_insert_tfuncion (OID = 429309) : 
--

CREATE OR REPLACE FUNCTION pxp.f_crear_rol_sistema (
  puser character varying,
  ppassword character varying,
  pmismo_pass boolean
)
RETURNS varchar
AS 
$body$
DECLARE
  v_user_name varchar;
  v_password varchar;
BEGIN
	v_user_name = current_database() || '_' || puser;
    IF (pmismo_pass = TRUE) THEN
    	v_password = v_user_name;
    ELSE
    	v_password = ppassword;
    END IF;
	IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_user
      WHERE  usename = v_user_name) THEN

      EXECUTE(	'CREATE ROLE ' || v_user_name || 
      			' SUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION ');
   	END IF;
    
    EXECUTE ('ALTER ROLE ' || v_user_name || ' PASSWORD ''' || v_password|| '''');
    return 'exito';
END;
$body$
    LANGUAGE plpgsql;
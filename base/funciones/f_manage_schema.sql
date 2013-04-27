CREATE OR REPLACE FUNCTION pxp.f_manage_schema (
  par_esquema varchar,
  par_opcion integer
)
RETURNS varchar AS
$body$
DECLARE
  v_response	varchar;
BEGIN
  v_response = '';	
  if (par_opcion = 1)then
  	EXECUTE 'DROP SCHEMA IF EXISTS ' || par_esquema || ' CASCADE';
  	v_response = 'Esquema ' || par_esquema || 'eliminado correctamente';
  end if;
  if (par_opcion in (1, 2)) then
  	IF NOT EXISTS(
        SELECT schema_name
          FROM information_schema.schemata
          WHERE schema_name = par_esquema
      )
    THEN
      EXECUTE 'CREATE SCHEMA ' || par_esquema || ' AUTHORIZATION postgres';
      v_response = v_response || '\nEsquema ' || par_esquema || 'eliminado correctamente';
    END IF;
  end if;
  return v_response;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
DROP SCHEMA IF EXISTS pxp CASCADE;
CREATE SCHEMA pxp AUTHORIZATION postgres;

CREATE TABLE pxp.tscript_version (
  codigo VARCHAR(50) NOT NULL
) WITHOUT OIDS;

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
  if (par_opcion in (1, 2,3)) then
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

CREATE OR REPLACE FUNCTION pxp.f_is_loaded_script (
  p_codigo varchar
)
RETURNS integer AS
$body$
DECLARE
BEGIN	
	IF (not exists (SELECT 1 
    			from pxp.tscript_version 
                where codigo = p_codigo))THEN
    	return 0;
    ELSE
    	return 1;
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;


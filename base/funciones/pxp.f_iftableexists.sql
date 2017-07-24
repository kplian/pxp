--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_iftableexists (
  varchar
)
RETURNS boolean AS
$body$
DECLARE

 BEGIN

     /* check the table exist in database and is visible*/
 perform n.nspname ,c.relname
FROM pg_catalog.pg_class c LEFT JOIN pg_catalog.pg_namespace n ON n.oid
= c.relnamespace
where n.nspname like 'pg_temp_%' AND pg_catalog.pg_table_is_visible(c.oid)
AND Upper(relname) = Upper($1);

     IF FOUND THEN
        RETURN TRUE;
     ELSE
        RETURN FALSE;
     END IF;

 END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
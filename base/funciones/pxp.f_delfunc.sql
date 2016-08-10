-- Function: pxp.f_delfunc(text)

-- DROP FUNCTION pxp.f_delfunc(text);

CREATE OR REPLACE FUNCTION pxp.f_delfunc(p_name text)
  RETURNS void AS
$BODY$
DECLARE

	v_name    		text;
	v_nspname           	text;
	v_consulta		text;
	
BEGIN

v_nspname = trim(both ' ' from split_part(p_name, '.', 1));
v_name = trim(both ' ' from split_part(p_name, '.', 2));
if (not exists (select 1 
				from  pg_proc p
				inner join pg_depend d on p.oid = d.refobjid and d.deptype = 'n'
				inner join pg_namespace n ON n.oid =  p.pronamespace
				where  p.proname = v_name
   				AND    n.nspname = v_nspname)) then
	 SELECT string_agg(format('DROP FUNCTION %s(%s);'
	                     ,proc.oid::regproc
	                     ,pg_catalog.pg_get_function_identity_arguments(proc.oid))
	          ,E'\n') into  v_consulta
	   FROM   pg_proc proc
	   INNER JOIN pg_namespace nm ON nm.oid =  proc.pronamespace
	   WHERE  proc.proname = v_name
	   AND    nm.nspname = v_nspname;
	if (v_consulta is not null) then   
		EXECUTE (v_consulta);
	end if;
end if;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION pxp.f_delfunc(text)
  OWNER TO postgres;

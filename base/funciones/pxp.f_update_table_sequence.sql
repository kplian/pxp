CREATE OR REPLACE FUNCTION pxp.f_update_table_sequence(p_esquema character varying, p_tabla character varying)
  RETURNS character varying AS
$BODY$
/*
Author: Ariel Ayaviri Omonte
Date: 06/05/2013
Description: Update the sequence to last + 1 number
*/
DECLARE
    v_nombre_funcion text;
    v_resp varchar;
    v_tabla text;
    v_llave name;
    v_secuencia text;
    v_sql varchar;
    v_cant numeric;

BEGIN
	v_nombre_funcion = 'alm.f_update_table_sequence';
	
	select tabla, llave, secuencia into v_tabla, v_llave, v_secuencia
	from pxp.vtabla_llave_secuencia
	where tabla = p_esquema || '.' || p_tabla;

	v_sql = 'SELECT coalesce(max('||v_llave||'), 0) + 1 FROM '||v_tabla||';';
	EXECUTE v_sql INTO v_cant;

	v_sql = 'alter sequence '|| v_secuencia ||' restart with '||v_cant;
	EXECUTE v_sql;
	
	return 'secuencia actualizada';

EXCEPTION					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION pxp.f_update_table_sequence(character varying, character varying)
  OWNER TO postgres;

-- Function: pxp.f_update_sequences()

-- DROP FUNCTION pxp.f_update_sequences();

CREATE OR REPLACE FUNCTION pxp.f_update_sequences()
  RETURNS character varying AS
$BODY$
/*
Author: RCM
Date: 30/11/2012
Description: Restart all sequences with last value + 1 for every table
*/
DECLARE

    v_rec record;
    v_rec1 record;
    v_sql varchar;
    v_cant numeric;

BEGIN
	--Creación de tabla temporal para almacenar el ID máximo por tabla
    v_sql = 'create temp table tt_tabla_secuencia(
		filas integer default 0
		) on commit drop';
    execute(v_sql);

	--Recorrido de todas las tablas con su llave y secuencia
    for v_rec in (select * from pxp.vtabla_llave_secuencia) loop
	    raise notice '%   %   %',v_rec.tabla,v_rec.llave,v_rec.secuencia;
	    --ALmacena temporalmente el maximo id de la tabla
		v_sql = 'insert into tt_tabla_secuencia(filas) select coalesce(max('||v_rec.llave||'),0)+1 from '||v_rec.tabla;
		execute(v_sql);
		
		--Obtiene el máximo almacenado
		v_sql = 'select filas from tt_tabla_secuencia';
		for v_rec1 in execute(v_sql) loop
			v_cant = v_rec1.filas;
		end loop;
	
		--Reinicia la secuencia
		v_sql = 'alter sequence '|| v_rec.secuencia ||' restart with '||v_cant;
		execute(v_sql);
	    
	    --ELimina el registro temporal
	    v_sql = 'delete from tt_tabla_secuencia';
		execute(v_sql);
	
    end loop;

    --Respuesta
    return 'secuencias actualizadas';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION pxp.f_update_sequences() OWNER TO postgres;

CREATE OR REPLACE FUNCTION gen.f_obtener_datos_tabla_sel (
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS SETOF record
AS 
$body$
/*
Autor: RCM
Fecha: 19/11/201
Descripción: Función que devuelve los datos de las columnas y de la tabla para el generador
*/

DECLARE

	v_consulta    		varchar;
	v_rec  				record;
	v_nombre_funcion   	text;
    v_resp				varchar;
    v_sql				varchar;

BEGIN

    v_nombre_funcion:='gen.f_obtener_datos_tabla_sel';

    if p_transaccion = 'GEN_COLUMN_SEL' then

    	begin
        	--1. Creación de la tabla temporal para almacenar todos los datos de la columna
            v_sql = 'create temp table tt_tabla_metadatos(id integer,
             												columna varchar,
                                                            descripcion varchar,
                                                            tipo_dato varchar,
                                                            longitud text,
                                                            nulo varchar,
                                                            checks varchar,
                                                            valor_defecto varchar,
                                                            grid_ancho integer,
                                                            grid_mostrar varchar,
                                                            form_ancho_porcen integer,
                                                            orden smallint,
                                                            grupo smallint

            ) on commit drop;';
            
            execute(v_sql);
            
            v_sql = 'create temp table tt_constraints(id integer,
            											nombre varchar
            ) on commit drop';
            execute(v_sql);
                        
            --2. Obtención de las columnas y sus metadatos
            v_sql = 'insert into tt_tabla_metadatos(
            		columna, descripcion, tipo_dato, checks, nulo, longitud,
                    valor_defecto, grid_ancho, grid_mostrar, form_ancho_porcen,
                    orden, grupo
            		)
                    SELECT DISTINCT
                    a.attname as column_name,
                    pg_catalog.obj_description(c.oid) as descripcion,
                    t.typname as tipo_dato,
                    CASE
                    WHEN cc.contype=''p'' THEN ''PK''
                    WHEN cc.contype=''u'' THEN ''UQ''
                    WHEN cc.contype=''f'' THEN ''FK''
                    ELSE '''' END AS cheks,
                    CASE WHEN a.attnotnull=false THEN ''si'' ELSE ''no'' END AS  nulo,
                    CASE WHEN a.attlen=''-1'' THEN (a.atttypmod - 4) ELSE a.attlen END as  longitud,
                    d.adsrc as valor_defecto,
                    100, ''si'', 80, null::smallint, 1::smallint
                    FROM pg_catalog.pg_attribute a
                    LEFT JOIN pg_catalog.pg_type t ON t.oid = a.atttypid
                    LEFT JOIN pg_catalog.pg_class c ON c.oid = a.attrelid
                    LEFT JOIN pg_catalog.pg_constraint cc ON cc.conrelid = c.oid AND cc.conkey[1] = a.attnum
                    LEFT JOIN pg_catalog.pg_attrdef d ON d.adrelid = c.oid AND a.attnum = d.adnum
                    WHERE c.relname = ''' || p_tabla || '''
                    AND a.attnum > 0
                    AND t.oid = a.atttypid
                    AND NOT a.attisdropped';

            --raise exception '%',v_sql;
            execute(v_sql);
            
            --5. Consulta de la tabla resultado
            for v_rec in execute('select distinct columna, descripcion, tipo_dato,
            					longitud, nulo, checks, valor_defecto,
                                grid_ancho, grid_mostrar, form_ancho_porcen,
                                orden, grupo
                                from tt_tabla_metadatos') loop
            	return next v_rec;
            end loop;
            
            --6. Respuesta
            return;
 
		end;

     else
     
         raise exception 'Transaccion inexistente';
         
     end if;

EXCEPTION

	WHEN OTHERS THEN
    	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_columna_ime (OID = 303919) : 
--

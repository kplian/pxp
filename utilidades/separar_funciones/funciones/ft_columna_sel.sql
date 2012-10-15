CREATE OR REPLACE FUNCTION gen.ft_columna_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/*
Autor: RCM
Fecha: 30/11/2010
Descripción: Función que devuelve conjuntos de datos
*/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
    v_resp				varchar;

BEGIN

    v_parametros:=pxp.f_get_record(p_tabla);
    v_nombre_funcion:='gen.ft_columna_sel';

    if p_transaccion = 'GEN_COLUMN_SEL' then

    	begin
        	v_consulta:='select
            			id_columna, nombre, descripcion,
            			id_tabla, id_usuario_reg, id_usuario_mod, fecha_reg,
            			fecha_mod, estado_reg, etiqueta,guardar,
                        tipo_dato, longitud, nulo, checks, valor_defecto,
                        grid_ancho, grid_mostrar, form_ancho_porcen, orden,
                        grupo
            			from gen.tcolumna
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice '%',v_consulta;
            return v_consulta;
		end;

    elsif p_transaccion = 'GEN_COLUMN_CONT' then

        begin
        	v_consulta:='select count(id_columna)
            			from gen.tcolumna
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
        end;

     elsif p_transaccion = 'GEN_DATCOL_SEL' then

    	begin
        	v_consulta:='
SELECT (col.table_schema)::character varying AS esquema,
    (col.table_name)::character varying AS tabla, (col.column_name)::character
    varying AS columna, (col.ordinal_position)::integer AS posicion,
    (col.column_default)::character varying AS defecto,
    (col.is_nullable)::character varying AS blanco, (col.data_type)::character
    varying AS tipo, CASE WHEN ((col.data_type)::text =
    ''character varying''::text) THEN (col.character_maximum_length)::integer
    WHEN ((col.data_type)::text = ''numeric''::text) THEN
    (col.numeric_precision)::integer ELSE 0 END AS length, CASE WHEN
    ((col.data_type)::text = ''numeric''::text) THEN (col.numeric_scale)::integer
    ELSE 0 END AS "precision", (cons.conname)::character varying AS
    nombre_constraint, (cons.consrc)::character varying AS definicion_constraint,
    col1.guardar,col1.etiqueta
FROM information_schema.columns col
INNER JOIN gen.tcolumna col1
    on(col1.nombre=col.column_name)
LEFT JOIN information_schema.constraint_column_usage colcon ON
    col.table_schema::text = colcon.table_schema::text AND
    col.table_name::text = colcon.table_name::text AND
    col.column_name::text = colcon.column_name::text
LEFT JOIN pg_constraint cons ON
    cons.conname = colcon.constraint_name::name AND
    cons.contype = ''c''::"char"
LEFT JOIN pg_class c ON
cons.conrelid =c.oid AND c.relname = col.table_name::name
WHERE '; --col.table_schema::text = 'rhum'::text AND
    --col.table_name::text = 'tcolumna'::text AND id_tabla=21;
      
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            return v_consulta;
		end;

     elsif p_transaccion = 'GEN_DATCOL_CONT' then

        begin
        	v_consulta:='select count(col1.relname)
            		from gen.vcolumna col1
			left join gen.tcolumna col2
			on col2.nombre = col1.relname
                        where ';
            v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
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
-- Definition for function ft_esquema_sel (OID = 303921) : 
--

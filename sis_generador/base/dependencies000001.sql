/***********************************I-DEP-RCM-GEN-0-14/01/2013****************************************/
ALTER TABLE ONLY gen.tcolumna
    ADD CONSTRAINT fk_tcolumna__id_tabla
    FOREIGN KEY (id_tabla) REFERENCES gen.ttabla(id_tabla);
    
ALTER TABLE ONLY gen.ttabla
    ADD CONSTRAINT fk_ttabla__id_subsistema
    FOREIGN KEY (id_subsistema) REFERENCES segu.tsubsistema(id_subsistema);

CREATE VIEW gen.vcolumna AS
SELECT col.table_schema AS esquema, col.table_name AS tabla,
    col.column_name AS columna, (col.ordinal_position)::integer AS
    posicion, (col.column_default)::character varying AS defecto,
    (col.is_nullable)::character varying AS blanco,
    (col.data_type)::character varying AS tipo, CASE WHEN
    ((col.data_type)::text = 'character varying'::text) THEN
    (col.character_maximum_length)::integer WHEN ((col.data_type)::text =
    'numeric'::text) THEN (col.numeric_precision)::integer ELSE 0 END AS
    length, CASE WHEN ((col.data_type)::text = 'numeric'::text) THEN
    (col.numeric_scale)::integer ELSE 0 END AS "precision",
    (cons.conname)::character varying AS nombre_constraint,
    (cons.consrc)::character varying AS definicion_constraint
FROM (((information_schema.columns col LEFT JOIN
    information_schema.constraint_column_usage colcon ON
    (((((col.table_schema)::text = (colcon.table_schema)::text) AND
    ((col.table_name)::text = (colcon.table_name)::text)) AND
    ((col.column_name)::text = (colcon.column_name)::text)))) LEFT JOIN
    pg_constraint cons ON (((cons.conname = (colcon.constraint_name)::name)
    AND (cons.contype = 'c'::"char")))) LEFT JOIN pg_class c ON
    (((cons.conrelid = c.oid) AND (c.relname = (col.table_name)::name))))
WHERE (((col.table_schema)::text <> 'pg_catalog'::text) AND
    ((col.table_schema)::text <> 'information_schema'::text));
/***********************************F-DEP-RCM-GEN-0-14/01/2013****************************************/
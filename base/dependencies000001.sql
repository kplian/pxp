/****************************I-SCP-RCM-PXP-0-30/11/2012*************/
CREATE VIEW "pxp"."vtabla_llave_secuencia" (
    tabla,
    llave,
    secuencia)
AS
 WITH fq_objects AS (
SELECT c.oid, (n.nspname::text || '.'::text) || c.relname::text AS fqname,
    c.relkind, c.relname AS relation
FROM pg_class c
      JOIN pg_namespace n ON n.oid = c.relnamespace
        ), sequences AS (
    SELECT fq_objects.oid, fq_objects.fqname AS secuencia
    FROM fq_objects
    WHERE fq_objects.relkind = 'S'::"char"
    ), tables AS (
    SELECT fq_objects.oid, fq_objects.fqname AS tabla
    FROM fq_objects
    WHERE fq_objects.relkind = 'r'::"char"
    ), llaves AS (
    SELECT DISTINCT n.nspname AS esquema, c.relname AS tabla, a.attname AS llave
    FROM pg_class c
      JOIN pg_namespace n ON n.oid = c.relnamespace
   JOIN pg_attribute a ON a.attrelid = c.oid
   JOIN pg_constraint cc ON cc.conrelid = c.oid AND cc.conkey[1] = a.attnum
    WHERE c.relkind = 'r'::"char" AND cc.contype = 'p'::"char" AND a.attnum > 0
        AND NOT a.attisdropped
    )
    SELECT t.tabla, k.llave, s.secuencia
    FROM pg_depend d
   JOIN sequences s ON s.oid = d.objid
   JOIN tables t ON t.oid = d.refobjid
   JOIN llaves k ON ((k.esquema::text || '.'::text) || k.tabla::text) = t.tabla
    WHERE d.deptype = 'a'::"char";
/****************************F-SCP-RCM-PXP-0-30/11/2012*************/
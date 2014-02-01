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
 
 --
-- Definition for aggregate list (OID = 305122) : 
--
CREATE AGGREGATE pxp.list (text) (
    SFUNC = pxp.comma_cat,
    STYPE = text
);
--
-- Definition for aggregate text_concat (OID = 305136) : 
--
CREATE AGGREGATE pxp.text_concat (text) (
    SFUNC = pxp.concat,
    STYPE = text
);
--
-- Definition for aggregate textcat_all (OID = 305137) : 
--
CREATE AGGREGATE pxp.textcat_all (text) (
    SFUNC = textcat,
    STYPE = text
);

--
-- Definition for aggregate aggarray (OID = 404687) : 
--
CREATE AGGREGATE pxp.aggarray (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);
--
-- Definition for aggregate aggarray1 (OID = 404688) : 
--
CREATE AGGREGATE pxp.aggarray1 (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);

/****************************F-SCP-RCM-PXP-0-30/11/2012*************/
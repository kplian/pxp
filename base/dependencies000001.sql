/****************************I-DEP-RCM-PXP-0-30/11/2012*************/
CREATE OR REPLACE  VIEW "pxp"."vtabla_llave_secuencia" (
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

/****************************F-DEP-RCM-PXP-0-30/11/2012*************/

/****************************I-DEP-JRR-PXP-0-25/04/2014********************************/

select pxp.f_insert_testructura_gui ('INITRAHP', 'SISTEMA');
select pxp.f_insert_testructura_gui ('VIDEMANU', 'SISTEMA');
select pxp.f_insert_testructura_gui ('INITRAHP.1', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.2', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.3', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.4', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.5', 'INITRAHP');
select pxp.f_insert_testructura_gui ('INITRAHP.1.1', 'INITRAHP.1');
select pxp.f_insert_testructura_gui ('INITRAHP.1.2', 'INITRAHP.1');
select pxp.f_insert_testructura_gui ('INITRAHP.4.1', 'INITRAHP.4');
select pxp.f_insert_testructura_gui ('INITRAHP.5.1', 'INITRAHP.5');
select pxp.f_insert_testructura_gui ('INITRAHP.5.1.1', 'INITRAHP.5.1');
select pxp.f_insert_testructura_gui ('ASINT', 'SISTEMA');

--los aggregates no se modoficaran solo las funciones de los aggregates
CREATE AGGREGATE pxp.list (text) (
    SFUNC = pxp.comma_cat,
    STYPE = text
);

CREATE AGGREGATE pxp.text_concat (text) (
    SFUNC = pxp.concat,
    STYPE = text
);

CREATE AGGREGATE pxp.textcat_all (text) (
    SFUNC = textcat,
    STYPE = text
);

CREATE AGGREGATE pxp.aggarray (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);

CREATE AGGREGATE pxp.aggarray1 (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);




CREATE AGGREGATE pxp.html_rows (
  varchar)
(
  SFUNC = pxp.html_rows,
  STYPE = "varchar"
);

CREATE AGGREGATE pxp.list_unique (
  text)
(
  SFUNC = pxp.list_unique,
  STYPE = text

);


CREATE AGGREGATE pxp.list_br (text)
(
  SFUNC = pxp.br_cat,
  STYPE = text
);

/****************************F-DEP-JRR-PXP-0-25/04/2014********************************/


/****************************I-DEP-RAC-PXP-0-17/08/2017********************************/

--------------- SQL ---------------

CREATE AGGREGATE pxp.concat_array (
  pg_catalog.anyarray)
(
  SFUNC = pxp.concat_array,
  STYPE = anyarray
);

/****************************F-DEP-RAC-PXP-0-17/08/2017********************************/

/****************************I-DEP-JJA-PXP-0-02/04/2019********************************/

select pxp.f_insert_testructura_gui ('PEHO', 'SISTEMA'); --#14 endetr Juan Agregado de menu pentaho
select pxp.f_insert_testructura_gui ('CUBO', 'PEHO');    --#14 endetr Juan Agregado de menu pentaho

/****************************F-DEP-JJA-PXP-0-02/04/2019********************************/

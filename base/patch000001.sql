/****************************I-SCP-JRR-PXP-1-19/11/2012*************/ 

CREATE EXTENSION IF NOT EXISTS dblink;
--
-- Definition for type enum_tipo_dato (OID = 303809) : 
--
SET search_path = pxp, pg_catalog;
CREATE TYPE pxp.enum_tipo_dato AS ENUM
  ( 'varchar', 'integer', 'float', 'numeric', 'boolean', 'text' );
--
-- Definition for type estado_reg (OID = 303822) : 
--
CREATE TYPE pxp.estado_reg AS ENUM
  ( 'activo', 'inactivo' );
  

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
-- Structure for table tbase (OID = 305288) : 
--
CREATE TABLE pxp.tbase (
    id_usuario_reg integer,
    id_usuario_mod integer,
    fecha_reg timestamp without time zone DEFAULT now(),
    fecha_mod timestamp without time zone DEFAULT now(),
    estado_reg varchar(10) DEFAULT 'activo'::character varying
) WITHOUT OIDS;
--
-- Definition for sequence parametro (OID = 306490) : 
--
CREATE SEQUENCE pxp.parametro
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
--
-- Structure for table variable_global (OID = 306540) : 
--
CREATE TABLE pxp.variable_global (
    id_variable_global serial NOT NULL,
    variable varchar NOT NULL,
    valor varchar(200) NOT NULL,
    descripcion varchar
) WITH OIDS;
ALTER TABLE ONLY pxp.variable_global ALTER COLUMN id_variable_global SET STATISTICS 0;
ALTER TABLE ONLY pxp.variable_global ALTER COLUMN valor SET STATISTICS 0;

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

--
-- Definition for index variable_global_pkey (OID = 308030) : 
--
ALTER TABLE ONLY variable_global
    ADD CONSTRAINT variable_global_pkey
    PRIMARY KEY (id_variable_global);
--
-- Definition for index variable_global_variable_key (OID = 308032) : 
--
ALTER TABLE ONLY variable_global
    ADD CONSTRAINT variable_global_variable_key
    UNIQUE (variable);
--
-- Definition for index fk_tbase__id_usuario_mod (OID = 308938) : 
--

/****************************F-SCP-JRR-PXP-1-19/11/2012*************/ 

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
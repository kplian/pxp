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

/****************************I-SCP-JRR-PXP-0-25/04/2014********************************/

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
select pxp.f_insert_tprocedimiento_gui ('WF_GATNREP_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_INS', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_MOD', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_ELI', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PWF_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_PROMAC_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_ANTEPRO_IME', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SESPRO_IME', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INITRAHP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_TUTO_SEL', 'VIDEMANU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SG_TUTO_CONT', 'VIDEMANU', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_MOD', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_ELI', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DWF_SEL', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CABMOM_IME', 'INITRAHP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPPROC_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_INS', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_MOD', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_ELI', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DES_SEL', 'INITRAHP.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_VERSIGPRO_IME', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_CHKSTA_IME', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_TIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DEPTIPES_SEL', 'INITRAHP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_DOCWFAR_MOD', 'INITRAHP.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INITRAHP.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'INITRAHP.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'INITRAHP.5.1.1', 'no');

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

/****************************F-SCP-JRR-PXP-0-25/04/2014********************************/
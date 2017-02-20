
DROP AGGREGATE IF EXISTS pxp.list (text);
CREATE AGGREGATE pxp.list (text) (
    SFUNC = pxp.comma_cat,
    STYPE = text
);
DROP AGGREGATE IF EXISTS pxp.text_concat (text);
CREATE AGGREGATE pxp.text_concat (text) (
    SFUNC = pxp.concat,
    STYPE = text
);
DROP AGGREGATE IF EXISTS pxp.textcat_all (text);
CREATE AGGREGATE pxp.textcat_all (text) (
    SFUNC = textcat,
    STYPE = text
);
DROP AGGREGATE IF EXISTS pxp.aggarray (anyelement);
CREATE AGGREGATE pxp.aggarray (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);
DROP AGGREGATE IF EXISTS pxp.aggarray1 (anyelement);
CREATE AGGREGATE pxp.aggarray1 (anyelement) (
    SFUNC = pxp.aggregate_array,
    STYPE = anyarray
);



DROP AGGREGATE IF EXISTS pxp.html_rows (varchar);
CREATE AGGREGATE pxp.html_rows (
  varchar)
(
  SFUNC = pxp.html_rows,
  STYPE = "varchar"
);
DROP AGGREGATE IF EXISTS pxp.list_unique (varchar);
CREATE AGGREGATE pxp.list_unique (
  text)
(
  SFUNC = pxp.list_unique,
  STYPE = text

);

DROP AGGREGATE IF EXISTS pxp.list_br (varchar);
CREATE AGGREGATE pxp.list_br (text)
(
  SFUNC = pxp.br_cat,
  STYPE = text
);




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
CREATE OR REPLACE FUNCTION param.f_get_id_lugares (
  p_id_lugar integer,
  p_padres_hijos varchar = 'hijos'::character varying
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 24/07/2013
*/
DECLARE

  v_ids varchar;

BEGIN

  if p_id_lugar is null then
      return '(null)';
    end if;

  if p_padres_hijos = 'padres' then
        WITH RECURSIVE t(id,id_fk,nombre,n) AS (
              SELECT l.id_lugar,l.id_lugar_fk, l.nombre,1
              FROM param.tlugar l
              WHERE l.id_lugar = p_id_lugar
              UNION ALL
              SELECT l.id_lugar,l.id_lugar_fk, l.nombre,n+1
              FROM param.tlugar l, t
              WHERE l.id_lugar = t.id_fk
          )
          SELECT (pxp.list(id::text))::varchar
          INTO v_ids
          FROM t;
          
    else
      WITH RECURSIVE t(id,id_fk,nombre,n) AS (
            SELECT l.id_lugar,l.id_lugar_fk, l.nombre,1
            FROM param.tlugar l
            WHERE l.id_lugar = p_id_lugar
            UNION ALL
            SELECT l.id_lugar,l.id_lugar_fk, l.nombre,n+1
            FROM param.tlugar l, t
            WHERE l.id_lugar_fk = t.id
        )
        SELECT (pxp.list(id::text))::varchar
        INTO v_ids
        FROM t;
    
    end if;
    
    return v_ids;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
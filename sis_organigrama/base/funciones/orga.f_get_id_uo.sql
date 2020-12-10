-- FUNCTION: orga.f_get_id_uo(character varying, character varying)

-- DROP FUNCTION orga.f_get_id_uo(character varying, character varying);

CREATE OR REPLACE FUNCTION orga.f_get_id_uo(
	p_id_estructura_uo character varying,
	p_padres_hijos character varying DEFAULT 'hijos'::character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
/*
Autor: RCM
Fecha: 19/08/2013
Proósito: Devolver recursivamente todos los ids padres o hijos a partir de un id_estructura_uo siguiendo la matriz de orga.testructura_uo
 #ETR-2026	09.12.2020		MZM					eliminacion de tabla temporal para evitar errores
*/
DECLARE

	v_ids varchar;
	v_sql varchar;

BEGIN

  if p_id_estructura_uo is null then
      return '(null)';
  end if;
  --#ETR-2026
  if exists (select 1 from pg_tables where tablename='tuos') then
    drop  table tuos;
  end if;
  
  create temp table tuos(
  	ids varchar
  ) on commit drop;


  if p_padres_hijos = 'padres' then
  		
        v_sql = 'insert into tuos
        	WITH RECURSIVE t(id,id_fk,n) AS (
              SELECT l.id_uo_hijo,l.id_uo_padre, 1
              FROM orga.testructura_uo l
              WHERE l.id_estructura_uo in (' || p_id_estructura_uo ||')
              UNION ALL
              SELECT l.id_uo_hijo,l.id_uo_padre,n+1
              FROM orga.testructura_uo l, t
              WHERE l.id_uo_hijo = t.id_fk
          )
          SELECT (pxp.list(id::text))::varchar
          FROM t';
          
    
    else
      v_sql = 'insert into tuos
      	WITH RECURSIVE t(id,id_fk,n) AS (
              SELECT l.id_uo_hijo,l.id_uo_padre, 1
              FROM orga.testructura_uo l
              WHERE l.id_estructura_uo in (' || p_id_estructura_uo ||')
              UNION ALL
              SELECT l.id_uo_hijo,l.id_uo_padre,n+1
              FROM orga.testructura_uo l, t
              WHERE l.id_uo_padre = t.id
          )
          SELECT (pxp.list(id::text))::varchar
          FROM t';
    
    end if;
    
    execute(v_sql);
    
    select ids into v_ids from tuos;
    
    return v_ids;

END;
$BODY$;

ALTER FUNCTION orga.f_get_id_uo(character varying, character varying)
    OWNER TO postgres;
CREATE OR REPLACE FUNCTION param.f_obtener_padre_lugar (
  p_id_lugar integer,
  p_tipo varchar
)
RETURNS varchar AS
$body$
DECLARE

	v_nombre varchar;

BEGIN

	WITH RECURSIVE t(id,id_fk,nombre,n,tipo) AS (
		SELECT l.id_lugar,l.id_lugar_fk, l.nombre,1, l.tipo
		FROM param.tlugar l 
		WHERE l.id_lugar = p_id_lugar
		UNION ALL
		SELECT l.id_lugar,l.id_lugar_fk, l.nombre , n+1, l.tipo
		FROM param.tlugar l, t
		WHERE l.id_lugar = t.id_fk 
	)
	SELECT nombre
	INTO v_nombre
	FROM t
	WHERE tipo = p_tipo LIMIT 1;

	RETURN v_nombre;

END;
$body$
LANGUAGE 'plpgsql'
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
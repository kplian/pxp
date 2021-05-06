CREATE OR REPLACE FUNCTION param.f_get_tcc_nivel(p_id_tipo_cc integer, p_nivel integer)
 RETURNS varchar
 LANGUAGE plpgsql
AS $function$
/*
Autor: MZM
Fecha: 06/05/2021
Descripción: Función que devuelve el TCC de nivel X de un TCC hijo
*/

DECLARE

	v_tcc varchar;
    v_consulta varchar;
    v_registros	record;

BEGIN
	
	if p_id_tipo_cc is null then
    	return null;
    end if;
	--1.Verificación de existencia de la partida
    if not exists(select 1 from param.ttipo_cc
    			where id_tipo_cc = p_id_tipo_cc) then
    	raise exception 'CeCo inexistente%', p_id_tipo_cc;
    end if;
    
 
WITH RECURSIVE tipo_cc_techo(
    ids,
    id_tipo_cc,
    id_tipo_cc_fk,
    
    codigo
   
    ) AS(
    
		WITH recursive tcc AS(
  			SELECT 
      		 c1.codigo,
   			 c1.tipo,
   			 1 AS nivel, c1.id_tipo_cc, c1.id_tipo_cc_fk
  			 FROM param.ttipo_cc c1 where id_tipo_cc_fk is null and codigo not like '%X_%'
  			UNION
  			SELECT 
             c2.codigo,
             c2.tipo,
             c1.nivel + 1 AS nivel, c2.id_tipo_cc, c2.id_tipo_cc_fk
             FROM param.ttipo_cc c2 ,
      		 tcc c1 where c1.id_tipo_cc=c2.id_tipo_cc_fk
  			 and c2.estado_reg = 'activo'  AND c2.id_tipo_cc_fk is not null
       )
       select 
       ARRAY [ tcc.id_tipo_cc ] AS "array",tcc.id_tipo_cc,tcc.id_tipo_cc_fk,
       tcc.codigo
       from tcc where nivel= p_nivel
  UNION
  SELECT pc.ids || c2.id_tipo_cc,
         c2.id_tipo_cc,
         c2.id_tipo_cc_fk,
         c2.codigo
  FROM param.ttipo_cc c2,
       tipo_cc_techo pc
  WHERE c2.id_tipo_cc_fk = pc.id_tipo_cc AND
        c2.estado_reg::text = 'activo' ::text)
      SELECT cl.codigo AS codigo_techo into v_consulta --,
             --cl.descripcion AS descripcion_techo,
             -- cl.id_tipo_cc AS id_tipo_cc_techo,
             --c.ids,
             --c.id_tipo_cc,
             --c.id_tipo_cc_fk,
             --c.codigo
      FROM tipo_cc_techo c
           JOIN param.ttipo_cc cl ON cl.id_tipo_cc = c.ids [ 1 ]
where c.id_tipo_cc=p_id_tipo_cc;
		
     
    return v_consulta;

END;
$function$
;
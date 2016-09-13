CREATE OR REPLACE FUNCTION orga.f_get_uo_prioridades (
  p_id_uo integer,
  out out_id_uo integer,
  out out_nombre_unidad varchar,
  out out_prioridad integer
)
RETURNS SETOF record AS
$body$
DECLARE
 	v_registros 	record;
BEGIN
	
	for v_registros in (with items as (select distinct on (uo.id_uo) uo.id_uo,es.haber_basico
    								from orga.tuo uo 
                                    left join orga.tcargo i on i.id_uo = uo.id_uo and i.estado_reg = 'activo'
                                    left join orga.tescala_salarial es on es.id_escala_salarial = i.id_escala_salarial
                                    where uo.estado_reg = 'activo'
                                    order by uo.id_uo,es.haber_basico desc)
    					select  hijos.id_uo, hijos.nombre_unidad,i.haber_basico,
                        (case when (select count(*) from orga.testructura_uo where id_uo_padre = hijos.id_uo) > 0 THEN
                        	1
                        ELSE
                        	0
                        end) as tiene_hijos,
                        (case when hijos.prioridad is null and niv.numero_nivel > 5 then 
                        	0
                        ELSE
                        	hijos.prioridad::integer
                        end) as prioridad_nueva
    					from orga.testructura_uo euo
                        inner join orga.tuo hijos on euo.id_uo_hijo = hijos.id_uo
                        inner join orga.tnivel_organizacional niv on niv.id_nivel_organizacional = hijos.id_nivel_organizacional
                        inner join items i on i.id_uo = hijos.id_uo
                        where hijos.estado_reg = 'activo' and euo.id_uo_padre!= euo.id_uo_hijo and euo.id_uo_padre = p_id_uo and hijos.estado_reg = 'activo'
                        order by tiene_hijos asc,prioridad_nueva asc, i.haber_basico desc
                         )loop
    
    	select nextval('orga.rep_planilla_actualizada') into out_prioridad;
        out_id_uo = v_registros.id_uo;
        out_nombre_unidad = v_registros.nombre_unidad;
        
        return query select * from orga.f_get_uo_prioridades(out_id_uo);
        return query select out_id_uo,out_nombre_unidad,out_prioridad;
        
    end loop;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;
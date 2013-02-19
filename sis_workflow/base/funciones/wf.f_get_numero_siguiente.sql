CREATE OR REPLACE FUNCTION wf.f_get_numero_siguiente (
  v_id_num_tramite integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_get_numero_siguiente
 DESCRIPCION: 	Devuelve un nuemero de correlativo a partir del Codigo, Numero siguiente y Gestion
 AUTOR: 		KPLIAN(FRH)
 FECHA:			20/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
  v_num_siguiente INTEGER;
  v_gestion varchar;
  v_id_gestion integer;
  v_cont_gestion integer;
  v_codigo_siguiente VARCHAR(30);
  v_codigo_proceso_macro varchar;
BEGIN
        select nt.num_siguiente
        into v_num_siguiente
        from wf.tnum_tramite nt
        where nt.id_num_tramite=v_id_num_tramite; 
       	
        select prom.codigo
        into v_codigo_proceso_macro
        from wf.tnum_tramite nt
        INNER JOIN wf.tproceso_macro prom on prom.id_proceso_macro =  nt.id_proceso_macro
        where nt.id_num_tramite=v_id_num_tramite; 
        
        select nt.id_gestion
        into v_id_gestion
        from wf.tnum_tramite nt
        where nt.id_num_tramite=v_id_num_tramite;
        
		SELECT count(id_gestion)
        INTO v_cont_gestion
        FROM wf.tnum_tramite
        WHERE id_gestion = v_id_gestion and estado_reg ilike 'activo';   
                 
        IF v_cont_gestion > 1 THEN
            RAISE EXCEPTION 'Existe mas de una gestion.';
        END IF;     
        
        --Incrementar el correlativo        
		IF v_num_siguiente IS NULL THEN
        	v_num_siguiente := 1;
        ELSE
        	v_num_siguiente := v_num_siguiente+1;
        END IF;
        UPDATE wf.tnum_tramite set			
            num_siguiente = v_num_siguiente			
            where id_num_tramite=v_id_num_tramite;
        v_codigo_siguiente := (v_codigo_proceso_macro||lpad(COALESCE(v_num_siguiente, 0)::varchar,6,'0')||v_id_gestion::varchar);
        raise notice '%',v_codigo_siguiente;
        
   RETURN v_codigo_siguiente;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;
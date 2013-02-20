
CREATE OR REPLACE FUNCTION wf.f_get_numero_siguiente (
  v_id_num_tramite integer
)
RETURNS integer AS
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
BEGIN
        select nt.num_siguiente
        into v_num_siguiente
        from wf.tnum_tramite nt
        where nt.id_num_tramite=v_id_num_tramite;      
                
		IF v_num_siguiente IS NULL THEN
        	v_num_siguiente := 1;
        ELSE
        	v_num_siguiente := v_num_siguiente+1;
        END IF;
        UPDATE wf.tnum_tramite set			
            num_siguiente = v_num_siguiente			
            where id_num_tramite=v_id_num_tramite;
        
   RETURN v_num_siguiente;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100;
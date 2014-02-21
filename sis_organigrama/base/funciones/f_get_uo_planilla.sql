CREATE OR REPLACE FUNCTION orga.f_get_uo_planilla (
  par_id_uo integer,
  par_id_funcionario integer,
  par_fecha date
)
RETURNS integer AS
$body$
DECLARE
  	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_consulta				text;
    v_id_uo					integer;
    v_planilla			varchar;
    v_id_uo_hijo		integer;
BEGIN
  	v_nombre_funcion = 'orga.f_get_uo_planilla';
    if (par_id_uo is not null) then
    	select euo.id_uo_padre, uo.gerencia, euo.id_uo_hijo
        into v_id_uo, v_planilla, v_id_uo_hijo
        from orga.tuo uo
        inner join orga.testructura_uo euo
        	on euo.id_uo_hijo = uo.id_uo
        where euo.id_uo_hijo = par_id_uo;
        
        if (v_planilla = 'si') then
        	return par_id_uo;
        else
        	if (v_id_uo = v_id_uo_hijo) then
        		return NULL; 
            else
            	return orga.f_get_uo_planilla(v_id_uo, NULL, NULL);
            end if;
        end if;
    
    else
    	select funuo.id_uo into v_id_uo
        from orga.tuo_funcionario funuo
        where funuo.estado_reg = 'activo' and funuo.id_funcionario = par_id_funcionario and
        	funuo.fecha_asignacion <= par_fecha and (funuo.fecha_finalizacion is null or funuo.fecha_finalizacion >= par_fecha);
        if (v_id_uo is null)then
        	return -1;
        end if;
        
            
        return orga.f_get_uo_planilla(v_id_uo, NULL, NULL);
    end if;
    
           
                     
               
EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
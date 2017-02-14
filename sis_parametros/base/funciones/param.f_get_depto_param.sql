--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_get_depto_param (
  p_id_depto integer,
  p_codigo_variable varchar
)
RETURNS varchar AS
$body$
DECLARE
    v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_valor 				varchar;
BEGIN

    v_nombre_funcion = 'paramf_get_depto_param';
    
    
    select 
       deva.valor
    into
       v_valor
    from param.tdepto_var deva
    inner join param.tsubsistema_var sv on  sv.id_subsistema_var = deva.id_subsistema_var
    where deva.id_depto = p_id_depto and sv.codigo = p_codigo_variable;
    
    
   
   IF v_valor is not null and v_valor != ''THEN
     return v_valor;
   END IF;
   -------------------------------------------------
   -- si no tenemos valor buscamos el valor_def  --
   ------------------------------------------------
   
   select 
     sv.valor_def
   into
     v_valor 
   from param.tdepto  dep
   inner join param.tsubsistema_var sv on sv.id_subsistema = dep.id_subsistema
   where dep.id_depto = p_id_depto and sv.codigo = p_codigo_variable;
   
   
    IF v_valor is not null and v_valor != ''THEN
     return v_valor;
    ELSE
       raise exception 'No existe variable (%) parametrizada para el depto (%)', p_codigo_variable, p_id_depto ;
    END IF;
   
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
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
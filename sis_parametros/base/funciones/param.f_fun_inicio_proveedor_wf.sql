--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_fun_inicio_proveedor_wf (
  p_id_usuario integer,
  p_id_usuario_ai integer,
  p_usuario_ai varchar,
  p_id_estado_wf integer,
  p_id_proceso_wf integer,
  p_codigo_estado varchar
)
RETURNS boolean AS
$body$
/*
*
*  Autor:   RAC
*  DESC:    funcion que actualiza los estados despues del registro de siguiente estado de proveedor
*  Fecha:   06/09/2017
*
*/

DECLARE

	v_nombre_funcion   	text;
    v_resp    			varchar;
    v_mensaje 			varchar;
    
    v_registros 		record;
    v_regitros_pp		record;
    v_monto_ejecutar_mo			numeric;
    v_id_uo						integer;
    v_id_usuario_excepcion		integer;
    v_resp_doc 					boolean;
    v_id_usuario_firma			integer;
    v_id_moneda_base			integer;
    v_fecha						date; 
    v_importe_aprobado_total	numeric;
    v_importe_total				numeric;
   
	
    
BEGIN

	 v_nombre_funcion = 'param.f_fun_inicio_proveedor_wf';
    
     
    -- actualiza estado en la solicitud
    update param.tproveedor   set 
       id_estado_wf =  p_id_estado_wf,
       estado = p_codigo_estado,
       id_usuario_mod=p_id_usuario,
       id_usuario_ai = p_id_usuario_ai,
       usuario_ai = p_usuario_ai,
       fecha_mod=now()
                   
    where id_proceso_wf = p_id_proceso_wf;
   


RETURN   TRUE;



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
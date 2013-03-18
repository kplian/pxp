--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_tipo_estado_inicial_del_tipo_proceso (
  p_id_tipo_proceso integer,
  out ps_id_tipo_estado integer,
  out ps_codigo_estado varchar
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_tipo_estado_inicial_del_tipo_proceso
 DESCRIPCION: 	esta funcion permite obtener el siguiente estado o  el anterior dentro del WF
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			21/02/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
 ********************************
  p_id_proceso_wf integer,   ->   identificador del proceso WF obligatorio
  p_id_estado_wf integer,    ->   identificador del estado del WF, se utiliza si id_tipo_estado es NULL
  p_id_tipo_estado integer,  ->   OPCIONAL
  p_operacion varchar,       ->   siguiente o anterior
 

***************************************************************************/
DECLARE

v_nombre_funcion varchar;
v_resp varchar;


	
BEGIN

v_nombre_funcion = 'wf.f_obtener_tipo_estado_inicial_del_tipo_proceso';

       
           select 
            te.id_tipo_estado,
            te.codigo
           into
            ps_id_tipo_estado,
            ps_codigo_estado
           
           from  wf.ttipo_estado te 
           where te.id_tipo_proceso=p_id_tipo_proceso and te.inicio = 'si';





          return;
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
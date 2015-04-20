--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_cadena_tipos_estados_anteriores_wf (
  p_id_tipo_estado integer,
  out ps_id_tipo_estado integer [],
  out ps_codigo_estado varchar []
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_cadena_tipos_estados_anteriores_wf
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

v_id_tipo_proceso integer;
v_id_tipo_estado integer;
	
BEGIN

v_nombre_funcion = 'wf.f_obtener_cadena_estados_anteriores_wf';
      
        WITH RECURSIVE estados (id_tipo_estado, codigo) AS (  
                                      select 
                                             te.id_tipo_estado,
                                            
                                             te.codigo
                                      
                                      from wf.ttipo_estado te
                                      inner join wf.testructura_estado ee 
                                           on te.id_tipo_estado= ee.id_tipo_estado_padre  and ee.bucle = 'no'
                                           and ee.id_tipo_estado_hijo != ee.id_tipo_estado_padre
                                      where ee.id_tipo_estado_hijo  = p_id_tipo_estado and ee.estado_reg = 'activo'  and te.estado_reg = 'activo'
                                      UNION ALL
                                      SELECT  te2.id_tipo_estado,
                                            
                                              te2.codigo
                                      FROM estados a
                                          INNER JOIN wf.testructura_estado ee2 on ee2.id_tipo_estado_hijo = a.id_tipo_estado  and ee2.bucle = 'no'
                                           INNER JOIN wf.ttipo_estado te2 on te2.id_tipo_estado = ee2.id_tipo_estado_padre
                                           and ee2.id_tipo_estado_hijo != ee2.id_tipo_estado_padre and ee2.estado_reg = 'activo' and te2.estado_reg = 'activo'
                                          
                                           )  
                                       
                                       
                                       SELECT  pxp.aggarray(id_tipo_estado),
                                               pxp.aggarray(codigo)
                                          into 
                                              ps_id_tipo_estado,
                                              ps_codigo_estado
                                       FROM estados 
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
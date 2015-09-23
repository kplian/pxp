--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_estado_ant_log_wf (
  p_id_estado_wf integer,
  out ps_id_tipo_estado integer,
  out ps_id_funcionario integer,
  out ps_id_usuario_reg integer,
  out ps_id_depto integer,
  out ps_codigo_estado varchar,
  out ps_id_estado_wf_ant integer
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_ant_log_wf
 DESCRIPCION: 	permite obtener el estado anterior  del proceso segun  registro de log del WF
 
 
 AUTOR: 		KPLIAN(RAC)
 FECHA:			15/03/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
 ********************************

  p_id_estado_wf integer,    ->   identificador del estado del WF, se utiliza si id_tipo_estado es NULL

***************************************************************************/
DECLARE

v_nombre_funcion 				varchar;
v_resp 							varchar;

v_id_tipo_proceso 				integer;
v_id_tipo_estado 				integer;
v_id_proceso_wf 				integer;

va_id_tipo_estado 				integer[];
va_codigo_estado 				varchar[];
va_disparador					 varchar[];
va_regla 						varchar[];
va_prioridad 					integer[];

v_id_tipo_estado_anterior		integer;

	
BEGIN

v_nombre_funcion='f_obtener_estado_ant_log_wf';

    
   

      select 
         ew.id_proceso_wf ,
         ew.id_tipo_estado,
         tew.id_tipo_estado_anterior
      into 
         v_id_proceso_wf,
         v_id_tipo_estado,
         v_id_tipo_estado_anterior
    from wf.testado_wf ew
    inner join wf.ttipo_estado tew on tew.id_tipo_estado = ew.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf;

-- si no tenemos un estado predecesor predefinido buscamos recursivamente en la configuracion
   IF  v_id_tipo_estado_anterior is null THEN
           --buscar estado anterior segun configuracion
           SELECT 
            oe.ps_id_tipo_estado,
            oe.ps_codigo_estado
           into 
             va_id_tipo_estado,
             va_codigo_estado
                      
           
           FROM wf.f_obtener_cadena_tipos_estados_anteriores_wf(v_id_tipo_estado) oe;
           
         
                
                raise notice 'parm  % %',v_id_proceso_wf  , p_id_estado_wf  ;
           --buscar responsables, funcionario, depto o usuario
           -- recursivamente has encontrar el ulitmo estado en el log que coincida con el tipo
           
           
           
           WITH RECURSIVE estados (id_estado_wf,id_estado_anterior, codigo, id_tipo_estado) AS (  
                                              select ew.id_estado_wf,
                                                     ew.id_estado_anterior,
                                                     te.codigo,
                                                     te.id_tipo_estado
                                              
                                              from wf.testado_wf ew
                                              inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado and te.estado_reg = 'activo'
                                              where ew.id_estado_wf = p_id_estado_wf
                                              UNION ALL
                                              SELECT ewp.id_estado_wf,
                                                     ewp.id_estado_anterior,
                                                     tep.codigo,
                                                     tep.id_tipo_estado
                                              FROM estados a
                                                   INNER JOIN wf.testado_wf ewp on
                                                    ewp.id_estado_wf = a.id_estado_anterior
                                                   INNER JOIN wf.ttipo_estado tep on tep.id_tipo_estado = ewp.id_tipo_estado and tep.estado_reg = 'activo')  
                                               
                                               
                                               SELECT id_estado_wf,
                                                      codigo,
                                                      id_tipo_estado
                                                  into 
                                                     ps_id_estado_wf_ant,
                                                     ps_codigo_estado,
                                                     ps_id_tipo_estado
                                               FROM estados 
                                               WHERE id_tipo_estado = ANY (va_id_tipo_estado) 
                                               order by  id_estado_wf   desc
                                               limit 1 offset 0;  
   
             select
             ewp.id_funcionario,
             ewp.id_usuario_reg,
             ewp.id_depto
            into
             ps_id_funcionario,
             ps_id_usuario_reg,
             ps_id_depto
            from wf.testado_wf ewp
            inner join wf.ttipo_estado te on te.id_tipo_estado=ewp.id_tipo_estado
            where ewp.id_estado_wf = ps_id_estado_wf_ant;
   
   
   ELSE  
   			
           SELECT 
                 
                 con.ps_id_funcionario ,
                 con.ps_id_usuario_reg ,
                 con.ps_id_depto ,
                 con.ps_codigo_estado ,
                 con.ps_id_estado_wf_ant
                
             into
                 ps_id_funcionario,
                 ps_id_usuario_reg,
                 ps_id_depto,
                 ps_codigo_estado,
                 ps_id_estado_wf_ant
               
                
             FROM wf.f_obtener_estado_segun_log_wf(p_id_estado_wf, v_id_tipo_estado_anterior) con;
             
             ps_id_tipo_estado = v_id_tipo_estado_anterior;
   
   END IF;  
   
      

  


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
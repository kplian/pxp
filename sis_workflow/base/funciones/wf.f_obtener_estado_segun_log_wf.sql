CREATE OR REPLACE FUNCTION wf.f_obtener_estado_segun_log_wf (
  p_id_estado_wf integer,
  p_id_tipo_estado integer,
  out ps_id_funcionario integer,
  out ps_id_usuario_reg integer,
  out ps_id_depto integer,
  out ps_codigo_estado varchar,
  out ps_id_estado_wf_ant integer
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION:     wf.f_obtener_estado_segun_log_wf
 DESCRIPCION:   esta funcion permite obtener el estado_wf   correpondiente al parametro id_tipo_estado,   
                 segun registro del log del WF para el parametros id_estado_wf,
                 (busca recursivamente en el los hasta encontra el tipo_estado)
                
 
 
 AUTOR:     KPLIAN(RAC)
 FECHA:     15/03/2013
 COMENTARIOS: 
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:     
 ********************************

  p_id_estado_wf integer,    ->   identificador del estado del WF de donde se inicia la busqueda
  p_id_tipo_estado           ->   el id_tipo_estado que se busca en log

***************************************************************************/
DECLARE

v_nombre_funcion        varchar;
v_resp              varchar;

v_id_tipo_proceso         integer;
v_id_tipo_estado        integer;
v_id_proceso_wf         integer;

va_id_tipo_estado         integer[];
va_codigo_estado        varchar[];
va_disparador           varchar[];
va_regla            varchar[];
va_prioridad          integer[];
v_id_tipo_estado_anterior   integer;

  
BEGIN

v_nombre_funcion='wf.f_obtener_estado_segun_log_wf';

     select 
         ew.id_proceso_wf ,
         ew.id_tipo_estado
      into 
         v_id_proceso_wf,
         v_id_tipo_estado
    from wf.testado_wf ew
    where ew.id_estado_wf = p_id_estado_wf;


   
   
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
                                                  codigo
                                              into 
                                                 ps_id_estado_wf_ant,
                                                 ps_codigo_estado
                                           FROM estados 
                                           WHERE id_tipo_estado = p_id_tipo_estado 
                                           order by  id_estado_wf   desc
                                           limit 1 offset 0;  
   

if p_id_estado_wf = 11186 then
  --raise exception 'aa: %   %',ps_id_estado_wf_ant,ps_codigo_estado;
end if;



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
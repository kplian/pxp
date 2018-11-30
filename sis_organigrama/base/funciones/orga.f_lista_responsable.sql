--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_lista_responsable (
  p_id_usuario integer,
  p_id_tipo_estado integer,
  p_fecha date = now(),
  p_id_estado_wf integer = NULL::integer,
  p_count boolean = false,
  p_limit integer = 1,
  p_start integer = 0,
  p_filtro varchar = '0=0'::character varying
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT:     tes.f_lista_funcionario_aprobador
 DESCRIPCIÓN:   lista funcionariso aprobadores segun configuracion en sistema de parametros,  
                con lso datos de WF, la misma lista de aprobadores es compartida con adquisciones
 AUTOR:     Rensi Arteaga Copari
 FECHA:      10/07/2017
 COMENTARIOS:  
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/

-------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*


  p_id_usuario integer,                                identificador del actual usuario de sistema
  p_id_tipo_estado integer,                            idnetificador del tipo estado del que se quiere obtener el listado de funcionario  (se correponde con tipo_estado que le sigue a id_estado_wf proporcionado)                       
  p_fecha date = now(),                                fecha  --para verificar asginacion de cargo con organigrama
  p_id_estado_wf integer = NULL::integer,              identificaro de estado_wf actual en el proceso_wf
  p_count boolean = false,                             si queremos obtener numero de funcionario = true por defecto false
  p_limit integer = 1,                                 los siguiente son parametros para filtrar en la consulta
  p_start integer = 0,
  p_filtro varchar = '0=0'::character varying
  
  
  




*/

DECLARE
  g_registros      record;
    v_depto_asignacion    varchar;
    v_nombre_depto_func_list   varchar;
    
    v_consulta varchar;
    v_nombre_funcion varchar;
    v_resp varchar;    
    v_cad_ep varchar;
    v_cad_uo varchar;
    v_id_funcionario_gerente   integer;    
    v_a_eps varchar[];
    v_a_uos varchar[];
    v_uos_eps varchar;
    v_size    integer;
    v_i       integer;    
    v_reg_op    record;
    va_id_uo  integer[];
    v_id_moneda_base integer;
    v_monto_mb      numeric;
    v_id_subsistema    integer;   
    v_tam        integer;
    v_id_func_list    varchar;

    v_id_funcionario    integer[];
    
    
BEGIN
  v_nombre_funcion ='orga.f_lista_responsable';

SELECT 
  pxp.list(uofun.id_funcionario::varchar)
  into
    v_id_func_list
  from orga.tuo_funcionario uofun
  inner join orga.tuo uo on uo.id_uo = uofun.id_uo
  where
  uofun.estado_reg = 'activo' and uo.id_nivel_organizacional not in(7,8,9,5)
  and uofun.fecha_asignacion <= now() and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= now());

    --RAISE EXCEPTION 'error provocado %',v_id_func_list;

    IF not p_count then
             v_consulta:='SELECT fun.id_funcionario, fun.desc_funcionario1 as desc_funcionario, ''Gerente''::text  as desc_funcionario_cargo, 1 as prioridad
                         FROM orga.vfuncionario fun WHERE '||p_filtro||' and fun.id_funcionario in ('||v_id_func_list||') 
                         limit '|| p_limit::varchar||' offset '||p_start::varchar; 
                   FOR g_registros in execute (v_consulta)LOOP     
                     RETURN NEXT g_registros;
                   END LOOP;
    ELSE
                  v_consulta='select
                                  COUNT(fun.id_funcionario) as total
                                 FROM orga.vfuncionario fun  WHERE fun.id_funcionario in('||v_id_func_list||') 
                                 and '||p_filtro;   
                   FOR g_registros in execute (v_consulta)LOOP     
                     RETURN NEXT g_registros;
                   END LOOP;
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
COST 100 ROWS 1000;

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
 SCRIPT: 		tes.f_lista_funcionario_aprobador
 DESCRIPCIÓN: 	lista funcionariso aprobadores segun configuracion en sistema de parametros,  
                con lso datos de WF, la misma lista de aprobadores es compartida con adquisciones
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			10/07/2017
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
	g_registros  		record;
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
    va_id_uo	integer[];
    v_id_moneda_base integer;
    v_monto_mb			numeric;
    v_id_subsistema		integer;   
    v_tam				integer;
    v_id_func_list		varchar;

BEGIN
  v_nombre_funcion ='orga.f_lista_responsable';
  
  
  --obtenmso datos basicos de la solicitud
   select 
      op.fecha,
      op.id_funcionario,
      op.total_pago,
      op.id_moneda,
      sum(dop.monto_pago_mb) as monto_pago_mb
    into
      v_reg_op
    from tes.tobligacion_pago op 
    inner join tes.tobligacion_det dop on dop.id_obligacion_pago = op.id_obligacion_pago
    where op.id_estado_wf = p_id_estado_wf
    group by op.fecha,
      op.id_funcionario,
      op.total_pago,
      op.id_moneda;
      
      
  
  --obtener id_uo
  
        WITH RECURSIVE path(id_funcionario,id_uo,presupuesta,gerencia,numero_nivel) AS (
                SELECT uofun.id_funcionario,uo.id_uo,uo.presupuesta,uo.gerencia, no.numero_nivel
                from orga.tuo_funcionario uofun
                inner join orga.tuo uo
                    on uo.id_uo = uofun.id_uo
                inner join orga.tnivel_organizacional no 
                                    on no.id_nivel_organizacional = uo.id_nivel_organizacional
                 where uofun.fecha_asignacion <= v_reg_op.fecha and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= v_reg_op.fecha)
                and uofun.estado_reg = 'activo' and uofun.id_funcionario = v_reg_op.id_funcionario
            UNION
                SELECT uofun.id_funcionario,euo.id_uo_padre,uo.presupuesta,uo.gerencia,no.numero_nivel
                from orga.testructura_uo euo
                inner join orga.tuo uo
                    on uo.id_uo = euo.id_uo_padre
                inner join orga.tnivel_organizacional no 
                                    on no.id_nivel_organizacional = uo.id_nivel_organizacional
                inner join path hijo
                    on hijo.id_uo = euo.id_uo_hijo
                left join orga.tuo_funcionario uofun
                    on uo.id_uo = uofun.id_uo and uofun.estado_reg = 'activo' and
                        uofun.fecha_asignacion <= v_reg_op.fecha 
                        and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= v_reg_op.fecha)
                                            
            )
             SELECT 
                pxp.aggarray(id_uo) 
              into
                va_id_uo
             FROM path 
             WHERE   id_funcionario is not null and presupuesta = 'si';
      
          
          
          select
            s.id_subsistema
           into
            v_id_subsistema
          from segu.tsubsistema s
          WHERE s.codigo = 'ADQ' and s.estado_reg = 'activo';
          
          v_tam = array_upper(va_id_uo, 1);
          v_i = 1;
          v_id_func_list='0';
          
          --raise exception 'array %',va_id_uo;
          --buscamos el aprobador subiendo por el array     
          WHILE v_i <= v_tam LOOP
             
             select 
                   pxp.list(id_funcionario::varchar)
                 into 
                    v_id_func_list    
            from 
                          
              param.f_obtener_listado_aprobadores(va_id_uo[v_i], 
              									  null,--  p_id_ep
                                                  null,--p_id_centro_costo, 
                                                  v_id_subsistema, 
                                                  v_reg_op.fecha,  
                                                  v_reg_op.monto_pago_mb,  
                                                  p_id_usuario, 
                                                  null--p_id_proceso_macro
                                                  ) as 
                                                  ( id_aprobador integer,
                                                    id_funcionario integer,
                                                    fecha_ini date,
                                                    fecha_fin date,
                                                    desc_funcionario text,
                                                    monto_min numeric,
                                                    monto_max numeric,
                                                    prioridad integer);
                                                  
              IF v_id_func_list != '0' and v_id_func_list is not null  THEN
                  v_i = v_tam +1;
                 -- raise exception 'array %---  %',va_id_uo, v_id_func_list;
              END IF;
              v_i = v_i +1  ;                                  
                                                  
          END LOOP;
   
    
             
    
    
   
    IF not p_count then
    
             v_consulta:='SELECT
                            fun.id_funcionario,
                            fun.desc_funcionario1 as desc_funcionario,
                            ''Gerente''::text  as desc_funcionario_cargo,
                            1 as prioridad
                         FROM orga.vfuncionario fun WHERE  '||p_filtro||' and fun.desc_funcionario1 != ''ADMINISTRADOR DEL SISTEMA ''
                         limit '|| p_limit::varchar||' offset '||p_start::varchar; 
     
              
                   FOR g_registros in execute (v_consulta)LOOP     
                     RETURN NEXT g_registros;
                   END LOOP;
                      
      ELSE
                  v_consulta='select
                                  COUNT(fun.id_funcionario) as total
                                 FROM orga.vfuncionario fun  WHERE '||p_filtro||' and fun.desc_funcionario1 != ''ADMINISTRADOR DEL SISTEMA '' ';   
                                          
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
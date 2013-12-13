--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_aprobadores_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		PARAM.f_aprobadores_sel
 DESCRIPCIÓN: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			19/03/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*
pm_id_usuario                               integer (si))
pm_ip_origen                                varchar(40) (si)
pm_mac_maquina                              macaddr (si)
pm_log_error                                varchar -- log -- error //variable interna (si)
pm_codigo_procedimiento                     varchar  // valor que identifica el tipo
                                                        de operacion a realizar
                                                        insert  (insertar)
                                                        delete  (eliminar)
                                                        update  (actualizar)
                                                        select  (visualizar)
pm_proc_almacenado                          varchar  // para colocar el nombre del procedimiento en caso de ser llamado
                                                        por otro procedimiento
*/



DECLARE


	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;


v_sw integer;
v_sw2 integer;
v_count integer;
v_consulta varchar;
v_consulta2 varchar;
g_registros  record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT

v_id_uo integer;
v_id_ep integer;
v_id_centro_costo integer;
v_id_subsistema integer;
v_id_proceso_macro integer;

BEGIN



    v_nombre_funcion = 'param.f_aprobadores_sel';
    v_parametros = pxp.f_get_record(p_tabla);
   
    /*********************************    
 	#TRANSACCION:  'PM_OBTARPOBA_SEL'
 	#DESCRIPCION:	Listado de aprobadores filtradao segun criterio de configuracion
 	#AUTOR:		rac	
 	#FECHA:		16-03-2012 17:06:17
	#PARAMETROS:  
          id_uo ->  unidad organizacional
          id_ep ->  EP
          id_centro_costo -> Centro de Costo
          id_subsistema -> parametrizacion para que sistema
          id_proceso_macro -> identifica el WF 
          fecha    -> fecha de solicitud para verificar quien corresponde segun fecha
          monto    ->  monto solicitado para aprobacion
          codigo_subsistema ->  codigo subsistema 
    ***********************************/

	IF(p_transaccion='PM_OBTARPOBA_SEL')then
    
    
    --  obtener si_subsistema apartir de codigo
    
    
    select 
      s.id_subsistema
    into 
      v_id_subsistema
    from segu.tsubsistema s
    where s.codigo = v_parametros.codigo_subsistema
    and s.estado_reg = 'activo' 
    limit 1 offset 0;  
    
    IF v_id_subsistema  is NULL THEN
    
      raise exception 'No existe el sistema solicitado';
    
    END IF;  
  
  --validacion de paramtros  
  
  raise  notice '%', v_parametros.id_uo;
  
   IF(pxp.f_existe_parametro(p_tabla,'id_uo')) THEN
   
     v_id_uo = v_parametros.id_uo;
   
   END IF;
   
   IF(pxp.f_existe_parametro(p_tabla,'id_ep')) THEN
   
     v_id_ep = v_parametros.id_ep;
      
     
   END IF;
   
   
   IF(pxp.f_existe_parametro(p_tabla,'id_centro_costo')) THEN
   
     v_id_centro_costo = v_parametros.id_centro_costo;
   
   END IF;
   
   
   IF(pxp.f_existe_parametro(p_tabla,'id_proceso_macro')) THEN
   
     v_id_proceso_macro = v_parametros.id_proceso_macro;
   
   END IF;
   
   
   

 raise notice '%,%,%,%,%,%,%,%', v_id_uo, --id_uo
                        v_id_ep,--p_id_ep,
                        v_id_centro_costo,--p_id_centro_costo, 
                        v_id_subsistema, --id_subsistema
                        v_parametros.fecha, 
                        v_parametros.monto,
                        p_id_usuario,
                        v_id_proceso_macro;

  --   listado ded la funcioan
  
        FOR g_registros in (
                  SELECT 
                         DISTINCT (
                        id_funcionario),
                        desc_funcionario,
                        prioridad
                        FROM param.f_obtener_listado_aprobadores(
                        v_id_uo, --id_uo
                        v_id_ep,--p_id_ep,
                        v_id_centro_costo,--p_id_centro_costo, 
                        v_id_subsistema, --id_subsistema
                        v_parametros.fecha, 
                        v_parametros.monto,
                        p_id_usuario,
                        v_id_proceso_macro)
                        AS ( id_aprobador integer,
                            id_funcionario integer,
                            fecha_ini date,
                            fecha_fin date,
                            desc_funcionario text,
                            monto_min numeric,
                            monto_max numeric,
                            prioridad integer)
                        ORDER BY prioridad asc )LOOP     
                        
           
           
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
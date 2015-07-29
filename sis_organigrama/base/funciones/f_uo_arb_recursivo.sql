CREATE OR REPLACE FUNCTION orga.f_uo_arb_recursivo (
  v_id integer,
  p_activos varchar = 'si'::character varying
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		orga.f_uo_arb_recursivo
 DESCRIPCIÓN: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			2012
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


/*
  0) listamos el regisotr con el v_id en la tabla temporal
  1)IF  si no hay registros en la tabla temporal
  1.1) Listamos el registro  con el v_id  de la tabla orignal
  1.2) IF, el registro v_id  NO tiene padre
  1.2.0) insertamos el registro de v_id con niveles = v_id
  1.2.1)  return  v_id 
  1.3) ELSE, si el registro tiene padres  
  1.3.1) nivel = fun_red(v_id) RECURSIVAMENTE
  1.3.2) insertamos el registro de v_id con niveles = nivel+v_id
  1.3.3) return nivel||_||v_id
  2)ELSE  si  hay regisotr registros en la tabla temporal
  2.1) retornamos los niveles del registro existente

*/


DECLARE
v_sw integer;
v_sw2 integer;
v_count integer;
v_consulta varchar;
v_consulta2 text;
v_consulta_ins text;
g_registros                record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_bool varchar;
v_bool2 varchar;
v_nivel varchar;
v_select_funcionarios	varchar;
v_select_cargos			varchar;
BEGIN


  --0) listamos el regisotr con el v_id en la tabla temporal
       
       raise notice '########  arb recursivo ';
       SELECT  
          id_uo,
          niveles 
       INTO 
          v_count,
          v_nivel
       FROM organigrama_filtro
       WHERE id_uo =v_id;
                      
   
  
  --1)IF  si no hay registros en la tabla temporal
   IF v_count is NULL THEN
        --1.1) Listamos el registro  con el v_id  de la tabla orignal
         if (p_activos = 'no') THEN
              v_select_funcionarios = '(orga.f_obtener_funcionarios_x_uo(UNIORG.id_uo, now()::date, ''no'')) as funcionarios,';
          else
              v_select_funcionarios = '(orga.f_obtener_funcionarios_x_uo(UNIORG.id_uo)) as funcionarios,';
          end if;
          
          v_select_cargos = '(orga.f_obtener_cargos_x_uo(UNIORG.id_uo)) as cargos,';
         v_consulta := 'SELECT
                           UNIORG.id_uo,
                           UNIORG.nombre_unidad,
                           UNIORG.nombre_cargo,
                           UNIORG.cargo_individual,
                           UNIORG.descripcion,
                           ESTORG.id_estructura_uo,
                           ESTORG.id_uo_padre,
                           UNIORG.estado_reg,
                           ' || v_select_funcionarios ||
                           v_select_cargos ||
                            '
                           UNIORG.presupuesta,
                           UNIORG.correspondencia,
                           UNIORG.codigo, 
                           UNIORG.nodo_base, 
                           UNIORG.gerencia,
                           UNIORG.id_nivel_organizacional,
                           nivorg.nombre_nivel
                           FROM orga.testructura_uo ESTORG
                           INNER JOIN orga.tuo UNIORG
                           ON UNIORG.id_uo = ESTORG.id_uo_hijo
                           INNER JOIN orga.tnivel_organizacional nivorg
                           	on nivorg.id_nivel_organizacional = UNIORG.id_nivel_organizacional
                           WHERE UNIORG.estado_reg= ''activo''  AND UNIORG.id_uo = '||COALESCE(v_id,'0');
        
      FOR g_registros in EXECUTE (v_consulta) LOOP
        
        --1.2) IF, el registro v_id  NO tiene padre
        IF g_registros.nodo_base = 'si' THEN
        RAISE NOTICE '>>>>>>>>>IF id_uo_padre = %',g_registros.id_uo_padre;
        
        --1.2.0) insertamos el registro de v_id con niveles = v_id
        
            INSERT  INTO organigrama_filtro 
                     (  niveles,
                        id_uo, 
                        nombre_unidad, 
                        nombre_cargo, 
                        cargo_individual, 
                        descripcion, 
                        presupuesta, 
                        codigo, 
                        nodo_base, 
                        gerencia, 
                        id_estructura_uo, 
                        correspondencia,
                        estado_reg,
                        funcionarios,
                        cargos,
                        resaltar,
                        id_uo_padre,
                        id_nivel_organizacional,
                        nombre_nivel
                     )
                     VALUES
                     (  v_id||'a'::varchar,
                        g_registros.id_uo, 
                        g_registros.nombre_unidad, 
                        g_registros.nombre_cargo, 
                        g_registros.cargo_individual, 
                        g_registros.descripcion, 
                        g_registros.presupuesta, 
                        g_registros.codigo, 
                        g_registros.nodo_base, 
                        g_registros.gerencia, 
                        g_registros.id_estructura_uo, 
                        g_registros.correspondencia,
                        g_registros.estado_reg,
                        g_registros.funcionarios,
                        g_registros.cargos,
                        'no',
                        g_registros.id_uo_padre,
                        g_registros.id_nivel_organizacional,
                        g_registros.nombre_nivel
                     );
                     
        
        
        --1.2.1)  return  v_id 
        
       RETURN v_id||'a'::varchar;
        
        --1.3) ELSE, si el registro tiene padres  
        ELSE
        
        RAISE NOTICE '>>>>>>>>>ELSE ';
        
        --1.3.1) nivel = fun_red(v_id_padre) RECURSIVAMENTE
        
          v_nivel := orga.f_uo_arb_recursivo(g_registros.id_uo_padre,p_activos);
          
        --1.3.2) insertamos el registro de v_id con niveles = nivel+v_id
                     
                     INSERT  INTO organigrama_filtro 
                     (  niveles,
                        id_uo, 
                        nombre_unidad, 
                        nombre_cargo, 
                        cargo_individual, 
                        descripcion, 
                        presupuesta, 
                        codigo, 
                        nodo_base, 
                        gerencia, 
                        id_estructura_uo, 
                        correspondencia,
                        estado_reg,
                        funcionarios,
                        cargos,
                        resaltar,
                        id_uo_padre,
                        id_nivel_organizacional,
                        nombre_nivel

                     )
                     VALUES
                     (  (v_nivel||v_id||'a')::varchar,
                        g_registros.id_uo, 
                        g_registros.nombre_unidad, 
                        g_registros.nombre_cargo, 
                        g_registros.cargo_individual, 
                        g_registros.descripcion, 
                        g_registros.presupuesta, 
                        g_registros.codigo, 
                        g_registros.nodo_base, 
                        g_registros.gerencia, 
                        g_registros.id_estructura_uo, 
                        g_registros.correspondencia,
                        g_registros.estado_reg,
                        g_registros.funcionarios,
                        g_registros.cargos,
                        'no',
                        g_registros.id_uo_padre,
                        g_registros.id_nivel_organizacional,
                        g_registros.nombre_nivel
                     );
                     
                     raise notice '<<<<<<< SALE DEL IF';
        
        END IF;
          --1.3.3) return nivel||_||v_id
        return v_nivel||v_id||'a';
        
        END LOOP;
      
      return v_nivel;
--2)ELSE  si  hay regisotr registros en la tabla temporal
  ELSE
   --2.1) retornamos los niveles del registro existente
   
    RETURN v_nivel;

  END IF;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
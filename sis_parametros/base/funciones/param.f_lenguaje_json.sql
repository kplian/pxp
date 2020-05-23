--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_lenguaje_json (
  p_codigo_grupo varchar,
  p_codigo_lenguaje varchar
)
RETURNS jsonb AS
$body$
/**************************************************************************
 FUNCION:       segu.f_get_menu
 DESCRIPCION:   fucion ara recueprar un grupo de traduccion en formato json
 AUTOR:         RAC - KPLIAN        
 FECHA:         21/04/2020
 COMENTARIOS:    
***************************************************************************

 ISSUE            FECHA:            AUTOR               DESCRIPCION  
 #133          10/04/2020           RAC            CREACION
***************************************************************************/
DECLARE
    v_registros         RECORD;
    v_resp_json         JSONB;
    v_resp              VARCHAR; 
    v_nombre_funcion    VARCHAR;  
    v_defecto_on_null   BOOLEAN; 
BEGIN

     --recuepra configuracion de comportamiento para valores pordefecto    
     v_defecto_on_null := pxp.f_get_variable_global('param_traduccion_defecto_on_null')::BOOLEAN;
   

    SELECT json_object_agg(clave, valor)
    INTO v_resp_json
    FROM (
          WITH base_trad AS (
             SELECT
               pc.id_palabra_clave,
               pc.codigo,
               len.codigo as lenguaje,
               tra.id_traduccion,
               tra.texto
             FROM param.tlenguaje len
             JOIN param.ttraduccion tra ON tra.id_lenguaje = len.id_lenguaje
             JOIN param.tpalabra_clave pc ON pc.id_palabra_clave = tra.id_palabra_clave
             JOIN param.tgrupo_idioma gi ON gi.id_grupo_idioma = pc.id_grupo_idioma
             WHERE gi.tipo = 'comun'
               AND len.codigo = p_codigo_lenguaje
               AND  gi.codigo = p_codigo_grupo
          )
          SELECT
              pc.codigo as clave,
              (
                 CASE WHEN v_defecto_on_null THEN  COALESCE(bt.texto, pc.default_text )::Varchar 
                      ELSE bt.texto
                 END    
              ) as valor
            
          FROM param.tgrupo_idioma gi
          JOIN param.tpalabra_clave pc ON pc.id_grupo_idioma = gi.id_grupo_idioma
          LEFT JOIN base_trad bt ON bt.id_palabra_clave = pc.id_palabra_clave
          WHERE  gi.tipo = 'comun'
            AND  gi.codigo = p_codigo_grupo
    ) s;
       
   
  
 RETURN  v_resp_json;
 
 EXCEPTION

       WHEN OTHERS THEN
        v_resp := '';
        v_resp := pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp := pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp := pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
        raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
PARALLEL UNSAFE
COST 100;
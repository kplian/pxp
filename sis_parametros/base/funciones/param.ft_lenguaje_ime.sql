
CREATE OR REPLACE FUNCTION param.ft_lenguaje_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Parametros Generales
 FUNCION:       param.ft_lenguaje_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tlenguaje'
 AUTOR:         rac
 FECHA:            21-04-2020 02:04:08
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133               21-04-2020 02:04:08    rac             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_lenguaje              INTEGER;
    v_lenguaje_json            JSONB;
    v_registros                RECORD;
                
BEGIN

    v_nombre_funcion = 'param.ft_lenguaje_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_LEN_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 02:04:08
    ***********************************/

    IF (p_transaccion='PM_LEN_INS') THEN
                    
        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.tlenguaje(
            codigo,
            nombre,
            defecto,
            estado_reg,
            id_usuario_ai,
            fecha_reg,
            usuario_ai,
            id_usuario_reg,
            id_usuario_mod,
            fecha_mod
              ) VALUES (
            v_parametros.codigo,
            v_parametros.nombre,
            v_parametros.defecto,
            'activo',
            v_parametros._id_usuario_ai,
            now(),
            v_parametros._nombre_usuario_ai,
            p_id_usuario,
            null,
            null            
            ) RETURNING id_lenguaje into v_id_lenguaje;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lenguaje almacenado(a) con exito (id_lenguaje'||v_id_lenguaje||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lenguaje',v_id_lenguaje::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_LEN_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 02:04:08
    ***********************************/

    ELSIF (p_transaccion='PM_LEN_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tlenguaje SET
            codigo = v_parametros.codigo,
            nombre = v_parametros.nombre,
            defecto = v_parametros.defecto,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_lenguaje=v_parametros.id_lenguaje;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lenguaje modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lenguaje',v_parametros.id_lenguaje::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_LEN_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 02:04:08
    ***********************************/

    ELSIF (p_transaccion='PM_LEN_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tlenguaje
            WHERE id_lenguaje=v_parametros.id_lenguaje;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Lenguaje eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_lenguaje',v_parametros.id_lenguaje::varchar);
              
            --Devuelve la respuesta
            RETURN v_resp;

        END;
    
    /*******************************    
     #TRANSACCION:  PM_GETLEN_JSON
     #DESCRIPCION:	Modifica la interfaz del arbol seleccionada 
     #AUTOR:		KPLIAN(rac)		
     #FECHA:		11-04-2020
    ***********************************/
     ELSIF(p_transaccion='PM_GETLEN_JSON')THEN
          BEGIN
          
             v_lenguaje_json := param.f_lenguaje_json('BASICO', v_parametros.codigo_lenguaje);
              
             FOR v_registros IN ( 
                                   SELECT g.codigo
                                     FROM param.tgrupo_idioma g
                                    WHERE g.estado_reg = 'activo'
                                      AND g.tipo = 'comun'
                                      AND g.codigo  != 'BASICO' ) LOOP                                   
                                   
                   v_lenguaje_json := v_lenguaje_json || json_build_object( '_'||upper(v_registros.codigo), param.f_lenguaje_json(v_registros.codigo, v_parametros.codigo_lenguaje))::JSONB;           
                                   
             END LOOP;
          
           
             
            v_resp = pxp.f_agrega_clave(v_resp,'message','Exito en la ejecucion de la funcion'::VARCHAR);
            v_resp = pxp.f_agrega_clave(v_resp,'resp_json',v_lenguaje_json::VARCHAR);
            RETURN v_resp;
            
          END;
          
    
    /*******************************    
     #TRANSACCION:  PM_GETLENGRP_JSON
     #DESCRIPCION:	Modifica la interfaz del arbol seleccionada 
     #AUTOR:		rac		
     #FECHA:		23-05-2020
    ***********************************/
     ELSIF(p_transaccion='PM_GETLENGRP_JSON')THEN
          BEGIN
          
            v_lenguaje_json := param.f_lenguaje_json(v_parametros.codigo_grupo, v_parametros.codigo_lenguaje);
                         
            v_resp = pxp.f_agrega_clave(v_resp,'message','Exito en la ejecucion de la funcion'::VARCHAR);
            v_resp = pxp.f_agrega_clave(v_resp,'resp_json',v_lenguaje_json::VARCHAR);
            RETURN v_resp;
            
          END;
         
         
    ELSE
     
        RAISE EXCEPTION 'Transaccion inexistente: %',p_transaccion;

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
PARALLEL UNSAFE
COST 100;
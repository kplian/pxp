--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_traduccion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_traduccion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttraduccion'
 AUTOR:          (admin)
 FECHA:            21-04-2020 03:41:52
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133               21-04-2020 03:41:52    admin             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_traduccion    INTEGER;
                
BEGIN

    v_nombre_funcion = 'param.ft_traduccion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_TRA_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 03:41:52
    ***********************************/

    IF (p_transaccion='PM_TRA_INS') THEN
                    
        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.ttraduccion(
            id_lenguaje,
            id_palabra_clave,
            texto,
            estado_reg,
            id_usuario_ai,
            id_usuario_reg,
            fecha_reg,
            usuario_ai,
            fecha_mod,
            id_usuario_mod
              ) VALUES (
            v_parametros.id_lenguaje,
            v_parametros.id_palabra_clave,
            v_parametros.texto,
            'activo',
            v_parametros._id_usuario_ai,
            p_id_usuario,
            now(),
            v_parametros._nombre_usuario_ai,
            null,
            null            
            ) RETURNING id_traduccion into v_id_traduccion;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Traducciones almacenado(a) con exito (id_traduccion'||v_id_traduccion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_traduccion',v_id_traduccion::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_TRA_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 03:41:52
    ***********************************/

    ELSIF (p_transaccion='PM_TRA_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.ttraduccion SET
            id_lenguaje = v_parametros.id_lenguaje,
            id_palabra_clave = v_parametros.id_palabra_clave,
            texto = v_parametros.texto,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_traduccion=v_parametros.id_traduccion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Traducciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_traduccion',v_parametros.id_traduccion::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_TRA_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        admin    
     #FECHA:        21-04-2020 03:41:52
    ***********************************/

    ELSIF (p_transaccion='PM_TRA_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.ttraduccion
            WHERE id_traduccion=v_parametros.id_traduccion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Traducciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_traduccion',v_parametros.id_traduccion::varchar);
              
            --Devuelve la respuesta
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
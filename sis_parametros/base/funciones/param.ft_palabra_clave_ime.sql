--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_palabra_clave_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Parametros Generales
 FUNCION:       param.ft_palabra_clave_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tpalabra_clave'
 AUTOR:         (ADMIN)
 FECHA:         21-04-2020 02:54:58
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #133                21-04-2020 02:54:58    ADMIN             Creacion    
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_palabra_clave    INTEGER;
                
BEGIN

    v_nombre_funcion = 'param.ft_palabra_clave_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PLC_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        ADMIN    
     #FECHA:        21-04-2020 02:54:58
    ***********************************/

    IF (p_transaccion='PM_PLC_INS') THEN
                    
        BEGIN
            --Sentencia de la insercion
            INSERT INTO param.tpalabra_clave(
           -- id_tabla,  TODO  este campo se utilizara cuando se trabaja la traducciones de tablas almacenadas
            estado_reg,
            codigo,
            default_text,
            id_grupo_idioma,
            fecha_reg,
            usuario_ai,
            id_usuario_reg,
            id_usuario_ai,
            fecha_mod,
            id_usuario_mod
              ) VALUES (
           -- v_parametros.id_tabla,
            'activo',
            v_parametros.codigo,
            v_parametros.default_text,
            v_parametros.id_grupo_idioma,
            now(),
            v_parametros._nombre_usuario_ai,
            p_id_usuario,
            v_parametros._id_usuario_ai,
            null,
            null            
            ) RETURNING id_palabra_clave into v_id_palabra_clave;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Palabras Claves almacenado(a) con exito (id_palabra_clave'||v_id_palabra_clave||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_palabra_clave',v_id_palabra_clave::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'PM_PLC_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        ADMIN    
     #FECHA:        21-04-2020 02:54:58
    ***********************************/

    ELSIF (p_transaccion='PM_PLC_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.tpalabra_clave SET
            --id_tabla = v_parametros.id_tabla,
            codigo = v_parametros.codigo,
            default_text = v_parametros.default_text,
            id_grupo_idioma = v_parametros.id_grupo_idioma,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_palabra_clave=v_parametros.id_palabra_clave;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Palabras Claves modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_palabra_clave',v_parametros.id_palabra_clave::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'PM_PLC_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        ADMIN    
     #FECHA:        21-04-2020 02:54:58
    ***********************************/

    ELSIF (p_transaccion='PM_PLC_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.tpalabra_clave
            WHERE id_palabra_clave=v_parametros.id_palabra_clave;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Palabras Claves eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_palabra_clave',v_parametros.id_palabra_clave::varchar);
              
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
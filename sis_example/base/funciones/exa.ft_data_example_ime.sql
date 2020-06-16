CREATE OR REPLACE FUNCTION "exa"."ft_data_example_ime" (    
                p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:        Example
 FUNCION:         exa.ft_data_example_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'exa.tdata_example'
 AUTOR:          (Favio Figueroa)
 FECHA:            12-06-2020 16:37:18
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                12-06-2020 16:37:18    Favio Figueroa             Creacion
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_data_example          INTEGER;

BEGIN

    v_nombre_funcion = 'exa.ft_data_example_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'EXA_TDE_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        Favio Figueroa
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    IF (p_transaccion='EXA_TDE_INS') THEN
                    
        BEGIN


            --Sentencia de la insercion
            INSERT INTO exa.tdata_example(
            estado_reg,
            desc_example,
            usuario_ai,
            fecha_reg,
            id_usuario_reg,
            id_usuario_ai,
            fecha_mod,
            id_usuario_mod
              ) VALUES (
            'activo',
            v_parametros.desc_example,
            v_parametros._nombre_usuario_ai,
            now(),
            p_id_usuario,
            v_parametros._id_usuario_ai,
            null,
            null            
            ) RETURNING id_data_example into v_id_data_example;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Data Example almacenado(a) con exito (id_data_example'||v_id_data_example||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_data_example',v_id_data_example::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************    
     #TRANSACCION:  'EXA_TDE_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        Favio Figueroa
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    ELSIF (p_transaccion='EXA_TDE_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE exa.tdata_example SET
            desc_example = v_parametros.desc_example,
            fecha_mod = now(),
            id_usuario_mod = p_id_usuario,
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai
            WHERE id_data_example=v_parametros.id_data_example;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Data Example modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_data_example',v_parametros.id_data_example::varchar);
               
            --Devuelve la respuesta
            RETURN v_resp;
            
        END;

    /*********************************    
     #TRANSACCION:  'EXA_TDE_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        Favio Figueroa
     #FECHA:        12-06-2020 16:37:18
    ***********************************/

    ELSIF (p_transaccion='EXA_TDE_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM exa.tdata_example
            WHERE id_data_example=v_parametros.id_data_example;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Data Example eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_data_example',v_parametros.id_data_example::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "exa"."ft_data_example_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

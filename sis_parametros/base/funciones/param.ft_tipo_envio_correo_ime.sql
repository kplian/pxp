--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_tipo_envio_correo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_tipo_agrupacion_correo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_envio_correo'
 AUTOR:          (egutierrez)
 FECHA:            26-11-2020 15:26:10
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                26-11-2020 15:26:10    egutierrez             Creacion
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        INTEGER;
    v_parametros               RECORD;
    v_id_requerimiento         INTEGER;
    v_resp                     VARCHAR;
    v_nombre_funcion           TEXT;
    v_mensaje_error            TEXT;
    v_id_tipo_envio_correo    INTEGER;
    v_dias_envio                varchar;
    v_dias_consecutivo          varchar;
    v_array                 VARCHAR[];
    v_tamano                integer;
    v_argumentos    			VARCHAR;
BEGIN

    v_nombre_funcion = 'param.ft_tipo_envio_correo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_GRC_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:26:10
    ***********************************/

    IF (p_transaccion='PM_GRC_INS') THEN

        BEGIN

            v_dias_envio = replace(v_parametros.dias_envio,',','');
            IF pxp.f_is_positive_integer(v_dias_envio) = false THEN
                   RAISE EXCEPTION 'Los dias de Envio no tienen el Formato. ejemplo (15,10,3) %',v_parametros.dias_envio;
            END IF;

            IF v_parametros.script_habilitado = 'si' THEN
                v_array = string_to_array(v_parametros.script,'.');
                v_tamano:=array_upper(v_array,1);
                IF v_tamano <> 2 THEN
               			 RAISE EXCEPTION 'El formato debe ser  schema.funcion ';
            	 END IF;

                 IF NOT EXISTS (SELECT
                  n.nspname AS schema_name

                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and  n.nspname = v_array[1])THEN
                		RAISE EXCEPTION 'No existe el esquema % ', v_array[1];
                END IF;

                  IF NOT EXISTS (SELECT
                  p.proname

                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and n.nspname = v_array[1] and   p.proname = v_array[2])THEN
                		RAISE EXCEPTION 'No existe la funcion % ', v_array[2];
                END IF;

                 SELECT
                 p.proargnames::varchar
                 into
                 v_argumentos
                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and  n.nspname = v_array[1] and p.proname = v_array[2];


                IF v_argumentos is not null  THEN
                		RAISE EXCEPTION 'La funcion no debe tener Argumentos';
                END IF;

                 --RAISE EXCEPTION 'El formato % ',v_tamano;
            END IF;
            --Sentencia de la insercion
            INSERT INTO param.ttipo_envio_correo(
            estado_reg,
            codigo,
            descripcion,
            dias_envio,
            dias_consecutivo,
            habilitado,
            id_usuario_reg,
            fecha_reg,
            id_usuario_ai,
            usuario_ai,
            id_usuario_mod,
            fecha_mod,
            dias_vencimiento,
            script,
            script_habilitado,
            columna_llave,
            tabla
              ) VALUES (
            'activo',
            upper(replace(v_parametros.codigo,' ','')),
            v_parametros.descripcion,
            replace(v_parametros.dias_envio,' ',''),
            v_parametros.dias_consecutivo,
            v_parametros.habilitado,
            p_id_usuario,
            now(),
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            null,
            null,
            v_parametros.dias_vencimiento,
            v_parametros.script,
            v_parametros.script_habilitado,
            v_parametros.columna_llave,
            v_parametros.tabla
            ) RETURNING id_tipo_envio_correo into v_id_tipo_envio_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de Correo almacenado(a) con exito (id_envio_correo'||v_id_tipo_envio_correo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_envio_correo',v_id_tipo_envio_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************
     #TRANSACCION:  'PM_GRC_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:26:10
    ***********************************/

    ELSIF (p_transaccion='PM_GRC_MOD') THEN

        BEGIN
            v_dias_envio = replace(v_parametros.dias_envio,',','');
            IF pxp.f_is_positive_integer(v_dias_envio) = false THEN
                   RAISE EXCEPTION 'Los dias de Envio no tienen el Formato. ejemplo (15,10,3) %',v_parametros.dias_envio;
            END IF;

            IF v_parametros.script_habilitado = 'si' THEN
                v_array = string_to_array(v_parametros.script,'.');
                v_tamano:=array_upper(v_array,1);

                IF v_tamano <> 2 or v_tamano is null THEN
               			 RAISE EXCEPTION 'El formato debe ser  schema.funcion ';
            	 END IF;

                 IF NOT EXISTS (SELECT
                  n.nspname AS schema_name

                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and  n.nspname = v_array[1])THEN
                		RAISE EXCEPTION 'No existe el esquema % ', v_array[1];
                END IF;

                  IF NOT EXISTS (SELECT
                  p.proname

                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and n.nspname = v_array[1] and   p.proname = v_array[2])THEN
                		RAISE EXCEPTION 'No existe la funcion % ', v_array[2];
                END IF;

                 SELECT
                 p.proargnames::varchar
                 into
                 v_argumentos
                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and  n.nspname = v_array[1] and p.proname = v_array[2];


                IF v_argumentos is not null  THEN
                		RAISE EXCEPTION 'La funcion no debe tener Argumentos';
                END IF;


            END IF;
            --Sentencia de la modificacion
            UPDATE param.ttipo_envio_correo SET
            codigo =  upper(replace(v_parametros.codigo,' ','')),
            descripcion = v_parametros.descripcion,
            dias_envio = replace(v_parametros.dias_envio,' ',''),
            dias_consecutivo = v_parametros.dias_consecutivo,
            habilitado = v_parametros.habilitado,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai,
            dias_vencimiento = v_parametros.dias_vencimiento,
            script = v_parametros.script,
            script_habilitado = v_parametros.script_habilitado,
            columna_llave = v_parametros.columna_llave,
            tabla = v_parametros.tabla
            WHERE id_tipo_envio_correo=v_parametros.id_tipo_envio_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de Correo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_envio_correo',v_parametros.id_tipo_envio_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;

    /*********************************
     #TRANSACCION:  'PM_GRC_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:26:10
    ***********************************/

    ELSIF (p_transaccion='PM_GRC_ELI') THEN

        BEGIN
            --Sentencia de la eliminacion
            DELETE FROM param.ttipo_envio_correo
            WHERE id_tipo_envio_correo=v_parametros.id_tipo_envio_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de Correo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_envio_correo',v_parametros.id_tipo_envio_correo::varchar);

            --Devuelve la respuesta
            RETURN v_resp;

        END;
     /*********************************
     #TRANSACCION:  'PM_MSJ_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        26-11-2020 15:26:10
    ***********************************/

    ELSIF (p_transaccion='PM_MSJ_MOD') THEN

        BEGIN
            --Sentencia de la modificacion
            UPDATE param.ttipo_envio_correo SET
            plantilla_mensaje = v_parametros.plantilla_mensaje,
            plantilla_mensaje_asunto = v_parametros.plantilla_mensaje_asunto
            WHERE id_tipo_envio_correo=v_parametros.id_tipo_envio_correo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de Correo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_envio_correo',v_parametros.id_tipo_envio_correo::varchar);

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
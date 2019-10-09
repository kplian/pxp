--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_concepto_ingas_agrupador_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_concepto_ingas_agrupador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconcepto_ingas_agrupador'
 AUTOR:          (egutierrez)
 FECHA:            02-09-2019 21:07:26
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                02-09-2019 21:07:26                                Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconcepto_ingas_agrupador'
 #
 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_concepto_ingas_agrupador    integer;

BEGIN

    v_nombre_funcion = 'param.ft_concepto_ingas_agrupador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_COINAGR_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        egutierrez
     #FECHA:        02-09-2019 21:07:26
    ***********************************/

    if(p_transaccion='PM_COINAGR_INS')then

        begin
            --Sentencia de la insercion
            insert into param.tconcepto_ingas_agrupador(
            descripcion,
            tipo_agrupador,
            estado_reg,
            nombre,
            id_usuario_ai,
            usuario_ai,
            fecha_reg,
            id_usuario_reg,
            id_usuario_mod,
            fecha_mod,
            es_obra_civil
              ) values(
            v_parametros.descripcion,
            v_parametros.tipo_agrupador,
            'activo',
            v_parametros.nombre,
            v_parametros._id_usuario_ai,
            v_parametros._nombre_usuario_ai,
            now(),
            p_id_usuario,
            null,
            null,
            v_parametros.es_obra_civil
            )RETURNING id_concepto_ingas_agrupador into v_id_concepto_ingas_agrupador;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Agrupador de concepto ingas almacenado(a) con exito (id_concepto_ingas_agrupador'||v_id_concepto_ingas_agrupador||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_agrupador',v_id_concepto_ingas_agrupador::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'PM_COINAGR_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        02-09-2019 21:07:26
    ***********************************/

    elsif(p_transaccion='PM_COINAGR_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tconcepto_ingas_agrupador set
            descripcion = v_parametros.descripcion,
            tipo_agrupador = v_parametros.tipo_agrupador,
            nombre = v_parametros.nombre,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_usuario_ai = v_parametros._id_usuario_ai,
            usuario_ai = v_parametros._nombre_usuario_ai,
            es_obra_civil = v_parametros.es_obra_civil
            where id_concepto_ingas_agrupador=v_parametros.id_concepto_ingas_agrupador;


            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Agrupador de concepto ingas modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_agrupador',v_parametros.id_concepto_ingas_agrupador::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'PM_COINAGR_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        egutierrez
     #FECHA:        02-09-2019 21:07:26
    ***********************************/

    elsif(p_transaccion='PM_COINAGR_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tconcepto_ingas_agrupador
            where id_concepto_ingas_agrupador=v_parametros.id_concepto_ingas_agrupador;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Agrupador de concepto ingas eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_agrupador',v_parametros.id_concepto_ingas_agrupador::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;
        /*********************************
     #TRANSACCION:  'PM_INSAGR_INS'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        02-09-2019 21:07:26
    ***********************************/

    elsif(p_transaccion='PM_INSAGR_INS')then

        begin
            --Sentencia de la modificacion
            update param.tconcepto_ingas set
            id_concepto_ingas_agrupador = v_parametros.id_concepto_ingas_agrupador
            where id_concepto_ingas=v_parametros.id_concepto_ingas;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Concepto ingas modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;
       /*********************************
     #TRANSACCION:  'PM_INSOC_INS'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        egutierrez
     #FECHA:        02-09-2019 21:07:26
    ***********************************/

    elsif(p_transaccion='PM_INSOC_INS')then

        begin
            --Sentencia de la modificacion
            update param.tconcepto_ingas_agrupador set
            es_obra_civil = v_parametros.es_obra_civil
            where id_concepto_ingas_agrupador=v_parametros.id_concepto_ingas_agrupador;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Concepto ingas modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas_agrupador',v_parametros.id_concepto_ingas_agrupador::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    else

        raise exception 'Transaccion inexistente: %',p_transaccion;

    end if;

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
COST 100;
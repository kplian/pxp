CREATE OR REPLACE FUNCTION orga.ft_tipo_cargo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Organigrama
 FUNCION:         orga.ft_tipo_cargo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttipo_cargo'
 AUTOR:          (rarteaga)
 FECHA:            15-07-2019 19:39:12
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #30                15-07-2019 19:39:12                                Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttipo_cargo'
 #46                05/08/2019              EGS                 e agrega campo id_contrato
 #70 etr        25/09/2019              	MMV                 Nueva campo factor nocturno

 ***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                     varchar;
    v_nombre_funcion           text;
    v_mensaje_error            text;
    v_id_tipo_cargo            integer;
    v_haber_basico_min         numeric;
    v_haber_basico_max         numeric;

BEGIN

    v_nombre_funcion = 'orga.ft_tipo_cargo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'OR_TCAR_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        rarteaga
     #FECHA:        15-07-2019 19:39:12
    ***********************************/

    if(p_transaccion='OR_TCAR_INS')then

        begin

            --validar que el sueldo de ales cala minima sea menor que el maximo

            SELECT
            es.haber_basico
            into
            v_haber_basico_min
            FROM orga.tescala_salarial es
            WHERE es.id_escala_salarial = v_parametros.id_escala_salarial_min;

            SELECT
            es.haber_basico
            into
            v_haber_basico_max
            FROM orga.tescala_salarial es
            WHERE es.id_escala_salarial = v_parametros.id_escala_salarial_max;

            --Sentencia de la insercion
            insert into orga.ttipo_cargo(
              estado_reg,
              codigo,
              nombre,
              id_escala_salarial_min,
              id_escala_salarial_max,
              factor_disp,
              obs,
              id_usuario_reg,
              fecha_reg,
              id_usuario_ai,
              usuario_ai,
              id_usuario_mod,
              fecha_mod,
              id_tipo_contrato, --#46
              factor_nocturno --#70
              ) values(
              'activo',
              v_parametros.codigo,
              v_parametros.nombre,
              v_parametros.id_escala_salarial_min,
              v_parametros.id_escala_salarial_max,
              v_parametros.factor_disp,
              v_parametros.obs,
              p_id_usuario,
              now(),
              v_parametros._id_usuario_ai,
              v_parametros._nombre_usuario_ai,
              null,
              null,
              v_parametros.id_tipo_contrato, --#46
              v_parametros.factor_nocturno --#70
            )RETURNING id_tipo_cargo into v_id_tipo_cargo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Cargo almacenado(a) con exito (id_tipo_cargo'||v_id_tipo_cargo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cargo',v_id_tipo_cargo::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'OR_TCAR_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        rarteaga
     #FECHA:        15-07-2019 19:39:12
    ***********************************/

    elsif(p_transaccion='OR_TCAR_MOD')then

        begin

            SELECT
            es.haber_basico
            into
            v_haber_basico_min
            FROM orga.tescala_salarial es
            WHERE es.id_escala_salarial = v_parametros.id_escala_salarial_min;

            SELECT
            es.haber_basico
            into
            v_haber_basico_max
            FROM orga.tescala_salarial es
            WHERE es.id_escala_salarial = v_parametros.id_escala_salarial_max;


            --Sentencia de la modificacion
            update orga.ttipo_cargo set
              codigo = v_parametros.codigo,
              nombre = v_parametros.nombre,
              id_escala_salarial_min = v_parametros.id_escala_salarial_min,
              id_escala_salarial_max = v_parametros.id_escala_salarial_max,
              factor_disp = v_parametros.factor_disp,
              obs = v_parametros.obs,
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai,
              id_tipo_contrato = v_parametros.id_tipo_contrato, --#46
              factor_nocturno = v_parametros.factor_nocturno --#70
            where id_tipo_cargo=v_parametros.id_tipo_cargo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Cargo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cargo',v_parametros.id_tipo_cargo::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
     #TRANSACCION:  'OR_TCAR_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        rarteaga
     #FECHA:        15-07-2019 19:39:12
    ***********************************/

    elsif(p_transaccion='OR_TCAR_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from orga.ttipo_cargo
            where id_tipo_cargo=v_parametros.id_tipo_cargo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Cargo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cargo',v_parametros.id_tipo_cargo::varchar);

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

ALTER FUNCTION orga.ft_tipo_cargo_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
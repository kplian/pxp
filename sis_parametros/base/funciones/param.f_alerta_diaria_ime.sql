--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_alerta_diaria_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:
 FUNCION:
 DESCRIPCION: Envia correos segun configuracion Estado
 AUTOR:
 FECHA:
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
     ISSUE            FECHA            AUTHOR                     DESCRIPCION
     ETR-1839         15/12/2020       EGS                        Creacion
***************************************************************************/

DECLARE

    v_parametros               	record;
    v_resp                    	varchar;
    v_nombre_funcion        	text;

    v_record                    record;
    v_consulta                  varchar;
   v_existe						BOOLEAN;
    v_array                 VARCHAR[];
    v_tamano                integer;
BEGIN

    v_nombre_funcion = 'param.f_alerta_diaria_ime';
    v_parametros = pxp.f_get_record(p_tabla);


  /*********************************
  #TRANSACCION:  'PARAM_ALERDIA_IME'
  #DESCRIPCION:
  #AUTOR:        EGS
  #FECHA:
  #ISSUE:
  ***********************************/

  if(p_transaccion='PARAM_ALERDIA_IME')then

  begin
  IF v_parametros.habilitado = 'si' THEN

    --ejecutamos scripts independientes
    FOR v_record IN(
        SELECT
            COALESCE(te.script,NULL) as script
        FROM param.ttipo_envio_correo te
        WHERE te.habilitado = 'si'
              and te.script_habilitado = 'si'
    )LOOP
      v_existe = false;
     v_array = string_to_array(v_record.script,'.');
     v_tamano:=array_upper(v_array,1);

        IF EXISTS (SELECT
                  p.proname

                FROM pg_proc p
                JOIN pg_namespace n ON n.oid = p.pronamespace
                Where n.nspname not in ('pg_catalog','pg_toast','public','information_schema')
                and n.nspname = v_array[1] and   p.proname = v_array[2]  and p.proargnames is null)THEN

        v_existe = true;
       END IF;

       IF v_existe = true THEN
         v_consulta = 'Select * from '||v_record.script||'()';
         execute (v_consulta);

       END IF;

    END LOOP;



    --ejecutamos registros que no esten en un script
    FOR v_record IN(
        SELECT
            te.columna_llave,
            te.tabla,
            te.plantilla_mensaje_asunto,
            te.plantilla_mensaje,
            te.dias_envio,
            te.dias_consecutivo,
            te.dias_vencimiento
            FROM param.ttipo_envio_correo te
            WHERE te.habilitado = 'si'
            and te.script_habilitado = 'no'
    )LOOP


    END LOOP;





  ELSE
      v_resp = 'no esta habilitado la opcion de desactivado automatico';
  END IF;
     v_resp='exito';
    --Definicion de la respuesta
     v_resp = pxp.f_agrega_clave(v_resp,'mensaje',v_resp);

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
PARALLEL UNSAFE
COST 100;
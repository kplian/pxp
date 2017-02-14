CREATE OR REPLACE FUNCTION param.f_inserta_alarma_dblink (
  p_id_usuario integer,
  p_asunto varchar,
  p_body text,
  p_mails varchar
)
  RETURNS integer AS
  $body$
  /**************************************************************************
   FUNCION: param.f_inserta_alarma_dblink
   DESCRIPCIÓN: Inserta alarma con dblink
   AUTOR:         KPLIAN(jrr)
   FECHA:
   COMENTARIOS:

  ***********************************************************************/

  DECLARE
    v_resp      record;
    v_res_cone  varchar;
    v_database  varchar;
    v_respuesta varchar;
    v_nombre_funcion   text;
    v_mensaje_error    text;
    v_usr_bd 		varchar;
    v_query			varchar;
  BEGIN
    v_nombre_funcion='param.f_inserta_alarma_dblink';
    v_database=current_database();
    v_usr_bd=v_database||'_conexion';

    v_res_cone=(select dblink_connect('user=' || v_usr_bd ||' dbname='||v_database));

    v_query = 'select * from param.f_inserta_alarma(
                                                      NULL,
                                                      ''' || p_body || ''',    --descripcion alarmce
                                                      NULL,--acceso directo
                                                      now()::date,
                                                      ''notificacion'',
                                                      '''',   -->
                                                      ' || p_id_usuario || ',
                                                      NULL,
                                                      ''' || p_asunto || ''',--titulo
                                                      ''{}''::varchar,
                                                      NULL::integer,
                                                      ''' || p_asunto || ''',
                                                      ''' || p_mails || '''
                                                     )';


    SELECT * FROM
      dblink(
          v_query,true)
        AS t1(id_alarma integer)
    into v_resp;

    v_res_cone=(select dblink_disconnect());

    return v_resp.id_alarma;

    EXCEPTION

    WHEN OTHERS THEN

      v_respuesta = '';
      v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
      v_respuesta = pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
      v_respuesta = pxp.f_agrega_clave(v_respuesta,'tipo_respuesta','ERROR'::varchar);
      v_respuesta = pxp.f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);

      --raise exception '%',v_respuesta;

      --RCM 31/01/2012: Cuando la llamada a esta funcion devuelve error, el manejador de excepciones de esa función da el resultado,
      --por lo que se modifica para que devuelva un json direcamente
      raise exception '%',pxp.f_resp_to_json(v_respuesta);

  END;
  $body$
LANGUAGE 'plpgsql'
VOLATILE
RETURNS NULL ON NULL INPUT
SECURITY DEFINER
COST 100;
CREATE OR REPLACE FUNCTION param.f_inserta_alarma_citas (
  p_id_usuario integer,
  p_asunto varchar,
  p_body text,
  p_mails varchar,
  p_url	varchar,
  p_fecha_caducidad date
)
  RETURNS integer AS
  $body$
  /**************************************************************************
   FUNCION: param.f_inserta_alarma_dblink
   DESCRIPCIÓN: Inserta alarma con dblink
   AUTOR:         KPLIAN(jrr)
   FECHA:
   COMENTARIOS:

  ************************************************************************
  HISTORIAL DE MODIFICACIONES:
	#ISSUE           FECHA                	AUTOR           DESCRIPCION
 	#0               17-06-2020 16:17:47    MZM             adicion de parametros de entrada: url y fecha_caducidad
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
    v_id			integer;
    
  BEGIN
    v_nombre_funcion='param.f_inserta_alarma_citas';
    v_database=current_database();
    v_usr_bd=v_database||'_conexion';

    v_res_cone=(select dblink_connect('user=' || v_usr_bd ||' dbname='||v_database));
	
	--verificar: si ya existe un registro en alarma para la url, entonces solo actualizar

	if not exists (select 1 from param.talarma where id_usuario=p_id_usuario and acceso_directo=p_url) then

    		v_query = 'select * from param.f_inserta_alarma(
                                                      NULL,--id_funcionario
                                                      ''' || p_body || ''',    --descripcion alarmce
                                                      ''' || p_url || ''',--acceso directo
                                                      now()::date, --fecha
                                                      ''notificacion'', --tipo
                                                      '''',   --> obs
                                                      ' || p_id_usuario || ', --id_usuario
                                                      NULL,  --clase
                                                      ''' || p_asunto || ''',--titulo
                                                      ''{}''::varchar, --parametros
                                                      ' || p_id_usuario || ', --id_usuario_alarma
                                                      ''' || p_asunto || ''', --titulo_correo
                                                      ''' || p_mails || ''' --correos
                                                      ,NULL, --documentos
                                                      NULL,  --id_proceso_wf
                                                      NULL,  --id_Estado_wf
                                                      NULL,  --id_plantilla
                                                      NULL,  --automatizado
                                                      '''||p_fecha_caducidad||'''
                                                     )';
  else
      --obtener el id_alarma para actualizar
  		select id_alarma into v_id from param.talarma where id_usuario=p_id_usuario and acceso_directo=p_url;
        update param.talarma
        set descripcion = p_body,
        acceso_directo= p_url,
        id_usuario= p_id_usuario,
        titulo=p_asunto,
        titulo_correo=p_asunto,
        correos=p_mails,
        fecha_caducidad=p_fecha_caducidad
        where id_alarma=v_id;
        
  end if;                                                     


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
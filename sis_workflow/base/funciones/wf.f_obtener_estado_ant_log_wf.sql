--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_obtener_estado_ant_log_wf (
  p_id_estado_wf integer,
  out ps_id_tipo_estado integer,
  out ps_id_funcionario integer,
  out ps_id_usuario_reg integer,
  out ps_id_depto integer,
  out ps_codigo_estado varchar,
  out ps_id_estado_wf_ant integer
)
RETURNS record AS
$body$
/**************************************************************************
 FUNCION: 		wf.f_obtener_estado_ant_log_wf
 DESCRIPCION: 	permite obtener el estado anterior  del proceso segun  registro de log del WF


 AUTOR: 		KPLIAN(RAC)
 FECHA:			15/03/2013
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:
     ISSUE              FECHA           AUTHOR    DESCRIPCION
    #144 EndeEtr        05/06/202       EGS       Se agrega alertas al momento retroceder un estado cuando no esta configurado en el estado
 ********************************

  p_id_estado_wf integer,    ->   identificador del estado del WF, se utiliza si id_tipo_estado es NULL

***************************************************************************/
DECLARE

v_nombre_funcion 				varchar;
v_resp 							varchar;

v_id_tipo_proceso 				integer;
v_id_tipo_estado 				integer;
v_id_proceso_wf 				integer;

va_id_tipo_estado 				integer[];
va_codigo_estado 				varchar[];
va_disparador					 varchar[];
va_regla 						varchar[];
va_prioridad 					integer[];

v_id_tipo_estado_anterior		integer;

v_codigo_estado         varchar;
v_obs                   varchar;
v_acceso_directo        varchar;
v_clase                 varchar;
v_codigo_estados        varchar;
v_parametros_ad         varchar;
v_tipo_noti             varchar;
v_titulo                varchar;
v_id_funcionario        integer;

v_nro_tramite           varchar;
v_id_alarma             varchar;
v_correo                varchar;
v_descripcion_correo    varchar;
v_desc_funcionario      VARCHAR;
v_id_usuario            integer;
v_alerta                varchar;


BEGIN

v_nombre_funcion='f_obtener_estado_ant_log_wf';




      select
         ew.id_proceso_wf ,
         ew.id_tipo_estado,
         tew.id_tipo_estado_anterior
      into
         v_id_proceso_wf,
         v_id_tipo_estado,
         v_id_tipo_estado_anterior
    from wf.testado_wf ew
    inner join wf.ttipo_estado tew on tew.id_tipo_estado = ew.id_tipo_estado
    where ew.id_estado_wf = p_id_estado_wf;

-- si no tenemos un estado predecesor predefinido buscamos recursivamente en la configuracion
   IF  v_id_tipo_estado_anterior is null THEN
           --buscar estado anterior segun configuracion
           SELECT
            oe.ps_id_tipo_estado,
            oe.ps_codigo_estado
           into
             va_id_tipo_estado,
             va_codigo_estado


           FROM wf.f_obtener_cadena_tipos_estados_anteriores_wf(v_id_tipo_estado) oe;



                raise notice 'parm  % %',v_id_proceso_wf  , p_id_estado_wf  ;
           --buscar responsables, funcionario, depto o usuario
           -- recursivamente has encontrar el ulitmo estado en el log que coincida con el tipo



           WITH RECURSIVE estados (id_estado_wf,id_estado_anterior, codigo, id_tipo_estado) AS (
                                              select ew.id_estado_wf,
                                                     ew.id_estado_anterior,
                                                     te.codigo,
                                                     te.id_tipo_estado

                                              from wf.testado_wf ew
                                              inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado and te.estado_reg = 'activo'
                                              where ew.id_estado_wf = p_id_estado_wf
                                              UNION ALL
                                              SELECT ewp.id_estado_wf,
                                                     ewp.id_estado_anterior,
                                                     tep.codigo,
                                                     tep.id_tipo_estado
                                              FROM estados a
                                                   INNER JOIN wf.testado_wf ewp on
                                                    ewp.id_estado_wf = a.id_estado_anterior
                                                   INNER JOIN wf.ttipo_estado tep on tep.id_tipo_estado = ewp.id_tipo_estado and tep.estado_reg = 'activo')


                                               SELECT id_estado_wf,
                                                      codigo,
                                                      id_tipo_estado
                                                  into
                                                     ps_id_estado_wf_ant,
                                                     ps_codigo_estado,
                                                     ps_id_tipo_estado
                                               FROM estados
                                               WHERE id_tipo_estado = ANY (va_id_tipo_estado)
                                               order by  id_estado_wf   desc
                                               limit 1 offset 0;

             select
             ewp.id_funcionario,
             ewp.id_usuario_reg,
             ewp.id_depto
            into
             ps_id_funcionario,
             ps_id_usuario_reg,
             ps_id_depto
            from wf.testado_wf ewp
            inner join wf.ttipo_estado te on te.id_tipo_estado=ewp.id_tipo_estado
            where ewp.id_estado_wf = ps_id_estado_wf_ant;


   ELSE

           SELECT

                 con.ps_id_funcionario ,
                 con.ps_id_usuario_reg ,
                 con.ps_id_depto ,
                 con.ps_codigo_estado ,
                 con.ps_id_estado_wf_ant

             into
                 ps_id_funcionario,
                 ps_id_usuario_reg,
                 ps_id_depto,
                 ps_codigo_estado,
                 ps_id_estado_wf_ant


             FROM wf.f_obtener_estado_segun_log_wf(p_id_estado_wf, v_id_tipo_estado_anterior) con;

             ps_id_tipo_estado = v_id_tipo_estado_anterior;

   END IF;

   --#144 insertar correo al retroceder de estado se define colocar la logica aqui
   --por que es el lugar donde tendra efecto en todos las WF y donde
   --se puede identificar el anterior estado

   --Recuperamos informacion del proceso actual

    SELECT
        e.id_usuario_reg,
        w.nro_tramite
        into
        v_id_usuario,
        v_nro_tramite
      From wf.testado_wf e
      join wf.tproceso_wf w on w.id_proceso_wf = e.id_proceso_wf
      Where e.id_estado_wf = p_id_estado_wf;

    SELECT
        te.acceso_directo_alerta,
        te.parametros_ad,
        te.nombre_clase_alerta,
        te.alerta
    Into
        v_acceso_directo,
        v_parametros_ad,
        v_clase ,
        v_alerta
    FROM wf.ttipo_estado te
    WHERE te.id_tipo_estado = ps_id_tipo_estado;
   --si la alerta no esta configurado por interfaz
   --enviara una alerta por defecto

   IF v_alerta = 'no' THEN --#144
       --si no existe el funcionario del estado anterior
       --recuperamos el usuario que registro el estado actual
       --por que este usuario es el que dio siguiente el el flujo
       IF ps_id_funcionario is null THEN

          SELECT
            p.nombre ,
            p.correo
              INTO
            v_desc_funcionario,
            v_correo
          FROM segu.tpersona p
          LEFT JOIN segu.tusuario u on u.id_persona = p.id_persona
          WHERE u.id_usuario = v_id_usuario;



       ELSE
                SELECT
                  fu.desc_funcionario1,
                  fun.email_empresa
                INTO
                  v_desc_funcionario,
                  v_correo
                FROM orga.tfuncionario fun
                LEFT JOIN orga.vfuncionario fu on fu.id_funcionario = fun.id_funcionario
                WHERE fun.id_funcionario = ps_id_funcionario;

       END IF;

       --si el tipo de estado anterior no tiene estas campos configurados los seteamos con
       IF v_acceso_directo = '' THEN
        v_acceso_directo = '';
       END IF;
       IF v_clase = '' THEN
        v_clase = '';
       END IF;
       IF v_parametros_ad = '' THEN
        v_parametros_ad = '';
       ELSE
       v_parametros_ad  ='{filtro_directo:{campo:"'||v_parametros_ad::varchar||'",valor:"'||v_id_proceso_wf::varchar||'"}}';
       END IF;


        v_descripcion_correo = '<font color="FF0000" size="5"><font size="4">NOTIFICACIÓN DE RETROCESO DE ESTADO</font> </font><br><br><b></b>El motivo de la presente es notificarle sobre El Retroceso de Estado con el número de trámite : <b>'||COALESCE(v_nro_tramite,'')||' </b> al Estado de '||COALESCE(ps_codigo_estado,'')||' .<br>Saludos.<br>';
        v_tipo_noti = 'notificacion';
        v_titulo  = 'RETROCESO';

        v_id_alarma = param.f_inserta_alarma(
                                        ps_id_funcionario,
                                        v_descripcion_correo,--par_descripcion
                                        v_acceso_directo,--acceso directo
                                        now()::date,--par_fecha: Indica la fecha de vencimiento de la alarma
                                        v_tipo_noti, --notificacion
                                        v_titulo,  --asunto
                                        1,
                                        v_clase, --clase
                                        v_titulo,--titulo
                                        v_parametros_ad,--par_parametros varchar,   parametros a mandar a la interface de acceso directo
                                        v_id_usuario, --usuario a quien va dirigida la alarma
                                        v_titulo,--titulo correo
                                        v_correo, --correo funcionario
                                        null,--#9
                                        v_id_proceso_wf,
                                        ps_id_estado_wf_ant
                                       );
   END IF;

return;
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
CREATE OR REPLACE FUNCTION param.f_inserta_alarma (
  par_id_funcionario integer,
  par_descripcion varchar,
  par_acceso_directo varchar,
  par_fecha date,
  par_tipo varchar,
  par_obs varchar,
  par_id_usuario integer,
  par_clase varchar,
  par_titulo varchar,
  par_parametros varchar,
  par_id_usuario_alarma integer,
  par_titulo_correo varchar,
  par_correos text = NULL::text,
  par_documentos text = NULL::text,
  p_id_proceso_wf integer = NULL::integer,
  p_id_estado_wf integer = NULL::integer,
  p_id_plantilla_correo integer = NULL::integer,
  p_automatizado varchar = 'si'::character varying
)
RETURNS integer AS
$body$
/************************************
FUNCION: f_inserta_alarma
AUTOR: 	    rac
PARAMETROS: par_id_funcionario : indica el funcionario para el que se genera la alrma
            par_descripcion: una descripcion de la alarma
            par_acceso_directo: es el link que lleva a la relacion de la alarma generada
            par_fecha: Indica la fecha de vencimiento de la alarma
            par_tipo: indica el tipo de alarma, puede ser alarma o notificacion
            par_obs: son las observaciones de la alarma
 			par_id_usuario: integer,   el usuario que registra la alarma
            
            par_clase varchar,        clases a ejecutar en interface deacceso directo
            par_titulo varchar,       titulo de la interface de acceso directo
            par_parametros varchar,   parametros a mandar a la interface de acceso directo
            par_id_usuario_alarma integer,dica el usuario para que se cre la alarma (solo si funcionario es NULL)
            par_titulo_correo varchar,   titulo de correo
          
************************************/
DECLARE
    
    v_id_alarma                             integer;
    v_nombre_funcion						text;  
    v_resp                                  varchar;
	v_estado_envio 							varchar;
    
BEGIN

	v_nombre_funcion:='param.f_inserta_alarma';
    
    IF  p_automatizado = 'si' THEN
        v_estado_envio = 'exito';
    ELSE
        v_estado_envio = 'bloqueado';
    END IF;
    
    
   --Realizamos la insercion de datos en alarma
   insert into param.talarma(
              acceso_directo,
              id_funcionario,
              fecha,
              estado_reg,
              descripcion,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod,
              tipo,
              obs,
              clase,
              titulo,
              parametros,
              id_usuario,
              titulo_correo,
              correos,
              documentos,
              id_proceso_wf,
              id_estado_wf,
              id_plantilla_correo,
              estado_envio
              ) values(
              par_acceso_directo,
              par_id_funcionario,
              par_fecha,
              'activo',
              par_descripcion,
              par_id_usuario,
              now(),
              null,
              null,
              par_tipo,
              par_obs,
              par_clase,
              par_titulo,
              par_parametros,
              par_id_usuario_alarma,
              par_titulo_correo,
              par_correos,
              par_documentos,
              p_id_proceso_wf,
              p_id_estado_wf,
              p_id_plantilla_correo,
              v_estado_envio
			)RETURNING id_alarma into v_id_alarma;
    
    return v_id_alarma;
    


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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_documento_historico_wf_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
  /**************************************************************************
   SISTEMA:		Work Flow
   FUNCION: 		wf.ft_documento_historico_wf_ime
   DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tdocumento_wf'
   AUTOR: 		 (admin)
   FECHA:	        15-01-2014 13:52:19
   COMENTARIOS:
  ***************************************************************************
   HISTORIAL DE MODIFICACIONES:

   DESCRIPCION:
   AUTOR:
   FECHA:
  ***************************************************************************/

  DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;

  BEGIN

    v_nombre_funcion = 'wf.ft_documento_historico_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);

   /*********************************
     #TRANSACCION:  'WF_DWFH_MOD'
     #DESCRIPCION:    Mofifica documentos, chequeo fisico y observaciones
     #AUTOR:        admin
     #FECHA:        15-01-2014 13:52:19
    ***********************************/

    if(p_transaccion='WF_DWFH_MOD')then

      begin
        --Sentencia de la modificacion
        update wf.tdocumento_historico_wf set

          observacion = v_parametros.observacion--#

        where id_documento_historico_wf=v_parametros.id_documento_historico_wf;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documento modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_historico_wf',v_parametros.id_documento_historico_wf::varchar);

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
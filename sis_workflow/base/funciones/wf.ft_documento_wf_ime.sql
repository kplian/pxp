CREATE OR REPLACE FUNCTION wf.ft_documento_wf_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
  $body$
  /**************************************************************************
   SISTEMA:		Work Flow
   FUNCION: 		wf.ft_documento_wf_ime
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

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_documento_wf		integer;
    v_momento				varchar;
    v_max_version           integer;
    v_id_documento_historico_wf integer;
    v_new_url				varchar;
    v_registros_his			record;
    v_sw_tiene_fisico		varchar;
    v_sw_tiene_modificar 	varchar;
    v_sw_tiene_insertar 	varchar;
    v_config_grupo_doc 		varchar;
    v_registros_pwf 		record;
    v_registros				record;
    v_registros_fisicos 	record;
    va_id_tipo_estado_siguiente		integer[];
    v_id_tipo_documentos 		varchar;
    va_id_tipo_documentos		VARCHAR[];
    v_tamano					integer;
    v_i							integer;

  BEGIN

    v_nombre_funcion = 'wf.ft_documento_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);


    /*********************************    
 	#TRANSACCION:  'WF_DWF_INS'
 	#DESCRIPCION:	Insertar doucmentos por demanda 
 	#AUTOR:		rac	
 	#FECHA:		15-04-2015 13:52:19
	***********************************/

    if(p_transaccion='WF_DWF_INS')then

      begin


        va_id_tipo_documentos = string_to_array(v_parametros.id_tipo_documentos,',');
        v_tamano = coalesce(array_length(va_id_tipo_documentos, 1),0);



        FOR v_i IN 1..v_tamano LOOP

          INSERT INTO
            wf.tdocumento_wf
            (
              id_usuario_reg,
              fecha_reg,
              estado_reg,
              id_tipo_documento,
              id_proceso_wf,
              demanda,
              obs,
              momento,
              chequeado

            )
          VALUES (
            p_id_usuario,
            now(),
            'activo',
            (va_id_tipo_documentos[v_i])::integer,
            v_parametros.id_proceso_wf,
            'si',
            'insertado manualmente',
            'exigir',
            'no'
          );

        END LOOP ;
        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','nuevo Documento');
        v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documentos',v_parametros.id_tipo_documentos::varchar);

        --Devuelve la respuesta
        return v_resp;

      end;

    /*********************************
     #TRANSACCION:  'WF_DWF_MOD'
     #DESCRIPCION:	Mofifica documentos, chequeo fisico y observaciones
     #AUTOR:		admin
     #FECHA:		15-01-2014 13:52:19
    ***********************************/

    elsif(p_transaccion='WF_DWF_MOD')then

      begin
        --Sentencia de la modificacion
        update wf.tdocumento_wf set
          --obs = v_parametros.obs,
          chequeado_fisico = v_parametros.chequeado_fisico,
          fecha_mod = now(),
          id_usuario_mod = p_id_usuario

        where id_documento_wf=v_parametros.id_documento_wf;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documento modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_wf',v_parametros.id_documento_wf::varchar);

        --Devuelve la respuesta
        return v_resp;

      end;

    /*********************************
     #TRANSACCION:  'WF_DWF_ELI'
     #DESCRIPCION:	Eliminacion de registros
     #AUTOR:		admin
     #FECHA:		15-01-2014 13:52:19
    ***********************************/

    elsif(p_transaccion='WF_DWF_ELI')then

      begin
        --Sentencia de la eliminacion
        delete from wf.tdocumento_wf
        where id_documento_wf=v_parametros.id_documento_wf;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documento eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_wf',v_parametros.id_documento_wf::varchar);

        --Devuelve la respuesta
        return v_resp;

      end;



    /*********************************
    #TRANSACCION:  'WF_DOCWFAR_MOD'
    #DESCRIPCION: Subir arhcivos al documento de WF
    #AUTOR:   admin
    #FECHA:   08-02-2013 19:01:00
    ***********************************/

    elsif(p_transaccion='WF_DOCWFAR_MOD')then
      begin

        -- optine la version maxima del historico
        select
          max(dh.version)
        into
          v_max_version
        from wf.tdocumento_historico_wf dh
        where dh.id_documento = v_parametros.id_documento_wf;

        -- optine la version maxima del historico
        select
          dh.url,
          dh.url_old,
          dh.version,
          dh.id_documento_historico_wf
        into
          v_registros_his
        from wf.tdocumento_historico_wf dh
        where dh.id_documento = v_parametros.id_documento_wf and version = v_max_version;

        -- cambiamos el estado de las versiones anterior

        UPDATE wf.tdocumento_historico_wf  SET vigente = 'no'
        WHERE  id_documento = v_parametros.id_documento_wf;

        -- inserta registro en el historico con el numero de version  actual
        v_new_url = v_parametros.folder||'historico/'||v_parametros.only_file||'_v'||(COALESCE(v_max_version,0) + 1)::VARCHAR||'.'||v_parametros.extension;

        INSERT INTO
          wf.tdocumento_historico_wf
          (
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_usuario_ai,
            usuario_ai,
            id_documento,
            url_old,
            url,
            extension,
            version,
            vigente
          )
        VALUES (
          p_id_usuario,
          now(),
          'activo',
          v_parametros._id_usuario_ai,
          v_parametros._nombre_usuario_ai,
          v_parametros.id_documento_wf,
          v_parametros.file_name,
          v_new_url,
          v_parametros.extension,
          COALESCE(v_max_version,0) +1,
          'si')RETURNING id_documento_historico_wf into v_id_documento_historico_wf;

        -- raise exception '--- %',COALESCE(v_max_version,0);
         --actualiza el archivo
        update wf.tdocumento_wf set
          --archivo=v_parametros.archivo,
          extension=v_parametros.extension,
          chequeado = 'si',
          url = v_parametros.file_name,
          fecha_mod = now(),
          id_usuario_mod = p_id_usuario,
          fecha_upload = now(),
          id_usuario_upload = p_id_usuario
        where id_documento_wf = v_parametros.id_documento_wf;

        if (pxp.f_existe_parametro(p_tabla,'hash_firma')) then

          update wf.tdocumento_wf set
            --archivo=v_parametros.archivo,
            hash_firma=v_parametros.hash_firma,
            datos_firma = to_json(v_parametros.datos_firma),
            accion_pendiente = NULL
          where id_documento_wf = v_parametros.id_documento_wf;
        end if;

        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_documento_wf);
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_wf',v_parametros.id_documento_wf::varchar);
        -- retorna el numero de la ultima version para renombar archivo viejo
        v_resp = pxp.f_agrega_clave(v_resp,'max_version',COALESCE(v_max_version,0)::varchar);
        -- retorna las urls
        v_resp = pxp.f_agrega_clave(v_resp,'url_origen',v_registros_his.url_old);
        v_resp = pxp.f_agrega_clave(v_resp,'url_destino',v_registros_his.url);

        return v_resp;
      end;
    /*********************************
   #TRANSACCION:  'WF_DOCWELIAR_MOD'
   #DESCRIPCION: Elimina archivo de DW
   #AUTOR:   admin
   #FECHA:   08-02-2013 19:01:00
   ***********************************/

    elsif(p_transaccion='WF_DOCWELIAR_MOD')then
      begin
        select
          max(dh.version)
        into
          v_max_version
        from wf.tdocumento_historico_wf dh
        where dh.id_documento = v_parametros.id_documento_wf;

        -- optine la version maxima del historico
        select
          dh.url,
          dh.url_old,
          dh.version,
          dh.id_documento_historico_wf,
          dw.fecha_firma,
          dw.datos_firma,
          dw.hash_firma
        into
          v_registros_his
        from wf.tdocumento_historico_wf dh
          inner join wf.tdocumento_wf dw on dw.id_documento_wf = dh.id_documento
        where dh.id_documento = v_parametros.id_documento_wf and version = v_max_version;

        -- cambiamos el estado de las versiones anterior

        UPDATE wf.tdocumento_historico_wf  SET vigente = 'no',
          fecha_firma = v_registros_his.fecha_firma,
          datos_firma = v_registros_his.datos_firma,
          hash_firma = v_registros_his.hash_firma
        WHERE  id_documento = v_parametros.id_documento_wf;

        -- raise exception '--- %',COALESCE(v_max_version,0);
         --actualiza el archivo
        update wf.tdocumento_wf set
          --archivo=v_parametros.archivo,
          accion_pendiente = NULL,
          fecha_firma = NULL,
          datos_firma = NULL,
          hash_firma = NULL,
          extension=NULL,
          chequeado = 'no',
          url = NULL,
          fecha_mod = now(),
          id_usuario_mod = p_id_usuario,
          fecha_upload = NULL,
          id_usuario_upload = NULL
        where id_documento_wf = v_parametros.id_documento_wf;


        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_documento_wf);
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_wf',v_parametros.id_documento_wf::varchar);
        -- retorna el numero de la ultima version para renombar archivo viejo
        v_resp = pxp.f_agrega_clave(v_resp,'max_version',COALESCE(v_max_version,0)::varchar);
        -- retorna las urls
        v_resp = pxp.f_agrega_clave(v_resp,'url_destino',v_registros_his.url);

        return v_resp;
      end;
    /*********************************
    #TRANSACCION:  'WF_CABMOM_IME'
    #DESCRIPCION: Cambiar Momentos (exigir, verificar) de Documentos WF
    #AUTOR:   admin
    #FECHA:   08-02-2013 19:01:00
    ***********************************/

    elsif(p_transaccion='WF_CABMOM_IME')then
      begin

        select
          dwf.momento
        into
          v_momento
        from wf.tdocumento_wf  dwf
        where dwf.id_documento_wf = v_parametros.id_documento_wf;

        IF v_momento  = 'exigir' THEN
          v_momento = 'verificar';
        ELSE
          v_momento = 'exigir';
        END IF;

        update wf.tdocumento_wf set
          momento = v_momento,
          fecha_mod = now(),
          id_usuario_mod = p_id_usuario
        where id_documento_wf=v_parametros.id_documento_wf;


        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_documento_wf);
        v_resp = pxp.f_agrega_clave(v_resp,'id_documento_wf',v_parametros.id_documento_wf::varchar);

        return v_resp;
      end;
    /*********************************
    #TRANSACCION:  'WF_VERDOC_IME'
    #DESCRIPCION: verifica configuracion del documentos por estado
    #AUTOR:   admin
    #FECHA:   08-02-2013 19:01:00
    ***********************************/

    elsif(p_transaccion='WF_VERDOC_IME')then
      begin

        v_sw_tiene_modificar = 'no';
        v_sw_tiene_insertar = 'no';
        v_sw_tiene_fisico = 'no';
        v_config_grupo_doc = '';
        v_id_tipo_documentos = '';


        select
          pw.id_tipo_proceso,
          pw.id_proceso_wf,
          ewf.id_estado_wf,
          ewf.id_estado_anterior,
          ewf.id_tipo_estado,
          tew.grupo_doc,
          COALESCE(pm.grupo_doc,'') as grupo_doc_def
        into
          v_registros_pwf
        from wf.tproceso_wf pw
          inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
          inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
          inner join wf.testado_wf ewf on ewf.id_proceso_wf = pw.id_proceso_wf and ewf.estado_reg = 'activo'
          inner join wf.ttipo_estado tew on tew.id_tipo_estado = ewf.id_tipo_estado
        where pw.id_proceso_wf = v_parametros.id_proceso_wf;




        -- si no tiene una grupacion de pestañas definida para el estado recuepra la del proceso macro
        IF v_registros_pwf.grupo_doc is not null and  v_registros_pwf.grupo_doc != '' THEN
          v_config_grupo_doc = v_registros_pwf.grupo_doc;
        ELSE
          v_config_grupo_doc = v_registros_pwf.grupo_doc_def;
        END IF;


        --chequea si en el estado actual tiene la opcion de modificar   algun documento
        FOR v_registros in (select
                              tde.momento,
                              tde.regla,
                              tde.id_tipo_documento
                            from wf.tdocumento_wf  dwf
                              inner join wf.ttipo_documento_estado  tde on tde.id_tipo_documento = dwf.id_tipo_documento and tde.estado_reg = 'activo'
                            where  dwf.id_proceso_wf = v_parametros.id_proceso_wf)  LOOP

          --solo revisa las reglas de lo momenstos que nos interesa
          IF  (v_registros.momento  = 'modificar'  and v_sw_tiene_modificar = 'no') THEN
            -- si la regla es verdadera ...
            IF  (wf.f_evaluar_regla_wf ( p_id_usuario,
                                         v_registros_pwf.id_proceso_wf,
                                         v_registros.regla,
                                         v_registros_pwf.id_tipo_estado,
                                         v_registros_pwf.id_estado_wf))  THEN

              v_sw_tiene_modificar = 'si';


            END IF;
          END IF;

        END LOOP;

        --chequea que tipo de documentos se pueden insertar ...



        FOR v_registros in (select
                              tde.momento,
                              tde.regla,
                              tde.id_tipo_documento
                            from wf.ttipo_documento_estado  tde
                            where  tde.id_tipo_estado = v_registros_pwf.id_tipo_estado and tde.estado_reg = 'activo')  LOOP

          --solo revisa las reglas de lo momenstos que nos interesa
          IF  (v_registros.momento  = 'insertar') THEN
            -- si la regla es verdadera ...
            IF  (wf.f_evaluar_regla_wf ( p_id_usuario,
                                         v_registros_pwf.id_proceso_wf,
                                         v_registros.regla,
                                         v_registros_pwf.id_tipo_estado,
                                         v_registros_pwf.id_estado_wf))  THEN



              IF v_sw_tiene_insertar = 'no'  THEN
                v_id_tipo_documentos = v_registros.id_tipo_documento::varchar;
              ELSE
                v_id_tipo_documentos = v_id_tipo_documentos||','||v_registros.id_tipo_documento::varchar;
              END IF;

              v_sw_tiene_insertar = 'si';



            END IF;
          END IF;

        END LOOP;

        --chequea si para los posibles estados siguientes se verifica o exige un fisico

        SELECT
          ps_id_tipo_estado
        into

          va_id_tipo_estado_siguiente

        FROM wf.f_obtener_estado_wf(
            v_parametros.id_proceso_wf,
            NULL,
            v_registros_pwf.id_tipo_estado,
            'siguiente',
            p_id_usuario);

        FOR v_registros_fisicos in (
          select
            tde.momento,
            tde.regla,
            tde.id_tipo_estado
          from wf.tdocumento_wf  dwf
            inner join wf.ttipo_documento_estado  tde on tde.id_tipo_documento = dwf.id_tipo_documento and tde.estado_reg = 'activo'
          where    tde.id_tipo_estado = ANY(va_id_tipo_estado_siguiente))  LOOP

          --solo revisa las reglas de lo momenstos que nos interesa
          IF  (v_registros.momento  = 'exigir_fisico'  and v_sw_tiene_fisico = 'no') or
              (v_registros.momento  = 'verificar_fisico'   and v_sw_tiene_fisico = 'no') THEN
            -- si la regla es verdadera ...
            IF  (wf.f_evaluar_regla_wf ( p_id_usuario,
                                         v_registros_pwf.id_proceso_wf,
                                         v_registros_fisicos.regla,
                                         v_registros_fisicos.id_tipo_estado,
                                         v_registros_pwf.id_estado_wf))  THEN

              IF v_registros.momento = 'exigir_fisico'  THEN
                v_sw_tiene_fisico = 'si';
              ELSIF  v_registros.momento = 'verificar_fisico' THEN
                v_sw_tiene_fisico = 'si';
              END IF;

            END IF;
          END IF;

        END LOOP;


        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','momentos verificados');
        v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
        v_resp = pxp.f_agrega_clave(v_resp,'sw_tiene_modificar', v_sw_tiene_modificar::varchar);
        v_resp = pxp.f_agrega_clave(v_resp,'sw_tiene_insertar', v_sw_tiene_insertar::varchar);
        v_resp = pxp.f_agrega_clave(v_resp,'sw_tiene_fisico', v_sw_tiene_fisico::varchar);
        v_resp = pxp.f_agrega_clave(v_resp,'json_grupo_doc', v_config_grupo_doc);
        v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documentos', v_id_tipo_documentos);


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
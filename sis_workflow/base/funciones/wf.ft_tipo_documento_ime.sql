CREATE OR REPLACE FUNCTION wf.ft_tipo_documento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:       Work Flow
 FUNCION:       wf.ft_tipo_documento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_documento'
 AUTOR:          (admin)
 FECHA:         14-01-2014 17:43:47
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:         
 FECHA:     
***************************************************************************/

DECLARE

    v_nro_requerimiento     integer;
    v_parametros            record;
    v_id_requerimiento      integer;
    v_resp                  varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_tipo_documento integer;
                
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_documento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
    #TRANSACCION:  'WF_TIPDW_INS'
    #DESCRIPCION:   Insercion de registros
    #AUTOR:     admin   
    #FECHA:     14-01-2014 17:43:47
    ***********************************/

    if(p_transaccion='WF_TIPDW_INS')then
                    
        begin

          --Sentencia de la insercion
          insert into wf.ttipo_documento(
          nombre,
          id_proceso_macro,
          codigo,
          descripcion,
          estado_reg,
          tipo,
          id_tipo_proceso,
          action,
          id_usuario_reg,
          fecha_reg,
          id_usuario_mod,
          fecha_mod,
          solo_lectura,
          categoria_documento,
          orden,
          nombre_vista,
          esquema_vista
            ) values(
          v_parametros.nombre,
          v_parametros.id_proceso_macro,
          v_parametros.codigo,
          v_parametros.descripcion,
          'activo',
          v_parametros.tipo,
          v_parametros.id_tipo_proceso,
          v_parametros.action,
          p_id_usuario,
          now(),
          null,
          null,
          v_parametros.solo_lectura,
          string_to_array(v_parametros.categoria_documento,','),
          v_parametros.orden,
          v_parametros.nombre_vista,
          v_parametros.esquema_vista    
              
      )RETURNING id_tipo_documento into v_id_tipo_documento;
      
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Documentos almacenado(a) con exito (id_tipo_documento'||v_id_tipo_documento||')'); 
      v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento',v_id_tipo_documento::varchar);

      --Devuelve la respuesta
      return v_resp;

    end;

  /*********************************    
  #TRANSACCION:  'WF_TIPDW_MOD'
  #DESCRIPCION: Modificacion de registros
  #AUTOR:   admin 
  #FECHA:   14-01-2014 17:43:47
  ***********************************/

  elsif(p_transaccion='WF_TIPDW_MOD')then

    begin
    
      --raise exception '%  %',v_parametros.nombre_vista,v_parametros.id_tipo_documento;
            --Sentencia de la modificacion
            update wf.ttipo_documento set
                  nombre = v_parametros.nombre,
                  id_proceso_macro = v_parametros.id_proceso_macro,
                  codigo = v_parametros.codigo,
                  descripcion = v_parametros.descripcion,
                  tipo = v_parametros.tipo,
                  id_tipo_proceso = v_parametros.id_tipo_proceso,
                  action = v_parametros.action,
                  id_usuario_mod = p_id_usuario,
                  fecha_mod = now(),
                  solo_lectura =  v_parametros.solo_lectura,
                  categoria_documento = string_to_array(v_parametros.categoria_documento,','),
                  orden = v_parametros.orden,
                  nombre_vista = v_parametros.nombre_vista,
                  esquema_vista = v_parametros.esquema_vista
            where id_tipo_documento=v_parametros.id_tipo_documento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Documentos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento',v_parametros.id_tipo_documento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
    #TRANSACCION:  'WF_TIPDW_ELI'
    #DESCRIPCION:   Eliminacion de registros
    #AUTOR:     admin   
    #FECHA:     14-01-2014 17:43:47
    ***********************************/

    elsif(p_transaccion='WF_TIPDW_ELI')then

        begin
        
            if (exists (select 1 
                        from wf.ttipo_documento_estado t
                        where t.id_tipo_documento = v_parametros.id_tipo_documento and
                        t.estado_reg = 'activo'))then
                raise exception 'Existe(n) Momentos de documento que depende(n) de este tipo documento';
            end if;
            
            --Sentencia de la eliminacion
            update wf.ttipo_documento
            set estado_reg = 'inactivo'
            where id_tipo_documento=v_parametros.id_tipo_documento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Documentos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento',v_parametros.id_tipo_documento::varchar);
              
            --Devuelve la respuesta
            return v_resp;

        end;
        
  /*********************************    
  #TRANSACCION:  'WF_UPLPLA_MOD'
  #DESCRIPCION: Upload de la plantilla
  #AUTOR:     RCM
  #FECHA:     19/04/2015
  ***********************************/

  elsif(p_transaccion='WF_UPLPLA_MOD')then

    begin
            --Sentencia de la modificacion
                
            update wf.ttipo_documento set
            nombre_archivo_plantilla = v_parametros.nombre_archivo_plantilla,
            nombre_vista = v_parametros.nombre_vista,
            esquema_vista = v_parametros.esquema_vista
            where id_tipo_documento=v_parametros.id_tipo_documento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documento subido con éxito'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento',v_parametros.id_tipo_documento::varchar);
               
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
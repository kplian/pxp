CREATE OR REPLACE FUNCTION param.ft_documento_fiscal_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Parametros Generales
 FUNCION:     param.ft_documento_fiscal_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdocumento_fiscal'
 AUTOR:      (admin)
 FECHA:         03-04-2013 15:48:47
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
  v_resp                varchar;
  v_nombre_funcion        text;
  v_mensaje_error         text;
  v_id_documento_fiscal integer;
    v_razon_social      varchar;
          
BEGIN

    v_nombre_funcion = 'param.ft_documento_fiscal_ime';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'PM_DOCFIS_INS'
  #DESCRIPCION: Insercion de registros
  #AUTOR:   admin 
  #FECHA:   03-04-2013 15:48:47
  ***********************************/

  if(p_transaccion='PM_DOCFIS_INS')then
          
        begin
          --Sentencia de la insercion
          insert into param.tdocumento_fiscal(
      estado_reg,
      nro_documento,
      razon_social,
      nro_autorizacion,
      estado,
      nit,
      codigo_control,
      formulario,
      tipo_retencion,
      id_plantilla,
      fecha_doc,
      dui,
      fecha_reg,
      id_usuario_reg,
      fecha_mod,
      id_usuario_mod
            ) values(
      'activo',
      v_parametros.nro_documento,
      v_parametros.razon_social,
      v_parametros.nro_autorizacion,
      v_parametros.estado,
      v_parametros.nit,
      v_parametros.codigo_control,
      v_parametros.formulario,
      v_parametros.tipo_retencion,
      v_parametros.id_plantilla,
      v_parametros.fecha_doc,
      v_parametros.dui,
      now(),
      p_id_usuario,
      null,
      null
              
      )RETURNING id_documento_fiscal into v_id_documento_fiscal;
      
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos Fiscales almacenado(a) con exito (id_documento_fiscal'||v_id_documento_fiscal||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_fiscal',v_id_documento_fiscal::varchar);

            --Devuelve la respuesta
            return v_resp;

    end;

  /*********************************    
  #TRANSACCION:  'PM_DOCFIS_MOD'
  #DESCRIPCION: Modificacion de registros
  #AUTOR:   admin 
  #FECHA:   03-04-2013 15:48:47
  ***********************************/

  elsif(p_transaccion='PM_DOCFIS_MOD')then

    begin
      --Sentencia de la modificacion
      update param.tdocumento_fiscal set
      nro_documento = v_parametros.nro_documento,
      razon_social = v_parametros.razon_social,
      nro_autorizacion = v_parametros.nro_autorizacion,
      estado = v_parametros.estado,
      nit = v_parametros.nit,
      codigo_control = v_parametros.codigo_control,
      formulario = v_parametros.formulario,
      tipo_retencion = v_parametros.tipo_retencion,
      id_plantilla = v_parametros.id_plantilla,
      fecha_doc = v_parametros.fecha_doc,
      dui = v_parametros.dui,
      fecha_mod = now(),
      id_usuario_mod = p_id_usuario
      where id_documento_fiscal=v_parametros.id_documento_fiscal;
               
      --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos Fiscales modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_fiscal',v_parametros.id_documento_fiscal::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
    end;

  /*********************************    
  #TRANSACCION:  'PM_DOCFIS_ELI'
  #DESCRIPCION: Eliminacion de registros
  #AUTOR:   admin 
  #FECHA:   03-04-2013 15:48:47
  ***********************************/

  elsif(p_transaccion='PM_DOCFIS_ELI')then

    begin
      --Sentencia de la eliminacion
      delete from param.tdocumento_fiscal
            where id_documento_fiscal=v_parametros.id_documento_fiscal;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documentos Fiscales eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_documento_fiscal',v_parametros.id_documento_fiscal::varchar);
              
            --Devuelve la respuesta
            return v_resp;

    end;
        
    /*********************************    
  #TRANSACCION:  'PM_OBTNIT_SEL'
  #DESCRIPCION: Obtiene datos en función del NIT
  #AUTOR:     rcm
  #FECHA:     05-04-2013
  ***********************************/

  elsif(p_transaccion='PM_OBTNIT_GET')then
            
      begin
        --Busca el NIT en el regitro de Documentos, busca el último registrado
      select
            razon_social
            into
            v_razon_social
            from param.tdocumento_fiscal
            where nit = v_parametros.nit
            and fecha_doc in (select max(fecha_doc)
                                    from param.tdocumento_fiscal
                                    where nit = v_parametros.nit);
            
            --Si no existe en Documentos, busca en Institucion
            if v_razon_social is null then
              select
                nombre
                into
              v_razon_social
                from param.tinstitucion
                where doc_id = v_parametros.nit;
                
                --Si no encuentra busca en persona
                if v_razon_social is null then
                  select
                    apellido_paterno
                    into
                    v_razon_social
                    from segu.tpersona
                    where ci = v_parametros.nit;
                end if;
                
            end if;
      
       --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','NIT encontrado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'razon_social',v_razon_social);
              
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
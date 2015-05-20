--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_proceso_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Work Flow
 FUNCION:     wf.ft_tipo_proceso_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_proceso'
 AUTOR:      (FRH)
 FECHA:         21-02-2013 15:52:52
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
  v_id_tipo_proceso integer;
  v_datos         record;
          
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_proceso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'WF_TIPPROC_INS'
  #DESCRIPCION: Insercion de registros
  #AUTOR:   admin 
  #FECHA:   21-02-2013 15:52:52
  ***********************************/

  if(p_transaccion='WF_TIPPROC_INS')then
          
        begin
        
         IF v_parametros.inicio = 'si' THEN
         --verificamos que sea el unico proceso marcado para inicio
            IF exists (select 1 from wf.ttipo_proceso tp where tp.inicio ='si' and tp.id_proceso_macro = v_parametros.id_proceso_macro ) THEN
                
                raise exception 'Solo un proceso puede marcarce como inicial dentro de un mismo macro proceso';
            
            END IF;
         
         END IF; 
            
       
          --Sentencia de la insercion
          insert into wf.ttipo_proceso(
      nombre,
      codigo,
      id_proceso_macro,
      tabla,
      columna_llave,
      estado_reg,
      id_tipo_estado,
      fecha_reg,
      id_usuario_reg,
      fecha_mod,
      id_usuario_mod,
            inicio,
            tipo_disparo,
            funcion_validacion_wf,
            descripcion,
            codigo_llave
            ) values(
      v_parametros.nombre,
      v_parametros.codigo,
      v_parametros.id_proceso_macro,
      v_parametros.tabla,
      v_parametros.columna_llave,
      'activo',
      v_parametros.id_tipo_estado,
      now(),
      p_id_usuario,
      null,
      null,
            v_parametros.inicio,
            v_parametros.tipo_disparo,
            v_parametros.funcion_validacion_wf,
            v_parametros.descripcion,
            v_parametros.codigo_llave
              
      )RETURNING id_tipo_proceso into v_id_tipo_proceso;
      
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso almacenado(a) con exito (id_tipo_proceso'||v_id_tipo_proceso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_id_tipo_proceso::varchar);

            --Devuelve la respuesta
            return v_resp;

    end;

  /*********************************    
  #TRANSACCION:  'WF_TIPPROC_MOD'
  #DESCRIPCION: Modificacion de registros
  #AUTOR:   admin 
  #FECHA:   21-02-2013 15:52:52
  ***********************************/

  elsif(p_transaccion='WF_TIPPROC_MOD')then

    begin
        
           IF v_parametros.inicio = 'si' THEN
         --verificamos que sea el unico proceso marcado para inicio
            IF exists (select 1 from wf.ttipo_proceso tp 
                       where tp.inicio ='si' and 
                            tp.id_proceso_macro = v_parametros.id_proceso_macro and 
                            tp.id_tipo_proceso != v_parametros.id_tipo_proceso) THEN
                            
                raise exception 'Solo un proceso puede marcarce como inicial dentor de un mismo macro proceso';
            
            END IF;
         
         END IF; 
        
      --Sentencia de la modificacion
      update wf.ttipo_proceso set
      nombre = v_parametros.nombre,
      codigo = v_parametros.codigo,
      id_proceso_macro = v_parametros.id_proceso_macro,
      tabla = v_parametros.tabla,
      columna_llave = v_parametros.columna_llave,
      id_tipo_estado = v_parametros.id_tipo_estado,
      fecha_mod = now(),
      id_usuario_mod = p_id_usuario,
            inicio=v_parametros.inicio,
            tipo_disparo=v_parametros.tipo_disparo,
            funcion_validacion_wf=v_parametros.funcion_validacion_wf,
            descripcion=v_parametros.descripcion,
            codigo_llave= v_parametros.codigo_llave
      where id_tipo_proceso=v_parametros.id_tipo_proceso;
               
      --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_parametros.id_tipo_proceso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
    end;

  /*********************************    
  #TRANSACCION:  'WF_TIPPROC_ELI'
  #DESCRIPCION: Eliminacion de registros
  #AUTOR:   admin 
  #FECHA:   21-02-2013 15:52:52
  ***********************************/

  elsif(p_transaccion='WF_TIPPROC_ELI')then

    begin
    
      if (exists (select 1 
                  from wf.ttipo_estado t
                        where t.id_tipo_proceso = v_parametros.id_tipo_proceso and
                        t.estado_reg = 'activo'))then
              raise exception 'Existe(n) Tipos de Estado que depende(n) de este tipo de proceso';
            end if;
            
            
            if (exists (select 1 
                  from wf.ttipo_documento t
                        where t.id_tipo_proceso = v_parametros.id_tipo_proceso and
                        t.estado_reg = 'activo'))then
              raise exception 'Existe(n) Tipos de Documento que depende(n) de este tipo de proceso';
            end if;
            
            if (exists (select 1 
                  from wf.ttipo_proceso_origen t
                        where t.id_tipo_proceso = v_parametros.id_tipo_proceso and
                        t.estado_reg = 'activo'))then
              raise exception 'Existe(n) Tipos de Proceso Origen que depende(n) de este tipo de proceso';
            end if;
            
            if (exists (select 1 
                  from wf.tlabores_tipo_proceso t
                        where t.id_tipo_proceso = v_parametros.id_tipo_proceso and
                        t.estado_reg = 'activo'))then
              raise exception 'Existe(n) Labores que depende(n) de este tipo de proceso';
            end if;
            
            if (exists (select 1 
                  from wf.ttabla t
                        where t.id_tipo_proceso = v_parametros.id_tipo_proceso and
                        t.estado_reg = 'activo'))then
              raise exception 'Existe(n) Tablas que depende(n) de este tipo de proceso';
            end if;  
                    
            --Sentencia de la modificacion
      update wf.ttipo_proceso set
      estado_reg = 'inactivo'
      where id_tipo_proceso=v_parametros.id_tipo_proceso;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Proceso eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_proceso',v_parametros.id_tipo_proceso::varchar);
              
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
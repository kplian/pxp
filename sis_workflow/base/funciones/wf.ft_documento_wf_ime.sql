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
			    
BEGIN

    v_nombre_funcion = 'wf.ft_documento_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DWF_MOD'
 	#DESCRIPCION:	Mofifica documentos, chequeo fisico y boservaciones
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:52:19
	***********************************/

	if(p_transaccion='WF_DWF_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tdocumento_wf set
			obs = v_parametros.obs,
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
                datos_firma = v_parametros.datos_firma::json,
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
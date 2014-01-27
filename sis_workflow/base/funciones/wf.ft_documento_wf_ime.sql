--------------- SQL ---------------

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
	v_id_documento_wf	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_documento_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DWF_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:52:19
	***********************************/

	if(p_transaccion='WF_DWF_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tdocumento_wf set
			obs = v_parametros.obs
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
          
            update wf.tdocumento_wf set
            --archivo=v_parametros.archivo,
            extension=v_parametros.extension,
            chequeado = 'si',
            url = v_parametros.file_name
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
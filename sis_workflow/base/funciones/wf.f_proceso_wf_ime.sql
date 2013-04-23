--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_proceso_wf_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_wf_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tproceso_wf'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 09:01:51
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
	v_id_proceso_wf	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.f_proceso_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PWF_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	if(p_transaccion='WF_PWF_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tproceso_wf(
			id_tipo_proceso,
			nro_tramite,
			
			estado_reg,			
			id_persona,
			
			id_institucion,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_tipo_proceso,
			v_parametros.nro_tramite,
			
			'activo',
			
			v_parametros.id_persona,
			
			v_parametros.id_institucion,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_proceso_wf into v_id_proceso_wf;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF almacenado(a) con exito (id_proceso_wf'||v_id_proceso_wf||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_id_proceso_wf::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tproceso_wf set
			id_tipo_proceso = v_parametros.id_tipo_proceso,
			nro_tramite = v_parametros.nro_tramite,
			
			
			id_persona = v_parametros.id_persona,
			
			id_institucion = v_parametros.id_institucion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_proceso_wf=v_parametros.id_proceso_wf;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tproceso_wf
            where id_proceso_wf=v_parametros.id_proceso_wf;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
              
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
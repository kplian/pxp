--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_obs_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_obs_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tobs'
 AUTOR: 		 (admin)
 FECHA:	        20-11-2014 18:53:55
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
    v_registros				record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_obs	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_obs_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_OBS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	if(p_transaccion='WF_OBS_INS')then
					
        begin
        	
            --datos del estado
            
            select 
              pwf.nro_tramite
            into
              v_registros
            from wf.testado_wf ewf
            inner join wf.tproceso_wf pwf 
              on pwf.id_proceso_wf = ewf.id_proceso_wf
            where ewf.id_estado_wf = v_parametros.id_estado_wf;
        
            
            --Sentencia de la insercion
        	insert into wf.tobs(
			estado_reg,
			estado,
			descripcion,
			id_funcionario_resp,
			titulo,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod,
            id_estado_wf,
            num_tramite
          	) values(
			
			'activo',
			'abierto',
			v_parametros.descripcion,
			v_parametros.id_funcionario_resp,
			v_parametros.titulo,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null,
            v_parametros.id_estado_wf,
            v_registros.nro_tramite
			)RETURNING id_obs into v_id_obs;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones almacenado(a) con exito (id_obs'||v_id_obs||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_id_obs::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_OBS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBS_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tobs set
			descripcion = v_parametros.descripcion,
			id_funcionario_resp = v_parametros.id_funcionario_resp,
			titulo = v_parametros.titulo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_obs=v_parametros.id_obs;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_parametros.id_obs::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_OBS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tobs
            where id_obs=v_parametros.id_obs;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_parametros.id_obs::varchar);
              
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
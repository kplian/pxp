CREATE OR REPLACE FUNCTION "param"."ft_conf_lector_mobile_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_conf_lector_mobile_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconf_lector_mobile'
 AUTOR: 		 (admin)
 FECHA:	        27-02-2017 01:01:56
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
	v_id_conf_lector_mobile	integer;
	v_respuesta	VARCHAR;

BEGIN

    v_nombre_funcion = 'param.ft_conf_lector_mobile_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:01:56
	***********************************/

	if(p_transaccion='PM_CONFLEC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tconf_lector_mobile(
			nombre,
			estado_reg,
			estado,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			'activo',
			v_parametros.estado,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_conf_lector_mobile into v_id_conf_lector_mobile;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile almacenado(a) con exito (id_conf_lector_mobile'||v_id_conf_lector_mobile||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile',v_id_conf_lector_mobile::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:01:56
	***********************************/

	elsif(p_transaccion='PM_CONFLEC_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tconf_lector_mobile set
			nombre = v_parametros.nombre,
			estado = v_parametros.estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_conf_lector_mobile=v_parametros.id_conf_lector_mobile;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile',v_parametros.id_conf_lector_mobile::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:01:56
	***********************************/

	elsif(p_transaccion='PM_CONFLEC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tconf_lector_mobile
            where id_conf_lector_mobile=v_parametros.id_conf_lector_mobile;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile',v_parametros.id_conf_lector_mobile::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONFLEC_PRU'
 	#DESCRIPCION:	prueba de registros
 	#AUTOR:		admin
 	#FECHA:		27-02-2017 01:01:56
	***********************************/

	elsif(p_transaccion='PM_CONFLEC_PRU')then

		begin
			--Sentencia de la eliminacion

			v_respuesta = '<b>'||v_parametros.code||'<b>';
			v_respuesta= v_respuesta || '<br><br> mensaje de prueba';


            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile',''::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje_code',v_respuesta::varchar);

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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_conf_lector_mobile_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

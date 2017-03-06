CREATE OR REPLACE FUNCTION "orga"."ft_log_generacion_firma_correo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_log_generacion_firma_correo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tlog_generacion_firma_correo'
 AUTOR: 		 (admin)
 FECHA:	        06-03-2017 21:21:37
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
	v_id_log_generacion_firma_correo	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_log_generacion_firma_correo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_LOGFIR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		06-03-2017 21:21:37
	***********************************/

	if(p_transaccion='OR_LOGFIR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tlog_generacion_firma_correo(
			telefono_interno,
			id_funcionario,
			telefono_personal,
			telefono_corporativo,
			estado_reg,
			direccion,
			cargo,
			cargo_ingles,
			nombre,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.telefono_interno,
			v_parametros.id_funcionario,
			v_parametros.telefono_personal,
			v_parametros.telefono_corporativo,
			'activo',
			v_parametros.direccion,
			v_parametros.cargo,
			v_parametros.cargo_ingles,
			v_parametros.nombre,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_log_generacion_firma_correo into v_id_log_generacion_firma_correo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Log Firma Correo almacenado(a) con exito (id_log_generacion_firma_correo'||v_id_log_generacion_firma_correo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_generacion_firma_correo',v_id_log_generacion_firma_correo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_LOGFIR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		06-03-2017 21:21:37
	***********************************/

	elsif(p_transaccion='OR_LOGFIR_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tlog_generacion_firma_correo set
			telefono_interno = v_parametros.telefono_interno,
			id_funcionario = v_parametros.id_funcionario,
			telefono_personal = v_parametros.telefono_personal,
			telefono_corporativo = v_parametros.telefono_corporativo,
			direccion = v_parametros.direccion,
			cargo = v_parametros.cargo,
			cargo_ingles = v_parametros.cargo_ingles,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_log_generacion_firma_correo=v_parametros.id_log_generacion_firma_correo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Log Firma Correo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_generacion_firma_correo',v_parametros.id_log_generacion_firma_correo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_LOGFIR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		06-03-2017 21:21:37
	***********************************/

	elsif(p_transaccion='OR_LOGFIR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tlog_generacion_firma_correo
            where id_log_generacion_firma_correo=v_parametros.id_log_generacion_firma_correo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Log Firma Correo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_log_generacion_firma_correo',v_parametros.id_log_generacion_firma_correo::varchar);
              
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
ALTER FUNCTION "orga"."ft_log_generacion_firma_correo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "param"."ft_conf_lector_mobile_detalle_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_conf_lector_mobile_detalle_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconf_lector_mobile_detalle'
 AUTOR: 		 (admin)
 FECHA:	        27-02-2017 01:07:44
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
	v_id_conf_lector_mobile_detalle	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_conf_lector_mobile_detalle_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:07:44
	***********************************/

	if(p_transaccion='PM_CONFLEM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tconf_lector_mobile_detalle(
			control,
			descripcion,
			activity,
			nombre,
			id_conf_lector_mobile,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.control,
			v_parametros.descripcion,
			v_parametros.activity,
			v_parametros.nombre,
			v_parametros.id_conf_lector_mobile,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_conf_lector_mobile_detalle into v_id_conf_lector_mobile_detalle;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile Detalle almacenado(a) con exito (id_conf_lector_mobile_detalle'||v_id_conf_lector_mobile_detalle||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile_detalle',v_id_conf_lector_mobile_detalle::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:07:44
	***********************************/

	elsif(p_transaccion='PM_CONFLEM_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tconf_lector_mobile_detalle set
			control = v_parametros.control,
			descripcion = v_parametros.descripcion,
			activity = v_parametros.activity,
			nombre = v_parametros.nombre,
			id_conf_lector_mobile = v_parametros.id_conf_lector_mobile,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_conf_lector_mobile_detalle=v_parametros.id_conf_lector_mobile_detalle;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile_detalle',v_parametros.id_conf_lector_mobile_detalle::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONFLEM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-02-2017 01:07:44
	***********************************/

	elsif(p_transaccion='PM_CONFLEM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tconf_lector_mobile_detalle
            where id_conf_lector_mobile_detalle=v_parametros.id_conf_lector_mobile_detalle;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion Lector Mobile Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_conf_lector_mobile_detalle',v_parametros.id_conf_lector_mobile_detalle::varchar);
              
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
ALTER FUNCTION "param"."ft_conf_lector_mobile_detalle_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

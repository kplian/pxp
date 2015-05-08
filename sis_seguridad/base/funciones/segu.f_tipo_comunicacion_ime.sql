CREATE OR REPLACE FUNCTION "segu"."f_tipo_comunicacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.f_tipo_comunicacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.ttipo_comunicacion'
 AUTOR: 		 (admin)
 FECHA:	        08-01-2013 18:57:15
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
	v_id_tipo_comunicacion	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.f_tipo_comunicacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_TICOM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 18:57:15
	***********************************/

	if(p_transaccion='SG_TICOM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.ttipo_comunicacion(
			estado_reg,
			nombre,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_comunicacion into v_id_tipo_comunicacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Comunicacion almacenado(a) con exito (id_tipo_comunicacion'||v_id_tipo_comunicacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comunicacion',v_id_tipo_comunicacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_TICOM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 18:57:15
	***********************************/

	elsif(p_transaccion='SG_TICOM_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.ttipo_comunicacion set
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_comunicacion=v_parametros.id_tipo_comunicacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Comunicacion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comunicacion',v_parametros.id_tipo_comunicacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_TICOM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-01-2013 18:57:15
	***********************************/

	elsif(p_transaccion='SG_TICOM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.ttipo_comunicacion
            where id_tipo_comunicacion=v_parametros.id_tipo_comunicacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Comunicacion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comunicacion',v_parametros.id_tipo_comunicacion::varchar);
              
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
ALTER FUNCTION "segu"."f_tipo_comunicacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

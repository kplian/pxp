CREATE OR REPLACE FUNCTION "param"."ft_wsmensaje_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_wsmensaje_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.twsmensaje'
 AUTOR: 		 (favio.figueroa)
 FECHA:	        16-06-2017 21:47:08
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
	v_id_wsmensaje	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_wsmensaje_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_WSM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		16-06-2017 21:47:08
	***********************************/

	if(p_transaccion='PM_WSM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.twsmensaje(
			id_usuario,
			estado_reg,
			titulo,
			tipo,
			mensaje,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_usuario,
			'activo',
			v_parametros.titulo,
			v_parametros.tipo,
			v_parametros.mensaje,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_wsmensaje into v_id_wsmensaje;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','WSMensaje almacenado(a) con exito (id_wsmensaje'||v_id_wsmensaje||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_wsmensaje',v_id_wsmensaje::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_WSM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		16-06-2017 21:47:08
	***********************************/

	elsif(p_transaccion='PM_WSM_MOD')then

		begin
			--Sentencia de la modificacion
			update param.twsmensaje set
			id_usuario = v_parametros.id_usuario,
			titulo = v_parametros.titulo,
			tipo = v_parametros.tipo,
			mensaje = v_parametros.mensaje,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_wsmensaje=v_parametros.id_wsmensaje;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','WSMensaje modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_wsmensaje',v_parametros.id_wsmensaje::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_WSM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		16-06-2017 21:47:08
	***********************************/

	elsif(p_transaccion='PM_WSM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.twsmensaje
            where id_wsmensaje=v_parametros.id_wsmensaje;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','WSMensaje eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_wsmensaje',v_parametros.id_wsmensaje::varchar);
              
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
ALTER FUNCTION "param"."ft_wsmensaje_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

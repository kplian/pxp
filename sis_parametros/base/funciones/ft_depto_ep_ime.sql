CREATE OR REPLACE FUNCTION "param"."ft_depto_ep_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_ep'
 AUTOR: 		 (admin)
 FECHA:	        29-04-2013 20:34:21
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
	v_id_depto_ep	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_depto_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEEP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-04-2013 20:34:21
	***********************************/

	if(p_transaccion='PM_DEEP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdepto_ep(
			estado_reg,
			id_ep,
			id_depto,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_ep,
			v_parametros.id_depto,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_depto_ep into v_id_depto_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Depto - EP almacenado(a) con exito (id_depto_ep'||v_id_depto_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_ep',v_id_depto_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEEP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-04-2013 20:34:21
	***********************************/

	elsif(p_transaccion='PM_DEEP_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdepto_ep set
			id_ep = v_parametros.id_ep,
			id_depto = v_parametros.id_depto,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_depto_ep=v_parametros.id_depto_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Depto - EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_ep',v_parametros.id_depto_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEEP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-04-2013 20:34:21
	***********************************/

	elsif(p_transaccion='PM_DEEP_ELI')then

		begin
			--Sentencia de la eliminacion
			update param.tdepto_ep
			set estado_reg = 'inactivo'
            where id_depto_ep=v_parametros.id_depto_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Depto - EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_ep',v_parametros.id_depto_ep::varchar);
              
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
ALTER FUNCTION "param"."ft_depto_ep_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

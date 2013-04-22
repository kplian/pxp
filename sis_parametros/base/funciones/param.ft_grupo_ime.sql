CREATE OR REPLACE FUNCTION "param"."ft_grupo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_grupo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tgrupo'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 14:20:57
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
	v_id_grupo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_grupo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GRU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:20:57
	***********************************/

	if(p_transaccion='PM_GRU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tgrupo(
			estado_reg,
			nombre,
			obs,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.obs,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_grupo into v_id_grupo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de EP almacenado(a) con exito (id_grupo'||v_id_grupo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo',v_id_grupo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_GRU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:20:57
	***********************************/

	elsif(p_transaccion='PM_GRU_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tgrupo set
			nombre = v_parametros.nombre,
			obs = v_parametros.obs,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_grupo=v_parametros.id_grupo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo',v_parametros.id_grupo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GRU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:20:57
	***********************************/

	elsif(p_transaccion='PM_GRU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tgrupo
            where id_grupo=v_parametros.id_grupo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupos de EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo',v_parametros.id_grupo::varchar);
              
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
ALTER FUNCTION "param"."ft_grupo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

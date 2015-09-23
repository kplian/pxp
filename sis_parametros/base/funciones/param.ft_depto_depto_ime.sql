--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_depto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_depto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_depto'
 AUTOR: 		 (admin)
 FECHA:	        08-09-2015 14:02:42
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
	v_id_depto_depto	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_depto_depto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEDE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-09-2015 14:02:42
	***********************************/

	if(p_transaccion='PM_DEDE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdepto_depto(
			id_depto_origen,
			estado_reg,
			obs,
			id_depto_destino,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_depto_origen,
			'activo',
			v_parametros.obs,
			v_parametros.id_depto_destino,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_depto_depto into v_id_depto_depto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEP almacenado(a) con exito (id_depto_depto'||v_id_depto_depto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_depto',v_id_depto_depto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEDE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-09-2015 14:02:42
	***********************************/

	elsif(p_transaccion='PM_DEDE_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdepto_depto set
			id_depto_origen = v_parametros.id_depto_origen,
			obs = v_parametros.obs,
			id_depto_destino = v_parametros.id_depto_destino,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_depto_depto=v_parametros.id_depto_depto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_depto',v_parametros.id_depto_depto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEDE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-09-2015 14:02:42
	***********************************/

	elsif(p_transaccion='PM_DEDE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdepto_depto
            where id_depto_depto=v_parametros.id_depto_depto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_depto',v_parametros.id_depto_depto::varchar);
              
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
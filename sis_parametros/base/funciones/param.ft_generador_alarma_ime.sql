CREATE OR REPLACE FUNCTION "param"."ft_generador_alarma_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_generador_alarma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tgenerador_alarma'
 AUTOR: 		 (admin)
 FECHA:	        26-04-2013 10:31:19
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
	v_id_generador_alarma	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_generador_alarma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GAL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2013 10:31:19
	***********************************/

	if(p_transaccion='PM_GAL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tgenerador_alarma(
			funcion,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.funcion,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_generador_alarma into v_id_generador_alarma;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Generadoor Alarma almacenado(a) con exito (id_generador_alarma'||v_id_generador_alarma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_generador_alarma',v_id_generador_alarma::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_GAL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2013 10:31:19
	***********************************/

	elsif(p_transaccion='PM_GAL_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tgenerador_alarma set
			funcion = v_parametros.funcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_generador_alarma=v_parametros.id_generador_alarma;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Generadoor Alarma modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_generador_alarma',v_parametros.id_generador_alarma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GAL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2013 10:31:19
	***********************************/

	elsif(p_transaccion='PM_GAL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tgenerador_alarma
            where id_generador_alarma=v_parametros.id_generador_alarma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Generadoor Alarma eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_generador_alarma',v_parametros.id_generador_alarma::varchar);
              
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
ALTER FUNCTION "param"."ft_generador_alarma_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

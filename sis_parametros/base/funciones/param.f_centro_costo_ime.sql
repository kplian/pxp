CREATE OR REPLACE FUNCTION "param"."f_centro_costo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_centro_costo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcentro_costo'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 22:53:59
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
	v_id_centro_costo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_centro_costo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CEC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	if(p_transaccion='PM_CEC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcentro_costo(
			estado_reg,
			id_ep,
			id_gestion,
			id_uo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_ep,
			v_parametros.id_gestion,
			v_parametros.id_uo,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_centro_costo into v_id_centro_costo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos almacenado(a) con exito (id_centro_costo'||v_id_centro_costo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_id_centro_costo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcentro_costo set
			id_ep = v_parametros.id_ep,
			id_gestion = v_parametros.id_gestion,
			id_uo = v_parametros.id_uo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_centro_costo=v_parametros.id_centro_costo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcentro_costo
            where id_centro_costo=v_parametros.id_centro_costo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
              
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
ALTER FUNCTION "param"."f_centro_costo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

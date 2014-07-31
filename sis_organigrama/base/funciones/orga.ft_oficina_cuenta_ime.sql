CREATE OR REPLACE FUNCTION "orga"."ft_oficina_cuenta_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_oficina_cuenta_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.toficina_cuenta'
 AUTOR: 		 (jrivera)
 FECHA:	        31-07-2014 22:57:29
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
	v_id_oficina_cuenta	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_oficina_cuenta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_OFCU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		31-07-2014 22:57:29
	***********************************/

	if(p_transaccion='OR_OFCU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.toficina_cuenta(
			id_oficina,
			descripcion,
			estado_reg,
			nro_medidor,
			nro_cuenta,
			tiene_medidor,
			nombre_cuenta,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_oficina,
			v_parametros.descripcion,
			'activo',
			v_parametros.nro_medidor,
			v_parametros.nro_cuenta,
			v_parametros.tiene_medidor,
			v_parametros.nombre_cuenta,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_oficina_cuenta into v_id_oficina_cuenta;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuentas por Oficina almacenado(a) con exito (id_oficina_cuenta'||v_id_oficina_cuenta||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_oficina_cuenta',v_id_oficina_cuenta::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_OFCU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		31-07-2014 22:57:29
	***********************************/

	elsif(p_transaccion='OR_OFCU_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.toficina_cuenta set
			id_oficina = v_parametros.id_oficina,
			descripcion = v_parametros.descripcion,
			nro_medidor = v_parametros.nro_medidor,
			nro_cuenta = v_parametros.nro_cuenta,
			tiene_medidor = v_parametros.tiene_medidor,
			nombre_cuenta = v_parametros.nombre_cuenta,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_oficina_cuenta=v_parametros.id_oficina_cuenta;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuentas por Oficina modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_oficina_cuenta',v_parametros.id_oficina_cuenta::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_OFCU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		31-07-2014 22:57:29
	***********************************/

	elsif(p_transaccion='OR_OFCU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.toficina_cuenta
            where id_oficina_cuenta=v_parametros.id_oficina_cuenta;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuentas por Oficina eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_oficina_cuenta',v_parametros.id_oficina_cuenta::varchar);
              
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
ALTER FUNCTION "orga"."ft_oficina_cuenta_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

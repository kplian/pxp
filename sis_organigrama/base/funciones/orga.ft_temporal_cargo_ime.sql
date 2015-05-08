CREATE OR REPLACE FUNCTION "orga"."ft_temporal_cargo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_temporal_cargo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttemporal_cargo'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 00:28:33
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
	v_id_temporal_cargo	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_temporal_cargo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_TCARGO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:33
	***********************************/

	if(p_transaccion='OR_TCARGO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.ttemporal_cargo(
			id_temporal_jerarquia_aprobacion,
			nombre,
			estado,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_temporal_jerarquia_aprobacion,
			v_parametros.nombre,
			v_parametros.estado,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_temporal_cargo into v_id_temporal_cargo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo almacenado(a) con exito (id_temporal_cargo'||v_id_temporal_cargo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_cargo',v_id_temporal_cargo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_TCARGO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:33
	***********************************/

	elsif(p_transaccion='OR_TCARGO_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.ttemporal_cargo set
			id_temporal_jerarquia_aprobacion = v_parametros.id_temporal_jerarquia_aprobacion,
			nombre = v_parametros.nombre,
			estado = v_parametros.estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_temporal_cargo=v_parametros.id_temporal_cargo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_cargo',v_parametros.id_temporal_cargo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_TCARGO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:33
	***********************************/

	elsif(p_transaccion='OR_TCARGO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.ttemporal_cargo
            where id_temporal_cargo=v_parametros.id_temporal_cargo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_cargo',v_parametros.id_temporal_cargo::varchar);
              
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
ALTER FUNCTION "orga"."ft_temporal_cargo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

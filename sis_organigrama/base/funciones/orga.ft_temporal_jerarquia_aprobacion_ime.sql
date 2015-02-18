CREATE OR REPLACE FUNCTION "orga"."ft_temporal_jerarquia_aprobacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_temporal_jerarquia_aprobacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttemporal_jerarquia_aprobacion'
 AUTOR: 		 (admin)
 FECHA:	        13-01-2014 23:54:09
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
	v_id_temporal_jerarquia_aprobacion	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_temporal_jerarquia_aprobacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_JERAPR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:09
	***********************************/

	if(p_transaccion='OR_JERAPR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.ttemporal_jerarquia_aprobacion(
			numero,
			nombre,
			estado,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.numero,
			v_parametros.nombre,
			v_parametros.estado,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_temporal_jerarquia_aprobacion into v_id_temporal_jerarquia_aprobacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Jerarquia Aprobación almacenado(a) con exito (id_temporal_jerarquia_aprobacion'||v_id_temporal_jerarquia_aprobacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_jerarquia_aprobacion',v_id_temporal_jerarquia_aprobacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_JERAPR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:09
	***********************************/

	elsif(p_transaccion='OR_JERAPR_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.ttemporal_jerarquia_aprobacion set
			numero = v_parametros.numero,
			nombre = v_parametros.nombre,
			estado = v_parametros.estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_temporal_jerarquia_aprobacion=v_parametros.id_temporal_jerarquia_aprobacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Jerarquia Aprobación modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_jerarquia_aprobacion',v_parametros.id_temporal_jerarquia_aprobacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_JERAPR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:09
	***********************************/

	elsif(p_transaccion='OR_JERAPR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.ttemporal_jerarquia_aprobacion
            where id_temporal_jerarquia_aprobacion=v_parametros.id_temporal_jerarquia_aprobacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Jerarquia Aprobación eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_temporal_jerarquia_aprobacion',v_parametros.id_temporal_jerarquia_aprobacion::varchar);
              
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
ALTER FUNCTION "orga"."ft_temporal_jerarquia_aprobacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

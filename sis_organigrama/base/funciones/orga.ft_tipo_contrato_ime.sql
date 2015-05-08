CREATE OR REPLACE FUNCTION "orga"."ft_tipo_contrato_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_tipo_contrato_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttipo_contrato'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 19:23:02
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
	v_id_tipo_contrato	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_tipo_contrato_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_TIPCON_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:23:02
	***********************************/

	if(p_transaccion='OR_TIPCON_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.ttipo_contrato(
			codigo,
			nombre,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			v_parametros.nombre,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_tipo_contrato into v_id_tipo_contrato;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Contrato almacenado(a) con exito (id_tipo_contrato'||v_id_tipo_contrato||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_contrato',v_id_tipo_contrato::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_TIPCON_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:23:02
	***********************************/

	elsif(p_transaccion='OR_TIPCON_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.ttipo_contrato set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_contrato=v_parametros.id_tipo_contrato;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Contrato modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_contrato',v_parametros.id_tipo_contrato::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_TIPCON_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:23:02
	***********************************/

	elsif(p_transaccion='OR_TIPCON_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.ttipo_contrato
            where id_tipo_contrato=v_parametros.id_tipo_contrato;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Contrato eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_contrato',v_parametros.id_tipo_contrato::varchar);
              
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
ALTER FUNCTION "orga"."ft_tipo_contrato_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

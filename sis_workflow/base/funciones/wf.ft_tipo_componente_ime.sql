CREATE OR REPLACE FUNCTION "wf"."ft_tipo_componente_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_componente_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_componente'
 AUTOR: 		 (admin)
 FECHA:	        15-05-2014 19:50:23
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
	v_id_tipo_componente	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_componente_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPCOM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 19:50:23
	***********************************/

	if(p_transaccion='WF_TIPCOM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_componente(
			estado_reg,
			nombre,
			codigo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_componente into v_id_tipo_componente;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Componente almacenado(a) con exito (id_tipo_componente'||v_id_tipo_componente||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_componente',v_id_tipo_componente::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPCOM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 19:50:23
	***********************************/

	elsif(p_transaccion='WF_TIPCOM_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_componente set
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_componente=v_parametros.id_tipo_componente;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Componente modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_componente',v_parametros.id_tipo_componente::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPCOM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 19:50:23
	***********************************/

	elsif(p_transaccion='WF_TIPCOM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_componente
            where id_tipo_componente=v_parametros.id_tipo_componente;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Componente eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_componente',v_parametros.id_tipo_componente::varchar);
              
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
ALTER FUNCTION "wf"."ft_tipo_componente_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

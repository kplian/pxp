CREATE OR REPLACE FUNCTION "wf"."ft_tipo_propiedad_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_propiedad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_propiedad'
 AUTOR: 		 (admin)
 FECHA:	        15-05-2014 20:38:59
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
	v_id_tipo_propiedad	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_propiedad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TIPPRO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:38:59
	***********************************/

	if(p_transaccion='WF_TIPPRO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_propiedad(
			estado_reg,
			nombre,
			tipo_dato,
			codigo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.tipo_dato,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_propiedad into v_id_tipo_propiedad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Propiedad almacenado(a) con exito (id_tipo_propiedad'||v_id_tipo_propiedad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_propiedad',v_id_tipo_propiedad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPPRO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:38:59
	***********************************/

	elsif(p_transaccion='WF_TIPPRO_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_propiedad set
			nombre = v_parametros.nombre,
			tipo_dato = v_parametros.tipo_dato,
			codigo = v_parametros.codigo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_propiedad=v_parametros.id_tipo_propiedad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Propiedad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_propiedad',v_parametros.id_tipo_propiedad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TIPPRO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:38:59
	***********************************/

	elsif(p_transaccion='WF_TIPPRO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_propiedad
            where id_tipo_propiedad=v_parametros.id_tipo_propiedad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Propiedad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_propiedad',v_parametros.id_tipo_propiedad::varchar);
              
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
ALTER FUNCTION "wf"."ft_tipo_propiedad_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

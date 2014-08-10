CREATE OR REPLACE FUNCTION "wf"."ft_catalogo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_catalogo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tcatalogo'
 AUTOR: 		 (admin)
 FECHA:	        16-05-2014 22:55:14
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
	v_id_catalogo	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_catalogo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_CATALO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-05-2014 22:55:14
	***********************************/

	if(p_transaccion='WF_CATALO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tcatalogo(
			estado_reg,
			codigo,
			id_proceso_macro,
			nombre,
			id_usuario_ai,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.id_proceso_macro,
			v_parametros.nombre,
			null,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_catalogo into v_id_catalogo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catálogo almacenado(a) con exito (id_catalogo'||v_id_catalogo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_id_catalogo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_CATALO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-05-2014 22:55:14
	***********************************/

	elsif(p_transaccion='WF_CATALO_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tcatalogo set
			codigo = v_parametros.codigo,
			id_proceso_macro = v_parametros.id_proceso_macro,
			nombre = v_parametros.nombre,
			--id_usuario_ai = v_parametros.id_usuario_ai,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_catalogo=v_parametros.id_catalogo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catálogo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_parametros.id_catalogo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_CATALO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-05-2014 22:55:14
	***********************************/

	elsif(p_transaccion='WF_CATALO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tcatalogo
            where id_catalogo=v_parametros.id_catalogo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catálogo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_parametros.id_catalogo::varchar);
              
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
ALTER FUNCTION "wf"."ft_catalogo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "param"."ft_extension_grupo_archivo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_extension_grupo_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.textension_grupo_archivo'
 AUTOR: 		 (admin)
 FECHA:	        23-12-2013 20:33:46
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
	v_id_extension_grupo_archivo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_extension_grupo_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_EXT_G_AR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:33:46
	***********************************/

	if(p_transaccion='PM_EXT_G_AR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.textension_grupo_archivo(
			id_extension,
			id_grupo_archivo,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_extension,
			v_parametros.id_grupo_archivo,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_extension_grupo_archivo into v_id_extension_grupo_archivo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Ext_g_ar almacenado(a) con exito (id_extension_grupo_archivo'||v_id_extension_grupo_archivo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension_grupo_archivo',v_id_extension_grupo_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_EXT_G_AR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:33:46
	***********************************/

	elsif(p_transaccion='PM_EXT_G_AR_MOD')then

		begin
			--Sentencia de la modificacion
			update param.textension_grupo_archivo set
			id_extension = v_parametros.id_extension,
			id_grupo_archivo = v_parametros.id_grupo_archivo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_extension_grupo_archivo=v_parametros.id_extension_grupo_archivo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Ext_g_ar modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension_grupo_archivo',v_parametros.id_extension_grupo_archivo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_EXT_G_AR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-12-2013 20:33:46
	***********************************/

	elsif(p_transaccion='PM_EXT_G_AR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.textension_grupo_archivo
            where id_extension_grupo_archivo=v_parametros.id_extension_grupo_archivo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Ext_g_ar eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_extension_grupo_archivo',v_parametros.id_extension_grupo_archivo::varchar);
              
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
ALTER FUNCTION "param"."ft_extension_grupo_archivo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

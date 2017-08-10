CREATE OR REPLACE FUNCTION "param"."ft_tipo_archivo_campo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_archivo_campo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_archivo_campo'
 AUTOR: 		 (favio.figueroa)
 FECHA:	        09-08-2017 19:39:47
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
	v_id_tipo_archivo_campo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_tipo_archivo_campo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TIPCAM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 19:39:47
	***********************************/

	if(p_transaccion='PM_TIPCAM_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.ttipo_archivo_campo(
			nombre,
			alias,
			tipo_dato,
			renombrar,
			estado_reg,
			id_tipo_archivo,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre,
			v_parametros.alias,
			v_parametros.tipo_dato,
			v_parametros.renombrar,
			'activo',
			v_parametros.id_tipo_archivo,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_tipo_archivo_campo into v_id_tipo_archivo_campo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campos almacenado(a) con exito (id_tipo_archivo_campo'||v_id_tipo_archivo_campo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_campo',v_id_tipo_archivo_campo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TIPCAM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 19:39:47
	***********************************/

	elsif(p_transaccion='PM_TIPCAM_MOD')then

		begin
			--Sentencia de la modificacion
			update param.ttipo_archivo_campo set
			nombre = v_parametros.nombre,
			alias = v_parametros.alias,
			tipo_dato = v_parametros.tipo_dato,
			renombrar = v_parametros.renombrar,
			id_tipo_archivo = v_parametros.id_tipo_archivo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_archivo_campo=v_parametros.id_tipo_archivo_campo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_campo',v_parametros.id_tipo_archivo_campo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TIPCAM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		favio.figueroa	
 	#FECHA:		09-08-2017 19:39:47
	***********************************/

	elsif(p_transaccion='PM_TIPCAM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.ttipo_archivo_campo
            where id_tipo_archivo_campo=v_parametros.id_tipo_archivo_campo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Campos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo_campo',v_parametros.id_tipo_archivo_campo::varchar);
              
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
ALTER FUNCTION "param"."ft_tipo_archivo_campo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

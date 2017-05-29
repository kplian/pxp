CREATE OR REPLACE FUNCTION "param"."ft_tipo_archivo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_archivo'
 AUTOR: 		 (admin)
 FECHA:	        05-12-2016 15:03:38
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
	v_id_tipo_archivo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_tipo_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TIPAR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:03:38
	***********************************/

	if(p_transaccion='PM_TIPAR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.ttipo_archivo(
			nombre_id,
			multiple,
			codigo,
			tipo_archivo,
			tabla,
			nombre,
			estado_reg,
			id_usuario_ai,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
			extensiones_permitidas,
			ruta_guardar,
			tamano
          	) values(
			v_parametros.nombre_id,
			v_parametros.multiple,
			v_parametros.codigo,
			v_parametros.tipo_archivo,
			v_parametros.tabla,
			v_parametros.nombre,
			'activo',
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			null,
			null,
			v_parametros.extensiones_permitidas,
			v_parametros.ruta_guardar,
			v_parametros.tamano

							
			
			
			)RETURNING id_tipo_archivo into v_id_tipo_archivo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Archivo almacenado(a) con exito (id_tipo_archivo'||v_id_tipo_archivo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo',v_id_tipo_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TIPAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:03:38
	***********************************/

	elsif(p_transaccion='PM_TIPAR_MOD')then

		begin
			--Sentencia de la modificacion
			update param.ttipo_archivo set
			nombre_id = v_parametros.nombre_id,
			multiple = v_parametros.multiple,
			codigo = v_parametros.codigo,
			tipo_archivo = v_parametros.tipo_archivo,
			tabla = v_parametros.tabla,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
				extensiones_permitidas = v_parametros.extensiones_permitidas,
				ruta_guardar = v_parametros.ruta_guardar,
				tamano = v_parametros.tamano
			where id_tipo_archivo=v_parametros.id_tipo_archivo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Archivo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo',v_parametros.id_tipo_archivo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TIPAR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:03:38
	***********************************/

	elsif(p_transaccion='PM_TIPAR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.ttipo_archivo
            where id_tipo_archivo=v_parametros.id_tipo_archivo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Archivo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_archivo',v_parametros.id_tipo_archivo::varchar);
              
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
ALTER FUNCTION "param"."ft_tipo_archivo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

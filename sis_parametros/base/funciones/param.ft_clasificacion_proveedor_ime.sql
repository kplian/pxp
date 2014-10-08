CREATE OR REPLACE FUNCTION "param"."ft_clasificacion_proveedor_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_clasificacion_proveedor_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tclasificacion_proveedor'
 AUTOR: 		 (gsarmiento)
 FECHA:	        06-10-2014 13:31:43
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
	v_id_clasificacion_proveedor	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_clasificacion_proveedor_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_clapro_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 13:31:43
	***********************************/

	if(p_transaccion='PM_clapro_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tclasificacion_proveedor(
			nombre_clasificacion,
			estado_reg,
			descripcion,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre_clasificacion,
			'activo',
			v_parametros.descripcion,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_clasificacion_proveedor into v_id_clasificacion_proveedor;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificacion Proveedor almacenado(a) con exito (id_clasificacion_proveedor'||v_id_clasificacion_proveedor||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_clasificacion_proveedor',v_id_clasificacion_proveedor::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_clapro_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 13:31:43
	***********************************/

	elsif(p_transaccion='PM_clapro_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tclasificacion_proveedor set
			nombre_clasificacion = v_parametros.nombre_clasificacion,
			descripcion = v_parametros.descripcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_clasificacion_proveedor=v_parametros.id_clasificacion_proveedor;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificacion Proveedor modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_clasificacion_proveedor',v_parametros.id_clasificacion_proveedor::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_clapro_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 13:31:43
	***********************************/

	elsif(p_transaccion='PM_clapro_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tclasificacion_proveedor
            where id_clasificacion_proveedor=v_parametros.id_clasificacion_proveedor;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificacion Proveedor eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_clasificacion_proveedor',v_parametros.id_clasificacion_proveedor::varchar);
              
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
ALTER FUNCTION "param"."ft_clasificacion_proveedor_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

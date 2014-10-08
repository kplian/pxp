CREATE OR REPLACE FUNCTION "param"."ft_categoria_proveedor_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_categoria_proveedor_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcategoria_proveedor'
 AUTOR: 		 (gsarmiento)
 FECHA:	        06-10-2014 14:06:09
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
	v_id_categoria_proveedor	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_categoria_proveedor_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CATPRO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 14:06:09
	***********************************/

	if(p_transaccion='PM_CATPRO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcategoria_proveedor(
			estado_reg,
			nombre_categoria,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre_categoria,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_categoria_proveedor into v_id_categoria_proveedor;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Proveedor almacenado(a) con exito (id_categoria_proveedor'||v_id_categoria_proveedor||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_proveedor',v_id_categoria_proveedor::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CATPRO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 14:06:09
	***********************************/

	elsif(p_transaccion='PM_CATPRO_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcategoria_proveedor set
			nombre_categoria = v_parametros.nombre_categoria,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_categoria_proveedor=v_parametros.id_categoria_proveedor;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Proveedor modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_proveedor',v_parametros.id_categoria_proveedor::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CATPRO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		06-10-2014 14:06:09
	***********************************/

	elsif(p_transaccion='PM_CATPRO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcategoria_proveedor
            where id_categoria_proveedor=v_parametros.id_categoria_proveedor;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Proveedor eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_proveedor',v_parametros.id_categoria_proveedor::varchar);
              
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
ALTER FUNCTION "param"."ft_categoria_proveedor_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

-- Function: param.f_proveedor_item_servicio_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION param.f_proveedor_item_servicio_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION param.f_proveedor_item_servicio_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_proveedor_item_servicio_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tproveedor_item_servicio'
 AUTOR: 		 (admin)
 FECHA:	        15-08-2012 18:56:19
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
	v_id_proveedor_item	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_proveedor_item_servicio_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PRITSE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-08-2012 18:56:19
	***********************************/

	if(p_transaccion='PM_PRITSE_INS')then
					
        begin

		--Verify the flag of item_servicio to set only one of those variables
		if v_parametros.item_servicio = 'item' then
			v_parametros.id_servicio = null;
		else 
			v_parametros.id_item = null;
		end if;
		
        	--Sentencia de la insercion
        	insert into param.tproveedor_item_servicio(
			estado_reg,
			id_servicio,
			id_proveedor,
			id_item,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_servicio,
			v_parametros.id_proveedor,
			v_parametros.id_item,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_proveedor_item into v_id_proveedor_item;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedor Item/Servicio almacenado(a) con exito (id_proveedor_item'||v_id_proveedor_item||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor_item',v_id_proveedor_item::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRITSE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-08-2012 18:56:19
	***********************************/

	elsif(p_transaccion='PM_PRITSE_MOD')then

		begin
			--Verify the flag of item_servicio to set only one of those variables
			if v_parametros.item_servicio = 'item' then
				v_parametros.id_servicio = null;
			else 
				v_parametros.id_item = null;
			end if;
			
			--Sentencia de la modificacion
			update param.tproveedor_item_servicio set
			id_servicio = v_parametros.id_servicio,
			id_proveedor = v_parametros.id_proveedor,
			id_item = v_parametros.id_item,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_proveedor_item=v_parametros.id_proveedor_item;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedor Item/Servicio modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor_item',v_parametros.id_proveedor_item::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRITSE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-08-2012 18:56:19
	***********************************/

	elsif(p_transaccion='PM_PRITSE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tproveedor_item_servicio
            where id_proveedor_item=v_parametros.id_proveedor_item;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedor Item/Servicio eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor_item',v_parametros.id_proveedor_item::varchar);
              
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
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION param.f_proveedor_item_servicio_ime(integer, integer, character varying, character varying) OWNER TO postgres;

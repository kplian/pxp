CREATE OR REPLACE FUNCTION "param"."ft_catalogo_tipo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_catalogo_tipo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcatalogo_tipo'
 AUTOR: 		 (admin)
 FECHA:	        27-11-2012 23:32:44
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
	v_id_catalogo_tipo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_catalogo_tipo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PACATI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-11-2012 23:32:44
	***********************************/

	if(p_transaccion='PM_PACATI_INS')then
					
        begin

			--Verifica que el nombre no se esté repitiendo
			if v_parametros.nombre in (select nombre 
									   from param.tcatalogo_tipo
									   where id_subsistema = v_parametros.id_subsistema) then
				raise exception 'Registro no almacenado: nombre duplicado.   Hint: cambie el nombre o aumente algún sufijo al nombre actual';
			end if;
		
        	--Sentencia de la insercion
        	insert into param.tcatalogo_tipo(
			nombre,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
			id_subsistema,
			tabla
          	) values(
			v_parametros.nombre,
			'activo',
			now(),
			p_id_usuario,
			null,
			null,
			v_parametros.id_subsistema,
			v_parametros.tabla
			)RETURNING id_catalogo_tipo into v_id_catalogo_tipo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Catálogo almacenado(a) con exito (id_catalogo_tipo'||v_id_catalogo_tipo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo_tipo',v_id_catalogo_tipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PACATI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-11-2012 23:32:44
	***********************************/

	elsif(p_transaccion='PM_PACATI_MOD')then

		begin
		
			--Verifica que el nombre no se esté repitiendo
			if v_parametros.nombre in (select nombre from param.tcatalogo_tipo
										where id_catalogo_tipo <> v_parametros.id_catalogo_tipo
										and id_subsistema = v_parametros.id_subsistema) then
				raise exception 'Registro no modificado: nombre duplicado.   Hint: cambie el nombre o aumente algún sufijo al nombre actual';
			end if;
			
			--Sentencia de la modificacion
			update param.tcatalogo_tipo set
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_subsistema = v_parametros.id_subsistema,
			tabla = v_parametros.tabla
			where id_catalogo_tipo=v_parametros.id_catalogo_tipo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Catálogo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo_tipo',v_parametros.id_catalogo_tipo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PACATI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-11-2012 23:32:44
	***********************************/

	elsif(p_transaccion='PM_PACATI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcatalogo_tipo
            where id_catalogo_tipo=v_parametros.id_catalogo_tipo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Catálogo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo_tipo',v_parametros.id_catalogo_tipo::varchar);
              
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
ALTER FUNCTION "param"."ft_catalogo_tipo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

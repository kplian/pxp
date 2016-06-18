-- Function: param.f_servicio_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION param.f_servicio_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION param.f_servicio_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_servicio_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tservicio'
 AUTOR: 		 (admin)
 FECHA:	        16-08-2012 23:48:42
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
	v_id_servicio	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_servicio_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_SERVIC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	if(p_transaccion='PM_SERVIC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tservicio(
			estado_reg,
			codigo,
			nombre,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.descripcion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_servicio into v_id_servicio;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Servicio almacenado(a) con exito (id_servicio'||v_id_servicio||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_servicio',v_id_servicio::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_SERVIC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	elsif(p_transaccion='PM_SERVIC_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tservicio set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_servicio=v_parametros.id_servicio;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Servicio modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_servicio',v_parametros.id_servicio::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_SERVIC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	elsif(p_transaccion='PM_SERVIC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tservicio
            where id_servicio=v_parametros.id_servicio;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Servicio eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_servicio',v_parametros.id_servicio::varchar);
              
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
ALTER FUNCTION param.f_servicio_ime(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "segu"."ft_tabla_migrar_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_tabla_migrar_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.ttabla_migrar'
 AUTOR: 		 (admin)
 FECHA:	        16-01-2014 18:06:08
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
	v_id_tabla_migrar	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_tabla_migrar_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_TBLMIG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-01-2014 18:06:08
	***********************************/

	if(p_transaccion='SG_TBLMIG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.ttabla_migrar(
			nombre_tabla,
			nombre_funcion,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre_tabla,
			v_parametros.nombre_funcion,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_tabla_migrar into v_id_tabla_migrar;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tablas Migradas desde ENDESIS almacenado(a) con exito (id_tabla_migrar'||v_id_tabla_migrar||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla_migrar',v_id_tabla_migrar::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_TBLMIG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-01-2014 18:06:08
	***********************************/

	elsif(p_transaccion='SG_TBLMIG_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.ttabla_migrar set
			nombre_tabla = v_parametros.nombre_tabla,
			nombre_funcion = v_parametros.nombre_funcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tabla_migrar=v_parametros.id_tabla_migrar;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tablas Migradas desde ENDESIS modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla_migrar',v_parametros.id_tabla_migrar::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_TBLMIG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-01-2014 18:06:08
	***********************************/

	elsif(p_transaccion='SG_TBLMIG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.ttabla_migrar
            where id_tabla_migrar=v_parametros.id_tabla_migrar;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tablas Migradas desde ENDESIS eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tabla_migrar',v_parametros.id_tabla_migrar::varchar);
              
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
ALTER FUNCTION "segu"."ft_tabla_migrar_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "gem"."f_tipo_variable_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_tipo_variable_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttipo_variable'
 AUTOR: 		 (rac)
 FECHA:	        15-08-2012 15:28:09
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
	v_id_tipo_variable	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_tipo_variable_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TVA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 15:28:09
	***********************************/

	if(p_transaccion='GEM_TVA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttipo_variable(
			estado_reg,
			nombre,
			id_tipo_equipo,
			id_unidad_medida,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.id_tipo_equipo,
			v_parametros.id_unidad_medida,
			v_parametros.descripcion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_tipo_variable into v_id_tipo_variable;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Variables Tipo almacenado(a) con exito (id_tipo_variable'||v_id_tipo_variable||')'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_variable',v_id_tipo_variable::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TVA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 15:28:09
	***********************************/

	elsif(p_transaccion='GEM_TVA_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttipo_variable set
			nombre = v_parametros.nombre,
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			id_unidad_medida = v_parametros.id_unidad_medida,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_tipo_variable=v_parametros.id_tipo_variable;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Variables Tipo modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_variable',v_parametros.id_tipo_variable::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TVA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		15-08-2012 15:28:09
	***********************************/

	elsif(p_transaccion='GEM_TVA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttipo_variable
            where id_tipo_variable=v_parametros.id_tipo_variable;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Variables Tipo eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_variable',v_parametros.id_tipo_variable::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "gem"."f_tipo_variable_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

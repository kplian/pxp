CREATE OR REPLACE FUNCTION "gem"."f_tipo_equipo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_tipo_equipo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.ttipo_equipo'
 AUTOR: 		 (rac)
 FECHA:	        08-08-2012 23:50:13
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
	v_id_tipo_equipo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_tipo_equipo_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TEQ_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		08-08-2012 23:50:13
	***********************************/

	if(p_transaccion='GEM_TEQ_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.ttipo_equipo(
			estado_reg,
			nombre,
			descripcion,
			codigo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.descripcion,
			v_parametros.codigo,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_tipo_equipo into v_id_tipo_equipo;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Definir Tipo de Equipos almacenado(a) con exito (id_tipo_equipo'||v_id_tipo_equipo||')'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_equipo',v_id_tipo_equipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TEQ_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		08-08-2012 23:50:13
	***********************************/

	elsif(p_transaccion='GEM_TEQ_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.ttipo_equipo set
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_tipo_equipo=v_parametros.id_tipo_equipo;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Definir Tipo de Equipos modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_equipo',v_parametros.id_tipo_equipo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TEQ_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		08-08-2012 23:50:13
	***********************************/

	elsif(p_transaccion='GEM_TEQ_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.ttipo_equipo
            where id_tipo_equipo=v_parametros.id_tipo_equipo;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Definir Tipo de Equipos eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_tipo_equipo',v_parametros.id_tipo_equipo::varchar);
              
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
ALTER FUNCTION "gem"."f_tipo_equipo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

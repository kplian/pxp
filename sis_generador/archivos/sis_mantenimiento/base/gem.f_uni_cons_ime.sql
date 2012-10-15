CREATE OR REPLACE FUNCTION "gem"."f_uni_cons_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_uni_cons_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons'
 AUTOR: 		 (rac)
 FECHA:	        09-08-2012 00:42:57
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
	v_id_uni_cons	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_uni_cons_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	if(p_transaccion='GEM_TUC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons(
			estado_reg,
			estado,
			nombre,
			tipo,
			codigo,
			id_tipo_equipo,
			id_localizacion,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.estado,
			v_parametros.nombre,
			v_parametros.tipo,
			v_parametros.codigo,
			v_parametros.id_tipo_equipo,
			v_parametros.id_localizacion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_uni_cons into v_id_uni_cons;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Equipos almacenado(a) con exito (id_uni_cons'||v_id_uni_cons||')'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons',v_id_uni_cons::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUC_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons set
			estado = v_parametros.estado,
			nombre = v_parametros.nombre,
			tipo = v_parametros.tipo,
			codigo = v_parametros.codigo,
			id_tipo_equipo = v_parametros.id_tipo_equipo,
			id_localizacion = v_parametros.id_localizacion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_uni_cons=v_parametros.id_uni_cons;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Equipos modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons',v_parametros.id_uni_cons::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_TUC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 00:42:57
	***********************************/

	elsif(p_transaccion='GEM_TUC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons
            where id_uni_cons=v_parametros.id_uni_cons;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Equipos eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons',v_parametros.id_uni_cons::varchar);
              
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
ALTER FUNCTION "gem"."f_uni_cons_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "gem"."f_uni_cons_comp_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_uni_cons_comp_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_comp'
 AUTOR: 		 (rac)
 FECHA:	        09-08-2012 01:38:28
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
	v_id_comp_equipo	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_uni_cons_comp_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_UCC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 01:38:28
	***********************************/

	if(p_transaccion='GEM_UCC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_comp(
			estado_reg,
			opcional,
			id_uni_cons_padre,
			cantidad,
			id_uni_const_hijo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.opcional,
			v_parametros.id_uni_cons_padre,
			v_parametros.cantidad,
			v_parametros.id_uni_const_hijo,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_comp_equipo into v_id_comp_equipo;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','composicion almacenado(a) con exito (id_comp_equipo'||v_id_comp_equipo||')'); 
            v_resp = f_agrega_clave(v_resp,'id_comp_equipo',v_id_comp_equipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UCC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 01:38:28
	***********************************/

	elsif(p_transaccion='GEM_UCC_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_comp set
			opcional = v_parametros.opcional,
			id_uni_cons_padre = v_parametros.id_uni_cons_padre,
			cantidad = v_parametros.cantidad,
			id_uni_const_hijo = v_parametros.id_uni_const_hijo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_comp_equipo=v_parametros.id_comp_equipo;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','composicion modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_comp_equipo',v_parametros.id_comp_equipo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_UCC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		09-08-2012 01:38:28
	***********************************/

	elsif(p_transaccion='GEM_UCC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_comp
            where id_comp_equipo=v_parametros.id_comp_equipo;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','composicion eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_comp_equipo',v_parametros.id_comp_equipo::varchar);
              
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
ALTER FUNCTION "gem"."f_uni_cons_comp_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

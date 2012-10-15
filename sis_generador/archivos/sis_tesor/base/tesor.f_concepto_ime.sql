CREATE OR REPLACE FUNCTION "tesor"."f_concepto_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Tesoreria
 FUNCION: 		tesor.f_concepto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tesor.tconcepto'
 AUTOR: 		 (rac)
 FECHA:	        16-08-2012 01:18:04
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
	v_id_concepto	integer;
			    
BEGIN

    v_nombre_funcion = 'tesor.f_concepto_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TSR_CON_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 01:18:04
	***********************************/

	if(p_transaccion='TSR_CON_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tesor.tconcepto(
			estado_reg,
			nombre,
			descripcion,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.descripcion,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_concepto into v_id_concepto;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Concepto almacenado(a) con exito (id_concepto'||v_id_concepto||')'); 
            v_resp = f_agrega_clave(v_resp,'id_concepto',v_id_concepto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TSR_CON_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 01:18:04
	***********************************/

	elsif(p_transaccion='TSR_CON_MOD')then

		begin
			--Sentencia de la modificacion
			update tesor.tconcepto set
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_concepto=v_parametros.id_concepto;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Concepto modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_concepto',v_parametros.id_concepto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TSR_CON_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 01:18:04
	***********************************/

	elsif(p_transaccion='TSR_CON_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from tesor.tconcepto
            where id_concepto=v_parametros.id_concepto;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Concepto eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_concepto',v_parametros.id_concepto::varchar);
              
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
ALTER FUNCTION "tesor"."f_concepto_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

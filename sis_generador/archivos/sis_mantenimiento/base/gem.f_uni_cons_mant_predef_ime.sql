CREATE OR REPLACE FUNCTION "gem"."f_uni_cons_mant_predef_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		SISTEMA DE GESTION DE MANTENIMIENTO
 FUNCION: 		gem.f_uni_cons_mant_predef_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_mant_predef'
 AUTOR: 		 (admin)
 FECHA:	        02-11-2012 15:07:12
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
	v_id_uni_cons_mant_predef	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_uni_cons_mant_predef_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GEM_MAPR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-11-2012 15:07:12
	***********************************/

	if(p_transaccion='GEM_MAPR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_mant_predef(
			estado_reg,
			ult_fecha_mant,
			id_unidad_medida,
			id_uni_cons,
			fecha_ini,
			id_mant_predef,
			frecuencia,
			horas_dia,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.ult_fecha_mant,
			v_parametros.id_unidad_medida,
			v_parametros.id_uni_cons,
			v_parametros.fecha_ini,
			v_parametros.id_mant_predef,
			v_parametros.frecuencia,
			v_parametros.horas_dia,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_uni_cons_mant_predef into v_id_uni_cons_mant_predef;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','mantenimientos almacenado(a) con exito (id_uni_cons_mant_predef'||v_id_uni_cons_mant_predef||')'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_id_uni_cons_mant_predef::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MAPR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-11-2012 15:07:12
	***********************************/

	elsif(p_transaccion='GEM_MAPR_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_mant_predef set
			ult_fecha_mant = v_parametros.ult_fecha_mant,
			id_unidad_medida = v_parametros.id_unidad_medida,
			id_uni_cons = v_parametros.id_uni_cons,
			fecha_ini = v_parametros.fecha_ini,
			id_mant_predef = v_parametros.id_mant_predef,
			frecuencia = v_parametros.frecuencia,
			horas_dia = v_parametros.horas_dia,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_uni_cons_mant_predef=v_parametros.id_uni_cons_mant_predef;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','mantenimientos modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_parametros.id_uni_cons_mant_predef::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GEM_MAPR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		02-11-2012 15:07:12
	***********************************/

	elsif(p_transaccion='GEM_MAPR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_mant_predef
            where id_uni_cons_mant_predef=v_parametros.id_uni_cons_mant_predef;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','mantenimientos eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_uni_cons_mant_predef',v_parametros.id_uni_cons_mant_predef::varchar);
              
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
ALTER FUNCTION "gem"."f_uni_cons_mant_predef_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

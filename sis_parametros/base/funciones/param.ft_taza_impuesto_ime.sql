CREATE OR REPLACE FUNCTION "param"."ft_taza_impuesto_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_taza_impuesto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttaza_impuesto'
 AUTOR: 		 (mguerra)
 FECHA:	        25-07-2019 19:23:20
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				25-07-2019 19:23:20								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttaza_impuesto'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_taza_impuesto	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_taza_impuesto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TAZIMP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		mguerra	
 	#FECHA:		25-07-2019 19:23:20
	***********************************/

	if(p_transaccion='PM_TAZIMP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.ttaza_impuesto(
			tipo,
			descripcion,
			factor_impuesto_pre,
			factor_impuesto,
			estado_reg,
			observacion,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.tipo,
			v_parametros.descripcion,
			v_parametros.factor_impuesto_pre,
			v_parametros.factor_impuesto,
			'activo',
			v_parametros.observacion,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_taza_impuesto into v_id_taza_impuesto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Taza impuesto almacenado(a) con exito (id_taza_impuesto'||v_id_taza_impuesto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_taza_impuesto',v_id_taza_impuesto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TAZIMP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		mguerra	
 	#FECHA:		25-07-2019 19:23:20
	***********************************/

	elsif(p_transaccion='PM_TAZIMP_MOD')then

		begin
			--Sentencia de la modificacion
			update param.ttaza_impuesto set
			tipo = v_parametros.tipo,
			descripcion = v_parametros.descripcion,
			factor_impuesto_pre = v_parametros.factor_impuesto_pre,
			factor_impuesto = v_parametros.factor_impuesto,
			observacion = v_parametros.observacion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_taza_impuesto=v_parametros.id_taza_impuesto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Taza impuesto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_taza_impuesto',v_parametros.id_taza_impuesto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TAZIMP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		mguerra	
 	#FECHA:		25-07-2019 19:23:20
	***********************************/

	elsif(p_transaccion='PM_TAZIMP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.ttaza_impuesto
            where id_taza_impuesto=v_parametros.id_taza_impuesto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Taza impuesto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_taza_impuesto',v_parametros.id_taza_impuesto::varchar);
              
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
ALTER FUNCTION "param"."ft_taza_impuesto_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

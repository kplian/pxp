CREATE OR REPLACE FUNCTION "param"."ft_cat_concepto_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_cat_concepto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcat_concepto'
 AUTOR: 		 (admin)
 FECHA:	        27-10-2016 06:32:37
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
	v_id_cat_concepto	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_cat_concepto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CACO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2016 06:32:37
	***********************************/

	if(p_transaccion='PM_CACO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcat_concepto(
			habilitado,
			nombre,
			estado_reg,
			codigo,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.habilitado,
			v_parametros.nombre,
			'activo',
			v_parametros.codigo,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_cat_concepto into v_id_cat_concepto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Concepto almacenado(a) con exito (id_cat_concepto'||v_id_cat_concepto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cat_concepto',v_id_cat_concepto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CACO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2016 06:32:37
	***********************************/

	elsif(p_transaccion='PM_CACO_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcat_concepto set
			habilitado = v_parametros.habilitado,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_cat_concepto=v_parametros.id_cat_concepto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Concepto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cat_concepto',v_parametros.id_cat_concepto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CACO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2016 06:32:37
	***********************************/

	elsif(p_transaccion='PM_CACO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcat_concepto
            where id_cat_concepto=v_parametros.id_cat_concepto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Concepto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cat_concepto',v_parametros.id_cat_concepto::varchar);
              
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
ALTER FUNCTION "param"."ft_cat_concepto_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

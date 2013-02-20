CREATE OR REPLACE FUNCTION "param"."f_centro_costo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_centro_costo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcentro_costo'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        18-02-2013 14:08:14
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
	v_id_centro_costo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_centro_costo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CCOST_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		18-02-2013 14:08:14
	***********************************/

	if(p_transaccion='PM_CCOST_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcentro_costo(
			estado_reg,
			tipo_pres,
			id_fuente_financiammiento,
			id_parametro,
			id_uo,
			estado,
			cod_prg,
			descripcion,
			id_concepto_colectivo,
			cod_fin,
			codigo,
			id_ep,
			id_categoria_prog,
			nombre_agrupador,
			cod_pry,
			cod_act,
			id_gestion,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.tipo_pres,
			v_parametros.id_fuente_financiammiento,
			v_parametros.id_parametro,
			v_parametros.id_uo,
			v_parametros.estado,
			v_parametros.cod_prg,
			v_parametros.descripcion,
			v_parametros.id_concepto_colectivo,
			v_parametros.cod_fin,
			v_parametros.codigo,
			v_parametros.id_ep,
			v_parametros.id_categoria_prog,
			v_parametros.nombre_agrupador,
			v_parametros.cod_pry,
			v_parametros.cod_act,
			v_parametros.id_gestion,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_centro_costo into v_id_centro_costo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo almacenado(a) con exito (id_centro_costo'||v_id_centro_costo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_id_centro_costo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CCOST_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		18-02-2013 14:08:14
	***********************************/

	elsif(p_transaccion='PM_CCOST_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcentro_costo set
			tipo_pres = v_parametros.tipo_pres,
			id_fuente_financiammiento = v_parametros.id_fuente_financiammiento,
			id_parametro = v_parametros.id_parametro,
			id_uo = v_parametros.id_uo,
			estado = v_parametros.estado,
			cod_prg = v_parametros.cod_prg,
			descripcion = v_parametros.descripcion,
			id_concepto_colectivo = v_parametros.id_concepto_colectivo,
			cod_fin = v_parametros.cod_fin,
			codigo = v_parametros.codigo,
			id_ep = v_parametros.id_ep,
			id_categoria_prog = v_parametros.id_categoria_prog,
			nombre_agrupador = v_parametros.nombre_agrupador,
			cod_pry = v_parametros.cod_pry,
			cod_act = v_parametros.cod_act,
			id_gestion = v_parametros.id_gestion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_centro_costo=v_parametros.id_centro_costo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CCOST_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		18-02-2013 14:08:14
	***********************************/

	elsif(p_transaccion='PM_CCOST_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcentro_costo
            where id_centro_costo=v_parametros.id_centro_costo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
              
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
ALTER FUNCTION "param"."f_centro_costo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

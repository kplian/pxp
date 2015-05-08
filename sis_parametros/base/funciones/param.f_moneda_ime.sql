CREATE OR REPLACE FUNCTION "param"."f_moneda_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_moneda_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tmoneda'
 AUTOR: 		 (admin)
 FECHA:	        05-02-2013 18:17:03
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
	v_id_moneda	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_moneda_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	if(p_transaccion='PM_MONEDA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tmoneda(
			prioridad,
			origen,
			tipo_actualizacion,
			estado_reg,
			codigo,
			moneda,
			tipo_moneda,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.prioridad,
			v_parametros.origen,
			v_parametros.tipo_actualizacion,
			'activo',
			v_parametros.codigo,
			v_parametros.moneda,
			v_parametros.tipo_moneda,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_moneda into v_id_moneda;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda almacenado(a) con exito (id_moneda'||v_id_moneda||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_id_moneda::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	elsif(p_transaccion='PM_MONEDA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tmoneda set
			prioridad = v_parametros.prioridad,
			origen = v_parametros.origen,
			tipo_actualizacion = v_parametros.tipo_actualizacion,
			codigo = v_parametros.codigo,
			moneda = v_parametros.moneda,
			tipo_moneda = v_parametros.tipo_moneda,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_moneda=v_parametros.id_moneda;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_parametros.id_moneda::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	elsif(p_transaccion='PM_MONEDA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tmoneda
            where id_moneda=v_parametros.id_moneda;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_parametros.id_moneda::varchar);
              
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
ALTER FUNCTION "param"."f_moneda_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

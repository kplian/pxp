CREATE OR REPLACE FUNCTION "param"."ft_firma_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_firma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfirma'
 AUTOR: 		 (admin)
 FECHA:	        11-07-2013 15:32:07
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
	v_id_firma	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_firma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FIR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-07-2013 15:32:07
	***********************************/

	if(p_transaccion='PM_FIR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tfirma(
			estado_reg,
			desc_firma,
			monto_min,
			prioridad,
			monto_max,
			id_documento,
			id_funcionario,
			id_depto,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.desc_firma,
			v_parametros.monto_min,
			v_parametros.prioridad,
			v_parametros.monto_max,
			v_parametros.id_documento,
			v_parametros.id_funcionario,
			v_parametros.id_depto,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_firma into v_id_firma;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Firma almacenado(a) con exito (id_firma'||v_id_firma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_firma',v_id_firma::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_FIR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-07-2013 15:32:07
	***********************************/

	elsif(p_transaccion='PM_FIR_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tfirma set
			desc_firma = v_parametros.desc_firma,
			monto_min = v_parametros.monto_min,
			prioridad = v_parametros.prioridad,
			monto_max = v_parametros.monto_max,
			id_documento = v_parametros.id_documento,
			id_funcionario = v_parametros.id_funcionario,
			id_depto = v_parametros.id_depto,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_firma=v_parametros.id_firma;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Firma modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_firma',v_parametros.id_firma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FIR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		11-07-2013 15:32:07
	***********************************/

	elsif(p_transaccion='PM_FIR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tfirma
            where id_firma=v_parametros.id_firma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Firma eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_firma',v_parametros.id_firma::varchar);
              
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
ALTER FUNCTION "param"."ft_firma_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

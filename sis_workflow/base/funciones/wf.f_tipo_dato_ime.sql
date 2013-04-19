CREATE OR REPLACE FUNCTION "wf"."f_tipo_dato_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_tipo_dato_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_dato'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 23:08:25
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
	v_id_tipo_dato	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.f_tipo_dato_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TDT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 23:08:25
	***********************************/

	if(p_transaccion='WF_TDT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_dato(
			estado_reg,
			presicion,
			descripcion,
			tipo,
			tamano,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.presicion,
			v_parametros.descripcion,
			v_parametros.tipo,
			v_parametros.tamano,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_dato into v_id_tipo_dato;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TIPO DATO almacenado(a) con exito (id_tipo_dato'||v_id_tipo_dato||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_dato',v_id_tipo_dato::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TDT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 23:08:25
	***********************************/

	elsif(p_transaccion='WF_TDT_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_dato set
			presicion = v_parametros.presicion,
			descripcion = v_parametros.descripcion,
			tipo = v_parametros.tipo,
			tamano = v_parametros.tamano,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_dato=v_parametros.id_tipo_dato;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TIPO DATO modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_dato',v_parametros.id_tipo_dato::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TDT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 23:08:25
	***********************************/

	elsif(p_transaccion='WF_TDT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_dato
            where id_tipo_dato=v_parametros.id_tipo_dato;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TIPO DATO eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_dato',v_parametros.id_tipo_dato::varchar);
              
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
ALTER FUNCTION "wf"."f_tipo_dato_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

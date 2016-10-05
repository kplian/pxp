CREATE OR REPLACE FUNCTION "param"."ft_dashdet_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_dashdet_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdashdet'
 AUTOR: 		 (admin)
 FECHA:	        10-09-2016 11:31:12
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
	v_id_dashdet	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_dashdet_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DAD_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	if(p_transaccion='PM_DAD_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdashdet(
			estado_reg,
			columna,
			id_widget,
			fila,
			id_dashboard,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.columna,
			v_parametros.id_widget,
			v_parametros.fila,
			v_parametros.id_dashboard,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_dashdet into v_id_dashdet;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dashdet almacenado(a) con exito (id_dashdet'||v_id_dashdet||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashdet',v_id_dashdet::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DAD_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	elsif(p_transaccion='PM_DAD_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdashdet set
			columna = v_parametros.columna,
			id_widget = v_parametros.id_widget,
			fila = v_parametros.fila,
			id_dashboard = v_parametros.id_dashboard,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_dashdet=v_parametros.id_dashdet;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dashdet modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashdet',v_parametros.id_dashdet::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DAD_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	elsif(p_transaccion='PM_DAD_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdashdet
            where id_dashdet=v_parametros.id_dashdet;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','dashdet eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashdet',v_parametros.id_dashdet::varchar);
              
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
ALTER FUNCTION "param"."ft_dashdet_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

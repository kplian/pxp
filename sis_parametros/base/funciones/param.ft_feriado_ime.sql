CREATE OR REPLACE FUNCTION "param"."ft_feriado_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_feriado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tferiado'
 AUTOR: 		 (admin)
 FECHA:	        27-10-2017 13:52:45
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
	v_id_feriado	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_feriado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FERIA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2017 13:52:45
	***********************************/

	if(p_transaccion='PM_FERIA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tferiado(
			estado_reg,
			descripcion,
			tipo,
			fecha,
			id_lugar,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.descripcion,
			v_parametros.tipo,
			v_parametros.fecha,
			v_parametros.id_lugar,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_feriado into v_id_feriado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Feriado almacenado(a) con exito (id_feriado'||v_id_feriado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_feriado',v_id_feriado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_FERIA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2017 13:52:45
	***********************************/

	elsif(p_transaccion='PM_FERIA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tferiado set
			descripcion = v_parametros.descripcion,
			tipo = v_parametros.tipo,
			fecha = v_parametros.fecha,
			id_lugar = v_parametros.id_lugar,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_feriado=v_parametros.id_feriado;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Feriado modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_feriado',v_parametros.id_feriado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FERIA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		27-10-2017 13:52:45
	***********************************/

	elsif(p_transaccion='PM_FERIA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tferiado
            where id_feriado=v_parametros.id_feriado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Feriado eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_feriado',v_parametros.id_feriado::varchar);
              
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
ALTER FUNCTION "param"."ft_feriado_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

-- Function: param.f_servicio_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION param.f_servicio_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION param.ft_variable_global_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_variable_global_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tservicio'
 AUTOR: 		 (admin)
 FECHA:	        16-08-2012 23:48:42
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
	v_id_variable_global	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_variable_global_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_VARGLO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	if(p_transaccion='PM_VARGLO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into pxp.variable_global(
			variable,
			valor,
			descripcion			
          	) values(			
			v_parametros.variable,
			v_parametros.valor,
			v_parametros.descripcion
			
			)RETURNING id_variable_global into v_id_variable_global;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Varibale global almacenado(a) con exito (id_variable_global'||v_id_variable_global||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_variable_global',v_id_variable_global::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_VARGLO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	elsif(p_transaccion='PM_VARGLO_MOD')then

		begin
			--Sentencia de la modificacion
			update pxp.variable_global set
			variable = v_parametros.variable,
			valor = v_parametros.valor,
			descripcion = v_parametros.descripcion
			where id_variable_global=v_parametros.id_variable_global;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variable Global modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_variable_global',v_parametros.id_variable_global::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_VARGLO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-08-2012 23:48:42
	***********************************/

	elsif(p_transaccion='PM_VARGLO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from pxp.variable_global
            where id_variable_global=v_parametros.id_variable_global;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variable Global eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_variable_global',v_parametros.id_variable_global::varchar);
              
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
  LANGUAGE plpgsql VOLATILE
  COST 100;

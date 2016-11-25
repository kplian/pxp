--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_var_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_var_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_var'
 AUTOR: 		 (admin)
 FECHA:	        22-11-2016 20:17:52
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
	v_id_depto_var	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_depto_var_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DEVA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 20:17:52
	***********************************/

	if(p_transaccion='PM_DEVA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdepto_var(
			valor,
			id_depto,
			estado_reg,
			id_subsistema_var,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			upper(v_parametros.valor),
			v_parametros.id_depto,
			'activo',
			v_parametros.id_subsistema_var,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_depto_var into v_id_depto_var;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables almacenado(a) con exito (id_depto_var'||v_id_depto_var||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_var',v_id_depto_var::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEVA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 20:17:52
	***********************************/

	elsif(p_transaccion='PM_DEVA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdepto_var set
                valor = upper(v_parametros.valor),
                id_depto = v_parametros.id_depto,
                id_subsistema_var = v_parametros.id_subsistema_var,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_usuario_ai = v_parametros._id_usuario_ai,
                usuario_ai = v_parametros._nombre_usuario_ai
			where id_depto_var=v_parametros.id_depto_var;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_var',v_parametros.id_depto_var::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DEVA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-11-2016 20:17:52
	***********************************/

	elsif(p_transaccion='PM_DEVA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdepto_var
            where id_depto_var=v_parametros.id_depto_var;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Variables eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_var',v_parametros.id_depto_var::varchar);
              
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
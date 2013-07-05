--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_uo_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_uo_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_uo_ep'
 AUTOR: 		 (admin)
 FECHA:	        03-06-2013 15:15:03
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
	v_id_depto_uo_ep	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_depto_uo_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DUE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	if(p_transaccion='PM_DUE_INS')then
					
        begin
        
           IF  v_parametros.id_uo  is NULL  and v_parametros.id_ep is NULL THEN
        
              raise exception 'EP y UO no pueden ser nulos simultaneamente';
        
           END IF;
           
            IF  v_parametros.id_depto is NULL THEN
        
              raise exception 'El departamento no puede ser nulo';
        
           END IF;
        
        	--Sentencia de la insercion
        	insert into param.tdepto_uo_ep(
			id_uo,
			id_depto,
			id_ep,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_uo,
			v_parametros.id_depto,
			v_parametros.id_ep,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_depto_uo_ep into v_id_depto_uo_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP almacenado(a) con exito (id_depto_uo_ep'||v_id_depto_uo_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_id_depto_uo_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DUE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_DUE_MOD')then

		begin
        
            IF  v_parametros.id_uo  is NULL  and v_parametros.id_ep is NULL THEN
        
              raise exception 'EP y UO no pueden ser nulos simultaneamente';
        
           END IF;
           
            IF  v_parametros.id_depto is NULL THEN
        
              raise exception 'El departamento no puede ser nulo';
        
           END IF;
        
			--Sentencia de la modificacion
			update param.tdepto_uo_ep set
			id_uo = v_parametros.id_uo,
			id_depto = v_parametros.id_depto,
			id_ep = v_parametros.id_ep,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_depto_uo_ep=v_parametros.id_depto_uo_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_parametros.id_depto_uo_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DUE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_DUE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdepto_uo_ep
            where id_depto_uo_ep=v_parametros.id_depto_uo_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_parametros.id_depto_uo_ep::varchar);
              
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
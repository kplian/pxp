CREATE OR REPLACE FUNCTION param.ft_buzon_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_buzon_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tbuzon'
 AUTOR: 		 (eddy.gutierrez)
 FECHA:	        25-07-2018 23:43:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				25-07-2018 23:43:03								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tbuzon'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_buzon	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_buzon_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_BUZ_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		eddy.gutierrez	
 	#FECHA:		25-07-2018 23:43:03
	***********************************/

	if(p_transaccion='PM_BUZ_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tbuzon(
			fecha,
			estado_reg,
			sugerencia,
			id_usuario_ai,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			now(),
			'activo',
			v_parametros.sugerencia,
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			now(),
			1,
			null,
			null
							
			
			
			)RETURNING id_buzon into v_id_buzon;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Buzon almacenado(a) con exito (id_buzon'||v_id_buzon||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_buzon',v_id_buzon::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_BUZ_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		eddy.gutierrez	
 	#FECHA:		25-07-2018 23:43:03
	***********************************/

	elsif(p_transaccion='PM_BUZ_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tbuzon set
			fecha = now(),
			sugerencia = v_parametros.sugerencia,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_buzon=v_parametros.id_buzon;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Buzon modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_buzon',v_parametros.id_buzon::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_BUZ_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		eddy.gutierrez	
 	#FECHA:		25-07-2018 23:43:03
	***********************************/

	elsif(p_transaccion='PM_BUZ_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tbuzon
            where id_buzon=v_parametros.id_buzon;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Buzon eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_buzon',v_parametros.id_buzon::varchar);
              
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_tipo_cambio_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tipo_cambio_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_cambio'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        08-03-2013 15:30:14
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
	v_id_tipo_cambio	integer;
    
    v_tipo_cambio numeric;
			    
BEGIN

    v_nombre_funcion = 'param.f_tipo_cambio_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TCB_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		08-03-2013 15:30:14
	***********************************/

	if(p_transaccion='PM_TCB_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.ttipo_cambio(
			estado_reg,
			fecha,
			observaciones,
			compra,
			venta,
			oficial,
			id_moneda,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.fecha,
			v_parametros.observaciones,
			v_parametros.compra,
			v_parametros.venta,
			v_parametros.oficial,
			v_parametros.id_moneda,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_cambio into v_id_tipo_cambio;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Cambio almacenado(a) con exito (id_tipo_cambio'||v_id_tipo_cambio||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cambio',v_id_tipo_cambio::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TCB_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		08-03-2013 15:30:14
	***********************************/

	elsif(p_transaccion='PM_TCB_MOD')then

		begin
			--Sentencia de la modificacion
			update param.ttipo_cambio set
			fecha = v_parametros.fecha,
			observaciones = v_parametros.observaciones,
			compra = v_parametros.compra,
			venta = v_parametros.venta,
			oficial = v_parametros.oficial,
			id_moneda = v_parametros.id_moneda,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_cambio=v_parametros.id_tipo_cambio;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Cambio modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cambio',v_parametros.id_tipo_cambio::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
        

	/*********************************    
 	#TRANSACCION:  'PM_TCB_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		08-03-2013 15:30:14
	***********************************/

	elsif(p_transaccion='PM_TCB_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.ttipo_cambio
            where id_tipo_cambio=v_parametros.id_tipo_cambio;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo de Cambio eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cambio',v_parametros.id_tipo_cambio::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    /*********************************    
 	#TRANSACCION:  'PM_OBTTCB_GET'
 	#DESCRIPCION:	Permite recuperar dede la interface el tipo de cambio para la moneda y fecha determinada
    #AUTOR:	     Rensi Arteaga Copari	
 	#FECHA:		08-03-2013 15:30:14
	***********************************/

	elsif(p_transaccion='PM_OBTTCB_GET')then

		begin
			
            
           v_tipo_cambio =  param.f_get_tipo_cambio(v_parametros.id_moneda,v_parametros.fecha, 'O');
           
           
           IF v_tipo_cambio is NULL THEN
           
               raise exception 'No existe tipo de cambio para la fecha .... %',v_parametros.fecha ;
           
           END IF;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Tipo de Cambio obtenido)'); 
            v_resp = pxp.f_agrega_clave(v_resp, 'tipo_cambio' ,v_tipo_cambio::varchar);
              
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
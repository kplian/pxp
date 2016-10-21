--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_widget_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_widget_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.twidget'
 AUTOR: 		 (admin)
 FECHA:	        10-09-2016 08:00:16
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
	v_id_widget	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_widget_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_WID_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 08:00:16
	***********************************/

	if(p_transaccion='PM_WID_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.twidget(
                ruta,
                nombre,
                
                obs,
                clase,
                tipo,
                estado_reg,
                id_usuario_ai,
                fecha_reg,
                usuario_ai,
                id_usuario_reg,
                fecha_mod,
                id_usuario_mod
          	) values(
                v_parametros.ruta,
                v_parametros.nombre,
                
                v_parametros.obs,
                v_parametros.clase,
                v_parametros.tipo,
                'activo',
                v_parametros._id_usuario_ai,
                now(),
                v_parametros._nombre_usuario_ai,
                p_id_usuario,
                null,
                null
							
			
			
			)RETURNING id_widget into v_id_widget;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Widget almacenado(a) con exito (id_widget'||v_id_widget||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_widget',v_id_widget::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_WID_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 08:00:16
	***********************************/

	elsif(p_transaccion='PM_WID_MOD')then

		begin
			--Sentencia de la modificacion
			update param.twidget set
			ruta = v_parametros.ruta,
			nombre = v_parametros.nombre,
			
			obs = v_parametros.obs,
			clase = v_parametros.clase,
			tipo = v_parametros.tipo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_widget=v_parametros.id_widget;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Widget modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_widget',v_parametros.id_widget::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_WIDIMG_INS'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 08:00:16
	***********************************/

	elsif(p_transaccion='PM_WIDIMG_INS')then

		begin
			--Sentencia de la modificacion
			update param.twidget set
                foto = v_parametros.foto,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario,
                id_usuario_ai = v_parametros._id_usuario_ai,
                usuario_ai = v_parametros._nombre_usuario_ai
			where id_widget=v_parametros.id_widget;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','foto Widget cambiada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_widget',v_parametros.id_widget::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;    
        
        
        

	/*********************************    
 	#TRANSACCION:  'PM_WID_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 08:00:16
	***********************************/

	elsif(p_transaccion='PM_WID_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.twidget
            where id_widget=v_parametros.id_widget;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Widget eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_widget',v_parametros.id_widget::varchar);
              
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
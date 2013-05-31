--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_tdepto_usuario_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tdepto_usuario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_usuario'
 AUTOR: 		 (mzm)
 FECHA:	        24-11-2011 18:26:47
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
	v_id_depto_usuario	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_tdepto_usuario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_DEPUSU_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        mzm    
     #FECHA:        24-11-2011 18:26:47
    ***********************************/

    if(p_transaccion='PM_DEPUSU_INS')then
                    
        begin
            --Sentencia de la insercion
            insert into param.tdepto_usuario(
            estado_reg,
            id_depto,
            id_usuario,
            id_usuario_reg,
            fecha_reg,
            id_usuario_mod,
            fecha_mod    ,
            cargo,
            sw_alerta
            
              ) values(
            'activo',
            v_parametros.id_depto,
            v_parametros.id_usuario,
            p_id_usuario,
            now(),
            null,
            null ,
            v_parametros.cargo,
            v_parametros.sw_alerta
            )RETURNING id_depto_usuario into v_id_depto_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario por Depto almacenado(a) con exito (id_depto_usuario'||v_id_depto_usuario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_usuario',v_id_depto_usuario::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_DEPUSU_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        mzm    
     #FECHA:        24-11-2011 18:26:47
    ***********************************/

    elsif(p_transaccion='PM_DEPUSU_MOD')then

        begin
            --Sentencia de la modificacion
            update param.tdepto_usuario set
            id_depto = v_parametros.id_depto,
            id_usuario = v_parametros.id_usuario,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now() ,
            cargo=v_parametros.cargo,
            sw_alerta=v_parametros.sw_alerta
            where id_depto_usuario=v_parametros.id_depto_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario por Depto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_usuario',v_parametros.id_depto_usuario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_DEPUSU_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        mzm    
     #FECHA:        24-11-2011 18:26:47
    ***********************************/

    elsif(p_transaccion='PM_DEPUSU_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from param.tdepto_usuario
            where id_depto_usuario=v_parametros.id_depto_usuario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario por Depto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_usuario',v_parametros.id_depto_usuario::varchar);
              
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
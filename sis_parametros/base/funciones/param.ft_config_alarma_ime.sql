--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_config_alarma_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_config_alarma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconfig_alarma'
 AUTOR: 		 RAC/KPLIAN
 FECHA:	        18-11-2011 11:59:10
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
	v_id_config_alarma	integer;  
   
			    
BEGIN     

    v_nombre_funcion = 'param.ft_config_alarma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CONALA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	if(p_transaccion='PM_CONALA_INS')then
					
        begin
        
       
        	--Sentencia de la insercion
        	insert into param.tconfig_alarma(
			codigo,
			descripcion,
			dias,
            id_subsistema,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.codigo,
			v_parametros.descripcion,
			v_parametros.dias,
			v_parametros.id_subsistema,
			'activo',
			p_id_usuario,
			now()::date,
			null,
			null
			)RETURNING id_config_alarma into v_id_config_alarma;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion de Alarmas almacenado(a) con exito (id_config_alarma'||v_id_config_alarma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_config_alarma',v_id_config_alarma::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONALA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_CONALA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tconfig_alarma set
			codigo = v_parametros.codigo,
			descripcion = v_parametros.descripcion,
			dias = v_parametros.dias,
			id_subsistema = v_parametros.id_subsistema,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_config_alarma=v_parametros.id_config_alarma;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion de Alarmas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_config_alarma',v_parametros.id_config_alarma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONALA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_CONALA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tconfig_alarma
            where id_config_alarma=v_parametros.id_config_alarma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Configuracion de Alarmas eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_config_alarma',v_parametros.id_config_alarma::varchar);
              
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
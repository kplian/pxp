--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_dashboard_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_dashboard_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdashboard'
 AUTOR: 		 (admin)
 FECHA:	        10-09-2016 11:29:58
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
	v_id_dashboard	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_dashboard_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DAS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:29:58
	***********************************/

	if(p_transaccion='PM_DAS_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdashboard(
			estado_reg,
			id_usuario,
			nombre,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			p_id_usuario,
			'Mi dashboard',
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_dashboard into v_id_dashboard;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DASHBOARD almacenado(a) con exito (id_dashboard'||v_id_dashboard||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashboard',v_id_dashboard::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DAS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:29:58
	***********************************/

	elsif(p_transaccion='PM_DAS_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdashboard set
			
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_dashboard=v_parametros.id_dashboard;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DASHBOARD modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashboard',v_parametros.id_dashboard::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DAS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:29:58
	***********************************/

	elsif(p_transaccion='PM_DAS_ELI')then

		begin
			
            
            delete from param.tdashdet where id_dashboard=v_parametros.id_dashboard;
            
            --Sentencia de la eliminacion
			delete from param.tdashboard
            where id_dashboard=v_parametros.id_dashboard;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DASHBOARD eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_dashboard',v_parametros.id_dashboard::varchar);
              
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
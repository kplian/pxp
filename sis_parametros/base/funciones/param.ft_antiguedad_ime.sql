CREATE OR REPLACE FUNCTION param.ft_antiguedad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_antiguedad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tantiguedad'
 AUTOR: 		 (szambrana)
 FECHA:	        17-10-2019 14:41:21
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				17-10-2019 14:41:21								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tantiguedad'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_antiguedad	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_antiguedad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ANTIG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		szambrana	
 	#FECHA:		17-10-2019 14:41:21
	***********************************/

	if(p_transaccion='PM_ANTIG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tantiguedad(
			estado_reg,
			categoria_antiguedad,
			dias_asignados,
			desde_anhos,
			hasta_anhos,
			obs_antiguedad,
			id_gestion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.categoria_antiguedad,
			v_parametros.dias_asignados,
			v_parametros.desde_anhos,
			v_parametros.hasta_anhos,
			v_parametros.obs_antiguedad,
			v_parametros.id_gestion,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_antiguedad into v_id_antiguedad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Antiguedad almacenado(a) con exito (id_antiguedad'||v_id_antiguedad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_antiguedad',v_id_antiguedad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ANTIG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		szambrana	
 	#FECHA:		17-10-2019 14:41:21
	***********************************/

	elsif(p_transaccion='PM_ANTIG_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tantiguedad set
			categoria_antiguedad = v_parametros.categoria_antiguedad,
			dias_asignados = v_parametros.dias_asignados,
			desde_anhos = v_parametros.desde_anhos,
			hasta_anhos = v_parametros.hasta_anhos,
			obs_antiguedad = v_parametros.obs_antiguedad,
			id_gestion = v_parametros.id_gestion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_antiguedad=v_parametros.id_antiguedad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Antiguedad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_antiguedad',v_parametros.id_antiguedad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ANTIG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		szambrana	
 	#FECHA:		17-10-2019 14:41:21
	***********************************/

	elsif(p_transaccion='PM_ANTIG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tantiguedad
            where id_antiguedad=v_parametros.id_antiguedad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Antiguedad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_antiguedad',v_parametros.id_antiguedad::varchar);
              
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

ALTER FUNCTION param.ft_antiguedad_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
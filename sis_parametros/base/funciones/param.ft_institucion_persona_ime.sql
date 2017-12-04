CREATE OR REPLACE FUNCTION param.ft_institucion_persona_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_institucion_persona_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tinstitucion_persona'
 AUTOR: 		Fprudencio
 FECHA:	        03-12-2017 15:13:03
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
	v_id_institucion_persona	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_institucion_persona_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_INSTIPER_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		03-12-2017 10:50:03
	***********************************/

	if(p_transaccion='PM_INSTIPER_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tinstitucion_persona(
			id_institucion,
			id_persona,
			cargo_institucion
          	) values(
			v_parametros.id_institucion,
			v_parametros.id_persona,
			v_parametros.cargo_institucion
            
			)RETURNING id_institucion_persona into v_id_institucion_persona;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona de Institución almacenado(a) con exito (id_institucion_persona'||v_id_institucion_persona||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion_persona',v_id_institucion_persona::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIPER_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		03-12-2017 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIPER_MOD')then

		begin
        
            -- raise exception 'ss  %',v_parametros.id_institucion;
			--Sentencia de la modificacion
			update param.tinstitucion_persona set
            fecha_mod=now(),
			cargo_institucion = v_parametros.cargo_institucion
			where id_institucion_persona=v_parametros.id_institucion_persona;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona de Institución modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion_persona',v_parametros.id_institucion_persona::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIPER_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		03-12-2017 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIPER_ELI')then

		begin
			--Sentencia de la eliminacion
			update param.tinstitucion_persona set
            estado_reg='inactivo'
            where id_institucion_persona=v_parametros.id_institucion_persona;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Persona de Institución eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion_persona',v_parametros.id_institucion_persona::varchar);
              
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
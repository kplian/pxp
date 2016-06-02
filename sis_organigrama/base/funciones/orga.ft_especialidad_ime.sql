
CREATE OR REPLACE FUNCTION orga.ft_especialidad_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.f_especialidad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tespecialidad'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 17:29:14
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
	v_id_especialidad	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.f_especialidad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_ESPCIA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:29:14
	***********************************/

	if(p_transaccion='RH_ESPCIA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tespecialidad(
			codigo,
			id_especialidad_nivel,
			estado_reg,
			nombre,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.codigo,
			v_parametros.id_especialidad_nivel,
			'activo',
			v_parametros.nombre,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_especialidad into v_id_especialidad;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidad almacenado(a) con exito (id_especialidad'||v_id_especialidad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad',v_id_especialidad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RH_ESPCIA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:29:14
	***********************************/

	elsif(p_transaccion='RH_ESPCIA_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tespecialidad set
			codigo = v_parametros.codigo,
			id_especialidad_nivel = v_parametros.id_especialidad_nivel,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_especialidad=v_parametros.id_especialidad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad',v_parametros.id_especialidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RH_ESPCIA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:29:14
	***********************************/

	elsif(p_transaccion='RH_ESPCIA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tespecialidad
            where id_especialidad=v_parametros.id_especialidad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad',v_parametros.id_especialidad::varchar);
              
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION orga.ft_especialidad_ime(integer, integer, character varying, character varying) OWNER TO postgres;

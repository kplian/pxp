CREATE OR REPLACE FUNCTION "orga"."ft_especialidad_nivel_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_especialidad_nivel_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tespecialidad_nivel'
 AUTOR: 		 (admin)
 FECHA:	        16-04-2016 07:45:20
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
	v_id_especialidad_nivel	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_especialidad_nivel_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_esp_niv_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 07:45:20
	***********************************/

	if(p_transaccion='OR_esp_niv_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tespecialidad_nivel(
			codigo,
			estado_reg,
			nombre,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			'activo',
			v_parametros.nombre,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_especialidad_nivel into v_id_especialidad_nivel;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','tipo_nivel_especialidad almacenado(a) con exito (id_especialidad_nivel'||v_id_especialidad_nivel||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad_nivel',v_id_especialidad_nivel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_esp_niv_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 07:45:20
	***********************************/

	elsif(p_transaccion='OR_esp_niv_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tespecialidad_nivel set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_especialidad_nivel=v_parametros.id_especialidad_nivel;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','tipo_nivel_especialidad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad_nivel',v_parametros.id_especialidad_nivel::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_esp_niv_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-04-2016 07:45:20
	***********************************/

	elsif(p_transaccion='OR_esp_niv_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tespecialidad_nivel
            where id_especialidad_nivel=v_parametros.id_especialidad_nivel;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','tipo_nivel_especialidad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad_nivel',v_parametros.id_especialidad_nivel::varchar);
              
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
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "orga"."ft_especialidad_nivel_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

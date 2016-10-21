CREATE OR REPLACE FUNCTION "orga"."ft_especialidad_nivel_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.ft_especialidad_nivel_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tespecialidad_nivel'
 AUTOR: 		 (admin)
 FECHA:	        26-08-2012 00:05:28
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
 	#TRANSACCION:  'RH_RHNIES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-08-2012 00:05:28
	***********************************/

	if(p_transaccion='RH_RHNIES_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tespecialidad_nivel(
			codigo,
			nombre,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.codigo,
			v_parametros.nombre,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_especialidad_nivel into v_id_especialidad_nivel;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Niveles Especialidad almacenado(a) con exito (id_especialidad_nivel'||v_id_especialidad_nivel||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad_nivel',v_id_especialidad_nivel::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHNIES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-08-2012 00:05:28
	***********************************/

	elsif(p_transaccion='RH_RHNIES_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tespecialidad_nivel set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_especialidad_nivel=v_parametros.id_especialidad_nivel;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Niveles Especialidad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_especialidad_nivel',v_parametros.id_especialidad_nivel::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHNIES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-08-2012 00:05:28
	***********************************/

	elsif(p_transaccion='RH_RHNIES_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tespecialidad_nivel
            where id_especialidad_nivel=v_parametros.id_especialidad_nivel;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Niveles Especialidad eliminado(a)'); 
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
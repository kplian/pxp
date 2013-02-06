CREATE OR REPLACE FUNCTION "param"."f_actividad_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_actividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tactividad'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 15:45:34
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
	v_id_actividad	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_actividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ACT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 15:45:34
	***********************************/

	if(p_transaccion='PM_ACT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tactividad(
			estado_reg,
			codigo_actividad,
			descripcion_actividad,
			nombre_actividad,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.codigo_actividad,
			v_parametros.descripcion_actividad,
			v_parametros.nombre_actividad,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_actividad into v_id_actividad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad almacenado(a) con exito (id_actividad'||v_id_actividad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_id_actividad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ACT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 15:45:34
	***********************************/

	elsif(p_transaccion='PM_ACT_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tactividad set
			codigo_actividad = v_parametros.codigo_actividad,
			descripcion_actividad = v_parametros.descripcion_actividad,
			nombre_actividad = v_parametros.nombre_actividad,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_actividad=v_parametros.id_actividad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ACT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 15:45:34
	***********************************/

	elsif(p_transaccion='PM_ACT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tactividad
            where id_actividad=v_parametros.id_actividad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Actividad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_actividad',v_parametros.id_actividad::varchar);
              
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
ALTER FUNCTION "param"."f_actividad_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

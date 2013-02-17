CREATE OR REPLACE FUNCTION "param"."f_programa_proyecto_acttividad_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_programa_proyecto_acttividad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tprograma_proyecto_acttividad'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 16:04:45
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
	v_id_prog_pory_acti	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_programa_proyecto_acttividad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PPA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 16:04:45
	***********************************/

	if(p_transaccion='PM_PPA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tprograma_proyecto_acttividad(
			estado_reg,
			id_proyecto,
			id_actividad,
			id_programa,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_proyecto,
			v_parametros.id_actividad,
			v_parametros.id_programa,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_prog_pory_acti into v_id_prog_pory_acti;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa-Proyecto-Actividad almacenado(a) con exito (id_prog_pory_acti'||v_id_prog_pory_acti||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_prog_pory_acti',v_id_prog_pory_acti::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PPA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 16:04:45
	***********************************/

	elsif(p_transaccion='PM_PPA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tprograma_proyecto_acttividad set
			id_proyecto = v_parametros.id_proyecto,
			id_actividad = v_parametros.id_actividad,
			id_programa = v_parametros.id_programa,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_prog_pory_acti=v_parametros.id_prog_pory_acti;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa-Proyecto-Actividad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_prog_pory_acti',v_parametros.id_prog_pory_acti::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PPA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 16:04:45
	***********************************/

	elsif(p_transaccion='PM_PPA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tprograma_proyecto_acttividad
            where id_prog_pory_acti=v_parametros.id_prog_pory_acti;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa-Proyecto-Actividad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_prog_pory_acti',v_parametros.id_prog_pory_acti::varchar);
              
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
ALTER FUNCTION "param"."f_programa_proyecto_acttividad_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

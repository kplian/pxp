CREATE OR REPLACE FUNCTION "segu"."ft_programador_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_programador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tprogramador'
 AUTOR: 		 (rarteaga)
 FECHA:	        08-01-2020 19:46:59
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #102		08-01-2020 19:46:59		RAC KPLIAN 			Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tprogramador'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_programador	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_programador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_PRG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rarteaga	
 	#FECHA:		08-01-2020 19:46:59
	***********************************/

	if(p_transaccion='SG_PRG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tprogramador(
			usuario_ldap,
			alias_git,
			alias_codigo_1,
			nombre_completo,
			organizacion,
			correo_personal,
			fecha_inicio,
			estado_reg,
			alias_codigo_2,
			correo,
			fecha_fin,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.usuario_ldap,
			v_parametros.alias_git,
			v_parametros.alias_codigo_1,
			v_parametros.nombre_completo,
			v_parametros.organizacion,
			v_parametros.correo_personal,
			v_parametros.fecha_inicio,
			'activo',
			v_parametros.alias_codigo_2,
			v_parametros.correo,
			v_parametros.fecha_fin,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_programador into v_id_programador;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Progamador almacenado(a) con exito (id_programador'||v_id_programador||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_programador',v_id_programador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_PRG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rarteaga	
 	#FECHA:		08-01-2020 19:46:59
	***********************************/

	elsif(p_transaccion='SG_PRG_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tprogramador set
			usuario_ldap = v_parametros.usuario_ldap,
			alias_git = v_parametros.alias_git,
			alias_codigo_1 = v_parametros.alias_codigo_1,
			nombre_completo = v_parametros.nombre_completo,
			organizacion = v_parametros.organizacion,
			correo_personal = v_parametros.correo_personal,
			fecha_inicio = v_parametros.fecha_inicio,
			alias_codigo_2 = v_parametros.alias_codigo_2,
			correo = v_parametros.correo,
			fecha_fin = v_parametros.fecha_fin,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_programador=v_parametros.id_programador;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Progamador modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_programador',v_parametros.id_programador::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_PRG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rarteaga	
 	#FECHA:		08-01-2020 19:46:59
	***********************************/

	elsif(p_transaccion='SG_PRG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tprogramador
            where id_programador=v_parametros.id_programador;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Progamador eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_programador',v_parametros.id_programador::varchar);
              
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
ALTER FUNCTION "segu"."ft_programador_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

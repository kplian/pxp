CREATE OR REPLACE FUNCTION "param"."ft_administrador_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_administrador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tadministrador'
 AUTOR: 		 (admin)
 FECHA:	        29-12-2017 16:10:32
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				29-12-2017 16:10:32								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tadministrador'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_administrador	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_administrador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ADMFUNLU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-12-2017 16:10:32
	***********************************/

	if(p_transaccion='PM_ADMFUNLU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tadministrador(
			id_funcionario,
			id_lugar,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_funcionario,
			v_parametros.id_lugar,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_administrador into v_id_administrador;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Administrador Func_Lugar almacenado(a) con exito (id_administrador'||v_id_administrador||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_administrador',v_id_administrador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ADMFUNLU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-12-2017 16:10:32
	***********************************/

	elsif(p_transaccion='PM_ADMFUNLU_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tadministrador set
			id_funcionario = v_parametros.id_funcionario,
			id_lugar = v_parametros.id_lugar,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_administrador=v_parametros.id_administrador;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Administrador Func_Lugar modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_administrador',v_parametros.id_administrador::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ADMFUNLU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		29-12-2017 16:10:32
	***********************************/

	elsif(p_transaccion='PM_ADMFUNLU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tadministrador
            where id_administrador=v_parametros.id_administrador;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Administrador Func_Lugar eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_administrador',v_parametros.id_administrador::varchar);
              
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
ALTER FUNCTION "param"."ft_administrador_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

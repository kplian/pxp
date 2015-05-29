CREATE OR REPLACE FUNCTION "orga"."ft_uo_funcionario_ope_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_uo_funcionario_ope_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tuo_funcionario_ope'
 AUTOR: 		 (admin)
 FECHA:	        19-05-2015 17:53:09
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
	v_id_uo_funcionario_ope	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_uo_funcionario_ope_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_UOFO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-05-2015 17:53:09
	***********************************/

	if(p_transaccion='OR_UOFO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tuo_funcionario_ope(
			estado_reg,
			id_uo,
			id_funcionario,
			fecha_asignacion,
			fecha_finalizacion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_uo,
			v_parametros.id_funcionario,
			v_parametros.fecha_asignacion,
			v_parametros.fecha_finalizacion,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_uo_funcionario_ope into v_id_uo_funcionario_ope;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asignación Operacional  almacenado(a) con exito (id_uo_funcionario_ope'||v_id_uo_funcionario_ope||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uo_funcionario_ope',v_id_uo_funcionario_ope::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_UOFO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-05-2015 17:53:09
	***********************************/

	elsif(p_transaccion='OR_UOFO_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tuo_funcionario_ope set
			id_uo = v_parametros.id_uo,
			id_funcionario = v_parametros.id_funcionario,
			fecha_asignacion = v_parametros.fecha_asignacion,
			fecha_finalizacion = v_parametros.fecha_finalizacion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_uo_funcionario_ope=v_parametros.id_uo_funcionario_ope;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asignación Operacional  modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uo_funcionario_ope',v_parametros.id_uo_funcionario_ope::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_UOFO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-05-2015 17:53:09
	***********************************/

	elsif(p_transaccion='OR_UOFO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tuo_funcionario_ope
            where id_uo_funcionario_ope=v_parametros.id_uo_funcionario_ope;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asignación Operacional  eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uo_funcionario_ope',v_parametros.id_uo_funcionario_ope::varchar);
              
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
ALTER FUNCTION "orga"."ft_uo_funcionario_ope_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

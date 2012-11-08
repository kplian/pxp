-- Function: orga.f_tipo_horario_ime(integer, integer, character varying, character varying)

-- DROP FUNCTION orga.f_tipo_horario_ime(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION orga.f_tipo_horario_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.f_tipo_horario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.ttipo_horario'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 16:28:19
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
	v_id_tipo_horario	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.f_tipo_horario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHTIHO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 16:28:19
	***********************************/

	if(p_transaccion='RH_RHTIHO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.ttipo_horario(
			estado_reg,
			nombre,
			codigo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_tipo_horario into v_id_tipo_horario;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Horario almacenado(a) con exito (id_tipo_horario'||v_id_tipo_horario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_horario',v_id_tipo_horario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHTIHO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 16:28:19
	***********************************/

	elsif(p_transaccion='RH_RHTIHO_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.ttipo_horario set
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_horario=v_parametros.id_tipo_horario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Horario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_horario',v_parametros.id_tipo_horario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHTIHO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 16:28:19
	***********************************/

	elsif(p_transaccion='RH_RHTIHO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.ttipo_horario
            where id_tipo_horario=v_parametros.id_tipo_horario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Horario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_horario',v_parametros.id_tipo_horario::varchar);
              
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
ALTER FUNCTION orga.f_tipo_horario_ime(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION param.ft_depto_uo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_uo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_uo'
 AUTOR: 		 (m)
 FECHA:	        19-10-2011 12:59:45
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
	v_id_depto_uo	integer;
			
BEGIN

    v_nombre_funcion = 'param.ft_depto_uo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_DEPUO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		m	
 	#FECHA:		19-10-2011 12:59:45
	***********************************/

	if(p_transaccion='PM_DEPUO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tdepto_uo(
			estado_reg,
			id_depto,
			id_uo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_depto,
			v_parametros.id_uo,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_depto_uo into v_id_depto_uo;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Departamento-UO almacenado(a) con exito (id_depto_uo'||v_id_depto_uo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo',v_id_depto_uo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_DEPUO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		m	
 	#FECHA:		19-10-2011 12:59:45
	***********************************/

	elsif(p_transaccion='PM_DEPUO_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tdepto_uo set
			id_depto = v_parametros.id_depto,
			id_uo = v_parametros.id_uo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_depto_uo=v_parametros.id_depto_uo;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Departamento-UO modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo',v_parametros.id_depto_uo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_DEPUO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		m	
 	#FECHA:		19-10-2011 12:59:45
	***********************************/

	elsif(p_transaccion='PM_DEPUO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdepto_uo
            where id_depto_uo=v_parametros.id_depto_uo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Departamento-UO eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo',v_parametros.id_depto_uo::varchar);

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
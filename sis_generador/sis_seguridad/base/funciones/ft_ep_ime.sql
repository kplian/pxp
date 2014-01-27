CREATE OR REPLACE FUNCTION segu.ft_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tep'
 AUTOR: 		 (w)
 FECHA:	        18-10-2011 02:09:50
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
	v_id_ep	integer;
			
BEGIN

    v_nombre_funcion = 'segu.ft_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_ESP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		w	
 	#FECHA:		18-10-2011 02:09:50
	***********************************/

	if(p_transaccion='SG_ESP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tep(
			estado_reg,
			id_actividad,
			id_programa,
			id_proyecto,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_actividad,
			v_parametros.id_programa,
			v_parametros.id_proyecto,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_ep into v_id_ep;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Programatica almacenado(a) con exito (id_ep'||v_id_ep||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_id_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_ESP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		w	
 	#FECHA:		18-10-2011 02:09:50
	***********************************/

	elsif(p_transaccion='SG_ESP_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tep set
			id_actividad = v_parametros.id_actividad,
			id_programa = v_parametros.id_programa,
			id_proyecto = v_parametros.id_proyecto,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_ep=v_parametros.id_ep;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Programatica modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_parametros.id_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_ESP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		w	
 	#FECHA:		18-10-2011 02:09:50
	***********************************/

	elsif(p_transaccion='SG_ESP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tep
            where id_ep=v_parametros.id_ep;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Programatica eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_ep',v_parametros.id_ep::varchar);

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_ep_sel (OID = 305051) : 
--

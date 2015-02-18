CREATE OR REPLACE FUNCTION segu.ft_proyecto_ime (
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
 FUNCION: 		segu.ft_proyecto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tproyecto'
 AUTOR: 		 (w)
 FECHA:	        17-10-2011 06:35:44
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
	v_id_proyecto	integer;
			
BEGIN

    v_nombre_funcion = 'segu.ft_proyecto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_PROY_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		w	
 	#FECHA:		17-10-2011 06:35:44
	***********************************/

	if(p_transaccion='SG_PROY_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tproyecto(
			codigo,
			descripcion,
			estado_reg,
			nombre,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			v_parametros.descripcion,
			'activo',
			v_parametros.nombre,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_proyecto into v_id_proyecto;

			--Definici?n de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto almacenado(a) con exito (id_proyecto'||v_id_proyecto||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_id_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_PROY_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		w	
 	#FECHA:		17-10-2011 06:35:44
	***********************************/

	elsif(p_transaccion='SG_PROY_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tproyecto set
			codigo = v_parametros.codigo,
			descripcion = v_parametros.descripcion,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_proyecto=v_parametros.id_proyecto;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_PROY_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		w	
 	#FECHA:		17-10-2011 06:35:44
	***********************************/

	elsif(p_transaccion='SG_PROY_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tproyecto
            where id_proyecto=v_parametros.id_proyecto;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);

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
-- Definition for function ft_proyecto_sel (OID = 305086) : 
--

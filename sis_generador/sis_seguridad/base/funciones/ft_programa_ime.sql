CREATE OR REPLACE FUNCTION segu.ft_programa_ime (
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
 FUNCION: 		segu.ft_programa_ime
 DESCRIPCION:   Funci?n que gestiona las operaciones b?sicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tprograma'
 AUTOR: 		 (w)
 FECHA:	        14-08-2011 15:36:44
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCI?N:	
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
	v_id_programa	integer;
			
BEGIN

    v_nombre_funcion = 'segu.ft_programa_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_PROGRA_INS'
 	#DESCRIPCION:	Inserci?n de registros
 	#AUTOR:		w	
 	#FECHA:		14-08-2011 15:36:44
	***********************************/

	if(p_transaccion='SG_PROGRA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tprograma(
			codigo,
			descripcion,
			nombre,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			v_parametros.descripcion,
			v_parametros.nombre,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_programa into v_id_programa;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa almacenado(a) con exito (id_programa'||v_id_programa||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_programa',v_id_programa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_PROGRA_MOD'
 	#DESCRIPCION:	Modificaci?n de registros
 	#AUTOR:		w	
 	#FECHA:		14-08-2011 15:36:44
	***********************************/

	elsif(p_transaccion='SG_PROGRA_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tprograma set
			codigo= v_parametros.codigo,
			descripcion= v_parametros.descripcion,
			nombre= v_parametros.nombre,
			fecha_mod=now(),
			id_usuario_mod = p_id_usuario
			where id_programa=v_parametros.id_programa;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_programa',v_parametros.id_programa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_PROGRA_ELI'
 	#DESCRIPCION:	Eliminaci?n de registros
 	#AUTOR:		w	
 	#FECHA:		14-08-2011 15:36:44
	***********************************/

	elsif(p_transaccion='SG_PROGRA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tprograma
            where id_programa=v_parametros.id_programa;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Programa eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_programa',v_parametros.id_programa::varchar);

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
-- Definition for function ft_programa_sel (OID = 305084) : 
--

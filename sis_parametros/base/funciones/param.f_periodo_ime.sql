--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_periodo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_periodo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla ''param.tperiodo''
 AUTOR: 		 (admin)
 FECHA:	        20-02-2013 04:11:23
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
	v_id_periodo			integer;
    v_registros           	record;

BEGIN

    v_nombre_funcion = 'param.f_periodo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_PER_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	if(p_transaccion='PM_PER_INS')then

        begin
        	--Sentencia de la insercion
        	insert into param.tperiodo(
              id_gestion,
              fecha_ini,
              periodo,
              estado_reg,
              fecha_fin,
              fecha_reg,
              id_usuario_reg,
              fecha_mod,
              id_usuario_mod,
              codigo_siga
          	) values(
              v_parametros.id_gestion,
              v_parametros.fecha_ini,
              v_parametros.periodo,
              'activo',
              v_parametros.fecha_fin,
              now(),
              p_id_usuario,
              null,
              null,
              v_parametros.codigo_siga

			)RETURNING id_periodo into v_id_periodo;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Periodo almacenado(a) con exito (id_periodo'||v_id_periodo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_id_periodo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_PER_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	elsif(p_transaccion='PM_PER_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tperiodo set
              fecha_mod = now(),
              id_usuario_mod = p_id_usuario,
              codigo_siga = v_parametros.codigo_siga
			where id_periodo=v_parametros.id_periodo;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Periodo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'PM_PER_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	elsif(p_transaccion='PM_PER_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tperiodo
            where id_periodo=v_parametros.id_periodo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Periodo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

    /*********************************
 	#TRANSACCION:  'PM_GETPER_GET'
 	#DESCRIPCION:	Recupera periodo y gestion segun el ID periodo
 	#AUTOR:		admin
 	#FECHA:		20-02-2013 04:11:23
	***********************************/

	elsif(p_transaccion='PM_GETPER_GET')then

		begin
			--Sentencia de la eliminacion


            select
              p.id_periodo,
              p.id_gestion,
              pxp.f_rellena_cero(p.periodo::varchar) as periodo,
              g.gestion,
              param.f_literal_periodo(p.id_periodo)as literal_periodo
            into
             v_registros
            from param.tperiodo p
            inner join param.tgestion g on g.id_gestion = p.id_gestion
            where p.id_periodo = v_parametros.id_periodo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Periodo recuperado)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_registros.id_gestion::varchar);
        	v_resp = pxp.f_agrega_clave(v_resp,'periodo',v_registros.periodo::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'gestion',v_registros.gestion::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'literal_periodo',v_registros.literal_periodo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;


	else

    	raise exception 'transaccion inexistente: %',p_transaccion;

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
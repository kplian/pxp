CREATE OR REPLACE FUNCTION segu.ft_usuario_externo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_usuario_externo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tusuario_externo'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        27-09-2017 13:33:32
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
	v_id_usuario_externo	integer;
    v_arreglo					varchar[];
    v_apellido					varchar;


BEGIN

    v_nombre_funcion = 'segu.ft_usuario_externo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_UEO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

	if(p_transaccion='SG_UEO_INS')then

        begin
        	--Sentencia de la insercion
        	insert into segu.tusuario_externo(
			id_usuario,
			usuario_externo,
			estado_reg,
			sistema_externo,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_usuario,
			v_parametros.usuario_externo,
			'activo',
			v_parametros.sistema_externo,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null



			)RETURNING id_usuario_externo into v_id_usuario_externo;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario Externo almacenado(a) con exito (id_usuario_externo'||v_id_usuario_externo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_externo',v_id_usuario_externo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_UEO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

	elsif(p_transaccion='SG_UEO_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tusuario_externo set
			id_usuario = v_parametros.id_usuario,
			usuario_externo = v_parametros.usuario_externo,
			sistema_externo = v_parametros.sistema_externo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_usuario_externo=v_parametros.id_usuario_externo;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario Externo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_externo',v_parametros.id_usuario_externo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'SG_UEO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

	elsif(p_transaccion='SG_UEO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tusuario_externo
            where id_usuario_externo=v_parametros.id_usuario_externo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario Externo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_externo',v_parametros.id_usuario_externo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
    /*********************************
 	#TRANSACCION:  'SG_UEO_GEN'
 	#DESCRIPCION:	Generar usuarios amadeus
 	#AUTOR:		miguel.mamani
 	#FECHA:		27-09-2017 13:33:32
	***********************************/

    elsif (p_transaccion = 'SG_UEO_GEN')then
    begin

    	select 	regexp_split_to_array(p.nombre,E'\\s+'),
               ( CASE
                WHEN p.apellido_paterno = ''then
                p.apellido_materno
                ELSE
                p.apellido_paterno
                END) as apellido
                into
                v_arreglo,
                v_apellido
				from segu.tusuario u
				inner join segu.tpersona p on p.id_persona = u.id_persona
				where u.id_usuario = v_parametros.id_usuario;


    insert into segu.tusuario_externo(
			id_usuario,
			usuario_externo,
			estado_reg,
			sistema_externo,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod)
            select 	v_parametros.id_usuario,
					lpad(COALESCE(nextval('segu.tusu_externo_amadeuz'::regclass), 0)::varchar,4,'0')||substring(lower(v_arreglo[1]::varchar) from 1 for 1)||substring (lower(v_apellido) from 1 for 1)::varchar,
                    'activo',
                    'Amadeus'::varchar,
                    now(),
                    v_parametros._nombre_usuario_ai,
                    p_id_usuario,
                    v_parametros._id_usuario_ai,
                    null,
                    null;




   			 --Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario Externo almacenado(a) con exito (id_usuario_externo'||v_parametros.id_usuario||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_externo',v_parametros.id_usuario::varchar);

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
CREATE OR REPLACE FUNCTION segu.ft_commit_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Asistencia
 FUNCION: 		asis.ft_grupo_asig_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'asis.tgrupo_asig'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        20-11-2019 20:00:15
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				20-11-2019 20:00:15								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'asis.tgrupo_asig'
  #104			27-02-2020 				MMV ETR     			Import github commit data, problems, branch and repository
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_commit_json			json;
	v_json_commit			record;
	v_commit				varchar;
	v_fecha_commit			timestamp;
	v_id_branches			integer;
    v_branch				varchar;
    v_issues				integer;
    v_id_issues				integer;

BEGIN

    v_nombre_funcion = 'segu.ft_commit_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SEG_JSON_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		20-11-2019 20:00:15
	***********************************/

	if(p_transaccion='SEG_JSON_INS')then

        begin
        	--Sentencia de la insercion

               v_commit_json = v_parametros.commit_data::json;  --#104

               v_id_issues = null;

               for v_json_commit in (select json_array_elements(v_commit_json))loop

                    v_commit = v_json_commit.json_array_elements::json;
                    v_fecha_commit = v_commit::json->>'fecha';
                    v_branch = v_commit::json->>'rama';
                    v_issues = v_commit::json->>'issues';

                     select iss.id_issues into v_id_issues
                     from segu.tissues iss
                     where iss.id_subsistema = v_parametros.id_subsistema
                     	   and iss.number_issues = v_issues;


                     select c.id_branches into v_id_branches
                     from segu.tbranches c
                     where c.id_subsistema = v_parametros.id_subsistema
                       and c.name = v_branch;
                       --#104
                       if not exists  (select 1
                                   from segu.tcommit com
                                   where com.id_subsistema = v_parametros.id_subsistema
                                   and com.message = v_commit::json->>'message'::text) then

                    INSERT INTO segu.tcommit( id_issues,
                                              sha,
                                              html_url,
                                              author,
                                              id_programador,
                                              message,
                                              fecha,
                                              id_subsistema,
                                              id_branches,
                                              issues
                                              )
                                              VALUES (
                                              v_id_issues,
                                               v_commit::json->>'sha'::text,
                                               v_commit::json->>'html_url'::text,
                                               v_commit::json->>'author'::text,
                                               null,
                                               v_commit::json->>'message'::text,
                                               v_fecha_commit,
                                               v_parametros.id_subsistema,
                                               v_id_branches,
                                               v_issues
                                            );
                    end if;
                 end loop;
			--Definicion de la respuesta
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);

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

ALTER FUNCTION segu.ft_commit_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
CREATE OR REPLACE FUNCTION segu.ft_commit_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_commit_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tcommit'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        09-01-2020 21:26:18
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				09-01-2020 21:26:18								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tcommit'
  #104			27-02-2020 				MMV ETR     			Import github commit data, problems, branch and repository
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'segu.ft_commit_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_COM_SEL' #104
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		miguel.mamani
 	#FECHA:		09-01-2020 21:26:18
	***********************************/

	if(p_transaccion='SG_COM_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select	com.id_commit,
                                com.id_issues,
                                com.sha,
                                com.html_url,
                                (case
                                      when pro.nombre_completo is null or  pro.nombre_completo = '''' then
                                      com.author
                                      else
                                       initcap(pro.nombre_completo)
                                end )::varchar as author,
                                com.id_programador,
                                com.message,
                                com.fecha::date as fecha,
                                com.id_subsistema,
                                com.id_branches,
                                com.issues
                                from segu.tcommit com
                                left join segu.tprogramador pro on pro.id_programador = com.id_programador
				        		where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice 'v_consulta %',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'SG_COM_CONT' #104
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		09-01-2020 21:26:18
	***********************************/

	elsif(p_transaccion='SG_COM_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_commit)
					    from segu.tcommit com
                        left join segu.tprogramador pro on pro.id_programador = com.id_programador
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	else

		raise exception 'Transaccion inexistente';

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
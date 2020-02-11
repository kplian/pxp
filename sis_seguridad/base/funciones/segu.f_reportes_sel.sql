CREATE OR REPLACE FUNCTION segu.f_reportes_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Asistencia
 FUNCION: 		asis.f_reportes_sel
 DESCRIPCION:   Funcion para Reportes
 AUTOR: 		 (miguel.mamani)
 FECHA:	        29-08-2019
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
104           30/1/2020   MMV ETR     Import github commit data, problems, branch and repository
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
    v_resp				varchar;
    v_filtro_repo		varchar;
    v_filtro_estado		varchar;

BEGIN

	v_nombre_funcion = 'segu.f_reportes_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SE_REP_SEL'
 	#DESCRIPCION:	Combo repositorios
 	#AUTOR:		miguel.mamani
 	#FECHA:		20/01/2020
	***********************************/

	if(p_transaccion='SE_REP_SEL')then
    	begin

			v_consulta:='select su.id_subsistema,
                                su.nombre,
                                su.organizacion_git,
                                su.codigo_git,
                                su.sw_importacion
                        from segu.tsubsistema su
                        where su.sw_importacion = ''si'' and ';

           --Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--Devuelve la respuesta
			return v_consulta;
		end;
	/*********************************
 	#TRANSACCION:  'SE_REP_CONT'
 	#DESCRIPCION:	Combo repositorios
 	#AUTOR:		miguel.mamani
 	#FECHA:		20/01/2020
	***********************************/
    elsif(p_transaccion='SE_REP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(su.id_subsistema)
                                from segu.tsubsistema su
                                where su.sw_importacion = ''si'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			--Devuelve la respuesta
			return v_consulta;

		end;
    /*********************************
 	#TRANSACCION:  'SE_BRA_SEL'
 	#DESCRIPCION:	Combo Branch
 	#AUTOR:		miguel.mamani
 	#FECHA:		20/01/2020
	***********************************/

    elsif(p_transaccion='SE_BRA_SEL')then
    begin

			v_consulta:='select br.id_branches,
                                br.id_subsistema,
                                br.name
                        from segu.tbranches br
                        where ';

           --Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--Devuelve la respuesta
			return v_consulta;
	end;
    /*********************************
 	#TRANSACCION:  'SE_BRA_CONT'
 	#DESCRIPCION:	Combo repositorios
 	#AUTOR:		miguel.mamani
 	#FECHA:		20/01/2020
	***********************************/
    elsif(p_transaccion='SE_BRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select  count(br.id_branches)
								 from segu.tbranches br
                                 where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'SE_REPR_SEL'
 	#DESCRIPCION:	Reporte Issues e Commit
 	#AUTOR:		miguel.mamani
 	#FECHA:		20/01/2020
	***********************************/
	elsif(p_transaccion='SE_REPR_SEL')then
    	begin

       -- raise exception '%',v_parametros.id_subsistema;
       if (v_parametros.id_subsistema = 0)then
       		v_filtro_repo = '0 = 0';
       else
       		v_filtro_repo = 'iss.id_subsistema = '||v_parametros.id_subsistema;
       end if;

       if (v_parametros.estado = 'all')then
       	v_filtro_estado = 'iss.state in (''open'',''closed'')';
       else
       v_filtro_estado = 'iss.state in ('||v_parametros.estado||')';
       end if;

        v_consulta:= 'with  issues as (select 	su.id_subsistema,
                            es.id_issues,
                            es.id_programador,
                            su.nombre,
                            es.number_issues,
                            es.title,
                            es.state,
                            es.created_at::date as fecha,
                            (case
                                when po.nombre_completo is null then
                                initcap(es.author)
                                else
                                initcap(po.nombre_completo)
                            end ) as nombre_completo
                    from segu.tsubsistema su
                    inner join segu.tissues es on es.id_subsistema = su.id_subsistema
                    left join segu.tprogramador po on po.id_programador = es.id_programador
                    order by number_issues desc),
			commit as (select com.id_branches,
                              com.id_issues,
                              com.id_subsistema,
                              com.id_programador,
                              com.issues,
                              bra.name,
                              com.message,
                              com.fecha::date as fecha,
                              (case
                                  when pro.nombre_completo is null then
                                  initcap(com.author)
                                  else
                                  initcap(pro.nombre_completo)
                                  end) as nombre_completo
                      from segu.tcommit com
                      inner join segu.tbranches bra on bra.id_branches = com.id_branches
                      left join segu.tprogramador pro on pro.id_programador = com.id_programador
                      order by issues desc) select  iss.id_subsistema,
                      								iss.id_programador,
                      								iss.nombre as sistema,
                                                    iss.number_issues,
                                                    iss.title as titulo,
                                                    iss.state as estado,
                                                    iss.fecha as creador_issues,
                                                    iss.nombre_completo as creador_issues,
                                                    com.issues,
                                                    com.id_branches,
                                                    com.name,
                                                    com.message,
                                                    com.fecha as fecha_commit,
                                                    com.nombre_completo as creador_commit
                                            from issues iss
                                            inner join commit com on com.id_issues = iss.id_issues
                      						where '||v_filtro_repo||'
                       						and iss.id_programador in ('||v_parametros.id_programador||')
                                            and com.name = ''master''
                                            and '||v_filtro_estado||'
                                            and iss.fecha between '''||v_parametros.fecha_ini||''' and '''||v_parametros.fecha_fin||''' ';
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

ALTER FUNCTION segu.f_reportes_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO dbaamamani;
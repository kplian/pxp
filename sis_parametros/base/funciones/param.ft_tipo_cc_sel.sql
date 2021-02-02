--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_tipo_cc_sel (
    p_administrador integer,
    p_id_usuario integer,
    p_tabla varchar,
    p_transaccion varchar
)
    RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_cc_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_cc'
 AUTOR: 		 (admin)
 FECHA:	        26-05-2017 10:10:19
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:

                 COMENTARIOS:
  #33  ETR       18/07/2018        RAC KPLIAN        insertar  tipos de centros operativos o no
  #34  ETR       09/10/2018        MMV 		 		 insertar timpos de autorizacion por catalago
  #2  ETR		 07/12/2018		   EGS				 Se creo las funciones PM_TCCARBHI_SEL y PM_TCCARBHI_CONT que lista los nodos transsaccionales del tipo cc por gestion
  #7  endeETR    21/01/2019		   EGS				 se modifico PM_TCCARBHI_SEL para que considere el con tipo de presupuesto
  #150 ENDETR    08/07/2020        JJA               Filtrar los tipo_cc vigentes
  #44  ENDETR    23/07/2020        JJA          Mejoras en reporte tipo centro de costo de presupuesto
  #155 ETR       14/08/2020        YMR               Bitacora de tipo dentro de costo
  #MDID-11       29/10/2020        EGS                se modifica para que no sea obligatorio la gestion
***************************************************************************/

DECLARE

    v_consulta    		varchar;
    v_parametros  		record;
    v_nombre_funcion   	text;
    v_resp				varchar;
    v_where				varchar;
    v_where_2           varchar; --#150
    v_id_tipo_cc		integer;
    v_filtro              varchar;
    v_join                varchar;
    v_select              varchar;

BEGIN

    v_nombre_funcion = 'param.ft_tipo_cc_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_TCC_SEL'
     #DESCRIPCION:	Consulta de datos
     #AUTOR:		admin
     #FECHA:		26-05-2017 10:10:19
    ***********************************/

    if(p_transaccion='PM_TCC_SEL')then

        begin
            --Sentencia de la consulta
            v_consulta:='SELECT
                          tcc.id_tipo_cc,
                          tcc.codigo,
                          tcc.control_techo,
                          tcc.mov_pres,
                          tcc.estado_reg,
                          tcc.movimiento,
                          tcc.id_ep,
                          tcc.id_tipo_cc_fk,
                          tcc.descripcion,
                          tcc.tipo,
                          tcc.control_partida,
                          tcc.momento_pres,
                          tcc.fecha_reg,
                          tcc.usuario_ai,
                          tcc.id_usuario_reg,
                          tcc.id_usuario_ai,
                          tcc.id_usuario_mod,
                          tcc.fecha_mod,
                          tcc.usr_reg,
                          tcc.usr_mod,
                          tcc.desc_ep,
                          tcc.fecha_inicio,
                          tcc.fecha_final,
                          COALESCE(tccp.codigo,'''')::varchar as codigo_tccp,
                          COALESCE(tccp.descripcion,'''')::varchar as descripcion_tccp,
                          array_to_string(tcc.mov_pres,'','')::varchar as mov_pres_str,
                          array_to_string(tcc.momento_pres,'','')::varchar as momento_pres_str
                        FROM   param.vtipo_cc_mov  tcc
                         left join param.ttipo_cc tccp on tccp.id_tipo_cc = tcc.id_tipo_cc_fk
				        where   ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice  'Consulta...%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
         #TRANSACCION:  'PM_TCC_CONT'
         #DESCRIPCION:	Conteo de registros
         #AUTOR:		admin
         #FECHA:		26-05-2017 10:10:19
        ***********************************/

    elsif(p_transaccion='PM_TCC_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT count(tcc.id_tipo_cc)
					     FROM   param.vtipo_cc_mov  tcc
                         left join param.ttipo_cc tccp on tccp.id_tipo_cc = tcc.id_tipo_cc_fk
				        where   ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
        #TRANSACCION:  'PM_TCCALL_SEL'
        #DESCRIPCION:	Consulta de datos
        #AUTOR:		admin
        #FECHA:		26-05-2017 10:10:19
       ***********************************/

    elsif(p_transaccion='PM_TCCALL_SEL')then

        begin
            --Sentencia de la consulta
            v_consulta:='SELECT
                          tcc.id_tipo_cc,
                          tcc.codigo,
                          tcc.control_techo,
                          tcc.mov_pres,
                          tcc.estado_reg,
                          tcc.movimiento,
                          tcc.id_ep,
                          tcc.id_tipo_cc_fk,
                          tcc.descripcion,
                          tcc.tipo,
                          tcc.control_partida,
                          tcc.momento_pres,
                          tcc.fecha_reg,
                          tcc.usuario_ai,
                          tcc.id_usuario_reg,
                          tcc.id_usuario_ai,
                          tcc.id_usuario_mod,
                          tcc.fecha_mod,
                          tcc.usr_reg,
                          tcc.usr_mod,
                          tcc.desc_ep,
                          tcc.fecha_inicio,
                          tcc.fecha_final,
                          COALESCE(tccp.codigo,'''')::varchar as codigo_tccp,
                          COALESCE(tccp.descripcion,'''')::varchar as descripcion_tccp
                        FROM   param.vtipo_cc  tcc
                        left join param.ttipo_cc tccp on tccp.id_tipo_cc = tcc.id_tipo_cc_fk
                        WHERE   ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice  'Consulta...%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
         #TRANSACCION:  'PM_TCCALL_CONT'
         #DESCRIPCION:	Conteo de registros
         #AUTOR:		admin
         #FECHA:		26-05-2017 10:10:19
        ***********************************/

    elsif(p_transaccion='PM_TCCALL_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='SELECT count(tcc.id_tipo_cc)
					     FROM   param.vtipo_cc  tcc
                         left join param.ttipo_cc tccp on tccp.id_tipo_cc = tcc.id_tipo_cc_fk
                         WHERE  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
         #TRANSACCION:  'PM_TCCARB_SEL'
         #DESCRIPCION:    Consulta tipos de centro de costo en formato arbol
         #AUTOR:          Rensi Arteaga
         #FECHA:          26-05-2017
        ***********************************/

    elseif(p_transaccion='PM_TCCARB_SEL')then

        begin
            if(v_parametros.node = 'id') then
                v_where := ' tcc.id_tipo_cc_fk is NULL  ';

            else
                v_where := ' tcc.id_tipo_cc_fk = '||v_parametros.node;
            end if;

            v_where_2 = ' and tcc.codigo not like ''X_%'' '; --#44
            if(v_parametros.ceco_vigente='Operativo')then --#150

                v_where_2 := ' and  tcc.operativo = ''si'' ';
            end if;
            if(v_parametros.ceco_vigente='Vigencia')then --#150
                v_where_2 := ' and (tcc.fecha_final >= now()::date  and tcc.fecha_inicio::date <= now()::Date)  ';
            end if;

            v_consulta:='select
                            tcc.id_tipo_cc,
                            tcc.codigo,
                            tcc.control_techo,
                            array_to_string(tcc.mov_pres,'','')::varchar as mov_pres,
                            tcc.estado_reg,
                            tcc.movimiento,
                            tcc.id_ep,
                            tcc.id_tipo_cc_fk,
                            tcc.descripcion,
                            tcc.tipo,
                            tcc.control_partida,
                            array_to_string(tcc.momento_pres,'','')::varchar as momento_pres,
                            tcc.fecha_reg,
                            tcc.usuario_ai,
                            tcc.id_usuario_reg,
                            tcc.id_usuario_ai,
                            tcc.id_usuario_mod,
                            tcc.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            tcc.fecha_inicio,
                            tcc.fecha_final,
                          case
                          when (tcc.movimiento=''si'' )then
                               ''hoja''::varchar
                          when (tcc.movimiento=''no'' )then
                               ''hijo''::varchar
                          END as tipo_nodo ,
                        ep.ep::varchar as desc_ep,
                        tcc.operativo,	--  #33 ++
                        array_to_string(tcc.autorizacion,'','')::varchar as autoriazcion --  #34 ++
						from param.ttipo_cc tcc
                        inner join segu.tusuario usu1 on usu1.id_usuario = tcc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tcc.id_usuario_mod
                        left join param.vep ep on ep.id_ep = tcc.id_ep
				        where  '||v_where|| '
                              and tcc.estado_reg = ''activo''
                              '||v_where_2|| ' --#150
                              ORDER BY tcc.id_tipo_cc';






            --raise notice '%',v_consulta;
            -- RAISE EXCEPTION 'jonathan %',v_consulta;
            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
       #TRANSACCION:  'PM_TCCARBHI_SEL'
       #DESCRIPCION:	Consulta de datos de centro de costos validos transaccionales en gestion del arbol de tipo centro de costos (hijos)
       #AUTOR:		EGS
       #FECHA:		07/12/2018
       ***********************************/

    elsif(p_transaccion='PM_TCCARBHI_SEL')then

        begin
            v_filtro = ' 0=0 ';
            v_select = ' 0 as id_centro_costo,
                             0 as id_gestion ';
            v_join = '';

            IF pxp.f_existe_parametro(p_tabla,'id_gestion') THEN --MDID-11
                v_select = 'cec.id_centro_costo,
                                cec.id_gestion ';
                v_join =' left join param.tcentro_costo cec on cec.id_tipo_cc = arb.id_tipo_cc
                              left join pre.tpresupuesto pre on pre.id_centro_costo = cec.id_centro_costo --#7';
                v_filtro = ' pre.tipo_pres is not null
                                 and cec.id_gestion = '||v_parametros.id_gestion||' ';
            END IF ;

            --Sentencia de la consulta
            v_consulta:='  with recursive arbol_tipo_cc AS (
                                SELECT
                                    tcc.id_tipo_cc,
                                    tcc.id_tipo_cc_fk,
                                    tcc.codigo,
                                    tcc.tipo,
                                    tcc.movimiento,
                                    tcc.descripcion,
                                    tcc.control_techo,
                                    tcc.control_partida
                                FROM param.ttipo_cc tcc
                                WHERE tcc.id_tipo_cc = '||v_parametros.id_tipo_cc||'
                                UNION
                                SELECT
                                    tcce.id_tipo_cc,
                                    tcce.id_tipo_cc_fk,
                                    tcce.codigo,
                                    tcce.tipo,
                                    tcce.movimiento,
                                    tcce.descripcion,
                                    tcce.control_techo,
                                    tcce.control_partida
                                FROM param.ttipo_cc tcce
                                inner join arbol_tipo_cc ar on ar.id_tipo_cc = tcce.id_tipo_cc_fk
                            )
                            select
                                arb.id_tipo_cc,
                                arb.id_tipo_cc_fk,
                                arb.codigo,
                                arb.tipo,
                                arb.movimiento,
                                arb.descripcion,
                                arb.control_techo,
                                arb.control_partida,
                                '||v_select||'
                            from arbol_tipo_cc arb
                           '||v_join||'
                            where  arb.movimiento = ''si'' and '||v_filtro||'
                            order by arb.id_tipo_cc ASC';   --se condiciono que solo considere si tienen un tipo de presupuesto

            --Definicion de la respuesta
            raise notice  'Consulta...%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
        #TRANSACCION:  'PM_TCCARBHI_CONT'
        #DESCRIPCION:	Conteo de datos de centro de costos validos transaccionales en gestion del arbol de tipo centro de costos (hijos)
        #AUTOR:		EGS
        #FECHA:		07/12/2018
        ***********************************/

    elsif(p_transaccion='PM_TCCARBHI_CONT')then

        begin
            v_filtro = ' 0=0 ';
            v_join = '';
            IF pxp.f_existe_parametro(p_tabla,'id_gestion') THEN --MDID-11
                v_join =' left join param.tcentro_costo cec on cec.id_tipo_cc = arb.id_tipo_cc
                              left join pre.tpresupuesto pre on pre.id_centro_costo = cec.id_centro_costo --#7';
                v_filtro = ' pre.tipo_pres is not null
                                 and cec.id_gestion = '||v_parametros.id_gestion||' ';
            END IF ;
            --Sentencia de la consulta de conteo de registros
            v_consulta:='  with recursive arbol_tipo_cc AS (
                                SELECT
                                    tcc.id_tipo_cc,
                                    tcc.id_tipo_cc_fk,
                                    tcc.codigo,
                                    tcc.tipo,
                                    tcc.movimiento,
                                    tcc.descripcion
                                FROM param.ttipo_cc tcc
                                WHERE tcc.id_tipo_cc = '||v_parametros.id_tipo_cc||'
                                UNION
                                SELECT
                                    tcce.id_tipo_cc,
                                    tcce.id_tipo_cc_fk,
                                    tcce.codigo,
                                    tcce.tipo,
                                    tcce.movimiento,
                                    tcce.descripcion
                                FROM param.ttipo_cc tcce
                                inner join arbol_tipo_cc ar on ar.id_tipo_cc = tcce.id_tipo_cc_fk
                            )
                            select
                               count(arb.id_tipo_cc)
                            from arbol_tipo_cc arb
                            '||v_join||'
                            where arb.movimiento = ''si'' and '||v_filtro||' ';

            --Devuelve la respuesta
            return v_consulta;

        end;

        /*********************************
         #TRANSACCION:  'PM_TCCREP_SEL'
         #DESCRIPCION:	Consulta de datos
         #AUTOR:		Yamil Medina
         #FECHA:		07-08-2020 10:10:19
        ***********************************/
        elsif(p_transaccion='PM_TCCREP_SEL')then
            begin
                if (pxp.f_existe_parametro(p_tabla,'id_tipo_cc')) then
                    v_id_tipo_cc = v_parametros.id_tipo_cc;
                end if;
                v_consulta:='  select  total.id_tipo_cc,
                                       total.codigo,
                                       total.descripcion,
                                       htc.id_historico,
                                       htc.fecha_reg,
                                       (htc.datos_antiguo)::text,
                                       (htc.datos_nuevo)::text,
                                       htc.operacion,
                                       (vu.desc_persona)::text,
                                       (total.codigo_padre)::text
                                from (
                         with recursive arbol_tipo_cc AS (
                                    SELECT tcc.id_tipo_cc,
                                           tcc.codigo,
                                           tcc.descripcion,
                                           ''/ ''||tcc.codigo as codigo_padre
                                    FROM param.ttipo_cc tcc ';
                if(v_id_tipo_cc is not null)then
                    v_consulta:=v_consulta||'  WHERE tcc.id_tipo_cc = '||v_id_tipo_cc||' ';
                end if;
                v_consulta:=v_consulta||'
                                    UNION
                                    SELECT tcce.id_tipo_cc,
                                           tcce.codigo,
                                           tcce.descripcion,
                                           ar.codigo_padre || '' / '' || tcce.codigo
                                    FROM param.ttipo_cc tcce
                                         inner join arbol_tipo_cc ar on ar.id_tipo_cc = tcce.id_tipo_cc_fk)
                                select arb.id_tipo_cc,
                                       arb.codigo,
                                       arb.descripcion,
                                       max(arb.codigo_padre) as codigo_padre
                                from arbol_tipo_cc arb
                                group by arb.id_tipo_cc, arb.codigo,arb.descripcion) as total
                                left join param.thistorico_tipo_cc htc on total.id_tipo_cc = htc.id_tipo_cc
                                left join segu.vusuario vu on htc.id_usuario_reg = vu.id_usuario ';
                if (v_parametros.fecha_ini is not null) then
                    v_consulta:=v_consulta||' where htc.fecha_reg::date BETWEEN '' '||v_parametros.fecha_ini||' ''::date AND '' '||v_parametros.fecha_fin||' ''::date ';
                end if;
                v_consulta:=v_consulta||'order by total.id_tipo_cc ASC, htc.id_historico ASC';
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
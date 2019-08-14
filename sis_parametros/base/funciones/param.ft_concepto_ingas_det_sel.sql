--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_concepto_ingas_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Parametros Generales
 FUNCION:         param.ft_concepto_ingas_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tconcepto_ingas_det'
 AUTOR:          (admin)
 FECHA:            22-07-2019 14:37:28
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                 AUTOR                DESCRIPCION
#39 ETR               EGS                   31/07/2019           Creacion #
#48 ETR               EGS                   14/08/2019           Se Creo la logica para columnas dinamicas   y se creo solo el combo
 ***************************************************************************/

DECLARE

    v_consulta              varchar;
    v_parametros            record;
    v_nombre_funcion        text;
    v_resp                  varchar;
    v_columnas_extra        varchar;
    v_record                record;
    v_columnas_extra_sel    varchar;
    v_consulta_cmp          varchar;
    v_consulta_value        varchar;
    v_columna               record;
    v_consulta_into         varchar;
    v_registros             record;
    v_count                 integer;
    v_count_value           integer;
    v_valor                 varchar;

BEGIN

    v_nombre_funcion = 'param.ft_concepto_ingas_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
     #TRANSACCION:  'PM_COIND_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        admin
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    if(p_transaccion='PM_COIND_SEL')then

        begin
            v_columnas_extra = '';
            v_columnas_extra_sel ='';

            FOR v_record IN(
                SELECT
                     cl.nombre_columna,
                     cl.tipo_dato
                FROM  param.tcolumna cl
                order by cl.nombre_columna  asc --ordenamos lbabeticamente
            )LOOP
                v_columnas_extra = v_columnas_extra||v_record.nombre_columna||'  '|| v_record.tipo_dato||',';
                v_columnas_extra_sel = v_columnas_extra_sel||'coind.'||v_record.nombre_columna||',';
            END LOOP;
                v_columnas_extra_sel = SUBSTRING (v_columnas_extra_sel,1,length(v_columnas_extra_sel) - 1);
            v_consulta ='CREATE TEMPORARY TABLE temp_t_concepto_ingas_det(
                                      id_usuario_reg INTEGER,
                                      id_usuario_mod INTEGER,
                                      fecha_reg TIMESTAMP,
                                      fecha_mod TIMESTAMP,
                                      estado_reg VARCHAR,
                                      id_usuario_ai INTEGER,
                                      usuario_ai VARCHAR,
                                      id_concepto_ingas_det integer,
                                      nombre VARCHAR,
                                      descripcion VARCHAR,
                                      id_concepto_ingas INTEGER,
                                      id_concepto_ingas_det_fk INTEGER,
                                      '||COALESCE(v_columnas_extra,'')||'
                                      agrupador VARCHAR
                                     ) ON COMMIT DROP';
            EXECUTE v_consulta;
            FOR v_record IN(
                select
                            coind.id_concepto_ingas_det,
                            coind.estado_reg,
                            coind.nombre,
                            coind.descripcion,
                            coind.id_concepto_ingas,
                            coind.id_usuario_reg,
                            coind.fecha_reg,
                            coind.id_usuario_ai,
                            coind.usuario_ai,
                            coind.id_usuario_mod,
                            coind.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            coind.agrupador,
                            coind.id_concepto_ingas_det_fk
                            from param.tconcepto_ingas_det coind
                            inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                            left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod

            )LOOP


                        v_consulta_cmp='';
                        v_consulta_value='';
                        --seleccionamos los valores por registro
                            FOR v_columna IN(
                            --recuperamos los campos
                                 SELECT
                                      cl.nombre_columna,
                                      cl.tipo_dato
                                 FROM param.tcolumna cl
                                 order by cl.nombre_columna asc --ordenamos lbabeticamente
                              )LOOP
                                    --nombre de campos
                                    v_consulta_cmp = v_consulta_cmp||v_columna.nombre_columna||' ,';
                                    --valor de campos
                                    IF v_columna.tipo_dato = 'varchar' or v_columna.tipo_dato = 'text'  THEN
                                    v_consulta_value = v_consulta_value||''''',';
                                    ELSE
                                    v_consulta_value = v_consulta_value||'null,';
                                    END IF;
                             END LOOP;

                             IF EXISTS (SELECT
                                  1
                             FROM param.tcolumna_concepto_ingas_det cld
                             Left join param.tcolumna cl on cl.id_columna = cld.id_columna
                             WHERE cld.id_concepto_ingas_det = v_record.id_concepto_ingas_det
                             order by cl.nombre_columna asc) THEN
                                       v_consulta_value='';
                                       FOR v_columna IN(
                                           --recuperamos las columnas
                                            SELECT
                                                cl.id_columna,
                                                cl.nombre_columna,
                                                lower(cl.tipo_dato) as tipo_dato
                                           FROM param.tcolumna cl
                                           order by cl.nombre_columna asc
                                           --ordenamos albabeticamente
                                        )LOOP
                                               SELECT
                                                 cld.valor
                                               INTO
                                                    v_valor
                                               FROM param.tcolumna_concepto_ingas_det cld
                                               Left join param.tcolumna cl on cl.id_columna = cld.id_columna
                                               WHERE    cld.id_concepto_ingas_det = v_record.id_concepto_ingas_det and
                                                        cld.id_columna = v_columna.id_columna;

                                              --valor de campos
                                              IF v_columna.tipo_dato = 'varchar' or v_columna.tipo_dato = 'text' or v_columna.tipo_dato = 'date' or v_columna.tipo_dato ='timestamp'  THEN
                                              v_consulta_value = v_consulta_value||''''||COALESCE(v_valor::varchar,'')||''' ,';
                                              ELSE
                                              v_consulta_value = v_consulta_value||COALESCE(v_valor::varchar,'null')||' ,';
                                              END IF;
                                       END LOOP;


                             END IF;
                            v_record.descripcion = REPLACE(v_record.descripcion,E'\n', '');
                            --v_record.descripcion = REPLACE(v_record.descripcion,'"', '');
                            v_record.descripcion = REPLACE(v_record.descripcion,'''', '');
                            v_record.nombre = REPLACE(v_record.nombre,E'\n', '');
                            --v_record.nombre = REPLACE(v_record.nombre,'"', '');
                            v_record.nombre = REPLACE(v_record.nombre,'''', '');
                            v_consulta_into = '
                             insert into temp_t_concepto_ingas_det(
                                    id_concepto_ingas_det,
                                    estado_reg,
                                    nombre,
                                    descripcion,
                                    id_concepto_ingas,
                                    id_usuario_reg,
                                    fecha_reg,
                                    id_usuario_ai,
                                    usuario_ai,
                                    id_usuario_mod,
                                    fecha_mod,
                                    agrupador,
                                    '||COALESCE(v_consulta_cmp,'')||'
                                    id_concepto_ingas_det_fk
                                      ) values(
                                    '||COALESCE(v_record.id_concepto_ingas_det::VARCHAR,'null')||',
                                    '||COALESCE(''''||v_record.estado_reg::VARCHAR||'''','null')||',
                                    '||COALESCE(''''||v_record.nombre::VARCHAR||'''','null')||',
                                    '||COALESCE(''''||v_record.descripcion::VARCHAR||'''','null')||',
                                    '||COALESCE(v_record.id_concepto_ingas::VARCHAR,'null')||',
                                    '||COALESCE(v_record.id_usuario_reg::VARCHAR,'null')||',
                                    '||COALESCE(''''||v_record.fecha_reg::VARCHAR||'''','null')||',
                                    '||COALESCE(v_record.id_usuario_ai::VARCHAR,'null')||',
                                    '||COALESCE(v_record.usuario_ai::VARCHAR,'null')||',
                                    '||COALESCE(v_record.id_usuario_mod::VARCHAR,'null')||',
                                    '||COALESCE(''''||v_record.fecha_mod::VARCHAR||'''','null')||',
                                    '||COALESCE(''''||v_record.agrupador::VARCHAR||'''','null')||',
                                    '||COALESCE(v_consulta_value::VARCHAR,'null')||'
                                    '||COALESCE(v_record.id_concepto_ingas_det_fk::VARCHAR,'null')||'
                                    )';

                    EXECUTE(v_consulta_into);
            END LOOP;

            --Sentencia de la consulta
            v_consulta:='select
                        coind.id_concepto_ingas_det,
                        coind.estado_reg,
                        coind.nombre,
                        coind.descripcion,
                        coind.id_concepto_ingas,
                        coind.id_usuario_reg,
                        coind.fecha_reg,
                        coind.id_usuario_ai,
                        coind.usuario_ai,
                        coind.id_usuario_mod,
                        coind.fecha_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod,
                        coind.agrupador,
                        coind.id_concepto_ingas_det_fk,
                        cid.nombre as desc_agrupador,
                        '||COALESCE(v_columnas_extra_sel,'')||'
                        from temp_t_concepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        left join param.tconcepto_ingas_det cid on cid.id_concepto_ingas_det = coind.id_concepto_ingas_det_fk
                        where  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            --raise exception 'v_consulta %',v_consulta;

            if pxp.f_existe_parametro(p_tabla, 'groupBy') THEN
                --raise exception 'groupBy % ',v_parametros.groupBy;
                v_consulta:=v_consulta||' order by ' ||v_parametros.groupBy|| ' ' ||v_parametros.groupDir|| ', ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
             else
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
            end if;
            --Devuelve la respuesta
            raise notice 'v_consulta %',v_consulta;
            return v_consulta ;
        end;

    /*********************************
     #TRANSACCION:  'PM_COIND_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COIND_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(coind.id_concepto_ingas_det)
                        from param.tconcepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        where ';
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            --Devuelve la respuesta
            return v_consulta ;

        end;
    /*********************************
     #TRANSACCION:  'PM_COINDCB_SEL'
     #DESCRIPCION:    Consulta de datos combo
     #AUTOR:        admin
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COINDCB_SEL')then

        begin

            --Sentencia de la consulta
            v_consulta:='select
                        coind.id_concepto_ingas_det,
                        coind.estado_reg,
                        coind.nombre,
                        coind.descripcion,
                        coind.id_concepto_ingas,
                        coind.agrupador,
                        coind.id_concepto_ingas_det_fk,
                        cid.nombre as desc_agrupador
                        from param.tconcepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        left join param.tconcepto_ingas_det cid on cid.id_concepto_ingas_det = coind.id_concepto_ingas_det_fk
                        where  ';

            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
            raise notice 'v_consulta %',v_consulta;
            return v_consulta ;
        end;
     /*********************************
     #TRANSACCION:  'PM_COINDCB_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        admin
     #FECHA:        22-07-2019 14:37:28
    ***********************************/

    elsif(p_transaccion='PM_COINDCB_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(coind.id_concepto_ingas_det)
                        from param.tconcepto_ingas_det coind
                        inner join segu.tusuario usu1 on usu1.id_usuario = coind.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = coind.id_usuario_mod
                        where ';
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            --Devuelve la respuesta
            return v_consulta ;

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
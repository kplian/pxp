--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_concepto_ingas_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_concepto_ingas_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tconcepto_ingas'
 AUTOR: 		 (admin)
 FECHA:	        25-02-2013 19:49:23
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
    v_filtro 			varchar;
    v_autorizacion_nulos	varchar;

BEGIN

	v_nombre_funcion = 'param.f_concepto_ingas_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PM_CONIG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	if(p_transaccion='PM_CONIG_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						conig.id_concepto_ingas,
						conig.desc_ingas,
						conig.tipo,
						conig.movimiento,
                        conig.sw_tes,
						conig.id_oec,
						conig.estado_reg,
						conig.id_usuario_reg,
						conig.fecha_reg,
						conig.fecha_mod,
						conig.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						conig.activo_fijo,
						conig.almacenable,
                        array_to_string( conig.id_grupo_ots,'','',''null'')::varchar,
                        conig.filtro_ot,
                        conig.requiere_ot,
                        array_to_string( conig.sw_autorizacion, '','',''null'')::varchar,
                        conig.id_entidad,
                        conig.descripcion_larga,
                        conig.id_unidad_medida,
                        um.codigo as  desc_unidad_medida,
                        conig.nandina,
                        COALESCE(conig.ruta_foto,'''')::Varchar as ruta_foto,
                        conig.id_cat_concepto,
                        (cc.codigo ||'' - ''||cc.nombre)::varchar as desc_cat_concepto

                        from param.tconcepto_ingas conig
						inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                        left join param.tunidad_medida um on um.id_unidad_medida = conig.id_unidad_medida
						left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
                        left join param.tcat_concepto cc on cc.id_cat_concepto = conig.id_cat_concepto
				        where conig.estado_reg = ''activo''  and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            rAISE NOTICE '%', v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONIG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_concepto_ingas)
					    from param.tconcepto_ingas conig
						inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                        left join param.tunidad_medida um on um.id_unidad_medida = conig.id_unidad_medida
						left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
                        left join param.tcat_concepto cc on cc.id_cat_concepto = conig.id_cat_concepto
				        where conig.estado_reg = ''activo'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
     /*********************************
 	#TRANSACCION:  'PM_CONIGPAR_SEL'
 	#DESCRIPCION:	listado de conceptos de gatos con partidas prespeustaria
 	#AUTOR:		rac
 	#FECHA:		20-06-2014 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIGPAR_SEL')then

    	begin

            v_filtro = '';

            IF  pxp.f_existe_parametro(p_tabla,'autorizacion_nulos') THEN
               v_autorizacion_nulos =  v_parametros.autorizacion_nulos;
            ELSE
               v_autorizacion_nulos = 'si';
            END IF;

           --RAC, 1/7/2015 solo por el tema de regularizaciones lso administradores no  tenian filtros
           -- IF  p_administrador != 1 THEN
               IF pxp.f_existe_parametro(p_tabla,'autorizacion')THEN
                   IF v_autorizacion_nulos = 'si' THEN
                    v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion) or conig.sw_autorizacion is null ) and ';
                   ELSE
                     v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion)) and ';
                   END IF;
                END IF;
            -- END IF;



            --Sentencia de la consulta
			v_consulta:='select
                          conig.id_concepto_ingas,
                          conig.desc_ingas,
                          conig.tipo,
                          conig.movimiento,
                          conig.sw_tes,
                          conig.id_oec,
                          conig.estado_reg,
                          conig.id_usuario_reg,
                          conig.fecha_reg,
                          conig.fecha_mod,
                          conig.id_usuario_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod,
                          conig.activo_fijo,
                          conig.almacenable,
                          par.codigo||'' ''||par.nombre_partida as desc_partida,
                          array_to_string( conig.id_grupo_ots,'','',''null'')::varchar,
                          conig.filtro_ot,
                          conig.requiere_ot,
                          array_to_string( conig.sw_autorizacion, '','',''null'')::varchar
                        from param.tconcepto_ingas conig
                          inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                          inner join pre.tpartida par on par.id_partida = cp.id_partida
                          inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
				        where  conig.estado_reg = ''activo'' and '||v_filtro;

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice 'consulta >>>> % <<<<',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONIGPAR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac
 	#FECHA:		20-06-2014 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIGPAR_CONT')then

		begin

            v_filtro = '';

            IF  pxp.f_existe_parametro(p_tabla,'autorizacion_nulos') THEN
               v_autorizacion_nulos =  v_parametros.autorizacion_nulos;
            ELSE
               v_autorizacion_nulos = 'si';
            END IF;


            IF  p_administrador != 1 THEN
               IF pxp.f_existe_parametro(p_tabla,'autorizacion')THEN
                   IF v_autorizacion_nulos = 'si' THEN
                    v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion) or conig.sw_autorizacion is null ) and ';
                   ELSE
                     v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion)) and ';
                   END IF;
                END IF;
             END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(conig.id_concepto_ingas)
					      from param.tconcepto_ingas conig
                          inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                          inner join pre.tpartida par on par.id_partida = cp.id_partida
                          inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
				        where  conig.estado_reg = ''activo'' and '||v_filtro;

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONIGPP_SEL'
 	#DESCRIPCION:	Consulta de datos conmceptos de gasto filtrados por partidas
 	#AUTOR:		admin
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elseif(p_transaccion='PM_CONIGPP_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                               distinct
                               conig.id_concepto_ingas,
                               conig.desc_ingas,
                               conig.tipo,
                               conig.movimiento,
                               conig.sw_tes,
                               conig.id_oec,
                               conig.estado_reg,
                               conig.id_usuario_reg,
                               conig.fecha_reg,
                               conig.fecha_mod,
                               conig.id_usuario_mod,
                               usu1.cuenta as usr_reg,
                               usu2.cuenta as usr_mod,
                               conig.activo_fijo,
							   conig.almacenable
                        from param.tconcepto_ingas conig
                             inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                             left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
                             inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                             and cp.id_partida in ('||COALESCE(v_parametros.id_partidas,'0')||')
				        where  conig.estado_reg = ''activo'' and ';



			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;


             raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'PM_CONIGPARGES_SEL'
 	#DESCRIPCION:	Consulta de datos conceptos de gasto partidas por gestion
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		01-12-2016
	***********************************/

	elseif(p_transaccion='PM_CONIGPARGES_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select cg.desc_ingas,  par.codigo, par.nombre_partida, par.descripcion, cg.movimiento,
            			par.sw_movimiento as tipo_partida, cg.tipo, cg.activo_fijo, cg.almacenable,
                        case cg.requiere_ot when ''obligatorio'' then ''si''::varchar else ''no''::varchar end as exige_ot,
                        array_to_string(cg.sw_autorizacion,'','')::text as sistemas
                        from param.tconcepto_ingas cg
                        inner join pre.tconcepto_partida cp on cp.id_concepto_ingas=cg.id_concepto_ingas
                        inner join pre.tpartida par on par.id_partida=cp.id_partida
                        inner join param.tgestion ges on ges.id_gestion=par.id_gestion
                        where ges.id_gestion='||v_parametros.id_gestion||' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

             raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONIGPP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIGPP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(conig.id_concepto_ingas)
					     from param.tconcepto_ingas conig
                             inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                             left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
                             inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                             and cp.id_partida in ('||COALESCE(v_parametros.id_partidas,'0')||')
				        where conig.estado_reg = ''activo'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'PM_CONIGPRE_SEL'
 	#DESCRIPCION:	listado de conceptos de gatos filtrados por presupuesto
 	#AUTOR:		RAC	(KPIAN)
 	#FECHA:		07-03-2016 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIGPRE_SEL')then

    	begin

            v_filtro = '';
            --raise exception 'ss';

            IF  pxp.f_existe_parametro(p_tabla,'autorizacion_nulos') THEN
               v_autorizacion_nulos =  v_parametros.autorizacion_nulos;
            ELSE
               v_autorizacion_nulos = 'si';
            END IF;

           --RAC, 1/7/2015 solo por el tema de regularizaciones lso administradores no  tenian filtros
           -- IF  p_administrador != 1 THEN
               IF pxp.f_existe_parametro(p_tabla,'autorizacion')THEN
                   IF v_autorizacion_nulos = 'si' THEN
                    v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion) or conig.sw_autorizacion is null ) and ';
                   ELSE
                     v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion)) and ';
                   END IF;
                END IF;
            -- END IF;

            --Sentencia de la consulta
			v_consulta:='select
                          conig.id_concepto_ingas,
                          conig.desc_ingas,
                          conig.tipo,
                          conig.movimiento,
                          conig.sw_tes,
                          conig.id_oec,
                          conig.estado_reg,
                          conig.id_usuario_reg,
                          conig.fecha_reg,
                          conig.fecha_mod,
                          conig.id_usuario_mod,
                          usu1.cuenta as usr_reg,
                          usu2.cuenta as usr_mod,
                          conig.activo_fijo,
                          conig.almacenable,
                          par.codigo||'' ''||par.nombre_partida as desc_partida,
                          array_to_string( conig.id_grupo_ots,'','',''null'')::varchar,
                          conig.filtro_ot,
                          conig.requiere_ot,
                          array_to_string( conig.sw_autorizacion, '','',''null'')::varchar,
                          ges.gestion::varchar as desc_gestion
                         from param.tconcepto_ingas conig

                            inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                            inner join pre.tpartida par on par.id_partida = cp.id_partida
                            inner join param.tgestion ges on ges.id_gestion = par.id_gestion
                            inner join pre.tpresup_partida pp on pp.id_partida = par.id_partida
                            inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                            left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
				        where    pp.id_presupuesto = '|| v_parametros.id_presupuesto||'
                             and conig.estado_reg = ''activo'' and '||v_filtro;

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice 'consulta >>>> % <<<<',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PM_CONIGPRE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac
 	#FECHA:		20-06-2014 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIGPRE_CONT')then

		begin

            v_filtro = '';

            IF  pxp.f_existe_parametro(p_tabla,'autorizacion_nulos') THEN
               v_autorizacion_nulos =  v_parametros.autorizacion_nulos;
            ELSE
               v_autorizacion_nulos = 'si';
            END IF;


            IF  p_administrador != 1 THEN
               IF pxp.f_existe_parametro(p_tabla,'autorizacion')THEN
                   IF v_autorizacion_nulos = 'si' THEN
                    v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion) or conig.sw_autorizacion is null ) and ';
                   ELSE
                     v_filtro = '('''||v_parametros.autorizacion||''' = ANY (conig.sw_autorizacion)) and ';
                   END IF;
                END IF;
             END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(DISTINCT(conig.id_concepto_ingas))
					       from param.tconcepto_ingas conig

                            inner join pre.tconcepto_partida cp on cp.id_concepto_ingas = conig.id_concepto_ingas
                            inner join pre.tpartida par on par.id_partida = cp.id_partida
                            inner join param.tgestion ges on ges.id_gestion = par.id_gestion
                            inner join pre.tpresup_partida pp on pp.id_partida = par.id_partida
                            inner join segu.tusuario usu1 on usu1.id_usuario = conig.id_usuario_reg
                            left join segu.tusuario usu2 on usu2.id_usuario = conig.id_usuario_mod
				        where pp.id_presupuesto = '|| v_parametros.id_presupuesto||'  and  conig.estado_reg = ''activo'' and '||v_filtro;

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
 	#TRANSACCION:  'PM_CONIGPARGES_CONT'
 	#DESCRIPCION:	Conteo de datos conceptos de gasto partidas por gestion
 	#AUTOR:		Gonzalo Sarmiento
 	#FECHA:		01-12-2016
	***********************************/

	elseif(p_transaccion='PM_CONIGPARGES_CONT')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select count(cg.desc_ingas)
                        from param.tconcepto_ingas cg
                        inner join pre.tconcepto_partida cp on cp.id_concepto_ingas=cg.id_concepto_ingas
                        inner join pre.tpartida par on par.id_partida=cp.id_partida
                        inner join param.tgestion ges on ges.id_gestion=par.id_gestion
                        where ges.id_gestion='||v_parametros.id_gestion||' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

             raise notice '%',v_consulta;
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
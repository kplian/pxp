CREATE OR REPLACE FUNCTION orga.ft_certificado_planilla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_certificado_planilla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tcertificado_planilla'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        24-07-2017 14:48:34
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
    v_iniciales			varchar;

BEGIN

	v_nombre_funcion = 'orga.ft_certificado_planilla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'OR_PLANC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	if(p_transaccion='OR_PLANC_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
      planc.id_certificado_planilla,
      planc.tipo_certificado,
      planc.fecha_solicitud,
     planc.beneficiario,
      planc.id_funcionario,
      planc.estado_reg,
      planc.importe_viatico,
      planc.id_usuario_ai,
      planc.fecha_reg,
      planc.usuario_ai,
      planc.id_usuario_reg,
      planc.fecha_mod,
      planc.id_usuario_mod,
      usu1.cuenta as usr_reg,
      usu2.cuenta as usr_mod,
      f.desc_funcionario1,
      planc.nro_tramite,
      planc.estado,
      planc.id_proceso_wf,
      planc.id_estado_wf,
      f.nombre_cargo,
      pe.ci,
      es.haber_basico,
      pe.expedicion
      from orga.tcertificado_planilla planc
      inner join segu.tusuario usu1 on usu1.id_usuario = planc.id_usuario_reg
      inner join orga.vfuncionario_cargo f on f.id_funcionario = planc.id_funcionario and (f.fecha_finalizacion is null or f.fecha_finalizacion >= now()::date)
      inner join orga.tcargo car on car.id_cargo = f.id_cargo
      inner join orga.tescala_salarial es on es.id_escala_salarial =car.id_escala_salarial
      inner join orga.tfuncionario fon on fon.id_funcionario = planc.id_funcionario
      inner join segu.tpersona pe on pe .id_persona = fon.id_persona
      left join segu.tusuario usu2 on usu2.id_usuario = planc.id_usuario_mod
      where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'OR_PLANC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_PLANC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_certificado_planilla)

                         from orga.tcertificado_planilla planc
      inner join segu.tusuario usu1 on usu1.id_usuario = planc.id_usuario_reg
      inner join orga.vfuncionario_cargo f on f.id_funcionario = planc.id_funcionario --and f.fecha_finalizacion is null
      inner join orga.tcargo car on car.id_cargo = f.id_cargo
      inner join orga.tescala_salarial es on es.id_escala_salarial =car.id_escala_salarial
      inner join orga.tfuncionario fon on fon.id_funcionario = planc.id_funcionario
      inner join segu.tpersona pe on pe .id_persona = fon.id_persona
      left join segu.tusuario usu2 on usu2.id_usuario = planc.id_usuario_mod
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

        /*********************************
 	#TRANSACCION:  'OR_CERT_REP'
 	#DESCRIPCION:	Reporte
 	#AUTOR:		miguel.mamani
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_CERT_REP')then

		begin
        select orga.f_iniciales_funcionarios(p.desc_funcionario1)
        into
        v_iniciales
        from segu.tusuario u
        inner join orga.vfuncionario_persona p on p.id_persona = u.id_persona
        where u.id_usuario = p_id_usuario;



        v_consulta:='select  initcap (fu.desc_funcionario1) as  nombre_funcionario,
                              fu.nombre_cargo,
                              plani.f_get_fecha_primer_contrato_empleado(fu.id_uo_funcionario, fu.id_funcionario, fu.fecha_asignacion) as fecha_contrato,
                              round(es.haber_basico + round(plani.f_evaluar_antiguedad(plani.f_get_fecha_primer_contrato_empleado(fu.id_uo_funcionario, fu.id_funcionario, fu.fecha_asignacion), c.fecha_solicitud::date, fun.antiguedad_anterior), 2)) as haber_basico,
                              pe.ci,
                              pe.expedicion,
                              CASE
                              WHEN pe.genero::text = ANY (ARRAY[''varon''::character varying,''VARON''::character varying, ''Varon''::character varying]::text[]) THEN ''Sr''::text
                              WHEN pe.genero::text = ANY (ARRAY[''mujer''::character varying,''MUJER''::character varying, ''Mujer''::character varying]::text[]) THEN ''Sra''::text
                              ELSE ''''::text
                              END::character varying AS genero,
                              c.fecha_solicitud,
                              ger.nombre_unidad,
                              initcap  (mat.f_primer_letra_mayuscula( pxp.f_convertir_num_a_letra( round(es.haber_basico + round(plani.f_evaluar_antiguedad(plani.f_get_fecha_primer_contrato_empleado(fu.id_uo_funcionario, fu.id_funcionario, fu.fecha_asignacion), c.fecha_solicitud::date, fun.antiguedad_anterior), 2)))))::varchar as haber_literal,
                              (select initcap( cart.desc_funcionario1)
                              from orga.vfuncionario_cargo cart
                              where cart.nombre_cargo = ''Jefe Recursos Humanos'') as jefa_recursos,
                              c.tipo_certificado,
                              c.importe_viatico,
                              initcap  (mat.f_primer_letra_mayuscula( pxp.f_convertir_num_a_letra(c.importe_viatico)))::varchar as literal_importe_viatico,
                              c.nro_tramite,
                              '''||v_iniciales||'''::varchar as iniciales
                              from orga.tcertificado_planilla c
                              inner join orga.vfuncionario_cargo  fu on fu.id_funcionario = c.id_funcionario and (fu.fecha_finalizacion is null or fu.fecha_finalizacion >=  now()::date )
                              inner join orga.tcargo ca on ca.id_cargo = fu.id_cargo
                              inner join orga.tescala_salarial es on es.id_escala_salarial = ca.id_escala_salarial
                              inner join orga.tfuncionario fun on fun.id_funcionario = fu.id_funcionario
                              inner join segu.tpersona pe on pe.id_persona = fun.id_persona
                              JOIN orga.tuo ger ON ger.id_uo = orga.f_get_uo_gerencia(fu.id_uo, NULL::integer, NULL::date)
                              where c.id_proceso_wf ='||v_parametros.id_proceso_wf;
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_aprobador_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_aprobador_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.taprobador'
 AUTOR: 		 (admin)
 FECHA:	        09-01-2013 21:58:35
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
			    
BEGIN

	v_nombre_funcion = 'param.f_aprobador_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_APRO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		09-01-2013 21:58:35
	***********************************/

	if(p_transaccion='PM_APRO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						apro.id_aprobador,
						apro.estado_reg,
						apro.id_centro_costo,
						apro.monto_min,
						apro.id_funcionario,
						apro.obs,
						apro.id_uo,
						apro.fecha_ini,
						apro.monto_max,
						apro.fecha_fin,
						apro.id_subsistema,
						apro.fecha_reg,
						apro.id_usuario_reg,
						apro.fecha_mod,
						apro.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        cc.codigo_cc as desc_cc,
                        uo.codigo ||''-''||  uo.nombre_unidad as desc_uo,
                        apro.id_ep,
                        ep.ep as desc_ep,
                        fun.desc_funcionario1 as desc_funcionario,
                        sub.nombre as desc_subsistema,
                        apro.id_uo_cargo,
                        uoc.codigo ||''-''||  uoc.nombre_cargo as desc_uo_cargo,
                        apro.id_proceso_macro,
                        pm.nombre as desc_proceso_macro
                       	from param.taprobador apro
						inner join segu.tusuario usu1 on usu1.id_usuario = apro.id_usuario_reg
						inner join segu.tsubsistema sub on sub.id_subsistema = apro.id_subsistema
                        left join wf.tproceso_macro pm  on pm.id_proceso_macro = apro.id_proceso_macro
                        left join orga.vfuncionario fun on fun.id_funcionario = apro.id_funcionario
                        left join orga.tuo uoc on uoc.id_uo = apro.id_uo_cargo
                        left join orga.tuo uo on uo.id_uo = apro.id_uo
                        left join param.vep ep on ep.id_ep = apro.id_ep
                        left join param.vcentro_costo cc on cc.id_centro_costo = apro.id_centro_costo
                        left join segu.tusuario usu2 on usu2.id_usuario = apro.id_usuario_mod
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_APRO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		09-01-2013 21:58:35
	***********************************/

	elsif(p_transaccion='PM_APRO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_aprobador)
					    from param.taprobador apro
						inner join segu.tusuario usu1 on usu1.id_usuario = apro.id_usuario_reg
						inner join segu.tsubsistema sub on sub.id_subsistema = apro.id_subsistema
                        left join wf.tproceso_macro pm  on pm.id_proceso_macro = apro.id_proceso_macro
                        left join orga.vfuncionario fun on fun.id_funcionario = apro.id_funcionario
                        left join orga.tuo uoc on uoc.id_uo = apro.id_uo_cargo
                        left join orga.tuo uo on uo.id_uo = apro.id_uo
                        left join param.vep ep on ep.id_ep = apro.id_ep
                        left join param.vcentro_costo cc on cc.id_centro_costo = apro.id_centro_costo
                        left join segu.tusuario usu2 on usu2.id_usuario = apro.id_usuario_mod
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
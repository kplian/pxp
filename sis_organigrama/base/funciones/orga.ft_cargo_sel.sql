CREATE OR REPLACE FUNCTION orga.ft_cargo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_cargo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tcargo'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 19:16:06
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
	v_ids_cargo			varchar;
			    
BEGIN

	v_nombre_funcion = 'orga.ft_cargo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CARGO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:16:06
	***********************************/

	if(p_transaccion='OR_CARGO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						cargo.id_cargo,
						cargo.id_uo,
						cargo.id_tipo_contrato,
						cargo.id_lugar,
						cargo.id_temporal_cargo,
						cargo.id_escala_salarial,
						cargo.codigo,
						cargo.nombre,
						cargo.fecha_ini,
						cargo.estado_reg,
						cargo.fecha_fin,
						cargo.fecha_reg,
						cargo.id_usuario_reg,
						cargo.fecha_mod,
						cargo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						tipcon.nombre,
						escsal.nombre,
						ofi.nombre,
						(case when (orga.f_get_empleado_x_item(cargo.id_cargo)  is null and cargo.fecha_fin is null) then
						  ''ACEFALO''
						else
						  ''ASIGNADO''
						end)::varchar as acefalo,
						cargo.id_oficina,
						cargo.id_cargo as identificador,
						tipcon.codigo as codigo_tipo_contrato
						from orga.tcargo cargo
						inner join segu.tusuario usu1 on usu1.id_usuario = cargo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cargo.id_usuario_mod
						inner join orga.ttipo_contrato tipcon on tipcon.id_tipo_contrato = cargo.id_tipo_contrato
						inner join orga.tescala_salarial escsal on escsal.id_escala_salarial = cargo.id_escala_salarial
						left join orga.toficina ofi on ofi.id_oficina = cargo.id_oficina
				        where cargo.estado_reg = ''activo'' and  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			
			if (pxp.f_existe_parametro(p_tabla, 'tipo') and
				pxp.f_existe_parametro(p_tabla, 'fecha') and 
				pxp.f_existe_parametro(p_tabla, 'id_uo')) then
				if (v_parametros.tipo is not null and v_parametros.tipo = 'oficial' and v_parametros.fecha is not null and v_parametros.id_uo is not null) then
					v_ids_cargo = orga.f_get_cargos_en_uso(v_parametros.id_uo, v_parametros.fecha);
					v_consulta := v_consulta || ' and cargo.id_cargo not in (' || v_ids_cargo ||') ';
					v_consulta := v_consulta || ' and (cargo.fecha_fin > ''' || v_parametros.fecha || ''' or cargo.fecha_fin is null) ';
				end if;
			end if;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARGO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:16:06
	***********************************/

	elsif(p_transaccion='OR_CARGO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cargo)
					    from orga.tcargo cargo
					    inner join segu.tusuario usu1 on usu1.id_usuario = cargo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cargo.id_usuario_mod
						inner join orga.ttipo_contrato tipcon on tipcon.id_tipo_contrato = cargo.id_tipo_contrato
						inner join orga.tescala_salarial escsal on escsal.id_escala_salarial = cargo.id_escala_salarial
						left join orga.toficina ofi on ofi.id_oficina = cargo.id_oficina
					    where cargo.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;
			
			if (pxp.f_existe_parametro(p_tabla, 'tipo') and
				pxp.f_existe_parametro(p_tabla, 'fecha') and 
				pxp.f_existe_parametro(p_tabla, 'id_uo')) then
				if (v_parametros.tipo is not null and v_parametros.tipo = 'oficial' and v_parametros.fecha is not null and v_parametros.id_uo is not null) then
					v_ids_cargo = orga.f_get_cargos_en_uso(v_parametros.id_uo, v_parametros.fecha);
					v_consulta := v_consulta || ' and cargo.id_cargo not in (' || v_ids_cargo ||') ';
					v_consulta := v_consulta || ' and (cargo.fecha_fin > ''' || v_parametros.fecha || ''' or cargo.fecha_fin is null) ';
				end if;
			end if;

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
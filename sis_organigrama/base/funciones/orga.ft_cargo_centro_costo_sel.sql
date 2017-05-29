CREATE OR REPLACE FUNCTION orga.ft_cargo_centro_costo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_cargo_centro_costo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tcargo_centro_costo'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 13:05:35
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

	v_nombre_funcion = 'orga.ft_cargo_centro_costo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CARCC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:05:35
	***********************************/

	if(p_transaccion='OR_CARCC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						carpre.id_cargo_centro_costo,
						carpre.id_cargo,
						carpre.id_gestion,
						carpre.id_centro_costo,
						carpre.porcentaje,
						carpre.fecha_ini,
						carpre.estado_reg,
						carpre.id_usuario_reg,
						carpre.fecha_reg,
						carpre.fecha_mod,
						carpre.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						cc.codigo_cc,
                        carpre.id_ot,
                        ot.desc_orden
						from orga.tcargo_centro_costo carpre
						inner join segu.tusuario usu1 on usu1.id_usuario = carpre.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = carpre.id_usuario_mod
						left join conta.torden_trabajo ot on ot.id_orden_trabajo = carpre.id_ot
                        inner join param.vcentro_costo cc on cc.id_centro_costo = carpre.id_centro_costo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARCC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:05:35
	***********************************/

	elsif(p_transaccion='OR_CARCC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cargo_centro_costo)
					    from orga.tcargo_centro_costo carpre
					    inner join segu.tusuario usu1 on usu1.id_usuario = carpre.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = carpre.id_usuario_mod
						left join conta.torden_trabajo ot on ot.id_orden_trabajo = carpre.id_ot
                        inner join param.vcentro_costo cc on cc.id_centro_costo = carpre.id_centro_costo
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
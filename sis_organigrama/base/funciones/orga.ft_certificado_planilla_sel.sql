CREATE OR REPLACE FUNCTION "orga"."ft_certificado_planilla_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
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
						usu2.cuenta as usr_mod	
						from orga.tcertificado_planilla planc
						inner join segu.tusuario usu1 on usu1.id_usuario = planc.id_usuario_reg
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
						left join segu.tusuario usu2 on usu2.id_usuario = planc.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "orga"."ft_certificado_planilla_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION param.ft_proveedor_cta_bancaria_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_proveedor_cta_bancaria_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tproveedor_cta_bancaria'
 AUTOR: 		 (gsarmiento)
 FECHA:	        30-10-2015 20:07:41
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

	v_nombre_funcion = 'param.ft_proveedor_cta_bancaria_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PCTABAN_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gsarmiento	
 	#FECHA:		30-10-2015 20:07:41
	***********************************/

	if(p_transaccion='PM_PCTABAN_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pctaban.id_proveedor_cta_bancaria,
                        pctaban.id_banco_beneficiario,
						instben.nombre as banco_beneficiario,
						pctaban.fw_aba_cta,
						pctaban.swift_big,
						pctaban.estado_reg,
                        pctaban.banco_intermediario,
						pctaban.nro_cuenta,
						pctaban.id_proveedor,
						pctaban.id_usuario_ai,
						pctaban.usuario_ai,
						pctaban.fecha_reg,
						pctaban.id_usuario_reg,
						pctaban.id_usuario_mod,
						pctaban.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tproveedor_cta_bancaria pctaban
                        left join param.tinstitucion instben on instben.id_institucion=pctaban.id_banco_beneficiario
						inner join segu.tusuario usu1 on usu1.id_usuario = pctaban.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pctaban.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PCTABAN_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gsarmiento	
 	#FECHA:		30-10-2015 20:07:41
	***********************************/

	elsif(p_transaccion='PM_PCTABAN_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proveedor_cta_bancaria)
					    from param.tproveedor_cta_bancaria pctaban
					    inner join segu.tusuario usu1 on usu1.id_usuario = pctaban.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pctaban.id_usuario_mod
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
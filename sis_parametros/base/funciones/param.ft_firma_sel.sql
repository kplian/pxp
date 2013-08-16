--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_firma_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_firma_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tfirma'
 AUTOR: 		 (admin)
 FECHA:	        11-07-2013 15:32:07
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

	v_nombre_funcion = 'param.ft_firma_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_FIR_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		11-07-2013 15:32:07
	***********************************/

	if(p_transaccion='PM_FIR_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						fir.id_firma,
						fir.estado_reg,
						fir.desc_firma,
						fir.monto_min,
						fir.prioridad,
						fir.monto_max,
						fir.id_documento,
						fir.id_funcionario,
						fir.id_depto,
						fir.id_usuario_reg,
						fir.fecha_reg,
						fir.id_usuario_mod,
						fir.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        fun.desc_funcionario1,
                        ''(''||doc.codigo||'') ''||doc.descripcion as desc_documento
						from param.tfirma fir
						inner join segu.tusuario usu1 on usu1.id_usuario = fir.id_usuario_reg
                        inner join orga.vfuncionario fun on fun.id_funcionario = fir.id_funcionario
                        inner join param.tdocumento doc on doc.id_documento = fir.id_documento
						left join segu.tusuario usu2 on usu2.id_usuario = fir.id_usuario_mod
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_FIR_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		11-07-2013 15:32:07
	***********************************/

	elsif(p_transaccion='PM_FIR_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_firma)
					    from param.tfirma fir
						inner join segu.tusuario usu1 on usu1.id_usuario = fir.id_usuario_reg
                        inner join orga.vfuncionario fun on fun.id_funcionario = fir.id_funcionario
                        inner join param.tdocumento doc on doc.id_documento = fir.id_documento
						left join segu.tusuario usu2 on usu2.id_usuario = fir.id_usuario_mod
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
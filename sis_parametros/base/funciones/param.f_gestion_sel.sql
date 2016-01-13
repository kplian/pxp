CREATE OR REPLACE FUNCTION param.f_gestion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_gestion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tgestion'
 AUTOR: 		 (admin)
 FECHA:	        05-02-2013 09:56:59
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

	v_nombre_funcion = 'param.f_gestion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	if(p_transaccion='PM_GES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ges.id_gestion,
						ges.id_moneda_base,
						ges.id_empresa,
						ges.estado_reg,
						ges.estado,
						ges.gestion,
						ges.fecha_reg,
						ges.id_usuario_reg,
						ges.id_usuario_mod,
						ges.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        emp.nombre as desc_empresa,
                        mon.moneda,
                        mon.codigo as codigo_moneda,
                        ges.tipo                         	
						from param.tgestion ges
						inner join segu.tusuario usu1 on usu1.id_usuario = ges.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ges.id_usuario_mod
                        INNER JOIN param.tempresa emp on emp.id_empresa = ges.id_empresa
                        INNER JOIN param.tmoneda mon on mon.id_moneda= ges.id_moneda_base
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	elsif(p_transaccion='PM_GES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_gestion)
					    from param.tgestion ges
					    inner join segu.tusuario usu1 on usu1.id_usuario = ges.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ges.id_usuario_mod
                        INNER JOIN param.tempresa emp on emp.id_empresa = ges.id_empresa
                        INNER JOIN param.tmoneda mon on mon.id_moneda= ges.id_moneda_base
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
CREATE OR REPLACE FUNCTION param.ft_antiguedad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_antiguedad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tantiguedad'
 AUTOR: 		 (szambrana)
 FECHA:	        17-10-2019 14:41:21
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				17-10-2019 14:41:21								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tantiguedad'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_antiguedad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ANTIG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		szambrana	
 	#FECHA:		17-10-2019 14:41:21
	***********************************/

	if(p_transaccion='PM_ANTIG_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						antig.id_antiguedad,
						antig.estado_reg,
						antig.categoria_antiguedad,
						antig.dias_asignados,
						antig.desde_anhos,
						antig.hasta_anhos,
						antig.obs_antiguedad,
						antig.id_gestion,
						antig.id_usuario_reg,
						antig.fecha_reg,
						antig.id_usuario_ai,
						antig.usuario_ai,
						antig.id_usuario_mod,
						antig.fecha_mod,
                        ges.gestion,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tantiguedad antig
						inner join segu.tusuario usu1 on usu1.id_usuario = antig.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = antig.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = antig.id_gestion 
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ANTIG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		szambrana	
 	#FECHA:		17-10-2019 14:41:21
	***********************************/

	elsif(p_transaccion='PM_ANTIG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_antiguedad)
						from param.tantiguedad antig
						inner join segu.tusuario usu1 on usu1.id_usuario = antig.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = antig.id_usuario_mod
                        inner join param.tgestion ges on ges.id_gestion = antig.id_gestion 
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

ALTER FUNCTION param.ft_antiguedad_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
CREATE OR REPLACE FUNCTION orga.ft_escala_salarial_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_escala_salarial_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tescala_salarial'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 00:28:29
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 ISSUE		FECHA			AUTHOR				DESCRIPCION		
  #35		23/07/2019		EGS					Se modifica la condicion estado_reg activo en el controlador
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'orga.ft_escala_salarial_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_ESCSAL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:29
	***********************************/

	if(p_transaccion='OR_ESCSAL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						escsal.id_escala_salarial,
						escsal.aprobado,
						escsal.id_categoria_salarial,
						escsal.fecha_fin,
						escsal.estado_reg,
						escsal.haber_basico,
						escsal.fecha_ini,
						escsal.nombre,
						escsal.nro_casos,
						escsal.codigo,
						escsal.fecha_reg,
						escsal.id_usuario_reg,
						escsal.id_usuario_mod,
						escsal.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from orga.tescala_salarial escsal
						inner join segu.tusuario usu1 on usu1.id_usuario = escsal.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = escsal.id_usuario_mod
				        where ';    --#35
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
            --raise exception 'v_consulta %',v_consulta;
            raise notice 'v_consulta %',v_consulta;
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'OR_ESCSAL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:29
	***********************************/

	elsif(p_transaccion='OR_ESCSAL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_escala_salarial)
					    from orga.tescala_salarial escsal
					    inner join segu.tusuario usu1 on usu1.id_usuario = escsal.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = escsal.id_usuario_mod
					    where '; --#35
			
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
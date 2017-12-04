CREATE OR REPLACE FUNCTION param.ft_institucion_persona_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_institucion_persona_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tinstitucion_persona'
 AUTOR: 		fprudencio
 FECHA:	        03-12-2017 10:50:03
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
    v_filadd			varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_institucion_persona_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_INSTIPER_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		fprudencio
 	#FECHA:		03-12-2017 10:50:03
	***********************************/

	if(p_transaccion='PM_INSTIPER_SEL')then
     				
    	begin
          
    		--Sentencia de la consulta
			v_consulta:='select
						instiper.id_institucion_persona,
						instiper.id_institucion,
						instit.nombre as nombre_institucion,
                        instiper.estado_reg,
                        instiper.id_persona,
						per.nombre_completo2 as desc_persona,
						instiper.cargo_institucion
                        from param.tinstitucion_persona instiper
						inner join param.tinstitucion instit on instiper.id_institucion = instit.id_institucion
                        INNER JOIN segu.vpersona per on per.id_persona = instiper.id_persona
						where  instit.estado_reg=''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIPER_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		03-12-2017 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIPER_CONT')then

		begin
                     
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(instiper.id_institucion)
					    from param.tinstitucion_persona instiper
						inner join param.tinstitucion instit on instiper.id_institucion = instit.id_institucion
                        INNER JOIN segu.vpersona per on per.id_persona = instiper.id_persona
						where  instit.estado_reg=''activo'' and ';
			
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
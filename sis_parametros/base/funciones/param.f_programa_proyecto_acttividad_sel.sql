--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_programa_proyecto_acttividad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_programa_proyecto_acttividad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tprograma_proyecto_acttividad'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 16:04:45
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

	v_nombre_funcion = 'param.f_programa_proyecto_acttividad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PPA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 16:04:45
	***********************************/

	if(p_transaccion='PM_PPA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ppa.id_prog_pory_acti,
						ppa.estado_reg,
						ppa.id_proyecto,
						ppa.id_actividad,
						ppa.id_programa,
						ppa.fecha_reg,
						ppa.id_usuario_reg,
						ppa.fecha_mod,
						ppa.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        prog.codigo_programa||''-''||prog.nombre_programa as desc_programa,	
                        proy.codigo_proyecto||''-''||proy.nombre_proyecto as desc_proyecto,	
                        act.codigo_actividad||''-''||act.nombre_actividad as desc_actividad	,
						prog.codigo_programa||''-''|| proy.codigo_proyecto||''-''|| act.codigo_actividad as desc_ppa
                        
                        from param.tprograma_proyecto_acttividad ppa
						inner join segu.tusuario usu1 on usu1.id_usuario = ppa.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ppa.id_usuario_mod
                        inner join param.tprograma prog on prog.id_programa = ppa.id_programa
                        inner join param.tproyecto proy on proy.id_proyecto = ppa.id_proyecto
                        inner join param.tactividad act on act.id_actividad = ppa.id_actividad
                        
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PPA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 16:04:45
	***********************************/

	elsif(p_transaccion='PM_PPA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_prog_pory_acti)
					    from param.tprograma_proyecto_acttividad ppa
					    inner join segu.tusuario usu1 on usu1.id_usuario = ppa.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ppa.id_usuario_mod
                        inner join param.tprograma prog on prog.id_programa = ppa.id_programa
                        inner join param.tproyecto proy on proy.id_proyecto = ppa.id_proyecto
                        inner join param.tactividad act on act.id_actividad = ppa.id_actividad
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
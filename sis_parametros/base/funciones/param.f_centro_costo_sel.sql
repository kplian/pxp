CREATE OR REPLACE FUNCTION param.f_centro_costo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_centro_costo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcentro_costo'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 22:53:59
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
    v_codigo_subsistema	varchar;
			    
BEGIN

	v_nombre_funcion = 'param.f_centro_costo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CEC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	if(p_transaccion='PM_CEC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						 id_centro_costo,
                          estado_reg,
                          id_ep,
                          id_gestion,
                          id_uo,
                          id_usuario_reg,
                          fecha_reg,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          codigo_uo,
                          nombre_uo,
                          ep,
                          gestion,
                          codigo_cc,
                          nombre_programa,
         					nombre_proyecto,
         					nombre_actividad,
         					nombre_financiador,
         					nombre_regional
						from param.vcentro_costo cec
						 where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from param.vcentro_costo cec
                        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'PM_CECCOM_SEL'
 	#DESCRIPCION:	Consulta de datos de centro de costo combo
 	#AUTOR:		admin	
 	#FECHA:		07-05-2013 22:53:59
	***********************************/				
	elsif(p_transaccion='PM_CECCOM_SEL')then
    	     				
    	begin
          v_filadd = '';
          v_codigo_subsistema = NULL;
          if (pxp.f_existe_parametro(p_tabla,'codigo_subsistema')) then
          	v_codigo_subsistema = v_parametros.codigo_subsistema;
          end if;
          IF   p_administrador != 1 THEN
          		v_filadd='(cec.id_ep  in ('|| param.f_get_lista_ccosto_x_usuario(p_id_usuario, v_codigo_subsistema)  ||')) and';
          END IF;
    		--Sentencia de la consulta
			v_consulta:='select
						 id_centro_costo,
                          estado_reg,
                          id_ep,
                          id_gestion,
                          id_uo,
                          id_usuario_reg,
                          fecha_reg,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          codigo_uo,
                          nombre_uo,
                          ep,
                          gestion,
                          codigo_cc	
						from param.vcentro_costo cec
						 WHERE '||v_filadd;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise exception '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CECCOM_CONT'
 	#DESCRIPCION:	Conteo de registros centro de costo combo
 	#AUTOR:		admin	
 	#FECHA:		07-05-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CECCOM_CONT')then

		begin
          v_filadd = '';
          v_codigo_subsistema = NULL;
          if (pxp.f_existe_parametro(p_tabla,'codigo_subsistema')) then
          	v_codigo_subsistema = v_parametros.codigo_subsistema;
          end if;
          IF   p_administrador != 1 THEN
          		v_filadd='(cec.id_ep  in ('|| param.f_get_lista_ccosto_x_usuario(p_id_usuario, v_codigo_subsistema)  ||')) and';
          END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from param.vcentro_costo cec
                        WHERE '||v_filadd;
			
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
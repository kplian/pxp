--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_periodo_subsistema_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_periodo_subsistema_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tperiodo_subsistema'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2013 13:58:30
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
	v_cons				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_periodo_subsistema_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PESU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 13:58:30
	***********************************/

	if(p_transaccion='PM_PESU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:=' select
                            pesu.id_periodo_subsistema,
                            pesu.estado_reg,
                            pesu.id_subsistema,
                            pesu.id_periodo,
                            peri.fecha_ini,
                            peri.fecha_fin,
                            peri.periodo,
                            peri.id_gestion,
                            gest.gestion,
                            pesu.estado,
                            pesu.fecha_reg,
                            pesu.id_usuario_reg,
                            pesu.fecha_mod,
                            pesu.id_usuario_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            sis.codigo || '' - '' ||sis.nombre as desc_subsistema	
						from param.tperiodo_subsistema pesu
                        left join segu.tsubsistema sis on sis.id_subsistema = pesu.id_subsistema
						inner join segu.tusuario usu1 on usu1.id_usuario = pesu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pesu.id_usuario_mod
                        inner join param.tperiodo peri on peri.id_periodo = pesu.id_periodo
                        inner join param.tgestion gest on gest.id_gestion = peri.id_gestion
				        where ';
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PESU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 13:58:30
	***********************************/

	elsif(p_transaccion='PM_PESU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_periodo_subsistema)
					    from param.tperiodo_subsistema pesu
                        left join segu.tsubsistema sis on sis.id_subsistema = pesu.id_subsistema
						inner join segu.tusuario usu1 on usu1.id_usuario = pesu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pesu.id_usuario_mod
                        inner join param.tperiodo peri on peri.id_periodo = pesu.id_periodo
                        inner join param.tgestion gest on gest.id_gestion = peri.id_gestion 
                        where ';
                        
                        v_cons='';
                        if pxp.f_existe_parametro(p_tabla,'codigo_subsistema') then
                        	v_cons = ' sis.codigo = '''|| v_parametros.codigo_subsistema ||''' and ';
                        elsif pxp.f_existe_parametro(p_tabla,'id_periodo') then
                        	v_cons = ' pesu.id_periodo = '|| v_parametros.id_periodo ||' and ';
                        end if;
                        
				        if v_consulta != '' then
				        	v_consulta = v_consulta || v_cons;
				        end if;
			
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
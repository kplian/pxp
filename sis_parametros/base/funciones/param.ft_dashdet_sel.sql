--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_dashdet_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_dashdet_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdashdet'
 AUTOR: 		 (admin)
 FECHA:	        10-09-2016 11:31:12
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

	v_nombre_funcion = 'param.ft_dashdet_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DAD_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	if(p_transaccion='PM_DAD_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						dad.id_dashdet,
						dad.estado_reg,
						dad.columna,
						dad.id_widget,
						dad.fila,
						dad.id_dashboard,
						dad.fecha_reg,
						dad.usuario_ai,
						dad.id_usuario_reg,
						dad.id_usuario_ai,
						dad.id_usuario_mod,
						dad.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from param.tdashdet dad
						inner join segu.tusuario usu1 on usu1.id_usuario = dad.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dad.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
        
        
        

	/*********************************    
 	#TRANSACCION:  'PM_DAD_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	elsif(p_transaccion='PM_DAD_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_dashdet)
					    from param.tdashdet dad
					    inner join segu.tusuario usu1 on usu1.id_usuario = dad.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dad.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_DADET_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		10-09-2016 11:31:12
	***********************************/

	elsif(p_transaccion='PM_DADET_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						dad.id_dashdet,
						dad.estado_reg,
						dad.columna,
						dad.id_widget,
						dad.fila,
						dad.id_dashboard,
						dad.fecha_reg,
						dad.usuario_ai,
						dad.id_usuario_reg,
						dad.id_usuario_ai,
						dad.id_usuario_mod,
						dad.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        w.clase,
                        w.nombre,
                        w.ruta,
                        w.tipo,
                        w.obs
						from param.tdashdet dad
                        inner join param.twidget w on w.id_widget = dad.id_widget
						inner join segu.tusuario usu1 on usu1.id_usuario = dad.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dad.id_usuario_mod
                       
				        where  id_dashboard = '||v_parametros.id_dashboard;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||'  order by columna, fila asc';

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
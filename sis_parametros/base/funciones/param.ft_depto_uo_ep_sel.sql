--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_uo_ep_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_uo_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_uo_ep'
 AUTOR: 		 (admin)
 FECHA:	        03-06-2013 15:15:03
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

	v_nombre_funcion = 'param.ft_depto_uo_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DUE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	if(p_transaccion='PM_DUE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select 
                        due.id_depto_uo_ep,
						due.id_uo,
						due.id_depto,
						due.id_ep,
						due.estado_reg,
						due.id_usuario_reg,
						due.fecha_reg,
						due.fecha_mod,
						due.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        ep.ep,
                        ''(''||COALESCE(uo.codigo,'''')||'')''||COALESCE(uo.nombre_unidad,''nan'') as desc_uo
                        	
						from param.tdepto_uo_ep due
						inner join segu.tusuario usu1 on usu1.id_usuario = due.id_usuario_reg
                        left join param.vep as ep on ep.id_ep = due.id_ep
                        left join orga.tuo uo on uo.id_uo = due.id_uo
						left join segu.tusuario usu2 on usu2.id_usuario = due.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
           -- raise notice  '%',v_consulta;
            
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DUE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_DUE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_depto_uo_ep)
					    from param.tdepto_uo_ep due
						inner join segu.tusuario usu1 on usu1.id_usuario = due.id_usuario_reg
                        left join param.vep as ep on ep.id_ep = due.id_ep
                        left join orga.tuo uo on uo.id_uo = due.id_uo
						left join segu.tusuario usu2 on usu2.id_usuario = due.id_usuario_mod
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
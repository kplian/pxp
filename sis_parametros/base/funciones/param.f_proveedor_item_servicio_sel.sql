CREATE OR REPLACE FUNCTION param.f_proveedor_item_servicio_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
  $body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_proveedor_item_servicio_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tproveedor_item_servicio'
 AUTOR: 		 (admin)
 FECHA:	        15-08-2012 18:56:19
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

	v_nombre_funcion = 'param.f_proveedor_item_servicio_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PRITSE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-08-2012 18:56:19
	***********************************/

	if(p_transaccion='PM_PRITSE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pritse.id_proveedor_item,
						pritse.estado_reg,
						pritse.id_servicio,
						pritse.id_proveedor,
						pritse.id_item,
						pritse.id_usuario_reg,
						pritse.fecha_reg,
						pritse.id_usuario_mod,
						pritse.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                                                serv.nombre as desc_servicio,
                                                ite.nombre as desc_item,
                                                case coalesce(ite.id_item,0)
						 when 0 then ''servicio''
						 else ''item''
						end as item_servicio
						from param.tproveedor_item_servicio pritse
						inner join segu.tusuario usu1 on usu1.id_usuario = pritse.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pritse.id_usuario_mod
                        left join param.tservicio serv on serv.id_servicio = pritse.id_servicio and serv.estado_reg = ''activo''
                        left join alm.titem ite on ite.id_item = pritse.id_item and ite.estado_reg = ''activo''
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRITSE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-08-2012 18:56:19
	***********************************/

	elsif(p_transaccion='PM_PRITSE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proveedor_item)
					    from param.tproveedor_item_servicio pritse
					    inner join segu.tusuario usu1 on usu1.id_usuario = pritse.id_usuario_reg
					    left join segu.tusuario usu2 on usu2.id_usuario = pritse.id_usuario_mod
                                            left join param.tservicio serv on serv.id_servicio = pritse.id_servicio
                                            left join alm.titem ite on ite.id_item = pritse.id_item
					    where ite.estado_reg = ''activo'' and ';
			
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
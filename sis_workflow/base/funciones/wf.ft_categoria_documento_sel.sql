CREATE OR REPLACE FUNCTION wf.ft_categoria_documento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_categoria_documento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tcategoria_documento'
 AUTOR: 		 (admin)
 FECHA:	        20-03-2015 15:44:44
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

	v_nombre_funcion = 'wf.ft_categoria_documento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_CATDOC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-03-2015 15:44:44
	***********************************/

	if(p_transaccion='WF_CATDOC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						catdoc.id_categoria_documento,
						catdoc.codigo,
						catdoc.estado_reg,
						catdoc.nombre,
						catdoc.id_usuario_reg,
						catdoc.fecha_reg,
						catdoc.usuario_ai,
						catdoc.id_usuario_ai,
						catdoc.fecha_mod,
						catdoc.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from wf.tcategoria_documento catdoc
						inner join segu.tusuario usu1 on usu1.id_usuario = catdoc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = catdoc.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    /*********************************    
 	#TRANSACCION:  'WF_EXPPROMAC_SEL'
 	#DESCRIPCION:	Listado de los datos del la categoria de documento seleccionado para exportar
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		19-03-2013
	***********************************/
    elsif(p_transaccion='WF_EXPCATDOC_SEL')then
		 BEGIN

               v_consulta:='select ''categoria_documento''::varchar,cd.codigo, cd.nombre,	
                                cd.estado_reg
                            from wf.tcategoria_documento cd ';

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and cd.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by cd.id_categoria_documento ASC';	
                                                                       
               return v_consulta;


         END;

	/*********************************    
 	#TRANSACCION:  'WF_CATDOC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-03-2015 15:44:44
	***********************************/

	elsif(p_transaccion='WF_CATDOC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_categoria_documento)
					    from wf.tcategoria_documento catdoc
					    inner join segu.tusuario usu1 on usu1.id_usuario = catdoc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = catdoc.id_usuario_mod
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_catalogo_tipo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_catalogo_tipo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcatalogo_tipo'
 AUTOR: 		 (admin)
 FECHA:	        27-11-2012 23:32:44
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

	v_nombre_funcion = 'param.ft_catalogo_tipo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PACATI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		27-11-2012 23:32:44
	***********************************/

	if(p_transaccion='PM_PACATI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pacati.id_catalogo_tipo,
						pacati.nombre,
						pacati.estado_reg,
						pacati.fecha_reg,
						pacati.id_usuario_reg,
						pacati.id_usuario_mod,
						pacati.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						pacati.id_subsistema,
						subsis.nombre as desc_subsistema,
						pacati.tabla	
						from param.tcatalogo_tipo pacati
						inner join segu.tusuario usu1 on usu1.id_usuario = pacati.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pacati.id_usuario_mod
						inner join segu.tsubsistema subsis on subsis.id_subsistema = pacati.id_subsistema
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PACATI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		27-11-2012 23:32:44
	***********************************/

	elsif(p_transaccion='PM_PACATI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_catalogo_tipo)
					    from param.tcatalogo_tipo pacati
					    inner join segu.tusuario usu1 on usu1.id_usuario = pacati.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pacati.id_usuario_mod
						inner join segu.tsubsistema subsis on subsis.id_subsistema = pacati.id_subsistema
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	/*********************************    
 	#TRANSACCION:  'PM_EXCATPO_SEL'
 	#DESCRIPCION:	Consulta de datos para exportacion 
 	#AUTOR:		rac	
 	#FECHA:		21/04/2016 23:32:44
	***********************************/

	elsif(p_transaccion='PM_EXCATPO_SEL')then
     				
    	begin
    		
            -- Sentencia de la consulta
			v_consulta:='select
                        ''maestro''::varchar as tipo_reg,
						pacati.id_catalogo_tipo,
						pacati.nombre,
						pacati.id_subsistema,
						subsis.codigo as codigo_subsistema,
						pacati.tabla	
						from param.tcatalogo_tipo pacati
						inner join segu.tsubsistema subsis on subsis.id_subsistema = pacati.id_subsistema
				        where  pacati.id_catalogo_tipo =   '||v_parametros.id_catalogo_tipo;
			
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    
    /*********************************    
 	#TRANSACCION:  'PM_EXCATA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		21/04/2016 23:32:44
	***********************************/

	elsif(p_transaccion='PM_EXCATA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						''detalle''::varchar as tipo_reg,
                        cat.id_catalogo,
						cat.id_catalogo_tipo,
						cattip.id_subsistema,
                        sis.codigo as codigo_subsistema,
						cat.descripcion,
						cat.codigo,
						cattip.nombre as desc_catalogo_tipo	
						from param.tcatalogo cat
						inner join param.tcatalogo_tipo cattip on cattip.id_catalogo_tipo = cat.id_catalogo_tipo
				     	inner join segu.tsubsistema sis on sis.id_subsistema= cattip.id_subsistema
				        where  cat.id_catalogo_tipo =   '||v_parametros.id_catalogo_tipo;
			
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
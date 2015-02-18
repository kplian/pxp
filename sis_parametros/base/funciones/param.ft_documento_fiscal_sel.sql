CREATE OR REPLACE FUNCTION "param"."ft_documento_fiscal_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_documento_fiscal_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdocumento_fiscal'
 AUTOR: 		 (admin)
 FECHA:	        03-04-2013 15:48:47
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

	v_nombre_funcion = 'param.ft_documento_fiscal_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DOCFIS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		03-04-2013 15:48:47
	***********************************/

	if(p_transaccion='PM_DOCFIS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						docfis.id_documento_fiscal,
						docfis.estado_reg,
						docfis.nro_documento,
						docfis.razon_social,
						docfis.nro_autorizacion,
						docfis.estado,
						docfis.nit,
						docfis.codigo_control,
						docfis.formulario,
						docfis.tipo_retencion,
						docfis.id_plantilla,
						docfis.fecha_doc,
						docfis.dui,
						docfis.fecha_reg,
						docfis.id_usuario_reg,
						docfis.fecha_mod,
						docfis.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						pla.desc_plantilla	
						from param.tdocumento_fiscal docfis
						inner join segu.tusuario usu1 on usu1.id_usuario = docfis.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = docfis.id_usuario_mod
						inner join param.tplantilla pla on pla.id_plantilla = docfis.id_plantilla
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DOCFIS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		03-04-2013 15:48:47
	***********************************/

	elsif(p_transaccion='PM_DOCFIS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_documento_fiscal)
					    from param.tdocumento_fiscal docfis
					    inner join segu.tusuario usu1 on usu1.id_usuario = docfis.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = docfis.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "param"."ft_documento_fiscal_sel"(integer, integer, character varying, character varying) OWNER TO postgres;

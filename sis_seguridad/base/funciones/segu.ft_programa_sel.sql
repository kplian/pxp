CREATE OR REPLACE FUNCTION segu.ft_programa_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCI?N: 		segu.ft_programa_sel
 DESCRIPCI?N:   Funci?n que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tprograma'
 AUTOR: 		 (w)
 FECHA:	        13-08-2011 16:32:52
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCI?N:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			
BEGIN

	v_nombre_funcion = 'segu.ft_programa_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_PROGRA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		w	
 	#FECHA:		13-08-2011 16:32:52
	***********************************/

	if(p_transaccion='SG_PROGRA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						progra.id_programa,
						progra.codigo,
						progra.descripcion,
						progra.estado_reg,
						progra.nombre,
						progra.fecha_reg,
						progra.id_usuario_reg,
						progra.fecha_mod,
						progra.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.tprograma progra
						inner join segu.tusuario usu1 on usu1.id_usuario = progra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = progra.id_usuario_mod
				        where  ';
			
			--Definici?n de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			
			if(pxp.f_existe_parametro(p_tabla,'estado_reg')) then
			  v_consulta:=v_consulta || ' and progra.estado_reg='''||v_parametros.estado_reg||'''';
			end if;
			
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************
 	#TRANSACCION:  'SG_PROGRA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		w	
 	#FECHA:		13-08-2011 16:32:52
	***********************************/

	elsif(p_transaccion='SG_PROGRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_programa)
					    from segu.tprograma progra
					    inner join segu.tusuario usu1 on usu1.id_usuario = progra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = progra.id_usuario_mod
					    where ';
			
			--Definici?n de la respuesta		
			v_consulta:=v_consulta||v_parametros.filtro;


            if(pxp.f_existe_parametro(p_tabla,'estado_reg')) then
			  v_consulta:=v_consulta || ' and progra.estado_reg='''||v_parametros.estado_reg||'''';
			end if;
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_proyecto_ime (OID = 305085) : 
--

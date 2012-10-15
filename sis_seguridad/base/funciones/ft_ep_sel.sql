CREATE OR REPLACE FUNCTION segu.ft_ep_sel (
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
 FUNCION: 		segu.ft_ep_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.tep'
 AUTOR: 		 (w)
 FECHA:	        18-10-2011 02:09:50
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

	v_nombre_funcion = 'segu.ft_ep_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SG_ESP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		w	
 	#FECHA:		18-10-2011 02:09:50
	***********************************/

	if(p_transaccion='SG_ESP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ep.id_ep,
						ep.estado_reg,
						ep.id_actividad,
						ep.nombre_actividad,
						ep.id_programa,
						ep.nombre_programa,
						ep.id_proyecto,
						ep.nombre_proyecto,
						ep.fecha_reg,
						ep.id_usuario_reg,
						ep.fecha_mod,
						ep.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.vep ep
						inner join segu.tusuario usu1 on usu1.id_usuario = ep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ep.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************
 	#TRANSACCION:  'SG_ESP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		w	
 	#FECHA:		18-10-2011 02:09:50
	***********************************/

	elsif(p_transaccion='SG_ESP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_ep)
					    from segu.vep ep
					    inner join segu.tusuario usu1 on usu1.id_usuario = ep.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ep.id_usuario_mod
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_estructura_dato_ime (OID = 305052) : 
--

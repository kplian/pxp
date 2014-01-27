CREATE OR REPLACE FUNCTION segu.ft_libreta_her_sel (
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
 FUNCION: 		segu.ft_libreta_her_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'segu.libreta_her'
 AUTOR: 		 (rac)
 FECHA:	        18-06-2012 16:45:50
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

	v_nombre_funcion = 'segu.ft_libreta_her_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_LIB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		18-06-2012 16:45:50
	***********************************/

	if(p_transaccion='SG_LIB_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						lib.id_libreta_her,
						lib.estado_reg,
						lib.telefono,
						lib.nombre,
						lib.obs,
						lib.id_usuario_reg,
						lib.fecha_reg,
						lib.id_usuario_mod,
						lib.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from segu.libreta_her lib
						inner join segu.tusuario usu1 on usu1.id_usuario = lib.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = lib.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SG_LIB_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		18-06-2012 16:45:50
	***********************************/

	elsif(p_transaccion='SG_LIB_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_libreta_her)
					    from segu.libreta_her lib
					    inner join segu.tusuario usu1 on usu1.id_usuario = lib.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = lib.id_usuario_mod
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
-- Definition for function ft_log_sel (OID = 305069) : 
--

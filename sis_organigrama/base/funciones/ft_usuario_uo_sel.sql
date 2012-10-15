CREATE OR REPLACE FUNCTION orga.ft_usuario_uo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_usuario_uo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tusuario_uo'
 AUTOR: 		 (rac)
 FECHA:	        13-12-2011 11:14:34
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

	v_nombre_funcion = 'param.ft_usuario_uo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_UUO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		13-12-2011 11:14:34
	***********************************/

	if(p_transaccion='PM_UUO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						uuo.id_usuario_uo,
						uuo.estado_reg,
						uuo.id_uo,
						uuo.id_usuario,
						uuo.fecha_reg,
						uuo.id_usuario_reg,
						uuo.fecha_mod,
						uuo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        PERSON.nombre_completo2 as desc_usuario,
                        uo.nombre_unidad
                       
						from param.tusuario_uo uuo
                         INNER JOIN orga.tuo uo on uo.id_uo = uuo.id_uo
                         INNER JOIN segu.tusuario usupri on usupri.id_usuario=uuo.id_usuario
                       INNER JOIN segu.vpersona PERSON on PERSON.id_persona = usupri.id_persona
						inner join segu.tusuario usu1 on usu1.id_usuario = uuo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = uuo.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_UUO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		13-12-2011 11:14:34
	***********************************/

	elsif(p_transaccion='PM_UUO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_usuario_uo)
					    from param.tusuario_uo uuo
                        INNER JOIN orga.tuo uo on uo.id_uo = uuo.id_uo
                         INNER JOIN segu.tusuario usupri on usupri.id_usuario=uuo.id_usuario
                       INNER JOIN segu.vpersona PERSON on PERSON.id_persona = usupri.id_persona
						inner join segu.tusuario usu1 on usu1.id_usuario = uuo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = uuo.id_usuario_mod
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
-- Definition for function f_obtener_funcionarios_x_uo (OID = 304939) : 
--

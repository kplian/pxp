CREATE OR REPLACE FUNCTION param.ft_lugar_sel (
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
 FUNCION: 		param.f_tlugar_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tlugar'
 AUTOR: 		 (rac)
 FECHA:	        29-08-2011 09:19:28
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
    v_where varchar;
    v_join varchar;
			    
BEGIN

	v_nombre_funcion = 'param.f_tlugar_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_LUG_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	if(p_transaccion='PM_LUG_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						lug.id_lugar,
						lug.codigo,
						lug.estado_reg,
						lug.id_lugar_fk,
						lug.nombre,
						lug.sw_impuesto,
						lug.sw_municipio,
						lug.tipo,
						lug.fecha_reg,
						lug.id_usuario_reg,
						lug.fecha_mod,
						lug.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						lug.es_regional	
						from param.tlugar lug
						inner join segu.tusuario usu1 on usu1.id_usuario = lug.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = lug.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
     /*********************************    
 	#TRANSACCION:  'PM_LUG_ARB_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	elseif(p_transaccion='PM_LUG_ARB_SEL')then
     				
    	begin
        
              if(v_parametros.id_padre = '%') then
                v_where := ' lug.id_lugar_fk is NULL';
                 v_join:= 'LEFT';      
                      
              else
                v_where := ' lug.id_lugar_fk = '||v_parametros.id_padre;
                v_join := 'INNER';
              end if;
        
        
    		--Sentencia de la consulta
			v_consulta:='select
						lug.id_lugar,
						lug.codigo,
						lug.estado_reg,
						lug.id_lugar_fk,
						lug.nombre,
						lug.sw_impuesto,
						lug.sw_municipio,
						lug.tipo,
						lug.fecha_reg,
						lug.id_usuario_reg,
						lug.fecha_mod,
						lug.id_usuario_mod,
						usu1.cuenta as usr_reg,
                        case
                          when (lug.id_lugar_fk is null )then
                               ''raiz''::varchar
                          ELSE
                              ''hijo''::varchar
                          END as tipo_nodo,
                         codigo_largo,
                         lug.es_regional
						from param.tlugar lug
						inner join segu.tusuario usu1 
                        on usu1.id_usuario = lug.id_usuario_reg
					    where  '||v_where|| '  
                        ORDER BY lug.id_lugar';
			
			
			--Devuelve la respuesta
			return v_consulta;
						
		end;   

	/*********************************    
 	#TRANSACCION:  'PM_LUG_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		29-08-2011 09:19:28
	***********************************/

	elsif(p_transaccion='PM_LUG_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_lugar)
					    from param.tlugar lug
					    inner join segu.tusuario usu1 on usu1.id_usuario = lug.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = lug.id_usuario_mod
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
-- Definition for function ft_moneda_ime (OID = 304041) : 
--

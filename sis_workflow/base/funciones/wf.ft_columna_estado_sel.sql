CREATE OR REPLACE FUNCTION wf.ft_columna_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_columna_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tcolumna_estado'
 AUTOR: 		 (admin)
 FECHA:	        07-05-2014 21:41:18
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

	v_nombre_funcion = 'wf.ft_columna_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_COLEST_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	if(p_transaccion='WF_COLEST_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						colest.id_columna_estado,
						colest.id_tipo_estado,
						colest.id_tipo_columna,
						colest.estado_reg,
						colest.momento,
						tes.nombre_estado,
						colest.id_usuario_reg,
						colest.fecha_reg,
						colest.id_usuario_mod,
						colest.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        colest.regla	
						from wf.tcolumna_estado colest
						inner join segu.tusuario usu1 on usu1.id_usuario = colest.id_usuario_reg
						inner join wf.ttipo_estado tes on tes.id_tipo_estado = colest.id_tipo_estado
						left join segu.tusuario usu2 on usu2.id_usuario = colest.id_usuario_mod
				        where colest.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_COLEST_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	elsif(p_transaccion='WF_COLEST_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_columna_estado)
					    from wf.tcolumna_estado colest
					    inner join segu.tusuario usu1 on usu1.id_usuario = colest.id_usuario_reg
					    inner join wf.ttipo_estado tes on tes.id_tipo_estado = colest.id_tipo_estado
						left join segu.tusuario usu2 on usu2.id_usuario = colest.id_usuario_mod
					    where colest.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
    /*********************************    
 	#TRANSACCION:  'WF_EXPCOLEST_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	elsif(p_transaccion='WF_EXPCOLEST_SEL')then

		BEGIN

               v_consulta:='select  ''columna_estado''::varchar,tcol.bd_nombre_columna,tab.bd_codigo_tabla,tp.codigo,tes.codigo,
                            coles.momento,coles.regla,coles.estado_reg

                            from wf.tcolumna_estado coles
                            inner join wf.ttipo_columna tcol
                            on tcol.id_tipo_columna = coles.id_tipo_columna
                            inner join wf.ttipo_estado tes
                            on tes.id_tipo_estado = coles.id_tipo_estado
                            inner join wf.ttabla tab
                            on tab.id_tabla = tcol.id_tabla
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tab.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and coles.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by coles.id_columna_estado ASC';	
                                                                       
               return v_consulta;


         END;
					
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
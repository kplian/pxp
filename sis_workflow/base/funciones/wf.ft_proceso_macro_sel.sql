--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_proceso_macro_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_macro_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.proceso_macro'
 AUTOR: 		 (rac)
 FECHA:	        19-02-2013 13:51:29
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

	v_nombre_funcion = 'wf.ft_proceso_macro_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	if(p_transaccion='WF_PROMAC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						promac.id_proceso_macro,
						promac.id_subsistema,
						promac.nombre,
						promac.codigo,
						promac.inicio,
						promac.estado_reg,
						promac.id_usuario_reg,
						promac.fecha_reg,
						promac.id_usuario_mod,
						promac.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        subs.nombre AS desc_subsistema,
                        promac.grupo_doc
						from wf.tproceso_macro promac
						inner join segu.tusuario usu1 on usu1.id_usuario = promac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = promac.id_usuario_mod
                        INNER JOIN segu.tsubsistema subs on subs.id_subsistema = promac.id_subsistema
				        where  promac.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;        

    /*********************************    
 	#TRANSACCION:  'WF_EXPPROMAC_SEL'
 	#DESCRIPCION:	Listado de los datos del proceso macro seleccionado para exportar
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		19-03-2013
	***********************************/
    elsif(p_transaccion='WF_EXPPROMAC_SEL')then
		 BEGIN

               v_consulta:='select ''proceso_macro''::varchar,pm.codigo, s.codigo as codigo_subsisitema,pm.nombre,	
                                inicio,pm.estado_Reg
                            from wf.tproceso_macro pm
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro =  '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and pm.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by pm.id_proceso_macro ASC';	
                                                                       
               return v_consulta;


         END;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proceso_macro)
					    from wf.tproceso_macro promac
					    inner join segu.tusuario usu1 on usu1.id_usuario = promac.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = promac.id_usuario_mod
                        INNER JOIN segu.tsubsistema subs on subs.id_subsistema = promac.id_subsistema
					    where   promac.estado_reg = ''activo''  and ';
			
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
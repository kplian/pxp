CREATE OR REPLACE FUNCTION wf.ft_estructura_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_estructura_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.testructura_estado'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:25:45
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

	v_nombre_funcion = 'wf.ft_estructura_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_ESTES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:25:45
	***********************************/

	if(p_transaccion='WF_ESTES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						estes.id_estructura_estado,
						estes.id_tipo_estado_padre,
						estes.id_tipo_estado_hijo,
						estes.prioridad,
						estes.regla,
						estes.estado_reg,
						estes.fecha_reg,
						estes.id_usuario_reg,
						estes.fecha_mod,
						estes.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        ''(''||tep.codigo||'') ''|| tep.nombre_estado AS desc_tipo_estado_padre,
                        ''(''||teh.codigo||'') ''|| teh.nombre_estado AS desc_tipo_estado_hijo                	
						from wf.testructura_estado estes
						inner join segu.tusuario usu1 on usu1.id_usuario = estes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = estes.id_usuario_mod
                        INNER JOIN wf.ttipo_estado tep on  tep.id_tipo_estado = estes.id_tipo_estado_padre
                        INNER JOIN wf.ttipo_estado teh on  teh.id_tipo_estado = estes.id_tipo_estado_hijo
				        where  estes.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
    
    /*********************************    
 	#TRANSACCION:  'WF_EXPESTES_SEL'
 	#DESCRIPCION:	Listado de estructura de datos del proceso macro seleccionado para exportar
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		19-03-2013
	***********************************/
    elsif(p_transaccion='WF_EXPESTES_SEL')then
    	BEGIN

               v_consulta:='select  ''estructura_estado''::varchar,padre.codigo, hijo.codigo, tp.codigo, estru.prioridad,estru.regla,
               				estru.estado_reg

                            from wf.testructura_estado estru
                            inner join wf.ttipo_estado padre
                            on padre.id_tipo_estado = estru.id_tipo_estado_padre
                            inner join wf.ttipo_estado hijo
                            on hijo.id_tipo_estado = estru.id_tipo_estado_hijo
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = padre.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and estru.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by estru.id_estructura_estado ASC';	
                                                                       
               return v_consulta;


         END;     

	/*********************************    
 	#TRANSACCION:  'WF_ESTES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:25:45
	***********************************/

	elsif(p_transaccion='WF_ESTES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_estructura_estado)
					    from wf.testructura_estado estes
					    inner join segu.tusuario usu1 on usu1.id_usuario = estes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = estes.id_usuario_mod
                        INNER JOIN wf.ttipo_estado tep on  tep.id_tipo_estado = estes.id_tipo_estado_padre
                        INNER JOIN wf.ttipo_estado teh on  teh.id_tipo_estado = estes.id_tipo_estado_hijo
					    where estes.estado_reg = ''activo'' and ';
			
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_proceso_wf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_wf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tproceso_wf'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 09:01:51
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
    
    v_filtro            varchar;
			    
BEGIN

	v_nombre_funcion = 'wf.f_proceso_wf_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PWF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	if(p_transaccion='WF_PWF_SEL')then
     				
    	begin
        
            v_filtro='';
            
            IF p_administrador !=1  and v_parametros.tipo_interfaz = 'ProcesoWfIniTra' THEN
               v_filtro = '(ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'  or pwf.id_usuario_reg='||p_id_usuario||' ) and ';
            END IF;
            
            IF  v_parametros.tipo_interfaz = 'ProcesoWfVb' THEN
                IF p_administrador !=1 THEN
                    v_filtro = '(ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' ) and  (lower(te.inicio)!=''si'') and ';
                ELSE
                     v_filtro = ' (lower(te.inicio)!=''si'') and ';
                END IF;
            END IF;
            
        
        
    		--Sentencia de la consulta
			v_consulta:='select pwf.id_proceso_wf,
                             pwf.id_tipo_proceso,
                             pwf.nro_tramite,
                             pwf.id_estado_wf_prev,
                             pwf.estado_reg,
                             pwf.id_persona,
                             pwf.valor_cl,
                             pwf.id_institucion,
                             pwf.id_usuario_reg,
                             pwf.fecha_reg,
                             pwf.fecha_mod,
                             pwf.id_usuario_mod,
                             usu1.cuenta as usr_reg,
                             usu2.cuenta as usr_mod,
                             tp.nombre as desc_tipo_proceso,
                             pwf.tipo_ini,
                             pwf.fecha_ini,
                             per.nombre_completo1 as desc_persona,
                             int.nombre as desc_intitucion,       
                             te.codigo as codigo_estado,
                             ew.id_estado_wf,
                             te.inicio as tipo_estado_inicio,
                             te.fin    as  tipo_estado_fin,
                             te.disparador as tipo_estado_disparador,
                             ew.obs
                        from wf.tproceso_wf pwf
                           inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                           inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                           inner join wf.tproceso_macro pm on tp.id_proceso_macro =
                            pm.id_proceso_macro
                           inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and
                            ew.estado_reg = ''activo''
                           inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                           left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                           left join segu.vpersona per on per.id_persona = pwf.id_persona
                           left join param.tinstitucion int on int.id_institucion = pwf.id_institucion
                        where '||v_filtro;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_CONT')then

		begin
        
           v_filtro='';
            
            IF p_administrador !=1  and v_parametros.tipo_interfaz = 'ProcesoWfIniTra' THEN
               v_filtro = '(ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'  or pwf.id_usuario_reg='||p_id_usuario||' ) and ';
            END IF;
            
            IF  v_parametros.tipo_interfaz = 'ProcesoWfVb' THEN
                IF p_administrador !=1 THEN
                    v_filtro = '(ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' ) and  (lower(te.inicio)!=''si'') and ';
                ELSE
                     v_filtro = ' (lower(te.inicio)!=''si'') and ';
                END IF;
            END IF;
           
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(pwf.id_proceso_wf)
					    from wf.tproceso_wf pwf
                           inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                           inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                           inner join wf.tproceso_macro pm on tp.id_proceso_macro =
                            pm.id_proceso_macro
                           inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and
                            ew.estado_reg = ''activo''
                           inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                           left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                           left join segu.vpersona per on per.id_persona = pwf.id_persona
                           left join param.tinstitucion int on int.id_institucion = pwf.id_institucion
                        where '||v_filtro;
			
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_obs_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_obs_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tobs'
 AUTOR: 		 (admin)
 FECHA:	        20-11-2014 18:53:55
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
    v_filtro			varchar;
    v_lista_fun			varchar;
			    
BEGIN

	v_nombre_funcion = 'wf.ft_obs_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_OBS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	if(p_transaccion='WF_OBS_SEL')then
     				
    	begin
    		
            IF v_parametros.todos = 0  THEN
            	v_filtro = ' obs.id_estado_wf = '||v_parametros.id_estado_wf||' and ' ;
            else
                v_filtro = ' obs.num_tramite = '''||v_parametros.num_tramite ||''' and ';
            END IF;
            
            --Sentencia de la consulta
			v_consulta:='select
                            obs.id_obs,
                            obs.fecha_fin,
                            obs.estado_reg,
                            obs.estado,
                            obs.descripcion,
                            obs.id_funcionario_resp,
                            obs.titulo,
                            obs.desc_fin,
                            obs.usuario_ai,
                            obs.fecha_reg,
                            obs.id_usuario_reg,
                            obs.id_usuario_ai,
                            obs.id_usuario_mod,
                            obs.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            fun.desc_funcionario1 as desc_funcionario,
                            te.codigo as codigo_tipo_estado,
                            te.nombre_estado as nombre_tipo_estado,
                            tp.nombre as nombre_tipo_proceso
                      from wf.tobs obs
                         inner join segu.tusuario usu1 on usu1.id_usuario = obs.id_usuario_reg
                         left join segu.tusuario usu2 on usu2.id_usuario = obs.id_usuario_mod
                         inner join orga.vfuncionario fun on fun.id_funcionario = obs.id_funcionario_resp
                         inner join wf.testado_wf ewf on ewf.id_estado_wf = obs.id_estado_wf
                         inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
                         inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = ewf.id_proceso_wf
                         inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                      where  obs.estado_reg = ''activo'' and '||v_filtro;
			
           
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice '... %', v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_OBS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBS_CONT')then

		begin
        
            IF v_parametros.todos = 0  THEN
            	v_filtro = ' obs.id_estado_wf = '||v_parametros.id_estado_wf||' and ' ;
            else
                v_filtro = ' obs.num_tramite = '''||v_parametros.num_tramite ||''' and ';
            END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_obs)
					    from wf.tobs obs
					     inner join segu.tusuario usu1 on usu1.id_usuario = obs.id_usuario_reg
                         left join segu.tusuario usu2 on usu2.id_usuario = obs.id_usuario_mod
                         inner join orga.vfuncionario fun on fun.id_funcionario = obs.id_funcionario_resp
                         inner join wf.testado_wf ewf on ewf.id_estado_wf = obs.id_estado_wf
                         inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
                         inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = ewf.id_proceso_wf
                         inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                      where obs.estado_reg = ''activo'' and '||v_filtro;
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'WF_OBSFUN_SEL'
 	#DESCRIPCION:	Consulta de observaciones por funcionario
 	#AUTOR:		admin	
 	#FECHA:		23-04-2015 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBSFUN_SEL')then
     				
    	begin
    	  v_lista_fun = '0';
             
          select
           pxp.list(fun.id_funcionario::varchar)
          into
           v_lista_fun
          from orga.tfuncionario fun
          inner join segu.tusuario usu on fun.id_persona = usu.id_persona 
          where usu.id_usuario = p_id_usuario;
          
           IF p_administrador = 1 THEN
             v_filtro = '0=0 ';
          else
             v_filtro = 'obs.id_funcionario_resp in ('||v_lista_fun||')' ;
          END IF;
          
          --Sentencia de la consulta
		  v_consulta:='select
                            obs.id_obs,
                            obs.fecha_fin,
                            obs.estado_reg,
                            obs.estado,
                            obs.descripcion,
                            obs.id_funcionario_resp,
                            obs.titulo,
                            obs.desc_fin,
                            obs.usuario_ai,
                            obs.fecha_reg,
                            obs.id_usuario_reg,
                            obs.id_usuario_ai,
                            obs.id_usuario_mod,
                            obs.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            te.codigo as codigo_tipo_estado,
                            te.nombre_estado as nombre_tipo_estado,
                            tp.nombre as nombre_tipo_proceso,
                            pwf.nro_tramite,
                            obs.id_estado_wf,
                            pwf.id_proceso_wf
                      from wf.tobs obs
                         inner join segu.tusuario usu1 on usu1.id_usuario = obs.id_usuario_reg
                         left join segu.tusuario usu2 on usu2.id_usuario = obs.id_usuario_mod
                        inner join wf.testado_wf ewf on ewf.id_estado_wf = obs.id_estado_wf
                         inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
                         inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = ewf.id_proceso_wf
                         inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                      where  obs.estado_reg = ''activo''  and  '||v_filtro||'   and ';
                      
                      			
           
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice '... %', v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_OBSFUN_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBSFUN_CONT')then

		begin
        
           v_lista_fun = '0';
        
            select
              pxp.list(fun.id_funcionario::varchar)
            into
              v_lista_fun
            from orga.tfuncionario fun
            inner join segu.tusuario usu on fun.id_persona = usu.id_persona 
            where usu.id_usuario = p_id_usuario;
          
          IF p_administrador = 1 THEN
             v_filtro = '0=0 ';
          else
             v_filtro = 'obs.id_funcionario_resp in ('||v_lista_fun||')' ;
          END IF;
           
          
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_obs)
					     from wf.tobs obs
                           inner join segu.tusuario usu1 on usu1.id_usuario = obs.id_usuario_reg
                           left join segu.tusuario usu2 on usu2.id_usuario = obs.id_usuario_mod
                           inner join wf.testado_wf ewf on ewf.id_estado_wf = obs.id_estado_wf
                           inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
                           inner join wf.tproceso_wf pwf on pwf.id_proceso_wf = ewf.id_proceso_wf
                           inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pwf.id_tipo_proceso
                        where  obs.estado_reg = ''activo'' and   '||v_filtro||'   and ';
			
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
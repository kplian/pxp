--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_estado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_estado_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_estado'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:36:11
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
    
    v_tipo_asignacion  varchar;
    v_nombre_func_list varchar;
    v_id_depto_wf      integer; 
    
    
			    
BEGIN


   
 
	v_nombre_funcion = 'wf.ft_tipo_estado_sel';
    v_parametros = pxp.f_get_record(p_tabla);
   
    /*********************************    
 	#TRANSACCION:  'WF_FUNTIPES_SEL'
 	#DESCRIPCION:	Consulta los funcionarios correpondientes con el tipo de estado
 	#AUTOR:		RAC	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	if(p_transaccion='WF_FUNTIPES_SEL')then
     				
    	begin
        
             IF   pxp.f_existe_parametro(p_tabla,'id_depto_wf') THEN
               v_id_depto_wf =  COALESCE(v_parametros.id_depto_wf,0);
             END IF;
     
             v_consulta:=' 
                   SELECT 
                   id_funcionario,
                   desc_funcionario,
                   desc_funcionario_cargo,
                   prioridad
                   FROM wf.f_funcionario_wf_sel(
                     '||p_id_usuario::varchar||', 
                     '||v_parametros.id_tipo_estado::varchar||', 
                      '''|| COALESCE(v_parametros.fecha,now())::varchar||''',
                      '|| v_parametros.id_estado_wf::varchar||',
                      FALSE,
                      '||v_parametros.cantidad||',
                      '||v_parametros.puntero||',
                      '||quote_literal(v_parametros.filtro)||',
                      '||COALESCE(v_id_depto_wf,0)::varchar||'
                      
                     ) AS (id_funcionario integer,
                           desc_funcionario text,
                           desc_funcionario_cargo text,
                           prioridad integer)';
                      
         
                
                     
			--Devuelve la respuesta
			return v_consulta;
						
		end;
 	/*********************************    
 	#TRANSACCION:  'WF_FUNTIPES_CONT'
 	#DESCRIPCION:	Consulta los funcionarios correpondientes con el tipo de estado
 	#AUTOR:		RAC	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elseif(p_transaccion='WF_FUNTIPES_CONT')then
     				
    	begin
       
             IF   pxp.f_existe_parametro(p_tabla,'id_depto_wf') THEN
               v_id_depto_wf =  COALESCE(v_parametros.id_depto_wf,0);
             END IF;
    
             v_consulta:=' 
                   SELECT 
                   total
                   FROM wf.f_funcionario_wf_sel(
                     '||p_id_usuario::varchar||', 
                     '||v_parametros.id_tipo_estado::varchar||', 
                      '''||COALESCE(v_parametros.fecha,now())::varchar||''',
                      '|| v_parametros.id_estado_wf::varchar||',
                      TRUE,
                      '||v_parametros.cantidad||',
                      '||v_parametros.puntero||',
                      '||quote_literal(v_parametros.filtro)||',
                      '||COALESCE(v_id_depto_wf,0)::varchar||'
                      
                     ) AS (total bigint)';
                      
                  
                
                     
			--Devuelve la respuesta
			return v_consulta;
						
		end;
        
        
     /*********************************    
 	#TRANSACCION:  'WF_DEPTIPES_SEL'
 	#DESCRIPCION:	Consulta los departamentos correspondientes al tipo de estado wf
 	#AUTOR:		RAC	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_DEPTIPES_SEL')then
     				
    	begin
               
        v_consulta:=' 
                   SELECT 
                    id_depto,
                    codigo_depto,
                    nombre_corto_depto,
                    nombre_depto,
                    prioridad,
                    subsistema
                   FROM wf.f_depto_wf_sel(
                     '||p_id_usuario::varchar||', 
                     '||v_parametros.id_tipo_estado::varchar||', 
                      '''|| COALESCE(v_parametros.fecha,now())::varchar||''',
                      '|| v_parametros.id_estado_wf::varchar||',
                      FALSE,
                      '||v_parametros.cantidad||',
                      '||v_parametros.puntero||',
                      '||quote_literal(v_parametros.filtro)||'
                      
                     ) AS (id_depto integer,
                           codigo_depto varchar,
                           nombre_corto_depto varchar,
                           nombre_depto varchar,
                           prioridad integer,
                           subsistema varchar)';
                      
         --Devuelve la respuesta
         
           
         
		return v_consulta;
						
		end;
 	/*********************************    
 	#TRANSACCION:  'WF_DEPTIPES_CONT'
 	#DESCRIPCION:	Cuenta los registros de la consulta de departamentos correspondientes al tipo de estado wf
 	#AUTOR:		RAC	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elseif(p_transaccion='WF_DEPTIPES_CONT')then
     				
    	begin
       
         v_consulta:=' 
                   SELECT 
                   total
                   FROM wf.f_depto_wf_sel(
                     '||p_id_usuario::varchar||', 
                     '||v_parametros.id_tipo_estado::varchar||', 
                      '''||COALESCE(v_parametros.fecha,now())::varchar||''',
                      '|| v_parametros.id_estado_wf::varchar||',
                      TRUE,
                      '||v_parametros.cantidad||',
                      '||v_parametros.puntero||',
                      '||quote_literal(v_parametros.filtro)||'
                      
                     ) AS (total bigint)';
                      
             --Devuelve la respuesta
			return v_consulta;
						
		end;    

   /*********************************    
 	#TRANSACCION:  'WF_TIPES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elseif(p_transaccion='WF_TIPES_SEL')then
     				
    	begin
        
       -- raise exception 'llega';
    		--Sentencia de la consulta
			v_consulta:='select
						tipes.id_tipo_estado,
						tipes.nombre_estado,
						tipes.id_tipo_proceso,
						tipes.inicio,
						tipes.disparador,
						tipes.tipo_asignacion,
						tipes.nombre_func_list,
						tipes.estado_reg,
						tipes.fecha_reg,
						tipes.id_usuario_reg,
						tipes.fecha_mod,
						tipes.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.nombre AS desc_tipo_proceso,
                        tipes.codigo as codigo_estado,
                        tipes.obs,
                        tipes.depto_asignacion,
						tipes.nombre_depto_func_list,
                        tipes.fin,
                        tipes.alerta,
                        tipes.pedir_obs,
                        tipes.plantilla_mensaje_asunto,
                        tipes.plantilla_mensaje,
                       -- tipes.cargo_depto::varchar
                        array_to_string( tipes.cargo_depto,'','',''null'')::varchar,
                        tipes.funcion_inicial,
                        tipes.funcion_regreso,
                        tipes.mobile,
                        tipes.acceso_directo_alerta, 
                        tipes.nombre_clase_alerta, 
                        tipes.tipo_noti, 
                        tipes.titulo_alerta, 
                        tipes.parametros_ad	,
                        pxp.text_concat(terol.id_rol::text) as id_roles,
                        tipes.admite_obs  ,
                        tipes.etapa,
                        tipes.grupo_doc,
                        tipes.id_tipo_estado_anterior,
                        ''(''||tea.codigo||'') ''|| tea.nombre_estado AS desc_tipo_estado_anterior,
                        tipes.icono
						from wf.ttipo_estado tipes
						inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                        INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
                        LEFT JOIN wf.ttipo_estado_rol terol on terol.id_tipo_estado = tipes.id_tipo_estado
                        	and terol.estado_reg = ''activo'' 
                        LEFT JOIN wf.ttipo_estado tea on tea.id_tipo_estado = tipes.id_tipo_estado_anterior 
                        	
				        where tipes.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
            
            v_consulta:=v_consulta|| ' group by tipes.id_tipo_estado,
						tipes.nombre_estado,
						tipes.id_tipo_proceso,
						tipes.inicio,
						tipes.disparador,
						tipes.tipo_asignacion,
						tipes.nombre_func_list,
						tipes.estado_reg,
						tipes.fecha_reg,
						tipes.id_usuario_reg,
						tipes.fecha_mod,
						tipes.id_usuario_mod,
						usu1.cuenta,
						usu2.cuenta,
                        tp.nombre,
                        tipes.codigo,
                        tipes.obs,
                        tipes.depto_asignacion,
						tipes.nombre_depto_func_list,
                        tipes.fin,
                        tipes.alerta,
                        tipes.pedir_obs,
                        tipes.plantilla_mensaje_asunto,
                        tipes.plantilla_mensaje,                      
                        tipes.cargo_depto,
                        tipes.funcion_inicial,
                        tipes.funcion_regreso,
                        tipes.mobile,
                        tipes.acceso_directo_alerta, 
                        tipes.nombre_clase_alerta, 
                        tipes.tipo_noti, 
                        tipes.titulo_alerta, 
                        tipes.parametros_ad,
                        tipes.admite_obs  ,
                        tipes.etapa,
                        tipes.grupo_doc,
                        tipes.id_tipo_estado_anterior,
                        tea.codigo,
                        tea.nombre_estado	';
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
	elseif(p_transaccion='WF_EXPTIPES_SEL')then
    /*********************************    
 	#TRANSACCION:  'WF_EXPTIPES_SEL'
 	#DESCRIPCION:	Listado de los datos de tipo estado segun del proceso macro seleccionado para exportar
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		19-03-2013 15:36:11
	***********************************/

    	BEGIN

               v_consulta:='select ''tipo_estado''::varchar,tes.codigo, tp.codigo, tes.nombre_estado ,tes.inicio, tes.disparador, tes.fin,
                            tes.tipo_asignacion, tes.nombre_func_list , tes.depto_asignacion, tes.nombre_depto_func_list,
                            tes.obs, tes.alerta, tes.pedir_obs,tes.descripcion,tes.plantilla_mensaje,tes.plantilla_mensaje_asunto,
                            array_to_string(tes.cargo_depto,'',''),tes.mobile,tes.funcion_inicial,tes.funcion_regreso,tes.acceso_directo_alerta,
                            tes.nombre_clase_alerta,tes.tipo_noti,tes.titulo_alerta,tes.parametros_ad,tes.estado_reg,tea.codigo

                            from wf.ttipo_estado tes
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tes.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            left join wf.ttipo_estado tea
                            on tea.id_tipo_estado = tes.id_tipo_estado_anterior
                            where pm.id_proceso_macro =  '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and tes.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by tes.id_tipo_estado ASC';	
                                                                       
               return v_consulta;


         END;

	/*********************************    
 	#TRANSACCION:  'WF_TIPES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:36:11
	***********************************/

	elsif(p_transaccion='WF_TIPES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tipes.id_tipo_estado)
					    from wf.ttipo_estado tipes
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
						LEFT JOIN wf.ttipo_estado tea on tea.id_tipo_estado = tipes.id_tipo_estado_anterior
                        INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
					    where  tipes.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'WF_SIGEST_SEL'
 	#DESCRIPCION:	Devuelve los siguientes estados posibles
 	#AUTOR:			RCM	
 	#FECHA:			15/10/2013
	***********************************/

	elseif(p_transaccion='WF_SIGEST_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipes.id_tipo_estado,
						tipes.nombre_estado,
						tipes.id_tipo_proceso,
						tipes.inicio,
						tipes.disparador,
						tipes.tipo_asignacion,
						tipes.nombre_func_list,
						tipes.estado_reg,
						tipes.fecha_reg,
						tipes.id_usuario_reg,
						tipes.fecha_mod,
						tipes.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.nombre AS desc_tipo_proceso,
                        tipes.codigo as codigo_estado,
                        tipes.obs,
                        tipes.depto_asignacion,
						tipes.nombre_depto_func_list,
                        tipes.fin,
                        tipes.alerta,
                        tipes.pedir_obs
						from wf.ttipo_estado tipes
						inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
                        inner join  wf.testructura_estado ee on ee.id_tipo_estado_hijo = tipes.id_tipo_estado
						where tipes.id_tipo_proceso = ' || v_parametros.id_tipo_proceso || '   
						and  ee.id_tipo_estado_padre = ' || v_parametros.id_tipo_estado_padre || '
				        and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;
		
	/*********************************    
 	#TRANSACCION:  'WF_SIGEST_CONT'
 	#DESCRIPCION:	Conteo de registros de los siguientes estados posibles
 	#AUTOR:			RCM	
 	#FECHA:			15/10/2013
	***********************************/

	elsif(p_transaccion='WF_SIGEST_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tipes.id_tipo_estado)
                          from wf.ttipo_estado tipes
                          inner join segu.tusuario usu1 on usu1.id_usuario = tipes.id_usuario_reg
                          left join segu.tusuario usu2 on usu2.id_usuario = tipes.id_usuario_mod
                          inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = tipes.id_tipo_proceso
                          inner join  wf.testructura_estado ee on ee.id_tipo_estado_hijo = tipes.id_tipo_estado
                          where tipes.id_tipo_proceso = ' || v_parametros.id_tipo_proceso || '   
                          and  ee.id_tipo_estado_padre = ' || v_parametros.id_tipo_estado_padre || '
                          and ';
			
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
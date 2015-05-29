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
    v_tramite 			record;
    v_historico         varchar;
    
    v_inner varchar;
    v_strg_pro varchar;
    v_strg_obs  varchar;
    va_id_depto integer[];
			    
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
        
             select  
                 pxp.aggarray(depu.id_depto)
             into 
                   va_id_depto
            from param.tdepto_usuario depu 
            where depu.id_usuario =  p_id_usuario; 
        
             
          v_filtro='';
            
            IF v_parametros.tipo_interfaz = 'ProcesoWfIniTra' THEN
                 IF p_administrador !=1  then
                    v_filtro = ' (lower(tp.inicio)=''si'') and  (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' )   and ';
                 ELSE
                  v_filtro =' (lower(tp.inicio)=''si'') and ';
                END IF;
                 
            END IF;
            
            
            IF  v_parametros.tipo_interfaz = 'ProcesoWfVb' THEN
                IF p_administrador !=1 THEN
                    v_filtro = ' (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||'))) and ';
                ELSE
                     v_filtro = '  ((lower(tp.inicio)=''si''  and lower(te.inicio)!=''si'')   or lower(tp.inicio)=''no'')  and ';
                END IF;
            END IF;
            
            --interface para visto de procesos simple, generalemte usado en mobile
            IF  v_parametros.tipo_interfaz = 'VoBoProceso' THEN
                IF p_administrador !=1 THEN
                    v_filtro = ' (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||'))) and ';
                ELSE
                    -- v_filtro = '  ((lower(te.mobile)=''si''  and lower(te.inicio)!=''si'')   or lower(tp.inicio)=''no'')  and ';
                    v_filtro = '0=0 and ';
                END IF;
            END IF;
            
            
            IF  pxp.f_existe_parametro(p_tabla,'historico') THEN
             
             v_historico =  v_parametros.historico;
            
            ELSE
            
            v_historico = 'no';
            
            END IF;
            
            IF v_historico =  'si' THEN
            
               v_inner =   'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf';
               v_strg_pro = 'DISTINCT(pwf.id_proceso_wf)'; 
               v_strg_obs = '''---''::text';
               
               IF p_administrador =1 THEN
              
                  v_filtro = ' (lower(te.codigo)!=''borrador'' ) and ';
              
               END IF;
               
               
            
            ELSE
            
               v_inner =  'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and  ew.estado_reg = ''activo''';
               v_strg_pro = 'pwf.id_proceso_wf';
               v_strg_obs = 'ew.obs'; 
               
             END IF;
            
            
        
        
    		--Sentencia de la consulta
			v_consulta:='select 
                             '||v_strg_pro||',
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
                             '||v_strg_obs||'
                        from wf.tproceso_wf pwf
                           inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                           inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                           inner join wf.tproceso_macro pm on tp.id_proceso_macro =
                           pm.id_proceso_macro
                           '||v_inner||'
                           inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                           left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                           left join segu.vpersona per on per.id_persona = pwf.id_persona
                           left join param.tinstitucion int on int.id_institucion = pwf.id_institucion
                        where '||v_filtro;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

             raise notice 'CONSULTA->>  %',v_consulta;


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
        
           select  
                 pxp.aggarray(depu.id_depto)
             into 
                   va_id_depto
            from param.tdepto_usuario depu 
            where depu.id_usuario =  p_id_usuario; 
        
             
          v_filtro='';
            
            IF v_parametros.tipo_interfaz = 'ProcesoWfIniTra' THEN
                 IF p_administrador !=1  then
                    v_filtro = ' (lower(tp.inicio)=''si'') and  (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||' )   and ';
                 ELSE
                  v_filtro =' (lower(tp.inicio)=''si'') and ';
                END IF;
                 
                  
            
            END IF;
            
            
            IF  v_parametros.tipo_interfaz = 'ProcesoWfVb' THEN
                IF p_administrador !=1 THEN
                    v_filtro = ' (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||'))) and ';
                ELSE
                     v_filtro = '  ((lower(tp.inicio)=''si''  and lower(te.inicio)!=''si'')   or lower(tp.inicio)=''no'')  and ';
                END IF;
            END IF;
            
            
            IF  pxp.f_existe_parametro(p_tabla,'historico') THEN
             
             v_historico =  v_parametros.historico;
            
            ELSE
            
            v_historico = 'no';
            
            END IF;
            
            IF v_historico =  'si' THEN
            
               v_inner =   'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf';
               v_strg_pro = 'DISTINCT(pwf.id_proceso_wf)'; 
               v_strg_obs = '''---''::text';
               
               IF p_administrador =1 THEN
              
                  v_filtro = ' (lower(te.codigo)!=''borrador'' ) and ';
              
               END IF;
               
               
            
            ELSE
            
               v_inner =  'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and  ew.estado_reg = ''activo''';
               v_strg_pro = 'pwf.id_proceso_wf';
               v_strg_obs = 'ew.obs'; 
               
             END IF;
            
           
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count('||v_strg_pro||')
					    from wf.tproceso_wf pwf
                           inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                           inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                           inner join wf.tproceso_macro pm on tp.id_proceso_macro =
                           pm.id_proceso_macro
                           '||v_inner||'
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
        
   /*********************************    
 	#TRANSACCION:  'WF_VOBOWF_SEL'
 	#DESCRIPCION:	Consulta de vistos buenos pendietes de prceso WF
 	#AUTOR:		rac	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_VOBOWF_SEL')then
     				
    	begin
        
             select  
                 pxp.aggarray(depu.id_depto)
             into 
                   va_id_depto
            from param.tdepto_usuario depu 
            where depu.id_usuario =  p_id_usuario; 
        
             
          v_filtro='';
            
            --interface para visto de procesos simple, generalemte usado en mobile
            IF  v_parametros.tipo_interfaz = 'VoBoProceso' THEN
                IF p_administrador !=1 THEN
                    v_filtro = 'lower(te.mobile)=''si''  and (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||'))) and ';
                ELSE
                     v_filtro = ' lower(te.mobile)=''si''   and ';
                    --v_filtro = '0=0 and ';
                END IF;
            END IF;
            
            
            IF  pxp.f_existe_parametro(p_tabla,'historico') THEN
             
             v_historico =  v_parametros.historico;
            
            ELSE
            
            v_historico = 'no';
            
            END IF;
            
            IF v_historico =  'si' THEN
            
               v_inner =   'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf';
               v_strg_pro = 'DISTINCT(pwf.id_proceso_wf)'; 
               v_strg_obs = '''---''::text';
               
               IF p_administrador =1 THEN
              
                  v_filtro = ' (lower(te.codigo)!=''borrador'' ) and ';
              
               END IF;
               
               
            
            ELSE
            
               v_inner =  'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and  ew.estado_reg = ''activo''';
               v_strg_pro = 'pwf.id_proceso_wf';
               v_strg_obs = 'ew.obs'; 
               
             END IF;
            
            
        
        
    		--Sentencia de la consulta
			v_consulta:='select 
                             '||v_strg_pro||',
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
                             '||v_strg_obs||',
                             fea.desc_funcionario1,
                             dea.nombre as nombre_depto,
                             usu3.cuenta as usu_reg_ew,
                             te.nombre_estado as nombre_tipo_estado,
                             sub.nombre as nombre_subsistema,
                             sub.codigo as codigo_subsistema,
                             pwf.prioridad,
                             pwf.revisado_asistente,
                             (select count(*)
                             from unnest(id_tipo_estado_wfs) elemento
                             where elemento = ew.id_tipo_estado) as contador_estados
                        from wf.tproceso_wf pwf
                           inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                           inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                           inner join wf.tproceso_macro pm on tp.id_proceso_macro =
                           pm.id_proceso_macro
                           '||v_inner||'
                           inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                           inner join segu.tusuario usu3 on usu3.id_usuario = ew.id_usuario_reg
                           inner join segu.tsubsistema sub on sub.id_subsistema = pm.id_subsistema
                          
                           left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                           left join segu.vpersona per on per.id_persona = pwf.id_persona
                           left join param.tinstitucion int on int.id_institucion = pwf.id_institucion
                           left  join wf.testado_wf ewant on ewant.id_estado_wf = ew.id_estado_anterior
                           left  join orga.vfuncionario fea on fea.id_funcionario = ewant.id_funcionario
                           left  join param.tdepto  dea  on dea.id_depto = ewant.id_depto
                        where '||v_filtro;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

             raise notice 'CONSULTA->>  %',v_consulta;


			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_VOBOWF_CONT'
 	#DESCRIPCION:	Conteo de registros de Vistos buenos para el proceso WF (este listado se usa en la interface de mobile)
 	#AUTOR:		rac	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_VOBOWF_CONT')then

		begin
        
             select  
                   pxp.aggarray(depu.id_depto)
               into 
                     va_id_depto
              from param.tdepto_usuario depu 
              where depu.id_usuario =  p_id_usuario; 
              
             v_filtro='';
              
              --interface para visto de procesos simple, generalemte usado en mobile
             IF  v_parametros.tipo_interfaz = 'VoBoProceso' THEN
                IF p_administrador !=1 THEN
                    v_filtro = 'lower(te.mobile)=''si''  and (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||'))) and ';
                ELSE
                     v_filtro = ' lower(te.mobile)=''si''   and ';
                    --v_filtro = '0=0 and ';
                END IF;
             END IF;
          
               
            
              
              
              IF  pxp.f_existe_parametro(p_tabla,'historico') THEN
               
               v_historico =  v_parametros.historico;
              
              ELSE
              
              v_historico = 'no';
              
              END IF;
              
              IF v_historico =  'si' THEN
              
                 v_inner =   'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf';
                 v_strg_pro = 'DISTINCT(pwf.id_proceso_wf)'; 
                 v_strg_obs = '''---''::text';
                 
                 IF p_administrador =1 THEN
                
                    v_filtro = ' (lower(te.codigo)!=''borrador'' ) and ';
                
                 END IF;
                 
                 
              
              ELSE
              
                 v_inner =  'inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and  ew.estado_reg = ''activo''';
                 v_strg_pro = 'pwf.id_proceso_wf';
                 v_strg_obs = 'ew.obs'; 
                 
               END IF;
              
             
              --Sentencia de la consulta de conteo de registros
              v_consulta:='select count('||v_strg_pro||')
                          from wf.tproceso_wf pwf
                             inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                             inner join segu.tusuario usu1 on usu1.id_usuario = pwf.id_usuario_reg
                             inner join wf.tproceso_macro pm on tp.id_proceso_macro =  pm.id_proceso_macro
                             '||v_inner||'
                             inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                             inner join segu.tusuario usu3 on usu3.id_usuario = ew.id_usuario_reg
                             inner join segu.tsubsistema sub on sub.id_subsistema = pm.id_subsistema
                          
                             left join segu.tusuario usu2 on usu2.id_usuario = pwf.id_usuario_mod
                             left join segu.vpersona per on per.id_persona = pwf.id_persona
                             left join param.tinstitucion int on int.id_institucion = pwf.id_institucion
                             left  join wf.testado_wf ewant on ewant.id_estado_wf = ew.id_estado_anterior
                             left  join orga.vfuncionario fea on fea.id_funcionario = ewant.id_funcionario
                             left  join param.tdepto  dea  on dea.id_depto = ewant.id_depto
                          where '||v_filtro;
  			
              --Definicion de la respuesta		    
              v_consulta:=v_consulta||v_parametros.filtro;

              --Devuelve la respuesta
              return v_consulta;

		end; 
         
        
        
        
    /*********************************    
 	#TRANSACCION:  'WF_TRAWF_SEL'
 	#DESCRIPCION:	Consulta flujos de tramite
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		02-05-2013
	***********************************/

	elsif(p_transaccion='WF_TRAWF_SEL')then
    begin 
		select pwf.id_proceso_wf, pwf.id_estado_wf_prev, pwf.id_tipo_proceso into v_tramite
		from wf.tproceso_wf pwf
		where pwf.nro_tramite=v_parametros.nro_tramite;
        
        --Definicion de la respuesta         	
        v_consulta:='select ewf.fecha_reg, 
                      te.nombre_estado as estado,
                      tp.nombre as proceso,
                      COALESCE(fun.desc_funcionario1,''-'') as func,
                      COALESCE(dep.nombre,''-'') as depto
                      from wf.testado_wf ewf
                      INNER JOIN wf.tproceso_wf pwf on pwf.id_proceso_wf=ewf.id_proceso_wf
                      INNER JOIN wf.ttipo_proceso tp on tp.id_tipo_proceso=pwf.id_tipo_proceso
                      INNER JOIN wf.ttipo_estado te on te.id_tipo_estado=ewf.id_tipo_estado
                      LEFT JOIN orga.vfuncionario fun on fun.id_funcionario=ewf.id_funcionario
                      LEFT JOIN orga.tdepto dep on dep.id_depto=ewf.id_depto
                      where ewf.id_proceso_wf='||v_tramite.id_proceso_wf||'
                      order by ewf.id_estado_wf';
		raise notice '%', v_consulta;
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
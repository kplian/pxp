--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_centro_costo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_centro_costo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tcentro_costo'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 22:53:59
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
    v_filadd			varchar;
    v_codigo_subsistema	varchar;
    v_inner 			varchar;
			    
BEGIN

	v_nombre_funcion = 'param.f_centro_costo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CEC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	if(p_transaccion='PM_CEC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						 id_centro_costo,
                          estado_reg,
                          id_ep,
                          id_gestion,
                          id_uo,
                          id_usuario_reg,
                          fecha_reg,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          codigo_uo,
                          nombre_uo,
                          ep,
                          gestion,
                          codigo_cc,
                          nombre_programa,
         				  nombre_proyecto,
         				  nombre_actividad,
         				  nombre_financiador,
         				  nombre_regional,
                          movimiento_tipo_pres
						from pre.vpresupuesto_cc cec
						where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from pre.vpresupuesto_cc cec
                        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'PM_CENCOS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CENCOS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						  id_centro_costo,
                          estado_reg,
                          id_ep,
                          id_gestion,
                          id_uo,
                          id_usuario_reg,
                          fecha_reg,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          codigo_uo,
                          nombre_uo,
                          ep,
                          gestion,
                          codigo_cc,
                          nombre_programa,
         				  nombre_proyecto,
         				  nombre_actividad,
         				  nombre_financiador,
         				  nombre_regional,
                          cec.id_tipo_cc,
                          cec.codigo_tcc,
                          cec.descripcion_tcc 
						from param.vcentro_costo cec
						 where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CENCOS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CENCOS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from param.vcentro_costo cec
                        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
    
    
    /*********************************    
 	#TRANSACCION:  'PM_CECCOM_SEL'
 	#DESCRIPCION:	Consulta de datos de centro de costo combo
 	#AUTOR:		admin	
 	#FECHA:		07-05-2013 22:53:59
	***********************************/				
	elsif(p_transaccion='PM_CECCOM_SEL')then
    	     				
    	begin
        
         /*********   NOTA     ***********************
        *
        *   PARA AUMENTAR CAMPOS EN LA COSULTA AUMENTAR TAMBIEN EN 
        *         PM_CCFILDEP_SEL
        *        PM_CECCOMFU_SEL
        *        PM_CECCOM_SEL
        *  ESTO POR QUE ESTA TRES CONSULTAS UTILIZAN EL MISMO COMBO REC PARA MOSTRAR LOS RESULTADOS
        * 
        **********************************/
        
        
          v_filadd = '';
          v_codigo_subsistema = NULL;
          if (pxp.f_existe_parametro(p_tabla,'codigo_subsistema')) then
          	v_codigo_subsistema = v_parametros.codigo_subsistema;
          end if;
          IF   p_administrador != 1 THEN
          		v_filadd='(cec.id_ep  in ('|| param.f_get_lista_ccosto_x_usuario(p_id_usuario, v_codigo_subsistema)  ||')) and';
          END IF;
    		--Sentencia de la consulta
			v_consulta:='select
						 cec.id_centro_costo,
                          cec.estado_reg,
                          cec.id_ep,
                          cec.id_gestion,
                          cec.id_uo,
                          cec.id_usuario_reg,
                          cec.fecha_reg,
                          cec.id_usuario_mod,
                          cec.fecha_mod,
                          cec.usr_reg,
                          cec.usr_mod,
                          cec.codigo_uo,
                          cec.nombre_uo,
                          cec.ep,
                          cec.gestion,
                          cec.codigo_cc	,
                          cec.nombre_programa,
         				  cec.nombre_proyecto,
         				  cec.nombre_actividad,
         				  cec.nombre_financiador,
         				  cec.nombre_regional,
                          cec.movimiento_tipo_pres
						from pre.vpresupuesto_cc cec
						 WHERE '||v_filadd;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise exception '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CECCOM_CONT'
 	#DESCRIPCION:	Conteo de registros centro de costo combo
 	#AUTOR:		admin	
 	#FECHA:		07-05-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CECCOM_CONT')then

		begin
          v_filadd = '';
          v_codigo_subsistema = NULL;
          if (pxp.f_existe_parametro(p_tabla,'codigo_subsistema')) then
          	v_codigo_subsistema = v_parametros.codigo_subsistema;
          end if;
          IF   p_administrador != 1 THEN
          		v_filadd='(cec.id_ep  in ('|| param.f_get_lista_ccosto_x_usuario(p_id_usuario, v_codigo_subsistema)  ||')) and';
          END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from pre.vpresupuesto_cc cec
                        WHERE '||v_filadd;
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;
			
			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'PM_CECCOMFU_SEL'
 	#DESCRIPCION:	Consulta de datos de centro de costo combo filtrado por grupo_ep del usuario
 	#AUTOR:		admin	
 	#FECHA:		31-05-2013 22:53:59
	***********************************/				
	elsif(p_transaccion='PM_CECCOMFU_SEL')then
    	     				
    	begin
        
         /*********   NOTA     ***********************
        *
        *   PARA AUMENTAR CAMPOS EN LA COSULTA AUMENTAR TAMBIEN EN 
        *         PM_CCFILDEP_SEL
        *        PM_CECCOMFU_SEL
        *        PM_CECCOM_SEL
        *  ESTO POR QUE ESTA TRES CONSULTAS UTILIZAN EL MISMO COMBO REC PARA MOSTRAR LOS RESULTADOS
        * 
        **********************************/
          v_filadd = '';
          v_inner='';
          
          IF   p_administrador != 1 THEN
          
              select 
              pxp.list(uge.id_grupo::text)
              into 
              v_filadd  
             from segu.tusuario_grupo_ep uge 
             where  uge.id_usuario = p_id_usuario;
              
              v_inner =  'inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                            
                                 ((gep.id_uo = cec.id_uo  and gep.id_ep = cec.id_ep )
                               or 
                                 (gep.id_uo = cec.id_uo  and gep.id_ep is NULL )
                               or
                                 (gep.id_uo is NULL and gep.id_ep = cec.id_ep )) and gep.id_grupo in ('||COALESCE(v_filadd,'0')||') ';
              		
             
               
          
          END IF;
    		--Sentencia de la consulta
			v_consulta:='select
						 cec.id_centro_costo,
                         cec. estado_reg,
                          cec.id_ep,
                          cec.id_gestion,
                          cec.id_uo,
                          cec.id_usuario_reg,
                          cec.fecha_reg,
                          cec.id_usuario_mod,
                          cec.fecha_mod,
                          cec.usr_reg,
                          cec.usr_mod,
                          cec.codigo_uo,
                          cec.nombre_uo,
                          cec.ep,
                          cec.gestion,
                          cec.codigo_cc,
                          cec.nombre_programa,
         				  cec.nombre_proyecto,
         				  cec.nombre_actividad,
         				  cec.nombre_financiador,
         				  cec.nombre_regional,
                          cec.movimiento_tipo_pres
						from pre.vpresupuesto_cc cec
                        '||v_inner||'
						 WHERE ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise exception '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CECCOMFU_CONT'
 	#DESCRIPCION:	Conteo de registros centro de costo combo
 	#AUTOR:		admin	
 	#FECHA:		07-05-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CECCOMFU_CONT')then

		begin
          v_filadd = '';
          v_inner='';
          
           IF   p_administrador != 1 THEN
          
              select 
              pxp.list(uge.id_grupo::text)
              into 
              v_filadd  
              from segu.tusuario_grupo_ep uge 
              where  uge.id_usuario = p_id_usuario;
              
              v_inner =  'inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                            
                                 ((gep.id_uo = cec.id_uo  and gep.id_ep = cec.id_ep )
                               or 
                                 (gep.id_uo = cec.id_uo  and gep.id_ep is NULL )
                               or
                                 (gep.id_uo is NULL and gep.id_ep = cec.id_ep )) and gep.id_grupo in ('||COALESCE(v_filadd,'0')||') ';
              		
             
               
          
          END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_centro_costo)
					    from pre.vpresupuesto_cc cec
                         '||v_inner||'
                        WHERE ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;
			
			--Devuelve la respuesta
			return v_consulta;

		end;				
	/*********************************    
 	#TRANSACCION:  'PM_CCFILDEP_SEL'
 	#DESCRIPCION:	Consulta  de centro de costos filtrado por el departamento que llega como parametros id_depto
                    ademas si la opcio filtrar = grupo_ep ademas anhade al filtro las 
                    lo grupo_de ep correspondiente al usuario
 	#AUTOR:		rac	
 	#FECHA:		03-06-2013 22:53:59
	***********************************/				
	elsif(p_transaccion='PM_CCFILDEP_SEL')then
    	     				
    	begin
        
        
       /*********   NOTA     ***********************
        *
        *   PARA AUMENTAR CAMPOS EN LA COSULTA AUMENTAR TAMBIEN EN 
        *         PM_CCFILDEP_SEL
        *        PM_CECCOMFU_SEL
        *        PM_CECCOM_SEL
        *  ESTO POR QUE ESTA TRES CONSULTAS UTILIZAN EL MISMO COMBO REC PARA MOSTRAR LOS RESULTADOS
        * 
        **********************************/
        
        
          v_filadd = '';
          v_inner='';
          
     
          
          IF   p_administrador != 1   and  pxp.f_existe_parametro(p_tabla,'filtrar')  THEN
          
        
              IF v_parametros.filtrar = 'grupo_ep'  THEN
                  select 
                  pxp.list(uge.id_grupo::text)
                  into 
                  v_filadd  
                 from segu.tusuario_grupo_ep uge 
                 where  uge.id_usuario = p_id_usuario;
                  
                  v_inner =  'inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                                
                                     ((gep.id_uo = cec.id_uo  and gep.id_ep = cec.id_ep )
                                   or 
                                     (gep.id_uo = cec.id_uo  and gep.id_ep is NULL )
                                   or
                                     (gep.id_uo is NULL and gep.id_ep = cec.id_ep )) and gep.id_grupo in ('||COALESCE(v_filadd,'0')||') ';
                  		
                 
               END IF;    
               
            
          
          END IF;
        
        
        
        
    		--Sentencia de la consulta
			v_consulta:='select
                         DISTINCT
						 cec.id_centro_costo,
                         cec. estado_reg,
                          cec.id_ep,
                          cec.id_gestion,
                          cec.id_uo,
                          cec.id_usuario_reg,
                          cec.fecha_reg,
                          cec.id_usuario_mod,
                          cec.fecha_mod,
                          cec.usr_reg,
                          cec.usr_mod,
                          cec.codigo_uo,
                          cec.nombre_uo,
                          cec.ep,
                          cec.gestion,
                          cec.codigo_cc,
                          cec.nombre_programa,
         				  cec.nombre_proyecto,
         				  cec.nombre_actividad,
         				  cec.nombre_financiador,
         				  cec.nombre_regional,
                          cec.movimiento_tipo_pres
						from pre.vpresupuesto_cc cec
                        inner join param.tdepto_uo_ep due on due.estado_reg = ''activo'' and
                            
                                 ((due.id_uo = cec.id_uo  and due.id_ep = cec.id_ep )
                               or 
                                 (due.id_uo = cec.id_uo  and due.id_ep is NULL )
                               or
                                 (due.id_uo is NULL and due.id_ep = cec.id_ep )) 
                                 
                                 
                                 and due.id_depto = '||COALESCE(v_parametros.id_depto,0)||'
						 '||v_inner||'
                        
                         WHERE ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CCFILDEP_CONT'
 	#DESCRIPCION:	Conteo de registros de la Consulta  de centro de costos filtrado por el departamento que llega como parametros id_depto
 	#AUTOR:		rac	
 	#FECHA:		03-06-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CCFILDEP_CONT')then

		begin
        
          v_filadd = '';
          v_inner='';
          
          IF   p_administrador != 1   and  pxp.f_existe_parametro(p_tabla,'filtrar')  THEN
          
          
              IF v_parametros.filtrar = 'grupo_ep'  THEN
                  select 
                  pxp.list(uge.id_grupo::text)
                  into 
                  v_filadd  
                 from segu.tusuario_grupo_ep uge 
                 where  uge.id_usuario = p_id_usuario;
                  
                  v_inner =  'inner join param.tgrupo_ep gep on gep.estado_reg = ''activo'' and
                                
                                     ((gep.id_uo = cec.id_uo  and gep.id_ep = cec.id_ep )
                                   or 
                                     (gep.id_uo = cec.id_uo  and gep.id_ep is NULL )
                                   or
                                     (gep.id_uo is NULL and gep.id_ep = cec.id_ep )) and gep.id_grupo in ('||v_filadd||') ';
                  		
                 
               END IF;    
          
          END IF;
      
        
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(DISTINCT id_centro_costo)
					    from pre.vpresupuesto_cc cec
                        inner join param.tdepto_uo_ep due on due.estado_reg = ''activo'' and
                            
                                 ((due.id_uo = cec.id_uo  and due.id_ep = cec.id_ep )
                               or 
                                 (due.id_uo = cec.id_uo  and due.id_ep is NULL )
                               or
                                 (due.id_uo is NULL and due.id_ep = cec.id_ep )) 
                                 
                                 
                                 and due.id_depto = '||COALESCE(v_parametros.id_depto,0)||'
                         '||v_inner||'
						 WHERE';
			
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
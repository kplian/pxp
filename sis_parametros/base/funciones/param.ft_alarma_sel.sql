CREATE OR REPLACE FUNCTION param.ft_alarma_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_alarma_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.talarma'
 AUTOR: 		 (fprudencio)
 FECHA:	        18-11-2011 11:59:10
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
    v_id_funcionario 	integer;
    v_filtro 			varchar;
    v_cond				varchar;
    v_registros			record;


	v_id_alarma INTEGER;
	ret varchar;
	aux int;
			    
BEGIN
                                                    
	v_nombre_funcion = 'param.ft_alarma_sel';
    v_parametros = pxp.f_get_record(p_tabla);
    
   -- v_filtro = '';
   
   /*********************************    
 	#TRANSACCION:  'PM_ALARMCOR_SEL'
 	#DESCRIPCION:	Consulta de alarmas pendientes de envio de correo no se utiliza con pagiancion
 	#AUTOR:		rarteaga	
 	#FECHA:		7-03-2012 11:59:10
	***********************************/

	if(p_transaccion='PM_ALARMCOR_SEL')then
     				
    	begin
            
           --Sentencia de la consulta
			v_consulta:='
                        select
						alarm.id_alarma,
                        
                         pxp.f_iif(funcio.id_funcionario is NULL, pxp.f_iif(fnciousu.id_funcionario is NULL,per.correo, fnciousu.email_empresa  )  ,funcio.email_empresa)
                        AS email_empresa,
                        
                        alarm.fecha,
						alarm.descripcion,
					    alarm.clase,
                        alarm.titulo,
                        alarm.obs,
                        alarm.tipo,
                        (alarm.fecha-now()::date)::integer as dias,
                        alarm.titulo_correo,
						alarm.acceso_directo,
						alarm.correos,
						alarm.documentos,
                        alarm.id_plantilla_correo,
                        pc.url_acuse,
                        pc.requiere_acuse,
                        pc.mensaje_link_acuse,
                        to_char(now(),''YYYYMMDD-HH24MISSMS'')::varchar as pendiente
                        from param.talarma alarm
						left join orga.tfuncionario funcio on funcio.id_funcionario=alarm.id_funcionario
                        left join segu.tusuario usu on usu.id_usuario =alarm.id_usuario
                        --left join segu.tusuario_rol urol on urol.id_usuario =usu.id_usuario and urol.estado_reg = ''activo'' and urol.id_rol = 1
                        left join segu.tpersona per on per.id_persona = usu.id_persona
                        left join orga.tfuncionario fnciousu on fnciousu.id_persona=per.id_persona
                        left join wf.tplantilla_correo pc on pc.id_plantilla_correo = alarm.id_plantilla_correo
                        where alarm.pendiente = ''no'' and alarm.estado_envio = ''exito''  and alarm.sw_correo = 0';
                        
                  
             for v_registros in execute(v_consulta) loop
             	update param.talarma set pendiente = v_registros.pendiente
                where id_alarma = v_registros.id_alarma;
                           
             end loop;
             
             
             	
             	v_consulta = replace(v_consulta, 'alarm.pendiente = ''no''', 'alarm.pendiente = ''' || coalesce(v_registros.pendiente,'x') || '''');
			 
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ALARM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		18-11-2012 11:59:10
	***********************************/

	elseif(p_transaccion='PM_ALARM_SEL')then
     				
    	begin
        
        	if p_administrador != 1 then
            	v_cond = '(usua.id_usuario =  '||v_parametros.id_usuario||'
                		or funcio.id_funcionario = '||(COALESCE(v_parametros.id_funcionario,'0'))::varchar ||'  ) and ';
            else
            	v_cond = '0=0 and alarm.tipo not in (''comunicado'') and ';
            end if;
         
         
    		--Sentencia de la consulta
			v_consulta:='SELECT
                     	alarm.id_alarma,
						alarm.acceso_directo,
						alarm.id_funcionario,
						alarm.fecha,
						alarm.estado_reg,
						alarm.descripcion,
						alarm.id_usuario_reg,
						alarm.fecha_reg,
						alarm.id_usuario_mod,
						alarm.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        alarm.clase,
                        alarm.titulo,
                        alarm.parametros,
                        alarm.obs,
                        alarm.tipo,
                        (alarm.fecha-now()::date)::integer as dias,
                        alarm.titulo_correo,
                        alarm.id_usuario
						from param.talarma alarm
						inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
                        left join orga.tfuncionario funcio on funcio.id_funcionario=alarm.id_funcionario   
                        left join segu.tusuario usua  on  usua.id_usuario = alarm.id_usuario
				        where ';
            v_consulta = v_consulta || v_cond;
				       
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ALARM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_ALARM_CONT')then

		begin
        	if p_administrador != 1 then
            	v_cond = '(usua.id_usuario =  '||v_parametros.id_usuario||'
                		or funcio.id_funcionario = '||(COALESCE(v_parametros.id_funcionario,'0'))::varchar ||'  ) and ';
            else
            	v_cond = '0=0 and alarm.tipo not in (''comunicado'') and ';
            end if;
            
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_alarma)
					    from param.talarma alarm
					    inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
                        left join orga.tfuncionario funcio on funcio.id_funcionario=alarm.id_funcionario   
                        left join segu.tusuario usua  on  usua.id_usuario = alarm.id_usuario
				        where ';
            v_consulta = v_consulta || v_cond;
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************    
 	#TRANSACCION:  'PM_ALARM_PEND'
 	#DESCRIPCION:	Cuenta cuantas alarmas tiene pendientes el funcionario
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_ALARM_PEND')then

		begin
          
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_alarma) as total
					    from param.talarma alarm
					    inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
                        inner join orga.tfuncionario funcio on funcio.id_funcionario=alarm.id_funcionario   
                        inner join segu.vpersona person on person.id_persona=funcio.id_persona
				        where  alarm.estado_reg=''activo'' AND alarm.id_funcionario in(Select fun.id_funcionario
            																	      from orga.tfuncionario fun
            																		  inner join segu.tusuario usu on usu.id_persona=fun.id_persona
                                                                                      where usu.id_usuario='||p_id_usuario||') AND ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;	
        
     /*********************************    
 	#TRANSACCION:  'PM_GETALA_SEL'
 	#DESCRIPCION:	recupera datos de la alerta especificada
 	#AUTOR:		rensi	
 	#FECHA:		21-04-2014 11:59:10
	***********************************/

	elsif(p_transaccion='PM_GETALA_SEL')then

		begin
			--Sentencia de la eliminacion
            
           v_consulta =  'SELECT
                     	alarm.id_alarma,
						alarm.acceso_directo,
						alarm.id_funcionario,
						alarm.fecha,
						alarm.estado_reg,
						alarm.descripcion,
						alarm.id_usuario_reg,
						alarm.fecha_reg,
						alarm.id_usuario_mod,
						alarm.fecha_mod,
						alarm.clase,
                        alarm.titulo,
                        alarm.parametros,
                        alarm.obs,
                        alarm.tipo,
                        (alarm.fecha-now()::date)::integer as dias
						from param.talarma alarm
						where alarm.id_alarma='||v_parametros.id_alarma;
            
            --Devuelve la respuesta
			return v_consulta;
			
            

		end;    
    /*********************************    
 	#TRANSACCION:  'PM_ALARMWF_SEL'
 	#DESCRIPCION:	consulta par ala interface de correos, para ver acuses de recibo, fallar y permitir el reenvio de correos
 	#AUTOR:		rac	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elseif(p_transaccion='PM_ALARMWF_SEL')then
     				
    	begin
        
        	--raise exception 'dddddddddddddddddd';
    		--Sentencia de la consulta
			v_consulta:='SELECT
                     	alarm.id_alarma,
                        alarm.sw_correo,
                        alarm.correos,
                        alarm.descripcion,
                        alarm.recibido,
                        alarm.fecha_recibido,
                        alarm.estado_envio,
                        alarm.desc_falla,
                        alarm.titulo_correo,
                        (alarm.fecha-now()::date)::integer as dias
						from param.talarma alarm
						inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
				        where ';
				       
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ALARMWF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		18-11-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_ALARMWF_CONT')then

		begin
        	
            
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_alarma)
					    from param.talarma alarm
						inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
				        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;    			
	
    /*********************************    
 	#TRANSACCION:  'PM_COMUN_SEL'
 	#DESCRIPCION:	lista de alarmas del tipo comunicados
 	#AUTOR:		rac	
 	#FECHA:		11/04/2016  11:59:10
	***********************************/

	elseif(p_transaccion='PM_COMUN_SEL')then
     				
    	begin
        
        	-- Sentencia de la consulta
			v_consulta:='SELECT
                     	alarm.id_alarma,
						alarm.acceso_directo,
						alarm.id_funcionario,
						alarm.fecha,
						alarm.estado_reg,
						alarm.descripcion,
						alarm.id_usuario_reg,
						alarm.fecha_reg,
						alarm.id_usuario_mod,
						alarm.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        alarm.clase,
                        alarm.titulo,
                        alarm.parametros,
                        alarm.obs,
                        alarm.tipo,
                        (alarm.fecha-now()::date)::integer as dias,
                        alarm.id_alarma_fk,
                        alarm.estado_comunicado,
                        array_to_string( alarm.id_uos,'','',''null'')::varchar as id_uos,
                        alarm.titulo_correo
						
                        
                        from param.talarma alarm
                        
						inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
				        where alarm.id_alarma_fk is null and alarm.tipo = ''comunicado''  and  ';
           
        
				       
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_COMUN_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		11/04/2016 11:59:10
	***********************************/

	elsif(p_transaccion='PM_COMUN_CONT')then

		begin
        	
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_alarma)
					    from param.talarma alarm
                        inner join segu.tusuario usu1 on usu1.id_usuario = alarm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = alarm.id_usuario_mod
				        where alarm.id_alarma_fk is null and alarm.tipo = ''comunicado''  and ';
           
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;


		/*********************************
   #TRANSACCION:  'PM_NOTISOCKET_SEL'
   #DESCRIPCION:	lista de alarmas para ser usado en el websocket
   #AUTOR:		favio figueroa
   #FECHA:		11/07/2017  11:59:10
  ***********************************/

	elseif(p_transaccion='PM_NOTISOCKET_SEL')then

		begin


			ret := '';
			FOR aux IN
			UPDATE param.talarma
			SET estado_notificacion = 'enviado'
			WHERE estado_notificacion = 'pendiente'
			RETURNING id_alarma
			LOOP
				ret := ret || aux || ',';
			END LOOP;

			ret = ret || '0';


			-- Sentencia de la consulta
			v_consulta:='SELECT
                     	alarm.id_usuario,
                     	upper(alarm.tipo) as titulo,
                     	alarm.titulo_correo
                        from param.talarma alarm
				        where alarm.id_alarma in ('|| ret ||')';






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
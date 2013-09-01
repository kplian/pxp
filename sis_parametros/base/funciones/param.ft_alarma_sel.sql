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
            
        --raise exception 'XXXXxxxx';
        
            --Sentencia de la consulta
			v_consulta:='
                        select
						alarm.id_alarma,
                        Case COALESCE( funcio.id_funcionario,0)  
                          when  0  THEN
                          
                            per.correo   
                        	
                          ELSE 
                            funcio.email_empresa
                          end as email_empresa,
						alarm.fecha,
						alarm.descripcion,
					    alarm.clase,
                        alarm.titulo,
                        alarm.obs,
                        alarm.tipo,
                        (alarm.fecha-now()::date)::integer as dias,
                         alarm.titulo_correo
						from param.talarma alarm
						left join orga.tfuncionario funcio on funcio.id_funcionario=alarm.id_funcionario
                        left join segu.tusuario usu on usu.id_usuario =alarm.id_usuario
                        left join segu.tpersona per on per.id_persona = usu.id_persona
                        where alarm.sw_correo = 0';
                        
             --modificar correpondencia
           /*  update param.talarma 
             set sw_correo = 1
             where sw_correo = 0;*/
			
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
            	v_cond = '0=0 and ';
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
                        (alarm.fecha-now()::date)::integer as dias
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
            	v_cond = '0=0 and ';
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
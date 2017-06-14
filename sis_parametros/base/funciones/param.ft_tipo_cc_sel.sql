--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_tipo_cc_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_cc_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_cc'
 AUTOR: 		 (admin)
 FECHA:	        26-05-2017 10:10:19
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
    v_where			varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_tipo_cc_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TCC_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	if(p_transaccion='PM_TCC_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='SELECT 
                          id_tipo_cc,
                          codigo,
                          control_techo,
                          mov_pres,
                          estado_reg,
                          movimiento,
                          id_ep,
                          id_tipo_cc_fk,
                          descripcion,
                          tipo,
                          control_partida,
                          momento_pres,
                          fecha_reg,
                          usuario_ai,
                          id_usuario_reg,
                          id_usuario_ai,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          desc_ep,
                          fecha_inicio,
                          fecha_final
                        FROM   param.vtipo_cc_mov  tcc
				        where   ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice  'Consulta...%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TCC_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	elsif(p_transaccion='PM_TCC_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='SELECT count(id_tipo_cc)
					     FROM   param.vtipo_cc_mov tcc
				         WHERE  ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
     /*********************************    
 	#TRANSACCION:  'PM_TCCALL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	elsif(p_transaccion='PM_TCCALL_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='SELECT 
                          id_tipo_cc,
                          codigo,
                          control_techo,
                          mov_pres,
                          estado_reg,
                          movimiento,
                          id_ep,
                          id_tipo_cc_fk,
                          descripcion,
                          tipo,
                          control_partida,
                          momento_pres,
                          fecha_reg,
                          usuario_ai,
                          id_usuario_reg,
                          id_usuario_ai,
                          id_usuario_mod,
                          fecha_mod,
                          usr_reg,
                          usr_mod,
                          desc_ep,
                          fecha_inicio,
                          fecha_final
                        FROM   param.vtipo_cc  tcc
				        where   ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
            raise notice  'Consulta...%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TCCALL_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	elsif(p_transaccion='PM_TCCALL_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='SELECT count(id_tipo_cc)
					     FROM   param.vtipo_cc tcc
				         WHERE  ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;   
        
	/*********************************   
     #TRANSACCION:  'PM_TCCARB_SEL'
     #DESCRIPCION:    Consulta tipos de centro de costo en formato arbol
     #AUTOR:          Rensi Arteaga
     #FECHA:          26-05-2017
    ***********************************/

    elseif(p_transaccion='PM_TCCARB_SEL')then
                    
        begin       
              if(v_parametros.node = 'id') then
                v_where := ' tcc.id_tipo_cc_fk is NULL  ';   
                     
              else
                v_where := ' tcc.id_tipo_cc_fk = '||v_parametros.node;
              end if;
              
            
              
              v_consulta:='select
                            tcc.id_tipo_cc,
                            tcc.codigo,
                            tcc.control_techo,
                            array_to_string(tcc.mov_pres,'','')::varchar as mov_pres,
                            tcc.estado_reg,
                            tcc.movimiento,
                            tcc.id_ep,
                            tcc.id_tipo_cc_fk,
                            tcc.descripcion,
                            tcc.tipo,
                            tcc.control_partida,
                            array_to_string(tcc.momento_pres,'','')::varchar as momento_pres,
                            tcc.fecha_reg,
                            tcc.usuario_ai,
                            tcc.id_usuario_reg,
                            tcc.id_usuario_ai,
                            tcc.id_usuario_mod,
                            tcc.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            tcc.fecha_inicio,
                            tcc.fecha_final,
                          case
                          when (tcc.movimiento=''si'' )then
                               ''hoja''::varchar
                          when (tcc.movimiento=''no'' )then
                               ''hijo''::varchar
                          END as tipo_nodo ,
                        ep.ep::varchar as desc_ep	
						from param.ttipo_cc tcc
                        inner join segu.tusuario usu1 on usu1.id_usuario = tcc.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tcc.id_usuario_mod
                        left join param.vep ep on ep.id_ep = tcc.id_ep
				        where  '||v_where|| ' 
                              and tcc.estado_reg = ''activo''
                              ORDER BY tcc.id_tipo_cc';
                              
                              
                        
       
       
            
            raise notice '%',v_consulta;
           
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
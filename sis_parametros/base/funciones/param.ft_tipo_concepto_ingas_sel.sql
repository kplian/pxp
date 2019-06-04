CREATE OR REPLACE FUNCTION param.ft_tipo_concepto_ingas_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_concepto_ingas_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_concepto_ingas'
 AUTOR: 		 (egutierrez)
 FECHA:	        29-04-2019 13:28:44
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				29-04-2019 13:28:44								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.ttipo_concepto_ingas'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'param.ft_tipo_concepto_ingas_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TICOING_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		egutierrez	
 	#FECHA:		29-04-2019 13:28:44
	***********************************/

	if(p_transaccion='PM_TICOING_SEL')then
                     
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        ticoing.id_tipo_concepto_ingas,
                        ticoing.nombre,
                        ticoing.descripcion,
                        ticoing.id_concepto_ingas,
                        ticoing.estado_reg,
                        ticoing.id_usuario_ai,
                        ticoing.id_usuario_reg,
                        ticoing.usuario_ai,
                        ticoing.fecha_reg,
                        ticoing.fecha_mod,
                        ticoing.id_usuario_mod,
                        usu1.cuenta as usr_reg,
                        usu2.cuenta as usr_mod    
                        from param.ttipo_concepto_ingas ticoing
                        inner join segu.tusuario usu1 on usu1.id_usuario = ticoing.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ticoing.id_usuario_mod
                        where  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                        
        end;

    /*********************************    
     #TRANSACCION:  'PM_TICOING_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        egutierrez    
     #FECHA:        29-04-2019 13:28:44
    ***********************************/

    elsif(p_transaccion='PM_TICOING_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_tipo_concepto_ingas)
                        from param.ttipo_concepto_ingas ticoing
                        inner join segu.tusuario usu1 on usu1.id_usuario = ticoing.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ticoing.id_usuario_mod
                        where ';
            
            --Definicion de la respuesta            
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;
    /*********************************    
 	#TRANSACCION:  'PM_TICOINGCOM_SEL'
 	#DESCRIPCION:	Consulta de datospara el combo
 	#AUTOR:		egutierrez	
 	#FECHA:		29-04-2019 13:28:44
	***********************************/

	elsif(p_transaccion='PM_TICOINGCOM_SEL')then
                     
        begin
            --Sentencia de la consulta
            v_consulta:='select
                        ticoing.id_tipo_concepto_ingas,
                        ticoing.nombre as nombre_tipcoing,
                        ticoing.descripcion,
                        ticoing.id_concepto_ingas    
                        from param.ttipo_concepto_ingas ticoing
                        inner join segu.tusuario usu1 on usu1.id_usuario = ticoing.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ticoing.id_usuario_mod
                        where  ';
            
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            --Devuelve la respuesta
            return v_consulta;
                        
        end;

    /*********************************    
     #TRANSACCION:  'PM_TICOINGCOM_CONT'
     #DESCRIPCION:    Conteo de registros
     #AUTOR:        egutierrez    
     #FECHA:        29-04-2019 13:28:44
    ***********************************/

    elsif(p_transaccion='PM_TICOINGCOM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='select count(id_tipo_concepto_ingas)
                        from param.ttipo_concepto_ingas ticoing
                        inner join segu.tusuario usu1 on usu1.id_usuario = ticoing.id_usuario_reg
                        left join segu.tusuario usu2 on usu2.id_usuario = ticoing.id_usuario_mod
                        where ';
            
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_plantilla_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Contabilidad
 FUNCION: 		param.f_plantilla_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tplantilla'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        01-04-2013 21:49:11
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

	v_nombre_funcion = 'param.f_plantilla_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PLT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	if(p_transaccion='PM_PLT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
                            plt.id_plantilla,
                            plt.estado_reg,
                            plt.desc_plantilla,
                            plt.sw_tesoro,
                            plt.sw_compro,
                            plt.nro_linea,
                            plt.tipo,
                            plt.fecha_reg,
                            plt.id_usuario_reg,
                            plt.fecha_mod,
                            plt.id_usuario_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            plt.sw_monto_excento,
                            plt.sw_descuento ,
                            plt.sw_autorizacion,
                            plt.sw_codigo_control,
                            plt.tipo_plantilla,
                            plt.sw_ic,
                            plt.sw_nro_dui,
                            plt.tipo_excento,
                            plt.valor_excento,
                            plt.tipo_informe,
                            plt.sw_qr,
                            plt.sw_nit,
                            COALESCE(plt.plantilla_qr,''''),
                            plt.sw_estacion,
                            plt.sw_punto_venta,
                            plt.sw_cod_no_iata
						from param.tplantilla plt
						inner join segu.tusuario usu1 on usu1.id_usuario = plt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plt.id_usuario_mod
				        where  ';
                        
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PLT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		01-04-2013 21:49:11
	***********************************/

	elsif(p_transaccion='PM_PLT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plantilla)
					    from param.tplantilla plt
					    inner join segu.tusuario usu1 on usu1.id_usuario = plt.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = plt.id_usuario_mod
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
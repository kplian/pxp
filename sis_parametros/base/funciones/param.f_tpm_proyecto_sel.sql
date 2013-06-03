CREATE OR REPLACE FUNCTION param.f_tpm_proyecto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tpm_proyecto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tpm_proyecto'
 AUTOR: 		 (rac)
 FECHA:	        26-10-2011 11:40:13
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
    v_addfil varchar;
			    
BEGIN

	v_nombre_funcion = 'param.f_tpm_proyecto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PRO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		rac	
 	#FECHA:		26-10-2011 11:40:13
	***********************************/

	if(p_transaccion='PM_PRO_SEL')then
     				
    	begin
            --si existe el parametro hidro lo aplicamos en un filtro
            v_addfil='';
            if(pxp.f_existe_parametro(p_tabla,'hidro'))THEN
            v_addfil=' ( pro.hidro='''||v_parametros.hidro||''') AND ';
            
            END IF;
        
    		--Sentencia de la consulta
			v_consulta:='select
						pro.id_proyecto,
						pro.id_usuario,
						pro.descripcion_proyecto,
						pro.codigo_sisin,
						pro.hora_ultima_modificacion,
						pro.codigo_proyecto,
						pro.hora_registro,
						pro.nombre_corto,
						pro.fecha_ultima_modificacion,
						pro.fecha_registro,
						pro.nombre_proyecto,
						pro.id_proyecto_actif
						from param.tpm_proyecto pro
						where  '||v_addfil;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2011 11:40:13
	***********************************/

	elsif(p_transaccion='PM_PRO_CONT')then

		begin
            v_addfil='';
            if(pxp.f_existe_parametro(p_tabla,'hidro'))THEN
            v_addfil=' (pro.hidro='''||v_parametros.hidro||''') AND ';
            
            END IF;
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_proyecto)
					    from param.tpm_proyecto pro
					    where '||v_addfil;
			
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
    LANGUAGE plpgsql;
--
-- Definition for function f_tproveedor_ime (OID = 304020) : 
--

--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_plantilla_correo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_plantilla_correo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tplantilla_correo'
 AUTOR: 		 (jrivera)
 FECHA:	        20-08-2014 21:52:38
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

	v_nombre_funcion = 'wf.ft_plantilla_correo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PCORREO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		jrivera	
 	#FECHA:		20-08-2014 21:52:38
	***********************************/

	if(p_transaccion='WF_PCORREO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pcorreo.id_plantilla_correo,
						pcorreo.id_tipo_estado,
						pcorreo.regla,
						pcorreo.plantilla,
						array_to_string(pcorreo.correos, '','') as correos,
						pcorreo.codigo_plantilla,
						array_to_string(pcorreo.documentos, '','') as documentos,
						pcorreo.estado_reg,
						pcorreo.id_usuario_ai,
						pcorreo.id_usuario_reg,
						pcorreo.fecha_reg,
						pcorreo.usuario_ai,
						pcorreo.fecha_mod,
						pcorreo.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						pcorreo.asunto,
                        pcorreo.requiere_acuse,
                        pcorreo.mensaje_acuse,
                        pcorreo.url_acuse,
                        pcorreo.mensaje_link_acuse,
                        pcorreo.mandar_automaticamente,
                        pcorreo.funcion_acuse_recibo,
                        pcorreo.funcion_creacion_correo,
                        array_to_string(pcorreo.cc, '''','''') as cc,
                        array_to_string(pcorreo.bcc, '''','''') as bcc
						from wf.tplantilla_correo pcorreo
						inner join segu.tusuario usu1 on usu1.id_usuario = pcorreo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pcorreo.id_usuario_mod
				        where pcorreo.estado_reg = ''activo'' and  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PCORREO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		jrivera	
 	#FECHA:		20-08-2014 21:52:38
	***********************************/

	elsif(p_transaccion='WF_PCORREO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_plantilla_correo)
					    from wf.tplantilla_correo pcorreo
					    inner join segu.tusuario usu1 on usu1.id_usuario = pcorreo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pcorreo.id_usuario_mod
					    where  pcorreo.estado_reg = ''activo'' and  ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
		
	/*********************************    
 	#TRANSACCION:  'WF_EXPCORREO_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	elsif(p_transaccion='WF_EXPCORREO_SEL')then

		BEGIN

               v_consulta:='select  ''plantilla_correo''::varchar,pcorreo.codigo_plantilla,tes.codigo,tp.codigo,pcorreo.regla,
               				pcorreo.plantilla,array_to_string(pcorreo.correos,'',''),pcorreo.estado_reg,pcorreo.asunto               				
                            from wf.tplantilla_correo pcorreo
                            inner join wf.ttipo_estado tes
                            on tes.id_tipo_estado = pcorreo.id_tipo_estado                                        
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tes.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

			   if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and pcorreo.modificado is null ';
               end if;
               
               v_consulta = v_consulta || ' order by pcorreo.id_plantilla_correo ASC';	
                                                                       
               return v_consulta;


         END;
					
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
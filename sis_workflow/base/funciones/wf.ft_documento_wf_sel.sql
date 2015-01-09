--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_documento_wf_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_documento_wf_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.tdocumento_wf'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 13:52:19
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
    v_nro_tramite varchar;
    v_id_proceso_macro integer;
    v_filtro			varchar;
			    
BEGIN

	v_nombre_funcion = 'wf.ft_documento_wf_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DWF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:52:19
	***********************************/

	if(p_transaccion='WF_DWF_SEL')then
     				
    	begin
           
           if (v_parametros.todos_documentos = 'si') then
	           select 
	             pw.nro_tramite,
	             tp.id_proceso_macro
	           into 
	             v_nro_tramite,
	             v_id_proceso_macro
	           
	           from wf.tproceso_wf pw
	           inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
	           where pw.id_proceso_wf = v_parametros.id_proceso_wf;
	           
	           v_filtro = ' pw.nro_tramite = '''||COALESCE(v_nro_tramite,'--')||''' and  ';
	       else
	       		v_filtro = ' pw.id_proceso_wf = ' || v_parametros.id_proceso_wf || ' and ';
	       
	       end if;
        
    		--Sentencia de la consulta
			v_consulta:='select
						dwf.id_documento_wf,
						dwf.url,
						dwf.num_tramite,
						dwf.id_tipo_documento,
						dwf.obs,
						dwf.id_proceso_wf,
						dwf.extension,
						dwf.chequeado,
						dwf.estado_reg,
						dwf.nombre_tipo_doc,
						dwf.nombre_doc,
						dwf.momento,
						dwf.fecha_reg,
						dwf.id_usuario_reg,
						dwf.fecha_mod,
						dwf.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        tp.codigo as codigo_tipo_proceso,
                        td.codigo as codigo_tipo_documento,
                        td.nombre as nombre_tipo_documento,
                        td.descripcion as descripcion_tipo_documento,
                        
                        pw.nro_tramite,
                        pw.codigo_proceso,
                        pw.descripcion as descripcion_proceso_wf,
                        tewf.nombre_estado,
                        dwf.chequeado_fisico,
                        usu3.cuenta as usr_upload,
                        dwf.fecha_upload,
                        td.tipo as tipo_documento,
                        td.action,
                        td.solo_lectura,
                        dwf.id_documento_wf_ori,
                        dwf.id_proceso_wf_ori,
                        dwf.nro_tramite_ori
						from wf.tdocumento_wf dwf
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf
                        inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
                        left join segu.tusuario usu2 on usu2.id_usuario = dwf.id_usuario_mod
                        left join segu.tusuario usu3 on usu3.id_usuario = dwf.id_usuario_upload
                        inner join segu.tusuario usu1 on usu1.id_usuario = dwf.id_usuario_reg
                        inner join wf.testado_wf ewf  on ewf.id_proceso_wf = dwf.id_proceso_wf and ewf.estado_reg = ''activo''
                        inner join wf.ttipo_estado tewf on tewf.id_tipo_estado = ewf.id_tipo_estado
				        where  ' || v_filtro;
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

            raise notice '%',v_consulta;

--raise exception 'xxx';
			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_DWF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:52:19
	***********************************/

	elsif(p_transaccion='WF_DWF_CONT')then

		begin
            
        
            if (v_parametros.todos_documentos = 'si') then
	           select 
	             pw.nro_tramite,
	             tp.id_proceso_macro
	           into 
	             v_nro_tramite,
	             v_id_proceso_macro
	           
	           from wf.tproceso_wf pw
	           inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
	           where pw.id_proceso_wf = v_parametros.id_proceso_wf;
	           
	           v_filtro = ' pw.nro_tramite = '''||COALESCE(v_nro_tramite,'--')||''' and  ';
	       else
	       		v_filtro = ' pw.id_proceso_wf = ' || v_parametros.id_proceso_wf || ' and ';
	       
	       end if;
        
        
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_documento_wf)
					    from wf.tdocumento_wf dwf
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf
                        inner join wf.ttipo_documento td on td.id_tipo_documento = dwf.id_tipo_documento
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = pw.id_tipo_proceso
                        left join segu.tusuario usu2 on usu2.id_usuario = dwf.id_usuario_mod
                        left join segu.tusuario usu3 on usu3.id_usuario = dwf.id_usuario_upload
                        inner join segu.tusuario usu1 on usu1.id_usuario = dwf.id_usuario_reg
                        inner join wf.testado_wf ewf  on ewf.id_proceso_wf = dwf.id_proceso_wf and ewf.estado_reg = ''activo''
                        inner join wf.ttipo_estado tewf on tewf.id_tipo_estado = ewf.id_tipo_estado
				        where ' || v_filtro;
			
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
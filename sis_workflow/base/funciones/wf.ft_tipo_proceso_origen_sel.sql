--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_tipo_proceso_origen_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_proceso_origen_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_proceso_origen'
 AUTOR: 		 (admin)
 FECHA:	        09-06-2014 17:03:47
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

	v_nombre_funcion = 'wf.ft_tipo_proceso_origen_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TPO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	if(p_transaccion='WF_TPO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:=' select
                            tpo.id_tipo_proceso_origin,
                            tpo.id_tipo_proceso,
                            tpo.id_tipo_estado,
                            tpo.id_proceso_macro,
                            tpo.funcion_validacion_wf,
                            tpo.tipo_disparo,
                            tpo.estado_reg,
                            tpo.id_usuario_reg,
                            tpo.id_usuario_ai,
                            tpo.usuario_ai,
                            tpo.fecha_reg,
                            tpo.id_usuario_mod,
                            tpo.fecha_mod,
                            usu1.cuenta as usr_reg,
                            usu2.cuenta as usr_mod,
                            te.nombre_estado as desc_tipo_estado,
                            pm.nombre as desc_proceso_macro	,
                            tp.nombre as desc_tipo_proceso
						from wf.ttipo_proceso_origen tpo
                        inner join wf.ttipo_estado te on te.id_tipo_estado = tpo.id_tipo_estado
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = te.id_tipo_proceso
                        inner join wf.tproceso_macro pm on pm.id_proceso_macro = tpo.id_proceso_macro
						inner join segu.tusuario usu1 on usu1.id_usuario = tpo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tpo.id_usuario_mod
				        where  tpo.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TPO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	elsif(p_transaccion='WF_TPO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_proceso_origin)
					    from wf.ttipo_proceso_origen tpo
                        inner join wf.ttipo_estado te on te.id_tipo_estado = tpo.id_tipo_estado
                        inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = te.id_tipo_proceso
                        inner join wf.tproceso_macro pm on pm.id_proceso_macro = tpo.id_proceso_macro
						inner join segu.tusuario usu1 on usu1.id_usuario = tpo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tpo.id_usuario_mod
				        where   tpo.estado_reg = ''activo'' and  ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
        
    /*********************************    
 	#TRANSACCION:  'WF_EXPTPO_SEL'
 	#DESCRIPCION:	Exportacion de tipo proceso origen
 	#AUTOR:		admin	
 	#FECHA:		09-06-2014 17:03:47
	***********************************/

	elsif(p_transaccion='WF_EXPTPO_SEL')then

		BEGIN

               v_consulta:='select  ''proceso_origen''::varchar,tp.codigo,pm.codigo,tpes.codigo,esor.codigo,
                            tpor.tipo_disparo,tpor.funcion_validacion_wf,tpor.estado_reg

                            from wf.ttipo_proceso_origen tpor
                            inner join wf.ttipo_proceso tp 
                            on tp.id_tipo_proceso = tpor.id_tipo_proceso
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join wf.ttipo_estado esor
                            on esor.id_tipo_estado = tpor.id_tipo_estado
                            inner join wf.ttipo_proceso tpes 
                            on tpes.id_tipo_proceso = esor.id_tipo_proceso
                            inner join wf.tproceso_macro pmes
                            on pmes.id_proceso_macro = tpes.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and tpor.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by tpor.id_tipo_proceso_origin ASC';	
                                                                       
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
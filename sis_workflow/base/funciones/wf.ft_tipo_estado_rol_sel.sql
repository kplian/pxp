CREATE OR REPLACE FUNCTION wf.ft_tipo_estado_rol_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_estado_rol_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'wf.ttipo_estado_rol'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 03:12:38
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

	v_nombre_funcion = 'wf.ft_tipo_estado_rol_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_EXPTESROL_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	if(p_transaccion='WF_EXPTESROL_SEL')then
     				
    	begin
    		v_consulta:='select  ''tipo_estado_rol''::varchar,tp.codigo,tes.codigo,r.rol,tesrol.estado_reg

                            from wf.ttipo_estado_rol tesrol
                            inner join wf.ttipo_estado tes
                            on tesrol.id_tipo_estado = tes.id_tipo_estado                            
                            inner join wf.ttipo_proceso tp
                            on tp.id_tipo_proceso = tes.id_tipo_proceso                            
                            inner join wf.tproceso_macro pm
                            on pm.id_proceso_macro = tp.id_proceso_macro
                            inner join segu.tsubsistema s
                            on s.id_subsistema = pm.id_subsistema
                            inner join segu.trol r
                            on r.id_rol = tesrol.id_rol
                            where pm.id_proceso_macro = '|| v_parametros.id_proceso_macro;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and tesrol.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by tesrol.id_tipo_estado_rol ASC';	
                                                                       
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.ft_funcionario_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		orga.ft_funcionario_sel
 DESCRIPCIÓN:  listado de funcionario
 AUTOR: 	    KPLIAN (mzm)
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		21-01-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;
v_filadd           varchar;
v_id_funcionario	integer;
v_ids_funcionario	varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='orga.ft_funcionario_sel';

/*******************************
 #TRANSACCION:  RH_FUNCIO_SEL
 #DESCRIPCION:	Listado de funcionarios
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     if(par_transaccion='RH_FUNCIO_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            FUNCIO.id_funcionario,
                            FUNCIO.codigo,
                            FUNCIO.estado_reg,
                            FUNCIO.fecha_reg,
                            FUNCIO.id_persona,
                            FUNCIO.id_usuario_reg,
                            FUNCIO.fecha_mod,
                            FUNCIO.id_usuario_mod,
                            FUNCIO.email_empresa,
                            FUNCIO.interno,
                            FUNCIO.fecha_ingreso,
                            PERSON.nombre_completo1 AS desc_person,
                            usu1.cuenta as usr_reg,
						    usu2.cuenta as usr_mod,
                            PERSON.ci, 
                            PERSON.num_documento,
                            PERSON.telefono1, 
                            PERSON.celular1, 
                            PERSON.correo,
                            FUNCIO.telefono_ofi,
                            FUNCIO.antiguedad_anterior
                            FROM orga.tfuncionario FUNCIO
                            INNER JOIN SEGU.vpersona PERSON ON PERSON.id_persona=FUNCIO.id_persona
                            inner join segu.tusuario usu1 on usu1.id_usuario = FUNCIO.id_usuario_reg
						    left join segu.tusuario usu2 on usu2.id_usuario = FUNCIO.id_usuario_mod
                            WHERE ';
               
               
               
               v_consulta := v_consulta || v_parametros.filtro;
               
               if (pxp.f_existe_parametro(par_tabla, 'tipo') and
				pxp.f_existe_parametro(par_tabla, 'fecha') and 
				pxp.f_existe_parametro(par_tabla, 'id_uo')) then
				
				if (v_parametros.tipo is not null and v_parametros.tipo = 'oficial' and v_parametros.fecha is not null and v_parametros.id_uo is not null) then
					v_ids_funcionario = orga.f_get_funcionarios_con_asignacion_activa(v_parametros.id_uo, v_parametros.fecha);
					v_consulta := v_consulta || ' and FUNCIO.id_funcionario not in (' || v_ids_funcionario ||') ';
					
				end if;
			end if;
               
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  RH_FUNCIO_CONT
 #DESCRIPCION:	Conteo de funcionarios
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     elsif(par_transaccion='RH_FUNCIO_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(FUNCIO.id_funcionario)
                            FROM orga.tfuncionario FUNCIO
                            INNER JOIN SEGU.vpersona PERSON ON PERSON.id_persona=FUNCIO.id_persona
                            inner join segu.tusuario usu1 on usu1.id_usuario = FUNCIO.id_usuario_reg
						    left join segu.tusuario usu2 on usu2.id_usuario = FUNCIO.id_usuario_mod
                            WHERE ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
    
    /*******************************
     #TRANSACCION:  RH_FUNCIOCAR_SEL
     #DESCRIPCION:	Listado de funcionarios con cargos historicos
     #AUTOR:		KPLIAN (RAC)
     #FECHA:		29/10/11	
    ***********************************/
     elseif(par_transaccion='RH_FUNCIOCAR_SEL')then

          --consulta:=';
          BEGIN
          
           v_filadd = '';
            IF (pxp.f_existe_parametro(par_tabla,'estado_reg_asi')) THEN
               v_filadd = ' (FUNCAR.estado_reg_asi = '''||v_parametros.estado_reg_asi||''') and ';
            END IF;

               v_consulta:='SELECT 
                            FUNCAR.id_uo_funcionario,
                            FUNCAR.id_funcionario,
                            FUNCAR.desc_funcionario1,
                            FUNCAR.desc_funcionario2,
                            FUNCAR.id_uo,
                            FUNCAR.nombre_cargo,
                            FUNCAR.fecha_asignacion,
                            FUNCAR.fecha_finalizacion,
                            FUNCAR.num_doc,
                            FUNCAR.ci,
                            FUNCAR.codigo,
                            FUNCAR.email_empresa,
                            FUNCAR.estado_reg_fun,
                            FUNCAR.estado_reg_asi,
                            FUNCAR.id_cargo,
                            FUNCAR.descripcion_cargo,
                            FUNCAR.cargo_codigo,
                            FUNCAR.id_lugar,
                            FUNCAR.id_oficina,
                            FUNCAR.lugar_nombre,
                            FUNCAR.oficina_nombre
                            
                            FROM orga.vfuncionario_cargo_lugar FUNCAR 
                            WHERE '||v_filadd;
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

              
                     
               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  RH_FUNCIOCAR_CONT
 #DESCRIPCION:	Conteo de funcionarios con cargos historicos
 #AUTOR:		KPLIAN (rac)
 #FECHA:		23/05/11	
***********************************/
     elsif(par_transaccion='RH_FUNCIOCAR_CONT')then

          --consulta:=';
          BEGIN
          
            v_filadd = '';
            IF (pxp.f_existe_parametro(par_tabla,'estado_reg_asi')) THEN
               v_filadd = ' (FUNCAR.estado_reg_asi = '''||v_parametros.estado_reg_asi||''') and ';
            END IF;

               v_consulta:='SELECT
                                  count(id_uo_funcionario)
                            FROM orga.vfuncionario_cargo_lugar FUNCAR 
                            WHERE '||v_filadd;
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;   

      else
         raise exception 'No existe la opcion';

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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.ft_uo_funcionario_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		ORGA.ft_uo_funcionario_sel
 DESCRIPCIÓN:  listado de uo
 AUTOR: 	    KPLIAN (mzm)	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		30-05-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;
v_id_padre         integer;

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='orga.ft_uo_funcionario_sel';

/*******************************
 #TRANSACCION:  RH_UO_SEL
 #DESCRIPCION:	Listado de uo funcionarios
 #AUTOR:		
 #FECHA:		30/05/11	
***********************************/
     if(par_transaccion='RH_UOFUNC_SEL')then


          BEGIN

               v_consulta:='SELECT
                                  UOFUNC.id_uo_funcionario,
                                  UOFUNC.id_uo,
                                  UOFUNC.id_funcionario,
                                  FUNCIO.ci,
                                  FUNCIO.codigo,
                                  FUNCIO.desc_funcionario1,
                                  FUNCIO.desc_funcionario2,
                                  FUNCIO.num_doc,
                                  UOFUNC.fecha_asignacion,
                                  UOFUNC.fecha_finalizacion,
                                  UOFUNC.estado_reg,
                                  UOFUNC.fecha_mod,
                                  UOFUNC.fecha_reg,
                                  UOFUNC.id_usuario_mod,
                                  UOFUNC.id_usuario_reg,
                                  PERREG.nombre_completo2 AS USUREG,
                                  PERMOD.nombre_completo2 AS USUMOD,
                                  cargo.id_cargo,
                                  (coalesce(''Cod: '' || cargo.codigo || ''---Id: '' || cargo.id_cargo,  ''Id: '' || cargo.id_cargo)|| '' -- '' || cargo.nombre) ::text,
                                  UOFUNC.observaciones_finalizacion,
                                  UOFUNC.nro_documento_asignacion,
                                  UOFUNC.fecha_documento_asignacion,
                                  UOFUNC.tipo                                  
                                  
                            FROM orga.tuo_funcionario UOFUNC
                            INNER JOIN orga.tuo UO ON UO.id_uo=UOFUNC.id_uo
                            INNER JOIN orga.vfuncionario FUNCIO ON FUNCIO.id_funcionario=UOFUNC.id_funcionario
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN orga.tcargo cargo ON cargo.id_cargo = UOFUNC.id_cargo
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE  UOFUNC.estado_reg !=''inactivo'' and ';

              
                v_id_padre:=v_parametros.id_uo;
              
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta || ' and UOFUNC.id_uo='|| v_id_padre;
		
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad;
        
               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  RH_UO_CONT
 #DESCRIPCION:	Conteo de uos
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     elsif(par_transaccion='RH_UOFUNC_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(UOFUNC.id_uo_funcionario)
                            FROM orga.tuo_funcionario UOFUNC
                            INNER JOIN orga.tuo UO ON UO.id_uo=UOFUNC.id_uo
                            INNER JOIN orga.vfuncionario FUNCIO ON FUNCIO.id_funcionario=UOFUNC.id_funcionario
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN orga.tcargo cargo ON cargo.id_cargo = UOFUNC.id_cargo
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE UOFUNC.estado_reg !=''inactivo'' and ';
               v_id_padre:=v_parametros.id_uo;
              
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta || ' and UOFUNC.id_uo='|| v_id_padre;
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.ft_uo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
  RETURNS varchar AS
  $body$
/**************************************************************************
 FUNCION: 		orga.ft_uo_sel
 DESCRIPCIÓN:  listado de uo
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


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='orga.ft_uo_sel';

/*******************************
 #TRANSACCION:  RH_UO_SEL
 #DESCRIPCION:	Listado de uos
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     if(par_transaccion='RH_UO_SEL')then

          
          BEGIN
          
          
            v_filadd = '';
            IF (pxp.f_existe_parametro(par_tabla,'correspondencia')) THEN
               v_filadd = ' (UO.correspondencia = '''||v_parametros.correspondencia||''') and ';
            END IF;    
            
            --29mar12: para SAJ
            IF (pxp.f_existe_parametro(par_tabla,'gerencia')) THEN
               v_filadd = ' (UO.gerencia = '''||v_parametros.gerencia||''') and ';
            END IF;
            
            IF (pxp.f_existe_parametro(par_tabla,'presupuesta')) THEN
               v_filadd = ' (UO.presupuesta = '''||v_parametros.presupuesta||''') and ';
            END IF;
            
            
               v_consulta:='SELECT UO.id_uo,
                                  UO.cargo_individual,
                                  UO.codigo,
                                  UO.descripcion,
                                  UO.estado_reg,
                                  UO.fecha_mod,
                                  UO.fecha_reg,
                                  
                                  UO.id_usuario_mod,
                                  UO.id_usuario_reg,
                                  UO.nombre_cargo,
                                  UO.nombre_unidad,
                                  UO.presupuesta,
                                  PERREG.nombre_completo2 AS USUREG,
                                  PERMOD.nombre_completo2 AS USUMOD
                            FROM orga.tuo UO
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE UO.estado_reg=''activo'' and '||v_filadd;
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  RH_UO_CONT
 #DESCRIPCION:	Conteo de uos
 #AUTOR:		
 #FECHA:		23/05/11	
***********************************/
     elsif(par_transaccion='RH_UO_CONT')then

          --consulta:=';
          BEGIN
          
           v_filadd = '';
            IF (pxp.f_existe_parametro(par_tabla,'correspondencia')) THEN
               v_filadd = ' (UO.correspondencia = '''||v_parametros.correspondencia||''') and ';
            END IF;
           
            --29mar12: para SAJ
            IF (pxp.f_existe_parametro(par_tabla,'gerencia')) THEN
               v_filadd = ' (UO.gerencia = '''||v_parametros.gerencia||''') and ';
            END IF;
            
               v_consulta:='SELECT
                                  count(UO.id_uo)
                            FROM orga.tuo UO
                            INNER JOIN segu.tusuario USUREG ON  UO.id_usuario_reg=USUREG.id_usuario
                            INNER JOIN SEGU.vpersona PERREG ON PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN SEGU.tusuario USUMOD ON USUMOD.id_usuario=UO.id_usuario_mod
                            LEFT JOIN SEGU.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE UO.estado_reg=''activo'' and '||v_filadd;
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
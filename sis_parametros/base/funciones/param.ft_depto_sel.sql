--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 documento: 	param.ft_depto_sel
 DESCRIPCIÓN:  listado de documento
 AUTOR: 	    KPLIAN	
 FECHA:	        06/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;
v_filadd varchar;

va_id_depto  integer[];


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_depto_sel';
     
 /*******************************
 #TRANSACCION:  PM_DEPPTO_SEL
 #DESCRIPCION:	Listado de departamento
 #AUTOR:		MZM	
 #FECHA:		03-06-2011
 #AUTOR_MOD:     RAC
 #DESCRIPCION_MOD  se aumenta el filtro de id_subsistema cuando dea distinto de null	
 #FECHA:		15-10-2011
***********************************/


     if(par_transaccion='PM_DEPPTO_SEL')then

          --consulta:=';
          
          
          BEGIN
          v_filadd = '';
         
          IF (pxp.f_existe_parametro(par_tabla,'id_subsistema')) THEN
          v_filadd = ' (DEPPTO.id_subsistema = ' ||v_parametros.id_subsistema||') and ';
          
          END IF;
          
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          v_filadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
          
          
          IF   par_administrador != 1 THEN
          
                
          
                IF (pxp.f_existe_parametro(par_tabla,'tipo_filtro')) THEN
                
                  IF v_parametros.tipo_filtro='DEPTO_UO' THEN
                    --se agrega filtro si el usuario pertenece al depto
                     select  
                           pxp.aggarray(depu.id_depto)
                        into 
                           va_id_depto
                       from param.tdepto_usuario depu 
                       where depu.id_usuario =  par_id_usuario; 
                  
                       v_filadd='(DEPPTO.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||')) and';
                  END IF;
               
               ELSE
                --TO DO,  filtro de departamento por EP cuando  el usuario no es administrador
               
               
                  -- obtener las ep del usuario en un array 
                  
                  
               
               END IF;
           
     
     
          END IF;
          
          
          
          
          

               v_consulta:='SELECT 
                            DEPPTO.id_depto,
                            DEPPTO.codigo,
                            DEPPTO.nombre,
                            DEPPTO.nombre_corto,
                            DEPPTO.id_subsistema,
                            DEPPTO.estado_reg,
                            DEPPTO.fecha_reg,
                            DEPPTO.id_usuario_reg,
                            DEPPTO.fecha_mod,
                            DEPPTO.id_usuario_mod,
                            PERREG.nombre_completo1 as usureg,
                            PERMOD.nombre_completo1 as usumod,
                            SUBSIS.codigo||'' - ''||SUBSIS.nombre as desc_subsistema
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            WHERE '||v_filadd;
               
              
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice '%',v_consulta;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  PM_DEPPTO_CONT
 #DESCRIPCION:	cuenta la cantidad de departamentos
 #AUTOR:		MZM	
 #FECHA:		03-06-2011
 #AUTOR_MOD:     RAC
 #DESCRIPCION_MOD  se aumenta el filtro de id_subsistema cuando dea distinto de null	
 #FECHA:		15-10-2011
***********************************/

     elsif(par_transaccion='PM_DEPPTO_CONT')then
        BEGIN
          
          v_filadd = '';
          IF (pxp.f_existe_parametro(par_tabla,'id_subsistema')) THEN
          v_filadd = ' (DEPPTO.id_subsistema = ' ||v_parametros.id_subsistema||') and ';
          
          END IF;
          
          IF (pxp.f_existe_parametro(par_tabla,'codigo_subsistema')) THEN
          v_filadd = ' (SUBSIS.codigo = ''' ||v_parametros.codigo_subsistema||''') and ';
          
          END IF;
          
          
          IF   par_administrador != 1 THEN
          
                
          
                IF (pxp.f_existe_parametro(par_tabla,'tipo_filtro')) THEN
                
                  IF v_parametros.tipo_filtro='DEPTO_UO' THEN
                    --se agrega filtro si el usuario pertenece al depto
                     select  
                           pxp.aggarray(depu.id_depto)
                        into 
                           va_id_depto
                       from param.tdepto_usuario depu 
                       where depu.id_usuario =  par_id_usuario; 
                  
                       v_filadd='(DEPPTO.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||')) and';
                  END IF;
               
               ELSE
                --TO DO,  filtro de departamento por EP cuando  el usuario no es administrador
               
               
                  -- obtener las ep del usuario en un array 
                  
                  
               
               END IF;
           
     
     
          END IF;
          
          
               v_consulta:='SELECT
                                  count(DEPPTO.id_depto)
                            FROM param.tdepto DEPPTO
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DEPPTO.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DEPPTO.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DEPPTO.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            WHERE '||v_filadd;
               v_consulta:=v_consulta||v_parametros.filtro;
               
                raise notice '%',v_consulta;
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
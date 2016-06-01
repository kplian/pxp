--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_documento_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 documento: 	param.ft_documento_sel
 DESCRIPCIÓN:  listado de documento
 AUTOR: 	    KPLIAN	(m)
 FECHA:	        04/06/2011
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


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_documento_sel';
     
/*******************************
 #TRANSACCION:  PM_DOCUME_SEL
 #DESCRIPCION:	Listado de documentos
 #AUTOR:		KPLIAN(mzm)	
 #FECHA:		08/01/11	
 ******************************
 #DESCRIPCION_MOD:	aumenta filtro para tipo de documentos por el subsistema
                    se usa desde la interface de correspondencia
 #AUTOR_MOD:		KPLIAN(rac)	
 #FECHA_MOD:		27/10/11
***********************************/


     if(par_transaccion='PM_DOCUME_SEL')then

          -- consulta:=';
          BEGIN
          
           v_filadd = '';
            IF (pxp.f_existe_parametro(par_tabla,'tipo')) THEN
               v_filadd = ' ( DOCUME.tipo = '''||v_parametros.tipo||''' and  DOCUME.estado_reg=''activo'' ) and ';
            END IF;

               v_consulta:='SELECT 
                                   DOCUME.id_documento,
                                   DOCUME.codigo,
                                   DOCUME.descripcion,
                                   DOCUME.estado_reg,
                                   DOCUME.fecha_mod,
                                   DOCUME.fecha_reg,
                                   DOCUME.id_subsistema,
                                   DOCUME.id_usuario_mod,
                                   DOCUME.id_usuario_reg,
                                   SUBSIS.codigo  ||''-''||SUBSIS.nombre as desc_subsis,
                                   SUBSIS.nombre as nombre_subsis,
                                   PERREG.nombre_completo1 as usureg,
                                   PERMOD.nombre_completo1 as usumod,
                                   DOCUME.tipo_numeracion,
                                   DOCUME.periodo_gestion,
                                   DOCUME.tipo,
                                   DOCUME.formato,
                                    DOCUME.ruta_plantilla

                            FROM param.tdocumento DOCUME
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DOCUME.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DOCUME.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DOCUME.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            
                            WHERE '||v_filadd;
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;



         END;


     elsif(par_transaccion='PM_DOCUME_CONT')then

          --consulta:=';
          BEGIN
          
              v_filadd = '';
              IF (pxp.f_existe_parametro(par_tabla,'tipo')) THEN
               v_filadd = ' ( DOCUME.tipo = '''||v_parametros.tipo||''' and  DOCUME.estado_reg=''activo'' ) and ';
              END IF;

               v_consulta:='SELECT
                            count(DOCUME.id_documento)
                            FROM param.tdocumento DOCUME
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema=DOCUME.id_subsistema
                            INNER JOIN segu.tusuario USUREG on USUREG.id_usuario=DOCUME.id_usuario_reg
                            INNER JOIN segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            LEFT JOIN segu.tusuario USUMOD on USUMOD.id_usuario=DOCUME.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            
                            WHERE  '||v_filadd;
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
     
     
     ELSEIF(par_transaccion='PM_EXPDCT_SEL')then

          
          BEGIN
          
                v_consulta:='SELECT 
                                   DOCUME.id_documento,
                                   DOCUME.codigo,
                                   DOCUME.descripcion,
                                   DOCUME.estado_reg,
                                   DOCUME.id_subsistema,
                                   SUBSIS.codigo  as codigo_subsis,
                                   SUBSIS.nombre as nombre_subsis,
                                   DOCUME.tipo_numeracion,
                                   DOCUME.periodo_gestion,
                                   DOCUME.tipo,
                                   DOCUME.formato,
   								   DOCUME.ruta_plantilla

                            FROM param.tdocumento DOCUME
                            INNER JOIN segu.tsubsistema SUBSIS on SUBSIS.id_subsistema = DOCUME.id_subsistema
                            
                            WHERE id_documento = '||v_parametros.id_documento;
               
               
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

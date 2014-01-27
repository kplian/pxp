CREATE OR REPLACE FUNCTION segu.ft_clasificador_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_clasificador_sel
 DESCRIPCION:   consultas de clasificador
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)		
 FECHA:		08/01/11
***************************************************************************/



DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp                 varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(p_tabla);
     v_nombre_funcion:='segu.ft_clasificador_sel';

 /*******************************
 #TRANSACCION:  SEG_CLASIF_SEL
 #DESCRIPCION:	Selecciona Clasificador
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/

     if(p_transaccion='SEG_CLASIF_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select id_clasificador,
                            codigo,
                            descripcion,
                            prioridad,
                            fecha_reg
                            --estado_reg
                        from segu.tclasificador where estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_CLASIF_CONT
 #DESCRIPCION:	Cuenta Clasificador
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/

     elsif(p_transaccion='SEG_CLASIF_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(id_clasificador)
               from segu.tclasificador where  estado_reg=''activo'' and ';
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_configurar_ime (OID = 305048) : 
--

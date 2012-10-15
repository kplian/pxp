CREATE OR REPLACE FUNCTION param.ft_moneda_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 moneda: 		param.ft_moneda_sel
 DESCRIPCIÓN:  listado de moneda
 AUTOR: 		KPLIAN
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		18-01-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_moneda_sel';


     if(par_transaccion='PM_MONEDA_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            MONEDA.id_moneda,
                            MONEDA.codigo ,
                            MONEDA.moneda,
                            MONEDA.estado_reg ,
                            MONEDA.fecha_reg ,
                            MONEDA.id_usuario_reg,
                            MONEDA.fecha_mod,
                            MONEDA.id_usuario_mod,
                            PERSON.nombre_completo1 AS desc_usuario_reg,
                            PERMOD.nombre_completo1 AS desc_usuario_mod,
                            f_iif(MONEDA.tipo_moneda=''base'',''true'',''false'') as tipo_moneda
                            FROM PARAM.tmoneda MONEDA
                            INNER JOIN SEGU.tusuario USUARI
                            ON USUARI.id_usuario=MONEDA.id_usuario_reg
                            INNER JOIN segu.vpersona PERSON ON PERSON.id_persona=USUARI.id_persona
                            LEFT JOIN SEGU.tusuario USUMOD
                            ON USUMOD.id_usuario=MONEDA.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE MONEDA.estado_reg!=''eliminado'' and ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;


     elsif(par_transaccion='PM_MONEDA_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                            count(MONEDA.id_moneda)
                            FROM PARAM.tmoneda MONEDA
                            INNER JOIN SEGU.tusuario USUARI
                            ON USUARI.id_usuario=MONEDA.id_usuario_reg
                            LEFT JOIN SEGU.tusuario USUMOD
                            ON USUMOD.id_usuario=MONEDA.id_moneda
                            WHERE MONEDA.estado_reg!=''eliminado'' and ';
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
-- Definition for function ft_periodo_ime (OID = 304043) : 
--

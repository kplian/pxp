CREATE OR REPLACE FUNCTION param.ft_config_alarma_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 moneda: 		param.ft_config_alarma_sel
 DESCRIPCIÓN:  listado de la configuracion de alarmas
 AUTOR: 		fprudencio
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		25-11-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_config_alarma_sel';


     if(par_transaccion='PM_CONALA_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            CONALA.id_config_alarma,
                            CONALA.codigo,
                            CONALA.descripcion,
                            CONALA.dias,
                            CONALA.id_subsistema,
                            (SUBSIS.codigo ||'' - ''|| SUBSIS.nombre) as desc_subsis,
                            CONALA.id_usuario_reg,
                            CONALA.estado_reg ,
                            CONALA.fecha_reg ,                            
                            CONALA.fecha_mod,
                            CONALA.id_usuario_mod,
                            PERSON.nombre_completo1 AS desc_usuario_reg,
                            PERMOD.nombre_completo1 AS desc_usuario_mod
                            FROM PARAM.tconfig_alarma CONALA
                            INNER JOIN SEGU.tusuario USUARI
                            ON USUARI.id_usuario=CONALA.id_usuario_reg
                            INNER JOIN segu.vpersona PERSON ON PERSON.id_persona=USUARI.id_persona
                            INNER JOIN segu.tsubsistema SUBSIS ON SUBSIS.id_subsistema=CONALA.id_subsistema
                            LEFT JOIN SEGU.tusuario USUMOD
                            ON USUMOD.id_usuario=CONALA.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE  ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               --raise notice'(%)',v_consulta   ;
               return v_consulta;


         END;


     elsif(par_transaccion='PM_CONALA_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                            count(CONALA.id_config_alarma)
                            FROM PARAM.tconfig_alarma CONALA
                            INNER JOIN SEGU.tusuario USUARI
                            ON USUARI.id_usuario=CONALA.id_usuario_reg
                            INNER JOIN segu.vpersona PERSON ON PERSON.id_persona=USUARI.id_persona
                            INNER JOIN segu.tsubsistema SUBSIS ON SUBSIS.id_subsistema=CONALA.id_subsistema
                            LEFT JOIN SEGU.tusuario USUMOD
                            ON USUMOD.id_usuario=CONALA.id_usuario_mod
                            LEFT JOIN segu.vpersona PERMOD ON PERMOD.id_persona=USUMOD.id_persona
                            WHERE  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
     elsif(par_transaccion='PM_ALATABLA_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT table_schema::varchar,
                                   table_name::varchar 
                            FROM information_schema.columns
                            WHERE column_name = ''id_alarma'' AND ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               raise notice '%',v_consulta;
               return v_consulta;


         END;
     elsif(par_transaccion='PM_ALATABLA_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(table_name)                                  
                            FROM information_schema.columns
                            WHERE column_name = ''id_alarma'' AND ';
               
               
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
-- Definition for function ft_dispara_alarma_ime (OID = 304030) : 
--

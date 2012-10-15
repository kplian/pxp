CREATE OR REPLACE FUNCTION param.ft_periodo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 periodo: 		param.ft_periodo_sel
 DESCRIPCIÓN:  listado de periodo
 AUTOR: 		KPLIAN
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		12-01-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_periodo_sel';


     if(par_transaccion='PM_PERIOD_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            PERIOD.id_periodo,
                            pxp.f_obtener_literal_periodo(PERIOD.periodo, 10),
                            PERIOD.estado_reg,
                            PERIOD.fecha_reg,
                            GESTIO.id_gestion,
                            GESTIO.gestion,
                            PERIOD.id_usuario_reg,
                            PERIOD.id_usuario_mod,
                            perreg.nombre_completo1 as usureg,
                            permod.nombre_completo1 as usumod,
                            PERIOD.fecha_mod
                            FROM param.tperiodo PERIOD
                            INNER JOIN param.tgestion GESTIO
                            ON GESTIO.id_gestion=PERIOD.id_gestion
                            inner join segu.tusuario usureg on usureg.id_usuario=PERIOD.id_usuario_reg
                            inner join segu.vpersona perreg on perreg.id_persona=usureg.id_persona
                            left join segu.tusuario usumod on usumod.id_usuario=PERIOD.id_usuario_mod
                            left join segu.vpersona permod on permod.id_persona=usumod.id_persona
                            WHERE PERIOD.estado_reg!=''eliminado'' and ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;

               --if (v_parametros.id_gestion!=null) then
               --raise exception 'id_gestion no null';
                 v_consulta:=v_consulta|| ' AND PERIOD.id_gestion='||coalesce(v_parametros.id_gestion,0);
             --  else
               --  raise exception 'entra aqui';
               --end if;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;


     elsif(par_transaccion='PM_PERIOD_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(PERIOD.id_periodo)
                            FROM param.tperiodo PERIOD
                            INNER JOIN param.tgestion GESTIO
                            ON GESTIO.id_gestion=PERIOD.id_gestion
                            WHERE PERIOD.estado_reg!=''eliminado'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
                 if (v_parametros.id_gestion is not null) then
                 v_consulta:=v_consulta|| ' AND PERIOD.id_gestion='||v_parametros.id_gestion;
               end if;
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

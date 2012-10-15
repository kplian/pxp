CREATE OR REPLACE FUNCTION param.ft_gestion_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 gestion: 		param.ft_gestion_sel
 DESCRIPCIÓN:  listado de gestion
 AUTOR: 		KPLIAN
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		07-01-2011
***************************************************************************/


DECLARE


v_consulta         varchar;
v_parametros       record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp             varchar;


BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='param.ft_gestion_sel';


     if(par_transaccion='PM_GESTIO_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            GESTIO.id_gestion,
                            GESTIO.gestion,
                            GESTIO.estado_reg,
                            GESTIO.fecha_reg,
                            GESTIO.fecha_mod,
                            GESTIO.id_usuario_reg,
                            GESTIO.id_usuario_mod,
                            PERREG.nombre_completo1 as desc_usureg,
                            PERMOD.nombre_completo1 as desc_usumod
                            FROM param.tgestion GESTIO
                            inner join segu.tusuario USUREG on USUREG.id_usuario=GESTIO.id_usuario_reg
                            inner join segu.vpersona PERREG on PERREG.id_persona=USUREG.id_persona
                            left join segu.tusuario USUMOD on USUMOD.id_usuario=GESTIO.id_usuario_mod
                            left join segu.vpersona PERMOD on PERMOD.id_persona=USUMOD.id_persona
                            WHERE GESTIO.estado_reg!=''eliminado'' and ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;     
               
               if(pxp.f_existe_parametro(par_tabla,'estado')) then
                  v_consulta:=v_consulta || ' and GESTIO.estado_reg='''||v_parametros.estado||'''';
               end if;
               
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;


     elsif(par_transaccion='PM_GESTIO_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(GESTIO.id_gestion)
                            FROM param.tgestion GESTIO
                            WHERE GESTIO.estado_reg!=''eliminado'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;  
               if(pxp.f_existe_parametro(par_tabla,'estado')) then
                  v_consulta:=v_consulta || ' and GESTIO.estado_reg='''||v_parametros.estado||'''';
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
--
-- Definition for function ft_institucion_ime (OID = 304037) : 
--

CREATE OR REPLACE FUNCTION segu.ft_rol_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_rol_sel
 DESCRIPCION:   
 AUTOR: 		KPLIAN(jrr)
 FECHA:	
 COMENTARIOS:	
***************************************************************************/
DECLARE


v_consulta    varchar;
v_parametros  record;
v_resp                  varchar;
v_nombre_funcion   text;
v_mensaje_error    text;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(p_tabla);
     v_nombre_funcion:='segu.ft_rol_sel';


     if(p_transaccion='SEG_ROL_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            roll.id_rol,
                            roll.descripcion,
                            roll.fecha_reg,
                            roll.estado_reg,
                            roll.rol,
                            roll.id_subsistema,
                            coalesce(subsis.nombre,'' '') as desc_subsis
                        FROM segu.trol roll
                        LEFT join segu.tsubsistema subsis
                        on subsis.id_subsistema=roll.id_subsistema where roll.estado_reg = ''activo'' AND ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;


     elsif(p_transaccion='SEG_ROL_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(roll.id_rol)
                            FROM segu.trol roll
                        LEFT JOIN segu.tsubsistema subsis
                        on subsis.id_subsistema=roll.id_subsistema where roll.estado_reg = ''activo'' AND ';
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
-- Definition for function ft_sesion_ime (OID = 305093) : 
--

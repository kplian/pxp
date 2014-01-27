CREATE OR REPLACE FUNCTION segu.ft_estructura_dato_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_estructura_dato_sel
 DESCRIPCION:   consultas de estructura_dato
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
v_resp           varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_estructura_dato_sel';


 /*******************************
 #TRANSACCION:  SEG_ESTDAT_SEL
 #DESCRIPCION:	Selecciona Estructura dato
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ESTDAT_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select estdat.id_estructura_dato,
                            estdat.id_subsistema,
                            estdat.nombre,
                            estdat.descripcion,
                            estdat.encripta,
                            estdat.log,
                            estdat.fecha_reg,
                            estdat.estado_reg,
                            estdat.tipo,
                            subsis.nombre as nombre_subsis
                        from segu.testructura_dato estdat
                        inner join segu.tsubsistema subsis
                        on subsis.id_subsistema=estdat.id_subsistema where
                        estdat.estado_reg=''activo'' and';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;


 /*******************************
 #TRANSACCION:  SEG_ESTDAT_CONT
 #DESCRIPCION:	Cuenta Estructura dato
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ESTDAT_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(estdat.id_estructura_dato)
                        from segu.testructura_dato estdat
                        inner join segu.tsubsistema subsis
                        on subsis.id_subsistema=estdat.id_subsistema where
                        estdat.estado_reg=''activo'' and ';
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
-- Definition for function ft_estructura_gui_ime (OID = 305054) : 
--

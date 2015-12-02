CREATE OR REPLACE FUNCTION segu.ft_patron_evento_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.fpatron_evento_sel
 DESCRIPCIÓN:   listado de patrones de evento
 AUTOR: 		KPLIAN(jrr)	
 FECHA:			
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/
                                                                          
DECLARE            

v_consulta    		varchar;
v_parametros  		record;
v_nombre_funcion   	text;
v_mensaje_error    	text;
v_id_padre         	integer;

v_resp             	varchar;
v_where 			varchar;
v_join  			varchar;      

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_patron_evento_sel';


     if(par_transaccion='SEG_PATEVE_SEL')then

          --consulta:=';
          BEGIN
          
              v_consulta =  'SELECT
                             PATEVE.id_patron_evento,
                             PATEVE.tipo_evento,
                             PATEVE.operacion,
                             PATEVE.aplicacion,
                           
                             PATEVE.cantidad_intentos,
                             
                             PATEVE.periodo_intentos,
                             PATEVE.tiempo_bloqueo,
                             PATEVE.email,
                             PATEVE.nombre_patron
                             from segu.tpatron_evento PATEVE
                             WHERE PATEVE.estado_reg=''activo'' AND
                             ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;
         END;

     elsif(par_transaccion='SEG_PATEVE_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(PATEVE.id_patron_evento)
                            from segu.tpatron_evento PATEVE  WHERE
                            PATEVE.estado_reg=''activo'' AND ';
               v_consulta:=v_consulta||v_parametros.filtro;
               --v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

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
-- Definition for function ft_persona_ime (OID = 305075) : 
--

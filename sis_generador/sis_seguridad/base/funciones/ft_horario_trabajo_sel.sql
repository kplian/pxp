CREATE OR REPLACE FUNCTION segu.ft_horario_trabajo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.fhorario_trabajo_sel
 DESCRIPCIÓN:   listado de horario de trabajo
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
     v_nombre_funcion:='segu.ft_horario_trabajo_sel';


     if(par_transaccion='SEG_HORTRA_SEL')then

          --consulta:=';
          BEGIN
          
              v_consulta =  'SELECT
                             HORTRA.id_horario_trabajo,
                             HORTRA.dia_semana,
                             HORTRA.hora_ini,
                             HORTRA.hora_fin,
                             (pxp.f_iif(to_char(HORTRA.dia_semana,''d'') = ''1'',''Domingo'',pxp.f_iif(to_char(HORTRA.dia_semana,''d'') = ''2'',''Lunes'',pxp.f_iif(to_char(HORTRA.dia_semana,''d'') = ''3'',''Martes'', pxp.f_iif(to_char(HORTRA.dia_semana,''d'') = ''4'',''Jueves'',pxp.f_iif(to_char(HORTRA.dia_semana,''d'') = ''5'',''Viernes'',''Sabado'')))))) ::varchar as dia_literal

                             from segu.thorario_trabajo HORTRA
                             WHERE
                             ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;
         END;

     elsif(par_transaccion='SEG_HORTRA_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(HORTRA.id_horario_trabajo)
                            from segu.thorario_trabajo HORTRA  WHERE ';
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
-- Definition for function ft_libreta_her_ime (OID = 305067) : 
--

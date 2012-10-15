CREATE OR REPLACE FUNCTION segu.ft_usuario_actividad_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_actividad_sel
 DESCRIPCIÓN: 	manejo de actividades por usuario
 AUTOR: 		KPLIAN(jrr)
 FECHA:		    28/02/2008
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			16/11/2010			
***************************************************************************/

DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_usuario_actividad_sel';
     
     
 /*******************************    
 #TRANSACCION:  SEG_USUACT_SEL
 #DESCRIPCION:	lista las actividades por usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/

     if(par_transaccion='SEG_USUACT_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            usuact.id_usuario_actividad,
                            usuact.id_usuario,
                            usuact.id_actividad,
                            usuact.fecha_reg,
                            usuact.estado_reg,
                            activi.nombre as desc_actividad,
                            person.nombre_completo2 as desc_person
                        FROM segu.tusuario_actividad usuact
                        INNER JOIN segu.tusuario usuari
                        on usuari.id_usuario=usuact.id_usuario 
                        INNER JOIN segu.tactividad activi
                        on activi.id_actividad=usuact.id_actividad and activi.estado_reg=''activo''
                        INNER JOIN segu.vpersona person
                        on person.id_persona=usuari.id_persona
                        WHERE usuact.estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

 /*******************************    
 #TRANSACCION:  SEG_USUACT_CONT
 #DESCRIPCION:	Contar  las actividades por usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/
     elsif(par_transaccion='SEG_USUACT_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(usuact.id_usuario_actividad)
                            FROM segu.tusuario_actividad usuact
                            INNER JOIN segu.tusuario usuari
                            ON usuari.id_usuario=usuact.id_usuario
                            INNER JOIN segu.tactividad activi
                            ON activi.id_actividad=usuact.id_actividad
                            where usuact.estado_reg=''activo'' and ';
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
-- Definition for function ft_usuario_ime (OID = 305100) : 
--

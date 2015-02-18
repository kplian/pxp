CREATE OR REPLACE FUNCTION segu.ft_bloqueo_notificacion_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_bloqueo_notificacion_sel
 DESCRIPCIÓN:   listado de los bloquos y notificaciones del sistema
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

v_consulta    varchar;
v_parametros  record;
v_resp          varchar;
v_nombre_funcion   text;
v_mensaje_error    text;
v_res_actualiz    varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(p_tabla);
     v_nombre_funcion:='segu.f_t_bloqueo_notificacion_sel';

/*******************************    
 #TRANSACCION:  SEG_NOTI_SEL
 #DESCRIPCION:	Listado del notificacion de eventos del sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     if(p_transaccion='SEG_NOTI_SEL')then

          
          BEGIN
               v_consulta:='select blono.id_bloqueo_notificacion,
                                    blono.nombre_patron,
                                    blono.aplicacion,
                                    blono.tipo_evento,
                                    blono.usuario,
                                    blono.ip,
                                    to_char(blono.fecha_hora_ini,''DD/MM/YYYY HH:MI:SS''),
                                    to_char(blono.fecha_hora_fin,''DD/MM/YYYY HH:MI:SS'')
               
                        from segu.tbloqueo_notificacion blono
                        where tipo=''notificacion'' and estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************    
 #TRANSACCION:  SEG_NOTI_CONT
 #DESCRIPCION:	Contar registros de notificaciones de enventos del sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_NOTI_CONT')then

          --consulta:=';
          BEGIN
               v_consulta:='select count(blono.id_bloqueo_notificacion)
                              from segu.tbloqueo_notificacion blono
                              where tipo=''notificacion'' and estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
         
/*******************************
 #TRANSACCION:  SEG_BLOQUE_SEL
 #DESCRIPCION:	Listado de bloqueos del sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_BLOQUE_SEL')then


          BEGIN
               v_consulta:='select blono.id_bloqueo_notificacion,
                                    blono.nombre_patron,
                                    blono.aplicacion,
                                    blono.tipo_evento,
                                    blono.usuario,
                                    blono.ip,
                                    to_char(blono.fecha_hora_ini,''DD/MM/YYYY HH:MI:SS''),
                                    to_char(blono.fecha_hora_fin,''DD/MM/YYYY HH:MI:SS'')

                        from segu.tbloqueo_notificacion blono
                        where tipo=''bloqueo'' and estado_reg=''activo'' and
                                fecha_hora_fin>now() and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_BLOQUE_CONT
 #DESCRIPCION:	Contar registros de bloqueos del sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_BLOQUE_CONT')then

          --consulta:=';
          BEGIN
               v_consulta:='select count(blono.id_bloqueo_notificacion)
                              from segu.tbloqueo_notificacion blono
                              where tipo=''bloqueo'' and estado_reg=''activo'' and
                                fecha_hora_fin>now() and ';
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
-- Definition for function ft_clasificador_ime (OID = 305046) : 
--

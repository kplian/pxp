CREATE OR REPLACE FUNCTION segu.ft_horario_trabajo_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************

 FUNCION: 		segu.ft_horario_trabajo_ime
 DESCRIPCIÓN: 	
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

v_parametros           record;
v_respuesta            varchar;
v_nombre_funcion       text;
v_mensaje_error        text;
v_accion               varchar;
v_resp                 varchar;

BEGIN

     v_nombre_funcion:='segu.ft_horario_trabajo_ime';
     v_parametros:=pxp.f_get_record(par_tabla); 
     

     if(par_transaccion='SEG_HORTRA_INS')then

        --raise exception 'lelga%',v_parametros.hora_ini;--||'---'||(select to_char(v_parametros.hora_ini,'HH24:mm'));
          BEGIN
              INSERT INTO segu.thorario_trabajo (
                          dia_semana,
                          hora_ini,
                          hora_fin
                           )

               values(     v_parametros.dia_semana,
                           v_parametros.hora_ini,
                           v_parametros.hora_fin);


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Horario de Trabajo insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'horario_trabajo',1::varchar);
    
         END;          
   
     elsif(par_transaccion='SEG_HORTRA_MOD')then


          BEGIN
               --modificacion de tipo_obligacion
                update segu.thorario_trabajo
                set
                          dia_semana=v_parametros.dia_semana,
                          hora_ini=v_parametros.hora_ini,
                          hora_fin=v_parametros.hora_fin
                where id_horario_trabajo=v_parametros.id_horario_trabajo;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','horario_trabajo modificado con exito '||v_parametros.id_horario_trabajo);
                v_resp = pxp.f_agrega_clave(v_resp,'id_horario_trabajo',v_parametros.id_horario_trabajo::varchar);
          END;
     elsif(par_transaccion='SEG_HORTRA_ELI')then
        BEGIN

         --inactivacion de tipo_obligacion
              delete from segu.thorario_trabajo
              where id_horario_trabajo=v_parametros.id_horario_trabajo;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','horario_trabajo eliminado con exito '||v_parametros.id_horario_trabajo);
               v_resp = pxp.f_agrega_clave(v_resp,'horario_trabajo',v_parametros.id_horario_trabajo::varchar);

        END;
     else

         raise exception 'No existe la transaccion: %',par_transaccion;
     end if;
     
   return v_resp; 

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
-- Definition for function ft_horario_trabajo_sel (OID = 305066) : 
--

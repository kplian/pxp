CREATE OR REPLACE FUNCTION segu.ft_patron_evento_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************

 FUNCION: 		segu.ft_patron_evento_ime
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

     v_nombre_funcion:='segu.ft_patron_evento_ime';
     v_parametros:=pxp.f_get_record(par_tabla); 
     

     if(par_transaccion='SEG_PATEVE_INS')then

        
          BEGIN
              INSERT INTO segu.tpatron_evento (
                           tipo_evento,
                           operacion,
                           aplicacion,
                           cantidad_intentos,
                           periodo_intentos,
                           tiempo_bloqueo,
                           email,
                           nombre_patron,
                           estado_reg
                           )

               values(     v_parametros.tipo_evento,
                           v_parametros.operacion,
                           v_parametros.aplicacion,
                           v_parametros.cantidad_intentos,
                           v_parametros.periodo_intentos,
                           v_parametros.tiempo_bloqueo,
                           v_parametros.email,
                           v_parametros.nombre_patron,
                           'activo');


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Patron evento insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'patron_evento',1::varchar);
    
         END;          
   
     elsif(par_transaccion='SEG_PATEVE_MOD')then


          BEGIN
               --modificacion de tipo_obligacion
                update segu.tpatron_evento
                set
                           tipo_evento=v_parametros.tipo_evento,
                           operacion=v_parametros.operacion,
                           aplicacion=v_parametros.aplicacion,
                           cantidad_intentos=v_parametros.cantidad_intentos,
                           periodo_intentos=v_parametros.periodo_intentos,
                           tiempo_bloqueo=v_parametros.tiempo_bloqueo,
                           email=v_parametros.email,
                           nombre_patron=v_parametros.nombre_patron
                where id_patron_evento=v_parametros.id_patron_evento;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','patron_evento modificado con exito '||v_parametros.id_patron_evento);
                v_resp = pxp.f_agrega_clave(v_resp,'id_patron_evento',v_parametros.id_patron_evento::varchar);
          END;
     elsif(par_transaccion='SEG_PATEVE_ELI')then
        BEGIN

         --inactivacion de patron_evento
              update segu.tpatron_evento
              set estado_reg='inactivo'
              where id_patron_evento=v_parametros.id_patron_evento;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','patron_evento eliminado con exito '||v_parametros.id_patron_evento);
               v_resp = pxp.f_agrega_clave(v_resp,'patron_evento',v_parametros.id_patron_evento::varchar);

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
-- Definition for function ft_patron_evento_sel (OID = 305074) : 
--

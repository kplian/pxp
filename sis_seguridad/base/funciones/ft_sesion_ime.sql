CREATE OR REPLACE FUNCTION segu.ft_sesion_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_sesion_ime
 DESCRIPCIÓN: 	Permite registrar de sesiones activas e inectavas de un usuario
 AUTOR: 		KPLIAN(rac)
 FECHA:			19/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/

DECLARE


v_parametros       	record;
v_resp              varchar;
v_respuesta        	varchar;
v_nombre_funcion   	text;
v_mensaje_error    	text;
v_id_sesion			integer;

BEGIN

     v_nombre_funcion:='segu.ft_sesion_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
 /*******************************    
 #TRANSACCION:  SEG_SESION_INS
 #DESCRIPCION:	registra sesiones  de un usuario
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
***********************************/
     if(par_transaccion='SEG_SESION_INS')then

        
          BEGIN
                update segu.tsesion
                    set estado_reg='inactivo'
                where id_usuario=v_parametros.id_usuario
                    and estado_reg='activo';
               insert into segu.tsesion(
             	variable,
		        ip,
		        fecha_reg,
		        id_usuario,
		        estado_reg,
		        hora_act,
		        hora_des,
                datos,
                pid_web,
                inicio_proceso
		        ) VALUES (
		        v_parametros.variable,
		        v_parametros.ip,
		        now(),
		        v_parametros.id_usuario,
		        'activo',
		        now(),
		        NULL,
                v_parametros.datos,
                v_parametros.pid,
                now()
                		        
            )returning  id_sesion into v_id_sesion;                           
            
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Sesion insertada con exito '||v_id_sesion); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcion',v_id_sesion::varchar);
            return 'Sesion  insertada con exito';

         END; 
         
 /*******************************    
 #TRANSACCION:  SEG_SESION_MOD
 #DESCRIPCION:	Modifica la una variable de sesion
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
***********************************/          
     elseif (par_transaccion='SEG_SESION_MOD')then      
        
          BEGIN
              UPDATE segu.tsesion
              SET datos = v_parametros.datos
              WHERE variable = v_parametros.variable
              and ip = v_parametros.ip;
              
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Sesion modificada con exito, variable: '||v_parametros.variable); 
              v_resp = pxp.f_agrega_clave(v_resp,'variable',v_parametros.variable::varchar);  		        
           
            return 'Sesion  insertada con exito';

         END;         
         	v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Sesion modificada con exito '||v_id_sesion); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcion',v_id_sesion::varchar);
     else

         raise exception 'No existe la transaccion: %',par_transaccion;
     end if;

EXCEPTION

       WHEN OTHERS THEN

         v_mensaje_error:=pxp.f_get_mensaje_err(SQLSTATE::varchar,SQLERRM::text,v_nombre_funcion,null,null);
         raise exception '%', v_mensaje_error;


END;
$body$
    LANGUAGE plpgsql SECURITY DEFINER;
--
-- Definition for function ft_sesion_sel (OID = 305094) : 
--

CREATE OR REPLACE FUNCTION segu.ft_gui_rol_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************

 FUNCION: 		segu.ft_gui_rol_ime
 DESCRIPCIÓN: 	registro de permisos sobre gui y procedimiento en roles
 AUTOR: 		KPLIAN(jrr)	
 FECHA:			19/07/2010
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

     v_nombre_funcion:='segu.ft_gui_rol_ime';
     v_parametros:=pxp.f_get_record(par_tabla); 
     
 /*******************************    
 #TRANSACCION:  SEG_GUIROL_INS
 #DESCRIPCION:	Modifica los permisos del un rol ID_ROL sobre un  tipo TIPO
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		19-07-2010	
***********************************/

     if(par_transaccion='SEG_GUIROL_INS')then

        
          BEGIN
               if(v_parametros.checked='true')then
                   v_accion='dar';
               else
                   v_accion='quitar';
               end if;
               
               if(v_parametros.tipo='gui')then
                   v_respuesta:=segu.f_permiso_rol(v_parametros.id,null,v_parametros.id_rol,v_accion,'subir_bajar');
               else
                   v_respuesta:=segu.f_permiso_rol(null,v_parametros.id,v_parametros.id_rol,v_accion,'subir_bajar');
               end if;   
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se modifico con exito los permisos del rol '||v_parametros.id_rol ||' sobre '|| v_parametros.tipo ||'  id='||v_parametros.id); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol',v_parametros.id_rol::varchar);
    
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
  		v_resp = pxp.agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;

END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function ft_gui_rol_sel (OID = 305061) : 
--

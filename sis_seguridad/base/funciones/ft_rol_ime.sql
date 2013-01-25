CREATE OR REPLACE FUNCTION segu.ft_rol_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************

 FUNCION: 		segu.ft_rol_ime
 DESCRIPCIÓN: 	registro de roles
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


v_parametros           record;
v_resp                  varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id_rol 					integer;
v_id_subsistema				integer;

BEGIN

     v_nombre_funcion:='segu.ft_rol_ime';
     v_parametros:=pxp.f_get_record(p_tabla);
/*******************************
 #TRANSACCION:  SEG_ROL_INS
 #DESCRIPCION:	Inserta Rol
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     if(p_transaccion='SEG_ROL_INS')then

        
          BEGIN
               insert into segu.trol(descripcion,rol,id_subsistema)
               values(v_parametros.descripcion,v_parametros.rol,v_parametros.id_subsistema)
                RETURNING id_rol into v_id_rol;

                     
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol insertado con exito '||v_id_rol); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol',v_id_rol::varchar);


         END;
/*******************************
 #TRANSACCION:  SEG_ROL_MOD
 #DESCRIPCION:	Modifica Rol
 #AUTOR:		KPLIAN(rac)
 #FECHA:		08/01/11	
***********************************/
     elsif(p_transaccion='SEG_ROL_MOD')then

          
          BEGIN
               select id_subsistema
               into v_id_subsistema
               from segu.trol
               where id_rol=v_parametros.id_rol;
               
               if (v_id_subsistema != v_parametros.id_subsistema)then
               	raise exception 'No es posible cambiar el subsistema de un rol';
               end if;
               
               update segu.trol set              
                      descripcion=v_parametros.descripcion,                     
                      rol=v_parametros.rol
               where id_rol=v_parametros.id_rol;           
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol modificado con exito '||v_parametros.id_rol); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol',v_parametros.id_rol::varchar);

          END;
/*******************************
 #TRANSACCION:  SEG_ROL_ELI
 #DESCRIPCION:	Elimina Rol
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
    elsif(p_transaccion='SEG_ROL_ELI')then

         
          BEGIN
               update segu.trol set estado_reg='inactivo'
               where id_rol=v_parametros.id_rol;
               
                     
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol eliminado con exito '||v_parametros.id_rol); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol',v_parametros.id_rol::varchar);

               
         END;

     else

         raise exception 'No existe la transaccion: %',p_transaccion;
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
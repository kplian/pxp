CREATE OR REPLACE FUNCTION segu.ft_usuario_rol_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_subsistema
 DESCRIPCIÓN: 	gestion de subsistemas
 AUTOR: 		
 FECHA:			
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	Actualizacion de version de XPH
 AUTOR: 		KPLIAN(rac)
 FECHA:			26/11/2010		
***************************************************************************/

DECLARE


v_parametros           record;
v_resp           varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id_usuario_rol integer;

BEGIN

     v_nombre_funcion:='segu.ft_usuario_rol_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
 /*******************************    
 #TRANSACCION:  SEG_USUROL_INS
 #DESCRIPCION:	funcion para insertar usuario 
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		16-11-2010	
***********************************/

     if(par_transaccion='SEG_USUROL_INS')then
     
        BEGIN
         --revisa si el usuario ya tiene asignado ese rol
            if(exists(select 1
                      from segu.tusuario_rol
                      where id_rol=v_parametros.id_rol 
                        and id_usuario=v_parametros.id_usuario 
                        and estado_reg='activo'))then
               
               raise exception 'El usuario ya tiene asignado ese rol';
            
            end if;
               
              --insertar el rol si no lo tiene todavia   
               insert into segu.tusuario_rol(id_rol,id_usuario)
               values(v_parametros.id_rol,v_parametros.id_usuario)
               returning id_usuario_rol into v_id_usuario_rol;
               
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario rol insertado con exito '||v_id_usuario_rol); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuaio_rol',v_id_usuario_rol::varchar);

              
         
         END;
 /*******************************    
 #TRANSACCION:  SEG_USUROL_MOD
 #DESCRIPCION:	modifica roles de usuario
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		16-11-2010	
***********************************/
     elsif(par_transaccion='SEG_USUROL_MOD')then

         --verifica que el nuevo rol que se quiere asignar no
         --no lo este previamente 
          BEGIN
            if(exists(select 1
                      from segu.tusuario_rol
                      where id_rol=v_parametros.id_rol 
                      and id_usuario=v_parametros.id_usuario 
                      and estado_reg='activo'))then
                
                raise exception 'El usuario ya tiene asignado ese rol';
                
            end if;
            
          --modifica el rol del usario  
               update segu.tusuario_rol set
                      id_rol=v_parametros.id_rol,
                      id_usuario=v_parametros.id_usuario
               where id_usuario_rol=v_parametros.id_usuario_rol;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario rol modificado con exito '||v_parametros.id_usuario_rol); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuaio_rol',v_parametros.id_usuario_rol::varchar);


          END;
 /*******************************    
 #TRANSACCION:  SEG_USUROL_ELI
 #DESCRIPCION:	retira  el rol asignado a un uusario
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		16-11-2010	
***********************************/
    elsif(par_transaccion='SEG_USUROL_ELI')then

         
          BEGIN
               update segu.tusuario_rol set estado_reg='inactivo'
               where id_usuario_rol=v_parametros.id_usuario_rol;
               return 'Usuario rol inactivcado con exito';
               
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario rol eliminado con exito '||v_parametros.id_usuario_rol); 
          v_resp = pxp.f_agrega_clave(v_resp,'id_usuaio_rol',v_parametros.id_usuario_rol::varchar);

               
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
-- Definition for function ft_usuario_rol_sel (OID = 305107) : 
--

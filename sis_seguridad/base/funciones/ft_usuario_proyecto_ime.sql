CREATE OR REPLACE FUNCTION segu.ft_usuario_proyecto_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_proyecto_ime
 DESCRIPCIÓN: 	gestiona las transaciones ime de usairio-regional
 AUTOR: 		KPLIAN(jrr)
 FECHA:			28/02/2008
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
v_nombre_funcion            text;
v_mensaje_error             text;
v_resp varchar;
v_id_usuario_proyecto integer;

BEGIN

     v_nombre_funcion:='segu.f_t_usuario_proyecto_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
 /*******************************    
 #TRANSACCION: SEG_USUPRO_INS
 #DESCRIPCION:  Relaciona proyectos con usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/
     if(par_transaccion='SEG_USUPRO_INS')then

        
          BEGIN
               insert into segu.tusuario_proyecto(id_usuario,id_proyecto)
               values(v_parametros.id_usuario,v_parametros.id_proyecto)
               returning  id_usuario_proyecto into v_id_usuario_proyecto;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','relacion proyecto-usuario insertado con exito '||v_id_usuario_proyecto); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_proyecto',v_id_usuario_proyecto::varchar);



         END;
 /*******************************    
 #TRANSACCION:   SEG_USUPRO_MOD
 #DESCRIPCION:  Modifica la relacion de proyectos con usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/
     elsif(par_transaccion='SEG_USUPRO_MOD')then

          
          BEGIN
               
               update segu.tusuario_proyecto set
                      id_usuario=v_parametros.id_usuario,
                      id_proyecto=v_parametros.id_proyecto
                     
               where id_usuario_proyecto=v_parametros.id_usuario_proyecto;

             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario proyecto modificado con exito '||v_parametros.id_usuario_proyecto); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_proyecto',v_parametros.id_usuario_proyecto::varchar);
     
               
          END;
 /*******************************    
 #TRANSACCION:  SEG_USUPRO_ELI
 #DESCRIPCION:  Inactiva la relacion de proyectos con usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/
    elsif(par_transaccion='SEG_USUPRO_ELI')then

         
          BEGIN
               UPDATE segu.tusuario_proyecto 
               SET estado_reg='inactivo'
               WHERe id_usuario_proyecto=v_parametros.id_usuario_proyecto;
              
          
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario proyecto inactivado con exito '||v_parametros.id_usuario_proyecto); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_proyecto',v_parametros.id_usuario_proyecto::varchar);
     
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
-- Definition for function ft_usuario_proyecto_sel (OID = 305103) : 
--

CREATE OR REPLACE FUNCTION segu.ft_usuario_actividad_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_actividad_ime
 DESCRIPCIÓN: 	gestiona las transaciones ime de usairio-actividad
 AUTOR: 		KPLIAN (jrr)
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
v_id_usuario_actividad		integer;
v_resp			varchar;

BEGIN

     v_nombre_funcion:='segu.f_t_usuario_actividad_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************    
 #TRANSACCION:  SEG_USUACT_INS
 #DESCRIPCION:  Relaciona actividades con usuario
 #AUTOR:		KPLIAN (jrr)
 #FECHA:		28-02-2010	
***********************************/

     if(par_transaccion='SEG_USUACT_INS')then

        
          BEGIN
               insert into segu.tusuario_actividad(id_usuario,id_actividad)
               values(v_parametros.id_usuario,v_parametros.id_actividad)
               returning  id_usuario_actividad into v_id_usuario_actividad;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario actividad insertado con exito '||v_id_usuario_actividad); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_actividad',v_id_usuario_actividad::varchar);


         END;
 /*******************************    
 #TRANSACCION:  SEG_USUACT_MOD
 #DESCRIPCION:  Modifica la relacion de  actividades con usuario
 #AUTOR:		KPLIAN (jrr)	
 #FECHA:		28-02-2010	
***********************************/
     elsif(par_transaccion='SEG_USUACT_MOD')then

          
          BEGIN
               
               update segu.tusuario_actividad set
                      id_usuario=v_parametros.id_usuario,
                      id_actividad=v_parametros.id_actividad
                     
               where id_usuario_actividad=v_parametros.id_usuario_actividad;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario actividad modificado con exito '||v_parametros.id_usuario_actividad); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_actividad',v_parametros.id_usuario_actividad::varchar);

          END;
 /*******************************    
 #TRANSACCION:  SEG_USUACT_ELI
 #DESCRIPCION:  Inactivacion de la relacion de  actividades con usuario
 #AUTOR:		KPLIAN (jrr)	
 #FECHA:		28-02-2010	
***********************************/

    elsif(par_transaccion='SEG_USUACT_ELI')then

         
          BEGIN
               update segu.tusuario_actividad 
               set estado_reg='inactivo'
               where id_usuario_actividad=v_parametros.id_usuario_actividad;
            
          
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario actividad inactivado con exito '||v_parametros.id_usuario_actividad); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_actividad',v_parametros.id_usuario_actividad::varchar);

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
-- Definition for function ft_usuario_actividad_sel (OID = 305099) : 
--

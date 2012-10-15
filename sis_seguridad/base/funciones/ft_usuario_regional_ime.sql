CREATE OR REPLACE FUNCTION segu.ft_usuario_regional_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_regional_ime
 DESCRIPCIÓN: 	manejo de regionales por usario
 AUTOR: 		KPLIAN(jrr)
 FECHA:			28/02/2010
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
v_id_usuario_regional       integer;
v_resp                varchar;

BEGIN

     v_nombre_funcion:='segu.f_t_usuario_regional_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************    
 #TRANSACCION:  SEG_USUREG_INS
 #DESCRIPCION:	Relaciona una regional al usuario
 #AUTOR:		KPLIAN(jrr)
 #FECHA:		28/02/2010
***********************************/

     if(par_transaccion='SEG_USUREG_INS')then

        
          BEGIN
               insert into segu.tusuario_regional(id_usuario,id_regional)
               values(v_parametros.id_usuario,v_parametros.id_regional)
               returning  id_usuario_regional into v_id_usuario_regional;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario-Regional  insertada con exito '||v_id_usuario_regional); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usario_regional',v_id_usuario_regional::varchar);

          END;
          
/*******************************    
 #TRANSACCION:  SEG_USUREG_MOD
 #DESCRIPCION:	Modifica la relacion una regional y un  usuario
 #AUTOR:		KPLIAN(jrr)
 #FECHA:		28/02/2010
***********************************/
     elsif(par_transaccion='SEG_USUREG_MOD')then

          
          BEGIN
               
               update segu.tusuario_regional set
                      id_usuario=v_parametros.id_usuario,
                      id_regional=v_parametros.id_regional
                      
               where id_usuario_regional=v_parametros.id_usuario_regional;

             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario-Regional modificados con exito '||v_parametros.id_usuario_regional); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_regional',v_parametros.id_usuario_regional::varchar);
   
          END;

/*******************************    
 #TRANSACCION:  SEG_USUREG_ELI
 #DESCRIPCION:	Inactiva la relacion de una regional y un  usuario
 #AUTOR:		KPLIAN(jrr)
 #FECHA:		28/02/2010
***********************************/

    elsif(par_transaccion='SEG_USUREG_ELI')then

         
          BEGIN
               update segu.tusuario_regional set estado_reg='inactivo'
               where id_usuario_regional=v_parametros.id_usuario_regional;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario regional eliminado con exito  '||v_parametros.id_usuario_regional); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_regional',v_parametros.id_usuario_regional::varchar);
  
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
-- Definition for function ft_usuario_regional_sel (OID = 305105) : 
--

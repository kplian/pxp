CREATE OR REPLACE FUNCTION segu.ft_procedimiento_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_procedimiento_ime
 DESCRIPCION:   modificaciones de procedimiento
 AUTOR: 	    KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)		
 FECHA:		08/01/11
***************************************************************************/


DECLARE
v_parametros           record;
v_respuesta            varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_resp                  varchar;
v_id_procedimiento      integer;

BEGIN

     v_nombre_funcion:='segu.ft_procedimiento_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
/*******************************
 #TRANSACCION:  SEG_PROCED_INS
 #DESCRIPCION:	Inserta Procedimiento
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_PROCED_INS')then

        
          BEGIN
               insert into segu.tprocedimiento(
                id_funcion,             codigo,             descripcion)
               values(
                v_parametros.id_funcion,v_parametros.codigo,v_parametros.descripcion)
                 RETURNING id_procedimiento into v_id_procedimiento;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento insertado con exito '||v_id_procedimiento);
               v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento',v_id_procedimiento::varchar);


         END;
/*******************************
 #TRANSACCION:  SEG_PROCED_MOD
 #DESCRIPCION:	Modifica Procedimiento
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PROCED_MOD')then

          
          BEGIN
               
               update segu.tprocedimiento set
                      codigo=v_parametros.codigo,
                      descripcion=v_parametros.descripcion
                     

               where id_procedimiento=v_parametros.id_procedimiento;
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento modificado con exito '||v_parametros.id_procedimiento);
                v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento',v_parametros.id_procedimiento::varchar);

          END;
/*******************************
 #TRANSACCION:  SEG_PROCED_ELI
 #DESCRIPCION:	Elimina Procedimiento
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_PROCED_ELI')then

         
          BEGIN
              
              UPDATE segu.tprocedimiento
              set estado_reg = 'inactivo'
              where id_procedimiento=v_parametros.id_procedimiento;
          
          
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento eliminado con exito '||v_parametros.id_procedimiento);
                v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento',v_parametros.id_procedimiento::varchar);

        
    
    
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
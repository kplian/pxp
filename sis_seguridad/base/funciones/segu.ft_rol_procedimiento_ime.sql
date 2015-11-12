CREATE OR REPLACE FUNCTION segu.ft_rol_procedimiento_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_rol_procedimiento_gui_ime
 DESCRIPCION:   modificaciones rol procedimiento
 AUTOR: 		KPLIAN(jrr)
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
v_resp                 varchar;
v_id_rol_procedimiento  integer;

BEGIN

     v_nombre_funcion:='segu.ft_rol_procedimiento_gui_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
/*******************************
 #TRANSACCION:  SEG_ROLPRO_INS
 #DESCRIPCION:	Inserta Rol Procedimiento gui
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ROLPRO_INS')then

        
          BEGIN
               insert into segu.trol_procedimiento_gui
               (id_procedimiento,                   id_rol)
               values(
               v_parametros.id_procedimiento,       v_parametros.id_rol
               )RETURNING id_rol_procedimiento into v_id_rol_procedimiento;


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol Procedimiento gui insertado con exito '||v_id_rol_procedimiento);
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol_procedimiento',v_id_rol_procedimiento::varchar);



         END;
/*******************************
 #TRANSACCION:  SEG_ROLPRO_MOD
 #DESCRIPCION:	modifica Rol Procedimiento gui
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ROLPRO_MOD')then

          
          BEGIN
               
               update segu.trol_procedimiento_gui set
                      
                      id_procedimiento=v_parametros.id_procedimiento,
                      id_rol=v_parametros.id_rol


               where id_rol_procedimiento=v_parametros.id_rol_procedimiento;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol Procedimiento gui modificado con exito '||v_parametros.id_rol_procedimiento);
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol_procedimiento',v_parametros.id_rol_procedimiento::varchar);



          END;
/*******************************
 #TRANSACCION:  SEG_ROLPRO_ELI
 #DESCRIPCION:	elimina Rol Procedimiento gui
 #AUTOR:		KPLIAN(jrr)
 #FECHA:		08/01/11	
 *********************************
 #DESCRIPCION_MOD:	la eliminacion tiene que ser fisica no por estado
 					para permitir eliminar procedimientos_gui
 #AUTOR_MOD:		KPLIAN(rac)
 #FECHA_MOD:		08/02/12	
***********************************/
    elsif(par_transaccion='SEG_ROLPRO_ELI')then

         
          BEGIN
             /*
               update segu.trol_procedimiento_gui set estado_reg='inactivo'
               where id_rol_procedimiento=v_parametros.id_rol_procedimiento;
              */
              
              delete from segu.trol_procedimiento_gui 
              where id_rol_procedimiento=v_parametros.id_rol_procedimiento;
          
          
           v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Rol Procedimiento gui eliminado con exito '||v_parametros.id_rol_procedimiento);
               v_resp = pxp.f_agrega_clave(v_resp,'id_rol_procedimiento',v_parametros.id_rol_procedimiento::varchar);


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
-- Definition for function ft_rol_sel (OID = 305092) : 
--

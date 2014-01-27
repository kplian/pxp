CREATE OR REPLACE FUNCTION segu.ft_estructura_gui_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_estructura_gui_ime
 DESCRIPCION:   modificaciones de estructura_gui
 AUTOR: 		
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		Jaime Rivera Rojas	
 FECHA:		08/01/11
***************************************************************************/


DECLARE


v_parametros           record;
v_respuesta            varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_resp                  varchar;
v_id_estructura_gui    integer;
BEGIN

     v_nombre_funcion:='segu.ft_estructura_gui_ime';
     v_parametros:=pxp.f_get_record(par_tabla);


 /*******************************
 #TRANSACCION:  SEG_ESTGUI_INS
 #DESCRIPCION:	Inserta Estructura gui
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ESTGUI_INS')then

        
          BEGIN
               insert into segu.testructura_gui(id_gui, fk_id_gui)
               values(v_parametros.id_gui,v_parametros.fk_id_gui
               )RETURNING id_estructura_gui into v_id_estructura_gui;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura gui insertado con exito: '||v_id_estructura_gui);
               v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_gui',v_id_estructura_gui::varchar);

         END;


 /*******************************
 #TRANSACCION:  SEG_ESTGUI_MOD
 #DESCRIPCION:	Modifica Estructura gui
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ESTGUI_MOD')then

          
          BEGIN
               
               update segu.testructura_gui set

                     estado_reg = 'inactivo'

               where id_estructura_gui=v_parametros.id_estructura_gui;
               insert into segu.testructura_gui(id_gui, fk_id_gui)
               values(v_parametros.id_gui,v_parametros.fk_id_gui
               )RETURNING id_estructura_gui into v_id_estructura_gui;
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Gui modificado con exito: '||v_parametros.id_estructura_gui);
                v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_gui',v_id_estructura_gui::varchar);




          END;


 /*******************************
 #TRANSACCION:  SEG_ESTGUI_ELI
 #DESCRIPCION:	Elimina Estructura gui
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_ESTGUI_ELI')then

         
          BEGIN
               update segu.testructura_gui set estado_reg='inactivo'
               where id_estructura_gui=v_parametros.id_estructura_gui;
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Gui modificado con exito: '||v_parametros.id_estructura_gui);
               v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_gui',v_parametros.id_estructura_gui::varchar);
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
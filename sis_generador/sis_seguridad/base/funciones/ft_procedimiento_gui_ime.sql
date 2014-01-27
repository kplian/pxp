CREATE OR REPLACE FUNCTION segu.ft_procedimiento_gui_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_procedimiento_gui
 DESCRIPCIÓN: 	gestion de procedimiento GUI
 AUTOR: 		KPLIAN(rac)	
 FECHA:			18/10/2010
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
v_id_procedimiento_gui      integer;
v_resp varchar;
v_id_procedimiento      integer;

BEGIN

     v_nombre_funcion:='segu.ft_procedimiento_gui_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
/*******************************
 #TRANSACCION:  SEG_PROGUI_INS
 #DESCRIPCION:	Inserta Procedimiento_Gui
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_PROGUI_INS')then

        
          BEGIN
               INSERT INTO segu.tprocedimiento_gui(
                     id_procedimiento, 
                     id_gui,
                     boton)
               VALUES (
                       v_parametros.id_procedimiento, 
                       v_parametros.id_gui,
               		   v_parametros.boton)
               RETURNING id_procedimiento_gui into v_id_procedimiento_gui;

             --  return 'Procedimiento GUI insertado con exito';
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento GUI  insertada con exito '||v_id_procedimiento_gui); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento_gui',v_id_procedimiento_gui::varchar);

         END;
/*******************************
 #TRANSACCION:  SEG_PROGUI_MOD
 #DESCRIPCION:	Modifica Procedimiento_Gui
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PROGUI_MOD')then

          
          BEGIN
            select id_procedimiento
            into v_id_procedimiento
            from segu.tprocedimiento_gui
            where id_procedimiento_gui = v_parametros.id_procedimiento_gui;
            
            if (v_id_procedimiento = v_parametros.id_procedimiento)then
            	update segu.tprocedimiento_gui set
                        id_gui=v_parametros.id_gui,
                        boton=v_parametros.boton
                where id_procedimiento_gui=v_parametros.id_procedimiento_gui;
                v_id_procedimiento_gui = v_parametros.id_procedimiento_gui;
			else
            	update segu.tprocedimiento_gui set
                        estado_reg = 'inactivo'
                where id_procedimiento_gui=v_parametros.id_procedimiento_gui;
				INSERT INTO segu.tprocedimiento_gui(
                     id_procedimiento, 
                     id_gui,
                     boton)
                VALUES (
                       v_parametros.id_procedimiento, 
                       v_parametros.id_gui,
               		   v_parametros.boton)
                RETURNING id_procedimiento_gui into v_id_procedimiento_gui;
            
            end if;   
                 
             
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento GUI modificado con exito '||v_parametros.id_procedimiento_gui::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento_gui',v_id_procedimiento_gui::varchar);
          
     
      END;
/*******************************
 #TRANSACCION:  SEG_PROGUI_ELI
 #DESCRIPCION:	Elimina Procedimiento_Gui
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_PROGUI_ELI')then

         
          BEGIN
            
          UPDATE segu.tprocedimiento_gui
          set estado_reg = 'inactivo'
          WHERE id_procedimiento_gui=v_parametros.id_procedimiento_gui;
              
              
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento GUI inactivado con exito '|| v_parametros.id_procedimiento_gui); 
              v_resp = pxp.f_agrega_clave(v_resp,'id_procedimiento_gui',v_parametros.id_procedimiento_gui::varchar);
         
    
    
      END;

/*******************************
 #TRANSACCION:  SEG_PROGUISINC_MOD
 #DESCRIPCION:	Sincroniza la relacion de las transacciones con las interfaces
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		30/01/12	
***********************************/
    elsif(par_transaccion='SEG_PROGUISINC_MOD')then

         
          BEGIN
            
          --verificar si existe la transaccion y obtener el id
          select id_procedimiento
          into v_id_procedimiento
          from segu.tprocedimiento
          where estado_reg = 'activo' and codigo = v_parametros.transaccion;
          
          if (v_id_procedimiento is not null) then
          	-- si no existe la relacion procedimiento_gui se inserta y sino se obtiene y se devuelve el id
          	select id_procedimiento_gui 
            into v_id_procedimiento_gui
            from segu.tprocedimiento_gui
            where estado_reg = 'activo' and id_gui = v_parametros.id_gui and id_procedimiento = v_id_procedimiento;
            
            if (v_id_procedimiento_gui is null) then
            	INSERT INTO segu.tprocedimiento_gui(
                     id_procedimiento, 
                     id_gui,
                     boton)
                VALUES (
                       v_id_procedimiento, 
                       v_parametros.id_gui,
               		   'no');
            end if;
          
          end if;             
              
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Procedimiento GUI sincronizado con exito '); 
           
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
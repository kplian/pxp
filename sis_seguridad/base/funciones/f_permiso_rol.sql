CREATE OR REPLACE FUNCTION segu.f_permiso_rol (
  par_id_gui integer,
  par_id_procedimiento_gui integer,
  par_id_rol integer,
  par_accion varchar,
  par_direccion varchar,
  par_temporal integer = NULL::integer
)
RETURNS varchar AS
$body$
/**************************************************************************

 FUNCION: 		segu.f_permiso_rol
 DESCRIPCION: 	Asigna permisos a un rol de forma recursiva en el arbol
 AUTOR: 		KPLIAN(JRR)
 FECHA:			19/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE

v_consulta    varchar;
v_registros  record;
v_respuesta     varchar;
v_nombre_funcion varchar;
v_mensaje_error  varchar;
v_resp		varchar;

/*
paramteros:

solo se puede tener id_gui o id_procedimiento (uno a la vez)


par_id_gui: id_gui al que se quiere otorgar o quitar permisos
par_id_procedimiento:id_procedimiento al q se quiere otorgar o quitar permisos
par_id_rol: id_del rol al que se totorga o se quitan los permisos
par_accion: "dar"=> da permisos al rol sobre la interfaz o la transaccion
        "quitar" =>revoca permisos sobre la interfaz o la transaccion
par_direccion:  "subir" => llamada q va dando permisos sobre las transacciones padre
                "bajar" => llamada q va dando permiso sobre todos los hijos
                "subir_bajar"=>otorga permisos tanto de subida comod e bajada (Para la primera llamada "subir_bajar")




1) Validamos la accion a realizar dar permiso o quitar permiso
    1.1) "dar" Se otorga permiso sobre la interfaz o transaccion
    1.2) "quitar" Se quita permiso sobre la interfaz o transaccion
2) Validamos la sigueinte accionde acuerdo a la direccion "subir","bajar","subir_bajar"
    2.1) Si es "subir" o "subir_bajar" hacemos una llamada recursiva a esta funcion para el padre de esta transaccion
        o vista
    2.2) Si es "bajar" o "subir_bajar" y no es una transaccion
        hacemos una llamada recursiva a esta funcion para cada hijo de este metaproceso

*/

BEGIN


    v_nombre_funcion:='segu.fpermiso_rol';
--1) Validamos la accion a realizar dar permiso o quitar permiso
    --1.1) "dar" Se otorga permiso sobre la interfaz o transaccion
    if(par_accion='dar')then
        --1.1.1) Si no existe el permiso sobre la transaccion lo insertamos
        if(par_id_gui is null)then
            if(not exists(select
                            1
                        from segu.trol_procedimiento_gui
                        where id_rol=par_id_rol and id_procedimiento_gui=par_id_procedimiento_gui
                        and estado_reg='activo'))then

            insert into segu.trol_procedimiento_gui (
                id_rol,
                id_procedimiento_gui)
            values(
                par_id_rol,
                par_id_procedimiento_gui);
            end if;
        --1.1.2) Si no existe el permiso sobre la vista lo insertamos
        else
            if(not exists(select
                            1
                        from segu.tgui_rol
                        where id_rol=par_id_rol and id_gui=par_id_gui
                        and estado_reg='activo'))then

            insert into segu.tgui_rol (
                id_rol,
                id_gui,
                temporal)
            values(
                par_id_rol,
                par_id_gui,
                par_temporal);
            end if;
        end if;
    
    --1.2) "quitar" Se quita permiso sobre la interfaz o transaccion
    ELSE
        --1.2.1) Quitamos cualquier permiso sobre la transaccion
        if(par_id_gui is null)then
            update segu.trol_procedimiento_gui set
                estado_reg='inactivo'
            where id_rol=par_id_rol and id_procedimiento_gui=par_id_procedimiento_gui;
        --1.2.1) Quitamos cualquier permiso sobre la vista
        else
            if(par_direccion='subir')then
                if(not exists(select 1 from segu.tgui_rol gr 
                              inner join segu.testructura_gui eg on(gr.id_gui=eg.id_gui)
                        where fk_id_gui=par_id_gui
                    and id_rol=par_id_rol and gr.estado_reg='activo' 
                    and eg.estado_reg='activo'))then
                    if(not exists(select 1 from segu.tprocedimiento_gui pg 
                                           inner join segu.trol_procedimiento_gui rpg 
                                           on(pg.id_procedimiento_gui=rpg.id_procedimiento_gui)
                        where pg.id_gui=par_id_gui
                          and id_rol=par_id_rol and rpg.estado_reg='activo' and pg.estado_reg='activo'))then
                            update segu.tgui_rol set
                                estado_reg='inactivo'
                            where id_rol=par_id_rol and id_gui=par_id_gui;
                    end if;
                end if;

            else
                update segu.tgui_rol set
                    estado_reg='inactivo'
                where id_rol=par_id_rol and id_gui=par_id_gui;
            end if;
        end if;
    
    
    end if;
--2) Validamos la sigueinte accionde acuerdo a la direccion "subir","bajar","subir_bajar"
    --2.1) Si es "subir" o "subir_bajar" hacemos una llamada recursiva a esta funcion para el padre de esta transaccion
        --o vista
    if(par_direccion='subir' or par_direccion='subir_bajar')then
        if(par_id_gui is null)THEN
            v_consulta:='select id_gui
                         from segu.tprocedimiento_gui
                         where estado_reg=''activo'' 
                         and id_procedimiento_gui='||par_id_procedimiento_gui;

        else
            v_consulta:='select fk_id_gui as id_gui
                         from segu.testructura_gui
                         where estado_reg=''activo'' and id_gui='||par_id_gui;
        
        end if;


        for v_registros in
        execute(v_consulta)loop
            v_respuesta:= segu.f_permiso_rol(v_registros.id_gui,null,par_id_rol,par_accion,'subir',par_temporal);

        end loop;
    end if;
    
    --2.2) Si es "bajar" o "subir_bajar" y no es una transaccion
        --hacemos una llamada recursiva a esta funcion para cada hijo de este metaproceso
    if((par_direccion='bajar' or par_direccion='subir_bajar') and par_id_gui is not null)then
         v_consulta:='select id_procedimiento_gui
                         from segu.tprocedimiento_gui
                         where estado_reg=''activo'' 
                         and id_gui='||par_id_gui;
                         
         for v_registros in
         execute(v_consulta)loop
             v_respuesta:= segu.f_permiso_rol(null,v_registros.id_procedimiento_gui,par_id_rol,par_accion,'bajar',par_temporal);

         end loop;

        
         v_consulta:='select id_gui
                       from segu.testructura_gui
                       where estado_reg=''activo'' and fk_id_gui='||par_id_gui;

        
        for v_registros in
         execute(v_consulta)loop
             v_respuesta:= segu.f_permiso_rol(v_registros.id_gui,null,par_id_rol,par_accion,'bajar',par_temporal);

         end loop;

    end if;
    return 'exito';


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
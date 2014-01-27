CREATE OR REPLACE FUNCTION segu.ft_rol_procedimiento_gui_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_rol_procedimiento_gui_sel
 DESCRIPCIÓN: 	listado de procesimientos asignado 
                a una intarface segun el rol especificado
 AUTOR: 		KPLIAN(rac)
 FECHA:			26/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/


DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_id_padre         integer;

v_resp                  varchar;
v_where varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.f_t_rol_procedimiento_gui_sel';


 /*******************************
 #TRANSACCION:  SEG_ROLPROGUI_SEL
 #DESCRIPCION:	Selecciona Procesos por Gui y Rol
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ROLPROGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                            pg.id_procedimiento_gui,
                            pg.id_gui,
                            pg.id_procedimiento,
                            p.codigo,
                            p.descripcion,
                            (case
                             when exists (  SELECT 1
                                            FROM segu.trol_procedimiento_gui rpg
                                            WHERE rpg.id_procedimiento_gui=pg.id_procedimiento_gui
                                            and rpg.estado_reg=''activo'' and rpg.id_rol='||v_parametros.id_rol||')then
                               ''true''
                             ELSE
                                ''false''
                             end)::varchar as checked,
                             (''transaccion'')::varchar as tipo_meta,
                             (pg.id_procedimiento_gui||''_transaccion'')::varchar  as id_nodo,
                            '||v_parametros.id_rol||'::integer as id_rol
                            
                        FROM segu.tprocedimiento_gui pg
                        INNER JOIN segu.tprocedimiento p
                            ON(p.id_procedimiento=pg.id_procedimiento)
                        
                        WHERE pg.estado_reg=''activo''' ;

                    if(v_parametros.id_padre = '%') then
                        v_id_padre:=0;
                
                    else
                        v_id_padre:=v_parametros.id_padre;
                    end if;

               v_consulta:=v_consulta|| ' and pg.id_gui= '|| v_id_padre;
               

                        
             
               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPROLPROCGUI_SEL
 #DESCRIPCION:	Listado de rol_procedimiento_gui de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPROLPROGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select ''rol_procedimiento_gui''::varchar, r.rol, p.codigo, g.codigo_gui, rpg.estado_reg
                            from segu.trol_procedimiento_gui rpg
                            inner join segu.tprocedimiento_gui pg
                                on pg.id_procedimiento_gui = rpg.id_procedimiento_gui
                            inner join segu.tprocedimiento p
                                on p.id_procedimiento = pg.id_procedimiento
                            inner join segu.tgui g
                                on g.id_gui = pg.id_gui
                            inner join segu.trol r
                                on rpg.id_rol = r.id_rol
                            inner join segu.tsubsistema s
                                on s.id_subsistema = g.id_subsistema
                            where  rpg.modificado is null and s.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and rpg.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by rpg.id_rol_procedimiento ASC';
                                                         
               return v_consulta;


         END;


 /*******************************
 #TRANSACCION:  SEG_ROLPRO_CONT
 #DESCRIPCION:	Cuenta Procesos por Gui y Rol
 #AUTOR:		KPLIAN(rac)
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ROLPRO_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(rolpro.id_rol_procedimiento)
                            FROM segu.trol_procedimiento rolpro
                            WHERE rolpro.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;

     else
         raise exception 'No existe la opcion';

     end if;
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
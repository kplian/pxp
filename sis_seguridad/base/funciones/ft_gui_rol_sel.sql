CREATE OR REPLACE FUNCTION segu.ft_gui_rol_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.fr_gui_rol_sel
 DESCRIPCIÓN: 	listado de interfaces con privilegios sobre procedimientos
                segun el rol especificado                     
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



v_consulta    		varchar;
v_parametros  		record;
v_nombre_funcion	text;
v_mensaje_error		text;
v_id_padre         	integer;

v_resp              varchar;
v_where 			varchar;
                            

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

 --raise exception 'XXXXXXXXXXXXXXXXXXXXxxx   No existe la opcion';

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_gui_rol_sel';

/*******************************    
 #TRANSACCION:  SEG_GUIROL_SEL
 #DESCRIPCION:	Listado de interfaces con privilegios sobre procedimientos
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		26/07/10	
***********************************/
     if(par_transaccion='SEG_GUIROL_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                             estgui.id_estructura_gui,
                             gui.id_gui,
                             gui.id_subsistema,
                             subsis.nombre as desc_subsistema,
                             gui_padre.id_gui as id_p,
                             gui.nivel,
                             coalesce(gui.nombre,'' '') as nombre,
                             gui.descripcion,
							 gui.codigo_gui,
                             gui.visible,
                             gui.orden_logico,
                             gui.ruta_archivo,
							 gui.icono,
                                (case
                                 when exists (  SELECT 1
                                                FROM segu.tgui_rol gr
                                                WHERE gr.id_gui=gui.id_gui
                                                AND gr.estado_reg=''activo'' 
                                                AND gr.id_rol='||v_parametros.id_rol||')then
                                   ''true''
                                 ELSE
                                    ''false''
                                 end)::varchar as checked,
                               -- (''gui''::varchar) as tipo_meta,
                                 case
                                        when (gui.ruta_archivo is null or gui.ruta_archivo='''')then
                                             ''carpeta''::varchar
                                        ELSE
                                            ''interface''::varchar
                                        END as tipo_meta,
                                
                                (gui.id_gui||''_gui'')::varchar  as id_nodo,
                                
                                '||v_parametros.id_rol||'::integer as id_rol
                        FROM segu.tgui gui 
                        LEFT JOIN segu.tsubsistema subsis 
                         ON subsis.id_subsistema=gui.id_subsistema
                        LEFT JOIN segu.testructura_gui estgui 
                         ON estgui.id_gui=gui.id_gui
                        LEFT JOIN segu.tgui gui_padre 
                         ON gui_padre.id_gui=estgui.fk_id_gui
                        WHERE gui.estado_reg=''activo'' and gui_padre.estado_reg=''activo'' ';
              

              if(v_parametros.id_padre = '%') then
                v_id_padre:=0;
              --  v_consulta:=v_consulta|| ' AND gui.id_subsistema= '|| v_parametros.id_subsistema;
              else
                v_id_padre:=v_parametros.id_padre;
              end if;
--raise exception 'sss%',v_id_padre;
               v_consulta:=v_consulta|| ' AND estgui.fk_id_gui= '|| v_id_padre;
               --v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               
              -- raise exception '%',v_consulta;
              
            --  v_consulta='select id_gui from segu.tgui gui';
              
               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPGUIROL_SEL
 #DESCRIPCION:	Listado de gui_rol de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPGUIROL_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select ''gui_rol''::varchar, g.codigo_gui, r.rol,gr.estado_reg
                            from segu.tgui_rol gr
                            inner join segu.tgui g
                                on gr.id_gui = g.id_gui
                            inner join segu.trol r
                                on gr.id_rol = r.id_rol
                            inner join segu.tsubsistema s
                                on s.id_subsistema = r.id_subsistema
                            where  r.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and gr.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by gr.id_gui_rol ASC';
                                                         
               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_GUIROL_CONT
 #DESCRIPCION:	Contar las interfaces con privilegios sobre procedimientos
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		26/07/10	
***********************************/    
     elsif(par_transaccion='SEG_GUIROL_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(guirol.id_gui_rol)
                            FROM segu.tgui_rol guirol 
                            INNER JOIN segu.tgui gui 
                              ON gui.id_gui=guirol.id_gui
                            INNER JOIN segu.trol rol
                              ON rol.id_rol=guirol.id_rol 
                            WHERE guirol.estado_reg=''activo'' and   ';
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
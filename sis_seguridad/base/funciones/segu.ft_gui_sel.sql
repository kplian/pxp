CREATE OR REPLACE FUNCTION segu.ft_gui_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.fgui_wel
 DESCRIPCIÓN:   listado de interfaces en formato arbol
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
v_nombre_funcion   	text;
v_mensaje_error    	text;
v_id_padre         	integer;

v_resp             	varchar;
v_where 			varchar;
v_join  			varchar;      

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_gui_sel';

/*******************************    
 #TRANSACCION:  SEG_GUI_SEL
 #DESCRIPCION:	Listado de interfaces en formato de arbol
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		26/07/10
 *******************************    
 #DESCRIPCION:	se modifica el filtro inicial para que considera nivel 0 o nivel 1
 #AUTOR_MOD:		KPLIAN(rac)		
 #FECHA_MOD:		22/11/11	
***********************************/
     if(par_transaccion='SEG_GUI_SEL')then

          --consulta:=';
          BEGIN
          
              if(v_parametros.id_padre = '%') then
                v_where := '  (g.nivel = 1 or  g.nivel = 0)
                              AND  g.id_subsistema = '||v_parametros.id_subsistema;
                 v_join:= 'LEFT';      
                      
              else
                v_where := ' eg.fk_id_gui = '||v_parametros.id_padre;
                v_join := 'INNER';
              end if;
          

                               v_consulta =  'SELECT
                                        g.id_gui,
                                        g.id_subsistema,
                                        eg.fk_id_gui as id_gui_padre,
                                        g.codigo_gui,
                                        g.nombre,
                                        g.descripcion,
                                        g.nivel,
                                        g.visible,
                                        g.orden_logico,
                                        g.ruta_archivo,
                                        g.icono,
                                        g.clase_vista,
                                        case
                                        when (g.ruta_archivo is null or g.ruta_archivo='''')then
                                             ''carpeta''::varchar
                                        ELSE
                                            ''interface''::varchar
                                        END as tipo_dato,
                                        case
                                           when (g.ruta_archivo is null or g.ruta_archivo = '''') then 
                                           (g.id_gui||''_carpeta'')::varchar
                                           ELSE 
                                           (g.id_gui||''_interface'')::varchar
                                         END 
                                         as id_nodo,
                                         g.parametros,
                                         g.codigo_mobile,
                                         g.sw_mobile,
                                         g.orden_mobile
                                  FROM segu.tgui g
                                       '||v_join||' JOIN segu.testructura_gui eg
                                       ON g.id_gui=eg.id_gui and eg.estado_reg = ''activo''
                                   WHERE g.estado_reg=''activo'' and '|| v_where ||' 
                       
                                  ORDER BY g.orden_logico, eg.fk_id_gui';
               
               return v_consulta;


         END;
         
 

/*******************************    
 #TRANSACCION:  SEG_GETGUI_SEL
 #DESCRIPCION:	Lista de datos para el manual
 #AUTOR:		KPLIAN(rac), favio figueroa penarrieta		
 #FECHA:		08/01/14
***********************************/
     elsif(par_transaccion='SEG_GETGUI_SEL')then

          --consulta:=';
          BEGIN
          
                       

                 v_consulta =  'SELECT
                          g.id_gui,
                          g.id_subsistema,
                          eg.fk_id_gui as id_gui_padre,
                          g.codigo_gui,
                          g.nombre,
                          g.descripcion,
                          g.nivel,
                          g.visible,
                          g.orden_logico,
                          g.ruta_archivo,
                          g.icono,
                          g.clase_vista,
                                       
                          case
                          when (g.ruta_archivo is null or g.ruta_archivo='''')then
                               ''carpeta''::varchar
                          ELSE
                              ''interface''::varchar
                          END as tipo_dato,
                          case
                             when (g.ruta_archivo is null or g.ruta_archivo = '''') then 
                             (g.id_gui||''_carpeta'')::varchar
                             ELSE 
                             (g.id_gui||''_interface'')::varchar
                           END 
                           as id_nodo,
                           g.imagen,
                           g.parametros
                    FROM segu.tgui g
                         INNER  JOIN segu.testructura_gui eg
                         ON g.id_gui=eg.id_gui and eg.estado_reg = ''activo''
                     WHERE g.estado_reg=''activo'' and g.id_gui = '|| v_parametros.id_gui;
               
               return v_consulta;


         END;        
         
         
/*******************************    
 #TRANSACCION:  SEG_EXPGUI_SEL
 #DESCRIPCION:	Listado de guis de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select 	''gui''::varchar,
               						g.nombre,
                                    g.descripcion,
                                    g.codigo_gui,
                                    g.visible,
                                    coalesce(g.orden_logico,0),
                                    g.ruta_archivo,
                                    g.nivel,
                                    g.icono,
                                    g.clase_vista,
                                    s.codigo,
                                    g.estado_reg,
                                    g.parametros
                                  from segu.tgui g
                                  inner join segu.tsubsistema s
                                      on s.id_subsistema = g.id_subsistema
                                  where g.temporal is null and g.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and g.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by g.id_gui ASC';
                                                         
               return v_consulta;


         END;
/*******************************    
 #TRANSACCION:  SEG_GUISINC_SEL
 #DESCRIPCION:	Listado de guis para sincronizar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/01/2013	
***********************************/

     elsif(par_transaccion='SEG_GUISINC_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select	g.id_gui,
                					g.nombre,
                                    g.descripcion,
                                    g.ruta_archivo,
                                    g.clase_vista,
                                    g.parametros
                                  from segu.tgui g
                                  where g.temporal is null and estado_reg = ''activo'' and ruta_archivo is not null and visible = ''si'' 
                                  	and clase_vista is not null and ((nivel > 1) or (nivel = 1 and id_subsistema = 0)) and trim(both '' '' from ruta_archivo) != '''' and  trim(both '' '' from clase_vista) !=''''
                                  	and g.id_subsistema = '|| v_parametros.id_subsistema ||
                            ' order by g.id_gui ASC';
                                                         
               raise notice '%', v_consulta;
               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_GUI_CONT
 #DESCRIPCION:	Contar  vistas registradas del sistema
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		26/07/10	
***********************************/
     elsif(par_transaccion='SEG_GUI_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(gui.id_gui)
                        from segu.tgui gui inner join
                        segu.subsistema subsis on subsis.id_subsistema=gui.id_subsistema
                        left join segu.testructura_gui estgui on estgui.id_gui=gui.id_gui
                        left join segu.tgui gui_padre on gui_padre.id_gui=estgui.fk_id_gui
                        where gui.estado_reg=''activo'' and gui_padre.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               
               if(v_parametros.id_padre like '%') then
                v_id_padre:=0;
              else
                v_id_padre:=v_parametros.id_padre;
              end if;
              v_consulta:=v_consulta|| ' and estgui.fk_id_gui= '||v_id_padre;
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
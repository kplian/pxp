CREATE OR REPLACE FUNCTION segu.ft_menu_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_menu_sel
 DESCRIPCION:   consultas de la tabla gui para armar el menu
 AUTOR: 	    KPLIAN(jrr)		
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		Jaime Rivera Rojas	
 FECHA:		08/01/11
***************************************************************************/


DECLARE

    v_consulta    varchar;
    v_parametros  record;
    v_nombre_funcion   text;
    v_mensaje_error    text;
    v_nivel             varchar;
    v_resp				varchar;
    v_filtro_codigo		varchar;
    v_registros			record;
    v_respuesta			integer;
    v_tabla_menu		varchar;

/*

'id_padre'
'id_subsistema'

*/

BEGIN

    v_parametros:=pxp.f_get_record(par_tabla);
    v_nombre_funcion:='segu.ft_menu_sel';

 /*******************************
 #TRANSACCION:  SEG_MENU_SEL
 #DESCRIPCION:	Arma el menu que aparece en la parte izquierda
                de la pantalla del sistema
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
	v_filtro_codigo = '';
    if(par_transaccion='SEG_MENU_SEL')then
    	BEGIN
        
    	v_tabla_menu = '';
        
                
        for v_registros in (select tp.codigo as codigo_proceso, ta.menu_nombre,te.codigo,te.nombre_estado,
        						pxp.list(terol.id_rol::text) as roles
                            from wf.ttabla ta
                            inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = ta.id_tipo_proceso
                            inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso
                            left join wf.ttipo_estado_rol terol on terol.id_tipo_estado = te.id_tipo_estado
                            where ta.vista_id_tabla_maestro is null and tp.estado_reg= 'activo' and  ta.estado_reg = 'activo' and ta.menu_codigo is not null and ta.menu_codigo != ''
                            group by tp.codigo, ta.menu_nombre,te.codigo,te.nombre_estado) loop
            	
                --registra la carpeta
                if (v_tabla_menu != v_registros.menu_nombre)then
                	v_respuesta = wf.f_registra_gui_tabla(v_registros.codigo_proceso,v_registros.menu_nombre, NULL, NULL,NULL);
                	v_tabla_menu = v_registros.menu_nombre;
                end if;                
            	
                --registr los guis
                v_respuesta = wf.f_registra_gui_tabla(	v_registros.codigo_proceso,v_registros.menu_nombre, 
                										v_registros.codigo,v_registros.nombre_estado, v_registros.roles);	
        end loop;
        
        if(v_parametros.id_padre='%')then
        
        	if (pxp.f_existe_parametro(par_tabla, 'busqueda')) then            	
            	v_nivel:='%';
            	v_filtro_codigo = ' and g.codigo_gui = ''' || v_parametros.codigo || ''' ';
            else
            	v_nivel = 1;
            end if;
            raise notice 'tiempo2:%',clock_timestamp();
        else
            v_nivel='%';
        end if;

        IF(par_administrador=1) THEN
           
              v_consulta:= 'SELECT
                                        g.id_gui,
                                        g.nombre,
                                        g.codigo_gui,
                                        g.descripcion,
                                        g.nivel,
                                        g.orden_logico,
                                        g.ruta_archivo,
                                        g.clase_vista,
                                        case
                                        when (g.ruta_archivo is null or g.ruta_archivo='''')then
                                             ''carpeta''::varchar
                                        ELSE
                                            ''hoja''::varchar
                                        END,
                                        g.icono,
                                        g.parametros
                                  FROM segu.tgui g
                                       INNER JOIN segu.testructura_gui eg
                                       ON g.id_gui=eg.id_gui
                                       AND eg.estado_reg = ''activo''
                                       INNER JOIN segu.tgui padre
                                       ON padre.id_gui = eg.fk_id_gui
                                  WHERE g.visible=''si''
								  AND g.estado_reg = ''activo''
                                  AND padre.codigo_gui::text like '''||v_parametros.id_padre||'''
                                  AND g.nivel::text like '''||v_nivel|| '''' || v_filtro_codigo || '
                                  ORDER BY g.orden_logico,eg.fk_id_gui';
                                  
                                  raise notice 'antes query: %',clock_timestamp();
              
              return v_consulta;
           
        ELSE
                      
              v_consulta:=
                   'SELECT 
                   g.id_gui,
                   g.nombre,
                   g.codigo_gui,
                   g.descripcion,
                   g.nivel,
                   g.orden_logico,
                   g.ruta_archivo,
                   g.clase_vista,
                   case
                       when (g.ruta_archivo is null or g.ruta_archivo='''')then
                            ''carpeta''::varchar
                       ELSE
                           ''hoja''::varchar
                   END ,
                   g.icono,
                   g.parametros 
                   FROM segu.tgui g  
                   inner join segu.testructura_gui eg
                   INNER JOIN segu.tgui padre ON padre.id_gui = eg.fk_id_gui
                      on g.id_gui=eg.id_gui
                         and g.estado_reg=''activo''
                         and eg.estado_reg=''activo''
                   inner join segu.tgui_rol gr
                      on gr.id_gui=g.id_gui
                         and gr.estado_reg=''activo''
                   inner join segu.trol r
                       on r.id_rol=gr.id_rol
                         and r.estado_reg=''activo''
                   inner join segu.tusuario_rol ur
                      on ur.id_rol=r.id_rol
                         and ur.estado_reg=''activo''
                   inner join segu.tusuario u
                      on u.id_usuario=ur.id_usuario
                        and u.estado_reg=''activo''
                   where g.visible=''si''
				      AND g.estado_reg = ''activo''
                      and padre.codigo_gui::text like '''||v_parametros.id_padre||'''
                     AND g.nivel::text like '''||v_nivel|| '''' || v_filtro_codigo || '
                     and u.id_usuario ='|| par_id_usuario||'
                   group by 
                   
                       g.id_gui,
                       g.nombre,
                       g.descripcion,
                       g.nivel,
                       g.orden_logico,
                       g.ruta_archivo,
                       g.clase_vista,
                       g.ruta_archivo,
                       g.icono,
                       eg.fk_id_gui
                   order by g.orden_logico,eg.fk_id_gui';
                   raise notice 'pueblo: %',v_consulta;
                  
              return v_consulta;
           	  
        END IF;
    	END;
/*******************************    
 #TRANSACCION:  SEG_GUIMOB_SEL
 #DESCRIPCION:	Listado de GUI para mobile 
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		14/06/14

***********************************/
     elsif(par_transaccion='SEG_GUIMOB_SEL')then

          --consulta:=';
          BEGIN
          
         -- raise exception 'XXXX';
             
            IF(par_administrador=1) THEN

                    
                v_consulta =  'SELECT
                                    g.id_gui,
                                    g.codigo_gui,
                                    g.nombre,
                                    g.codigo_mobile,
                                    sub.prefijo||'' ''||g.nombre as desc_mobile
                                                   
                              FROM segu.tgui g
                              INNER JOIN segu.testructura_gui eg ON g.id_gui=eg.id_gui and eg.estado_reg = ''activo''
                              INNER JOIN segu.tsubsistema sub ON sub.id_subsistema = g.id_subsistema
                              WHERE g.estado_reg=''activo''  and sw_mobile = ''si'' 
                              ORDER BY desc_mobile, g.nombre';
              
             ELSE
                  
                  v_consulta =  'SELECT
                                        g.id_gui,
                                        g.codigo_gui,
                                        g.nombre,
                                        g.codigo_mobile,
                                        g.nombre::text as desc_mobile
                                                                                     
                                  FROM segu.tgui g
                                  INNER JOIN segu.testructura_gui eg ON g.id_gui=eg.id_gui and eg.estado_reg = ''activo''
                                  INNER JOIN segu.tsubsistema sub ON sub.id_subsistema = g.id_subsistema
                                  
                                  
                                   inner join segu.tgui_rol gr
                                                on gr.id_gui=g.id_gui
                                                   and gr.estado_reg=''activo''
                                  
                                  inner join segu.trol r
                                                 on r.id_rol=gr.id_rol
                                                   and r.estado_reg=''activo''
                                  
                                  inner join segu.tusuario_rol ur
                                                on ur.id_rol=r.id_rol
                                                   and ur.estado_reg=''activo''
                                  WHERE g.estado_reg=''activo''  and sw_mobile = ''si''  and ur.id_usuario ='||par_id_usuario||'
                                  group by 
                                             
                                                g.id_gui,
                                                g.codigo_gui,
                                                g.nombre,
                                                g.codigo_mobile,
                                                desc_mobile
                                                 
                                  
                                  ORDER BY desc_mobile, g.nombre';
          
          
          END IF; 
               
            raise notice '%',v_consulta;   
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
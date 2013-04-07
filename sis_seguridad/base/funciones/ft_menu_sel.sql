--------------- SQL ---------------

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
    if(par_transaccion='SEG_MENU_SEL')then
        if(v_parametros.id_padre='%')then
            v_nivel:='1';
        else
            v_nivel='%';
        end if;

        IF(par_administrador=1) THEN
           BEGIN
              v_consulta:= 'SELECT
                                        g.id_gui,
                                        g.nombre,
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
                                        g.icono 
                                  FROM segu.tgui g
                                       INNER JOIN segu.testructura_gui eg
                                       ON g.id_gui=eg.id_gui
                                  WHERE g.visible=''si''
                                  AND eg.fk_id_gui::text like '''||v_parametros.id_padre||'''
                                  AND g.nivel::text like '''||v_nivel||'''
                                  ORDER BY g.orden_logico,eg.fk_id_gui';
                                  
                                  raise notice 'adm: %',v_consulta;
              
              return v_consulta;
           END;
        ELSE
           BEGIN
           
              v_consulta:=
                   'SELECT 
                   g.id_gui,
                   g.nombre,
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
                   g.icono 
                   FROM segu.tgui g
                   inner join segu.testructura_gui eg
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
                   and eg.fk_id_gui::text like '''||v_parametros.id_padre||'''
                   AND g.nivel::text like '''||v_nivel||'''
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
           END;
        END IF;
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
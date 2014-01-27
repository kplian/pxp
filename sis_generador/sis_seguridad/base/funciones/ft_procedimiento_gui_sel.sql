CREATE OR REPLACE FUNCTION segu.ft_procedimiento_gui_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 CAPA:          MODELO
 FUNCION: 		segu.ft_procedimiento_gui_sel
 DESCRIPCIÓN: 	Permite la gestion de interfaces 
                 de usario con todas sus operaciones basicas
                
 AUTOR: 		KPLIAN(rac)
 FECHA:			16/10/2010
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
     v_nombre_funcion:='segu.ft_procedimiento_gui_sel';

 /*******************************
 #TRANSACCION:  SEG_PROGUI_SEL
 #DESCRIPCION:	Lista procedimientos de una interfaz dada
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/

     if(par_transaccion='SEG_PROGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select 
                            progui.id_procedimiento_gui,
                            progui.id_procedimiento,
                            progui.id_gui,
                            sub.codigo as codigo_sub,
                            fun.nombre as nombre_fun,
                            proced.codigo,
                            proced.descripcion as desc_procedimiento,                           
                            progui.boton,
                            progui.fecha_reg,
                            progui.estado_reg
                        from segu.tprocedimiento_gui progui
                        inner join segu.tprocedimiento proced
                        on proced.id_procedimiento=progui.id_procedimiento
                        inner join segu.tgui gui
                        on gui.id_gui=progui.id_gui 
                        inner join segu.tfuncion fun
                        on proced.id_funcion = fun.id_funcion
                        inner join segu.tsubsistema sub
                        on sub.id_subsistema = fun.id_subsistema 
                        where progui.estado_reg=''activo'' AND progui.id_gui ='|| v_parametros.id_gui||'  AND ';
                   
                   
                   v_consulta:=v_consulta||v_parametros.filtro;


               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPPROCGUI_SEL
 #DESCRIPCION:	Listado de procedimiento_gui de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPPROCGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select ''procedimiento_gui''::varchar, p.codigo, g.codigo_gui, pg.boton, pg.estado_reg
                            from segu.tprocedimiento_gui pg
                            inner join segu.tprocedimiento p
                                on p.id_procedimiento = pg.id_procedimiento
                            inner join segu.tgui g
                                on g.id_gui = pg.id_gui
                            inner join segu.tsubsistema s
                                on s.id_subsistema = g.id_subsistema
                            where  g.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and pg.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by pg.id_procedimiento_gui ASC';
                                                         
               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  SEG_PROGUI_CONT
 #DESCRIPCION:	Cuenta procedimientos de una interfaz dada
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PROGUI_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(progui.id_procedimiento_gui)
                            from segu.tprocedimiento_gui progui
                            where progui.estado_reg=''activo'' AND progui.id_gui='||v_parametros.id_gui;
                            
               /* v_consulta:='select count(progui.id_procedimiento_gui)
                            from segu.tprocedimiento_gui progui'; */            
                            
            
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
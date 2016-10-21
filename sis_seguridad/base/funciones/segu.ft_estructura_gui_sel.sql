CREATE OR REPLACE FUNCTION segu.ft_estructura_gui_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_estructura_gui_sel
 DESCRIPCION:   consultas de estructura_gui
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


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp          varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_estructura_gui_sel';


 /*******************************
 #TRANSACCION:  SEG_ESTGUI_SEL
 #DESCRIPCION:	Selecciona Estructura gui
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ESTGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select id_estructura_gui,
                            id_gui,
                            fk_id_gui,
                            fecha_reg,
                            estado_reg
                        from segu.testructura_gui estgui
                        inner join segu.tgui guihij
                        on guihij.id_gui=estgui.id_gui
                        inner join segu.tgui guipad
                        on guipad.id_gui=estgui.fk_id_gui where
                        guihij.estado_reg=''activo'' and guipad.estado_reg=''activo'' and
                        estgui. estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPESTGUI_SEL
 #DESCRIPCION:	Listado de estructura_gui de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPESTGUI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select 	''estructura_gui''::varchar, g.codigo_gui , gfk.codigo_gui ,eg.estado_reg
                            from segu.testructura_gui eg
                            inner join segu.tgui g on g.id_gui = eg.id_gui
                            inner join segu.tsubsistema s on g.id_subsistema = s.id_subsistema
                            inner join segu.tgui gfk on gfk.id_gui = eg.fk_id_gui
                            where  g.id_subsistema = '|| v_parametros.id_subsistema;

				if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and eg.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by eg.id_estructura_gui ASC';	
                                                                       
               return v_consulta;


         END;


 /*******************************
 #TRANSACCION:  SEG_ESTGUI_CONT
 #DESCRIPCION:	Cuenta Estructura gui
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ESTGUI_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(id_estructura_gui) from segu.testructura_gui estgui
                        inner join segu.tgui guihij
                        on guihij.id_gui=estgui.id_gui
                        inner join segu.tgui guipad
                        on guipad.id_gui=estgui.fk_id_gui where
                        guihij.estado_reg=''activo'' and guipad.estado_reg=''activo'' and
                        estgui. estado_reg=''activo'' and ';
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
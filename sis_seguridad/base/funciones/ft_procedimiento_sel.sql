CREATE OR REPLACE FUNCTION segu.ft_procedimiento_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_procedimiento_sel
 DESCRIPCIÓN: 	Realiza el listado de procedimientos (trasacciones)
 AUTOR: 		KPLIAN(rac)	
 FECHA:			17/10/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/


DECLARE


v_consulta    			varchar;
v_parametros  record;
v_nombre_funcion   		text;
v_mensaje_error    		text;
v_id_padre         		integer;
v_resp                  varchar;

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_procedimiento_sel';

 /*******************************
 #TRANSACCION:  SEG_PROCED_SEL
 #DESCRIPCION:	Selecciona Procedimientos para agregar al listado del arbol
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		08/01/11	
***********************************/

     if(par_transaccion='SEG_PROCED_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select
               
               progui.id_procedimiento_gui,
               proced.id_procedimiento,
               progui.id_gui,
                            proced.id_funcion,
                            proced.codigo,
                            proced.descripcion,
                            
                            proced.habilita_log,
                            (select distinct ''transaccion'') as tipo_meta
                        from segu.tprocedimiento proced
                        inner join segu.tfuncion funcio
                        on funcio.id_funcion=proced.id_funcion 
                        left join segu.tprocedimiento_gui progui on progui.id_procedimiento=proced.id_procedimiento
                        where proced.estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
              if(v_parametros.id_padre = '%') then
                v_id_padre:=0;
              else
                v_id_padre:=v_parametros.id_padre;
              end if;
              v_consulta:=v_consulta|| ' and progui.id_gui='|| v_id_padre;
              v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPPROC_SEL
 #DESCRIPCION:	Listado de procedimiento de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPPROC_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select ''procedimiento''::varchar, p.codigo, p.descripcion, p.habilita_log, p.autor, p.fecha_creacion, f.nombre,p.estado_reg
                            from segu.tprocedimiento p
                            inner join segu.tfuncion f
                                on f.id_funcion = p.id_funcion
                            inner join segu.tsubsistema s
                                on s.id_subsistema = f.id_subsistema
                            where  f.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and p.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by p.id_procedimiento ASC';	
                                                                        
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_PROCED_CONT
 #DESCRIPCION:	Cuenta Procedimientos para agregar al listado del arbol
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/

     elsif(par_transaccion='SEG_PROCED_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(proced.id_procedimiento)
                            FROM segu.tprocedimiento proced
                            INNER join segu.tfuncion funcio
                            on funcio.id_funcion=proced.id_funcion 
                            WHERE proced.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
            
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_PROCE_SEL
 #DESCRIPCION:	Listado de Procedimientos
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PROCE_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select
                            proced.id_procedimiento,
                            proced.id_funcion,
                            proced.codigo,
                            proced.descripcion,
                            proced.habilita_log,
                            (select distinct ''transaccion'') as tipo_meta
                            from segu.tprocedimiento proced
                            inner join segu.tfuncion funcio
                            on funcio.id_funcion=proced.id_funcion
                            where proced.estado_reg=''activo'' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
                 v_consulta:=v_consulta || ' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
            
              /*if(v_parametros.id_padre = '%') then
                v_id_padre:=0;
              else
                v_id_padre:=v_parametros.id_padre;
              end if;*/

              return v_consulta;


         END;
/*******************************
 #TRANSACCION:  SEG_PROCE_CONT
 #DESCRIPCION:	Cuenta Procedimientos
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		08/01/11	
***********************************/

     elsif(par_transaccion='SEG_PROCE_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(proced.id_procedimiento)
                            from segu.tprocedimiento proced
                            inner join segu.tfuncion funcio
                            on funcio.id_funcion=proced.id_funcion where proced.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
              
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_PROCECMB_SEL
 #DESCRIPCION:	Selecciona Procedimientos para el listado
                del combo en la vista de procedimiento_gui
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		08/01/11	
***********************************/
      
        elsif(par_transaccion='SEG_PROCECMB_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                                   pro.id_procedimiento,
                                   pro.id_funcion,
                                   sub.id_subsistema,
                                   sub.codigo as codigo_sub,
                                   fun.nombre as nombre_fun,
                                   pro.codigo,
                                   pro.descripcion,
                                   pro.habilita_log
                            FROM segu.tprocedimiento pro
                                 INNER JOIN segu.tfuncion fun on fun.id_funcion = pro.id_funcion
                                 INNER JOIN segu.tsubsistema sub on sub.id_subsistema = fun.id_subsistema

                            WHERE pro.estado_reg = ''activo'' and ';
                            
                            -- pro.id_funcion='|| v_parametros.id_funcion || ' and ';
              v_consulta:=v_consulta||v_parametros.filtro;
              v_consulta:=v_consulta || ' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
            
         

              return v_consulta;


         END;

/*******************************
 #TRANSACCION:  SEG_PROCECMB_CONT
 #DESCRIPCION:	Cuenta Procedimientos para el listado
                del combo en la vista de procedimiento_gui
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_PROCECMB_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(pro.id_procedimiento)
         
                            FROM segu.tprocedimiento pro
                                 INNER JOIN segu.tfuncion fun 
                                 on fun.id_funcion = pro.id_funcion
                                 INNER JOIN segu.tsubsistema sub 
                                 on sub.id_subsistema = fun.id_subsistema

                            WHERE pro.estado_reg = ''activo'' and
                            ';
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
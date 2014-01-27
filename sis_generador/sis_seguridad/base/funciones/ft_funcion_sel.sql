CREATE OR REPLACE FUNCTION segu.ft_funcion_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_funcion_sel
 DESCRIPCIÓN:   listado de interfaces en formato arbol
 AUTOR: 		KPLIAN(rac)	
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(rac)		
 FECHA:		27/11/10
***************************************************************************/


DECLARE


v_consulta   		varchar;
v_parametros  		record;
v_nombre_funcion  	text;
v_mensaje_error    	text;
v_resp              varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_funcion_sel';   
     
/*******************************    
 #TRANSACCION:  SEG_FUNCIO_SEL
 #DESCRIPCION:	Listado de funciones registradas del sistema
 #AUTOR:		Rensi Arteaga Copari	
 #FECHA:		27/11/10	
***********************************/

     if(par_transaccion='SEG_FUNCIO_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                             funcio.id_funcion,
                             funcio.nombre,
                             funcio.descripcion,
                             funcio.fecha_reg,
                             funcio.id_subsistema,
                             funcio.estado_reg
                             FROM segu.tfuncion funcio 
                             INNER JOIN  segu.tsubsistema subsis 
                             on subsis.id_subsistema=funcio.id_subsistema
                             WHERE funcio.estado_reg=''activo'' and funcio.id_subsistema = '|| v_parametros.id_subsistema || '  and ';
               
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_EXPFUN_SEL
 #DESCRIPCION:	Listado de funciones de un subsistema para exportar
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		28/09/2012	
***********************************/

     elsif(par_transaccion='SEG_EXPFUN_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                             ''funcion''::varchar,
                             funcio.nombre,
                             funcio.descripcion,
                             subsis.codigo,
                             funcio.estado_reg
                             FROM segu.tfuncion funcio 
                             INNER JOIN  segu.tsubsistema subsis 
                             on subsis.id_subsistema=funcio.id_subsistema
                             WHERE  funcio.id_subsistema = '|| v_parametros.id_subsistema;
               if (v_parametros.todo = 'no') then                   
               		v_consulta = v_consulta || ' and funcio.modificado is null ';
               end if;
               v_consulta = v_consulta || ' order by funcio.id_funcion ASC';	
                           
               return v_consulta;


         END;
         
/*******************************    
 #TRANSACCION:  SEG_FUNCIO_CONT
 #DESCRIPCION:	Contar  funciones registradas del sistema
 #AUTOR:		Rensi Arteaga Copari	
 #FECHA:		27/11/10	
***********************************/
     elsif(par_transaccion='SEG_FUNCIO_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(funcio.id_funcion)
                            FROM segu.tfuncion funcio 
                            INNER JOIN  segu.tsubsistema subsis 
                            on subsis.id_subsistema=funcio.id_subsistema
                            WHERE funcio.estado_reg=''activo'' and  ';
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
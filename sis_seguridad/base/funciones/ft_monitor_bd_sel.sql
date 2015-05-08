CREATE OR REPLACE FUNCTION segu.ft_monitor_bd_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_monitor_bd_sel
 DESCRIPCIÓN:   listado de los objetos dela bd
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	        
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
v_resp          varchar;
v_nombre_funcion   text;
v_mensaje_error    text;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(p_tabla);
     v_nombre_funcion:='segu.f_t_log_sel';

/*******************************    
 #TRANSACCION:  SEG_MONESQ_SEL
 #DESCRIPCION:	Listado de registros del monitor de objetos de bd (Esquemas)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     if(p_transaccion='SEG_MONESQ_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select *
                            
                        from segu.vmonitor_bd_esquema mes
                        where  ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************    
 #TRANSACCION:  SEG_MONESQ_CONT
 #DESCRIPCION:	Contar registros del monitor de objetos de bd (Esquemas)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONESQ_CONT')then

          --consulta:=';
          BEGIN
                
               v_consulta:='select count(mes.nspoid)
                            from segu.vmonitor_bd_esquema mes
                            where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_MONTAB_SEL
 #DESCRIPCION:	Listado de registros del monitor de objetos de bd (Tablas)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONTAB_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select *

                        from segu.vmonitor_bd_tabla mta
                        where  ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_MONTAB_CONT
 #DESCRIPCION:	Contar registros del monitor de objetos de bd (Tablas)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONTAB_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(mta.oid)
                            from segu.vmonitor_bd_tabla mta
                            where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_MONFUN_SEL
 #DESCRIPCION:	Listado de registros del monitor de objetos de bd (Funciones)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONFUN_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select *

                        from segu.vmonitor_bd_funcion mfu
                        where  ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_MONFUN_CONT
 #DESCRIPCION:	Contar registros del monitor de objetos de bd (funciones)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONFUN_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(mfu.oid)
                            from segu.vmonitor_bd_funcion mfu
                            where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_MONIND_SEL
 #DESCRIPCION:	Listado de registros del monitor de objetos de bd (Indices)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONIND_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='select *

                        from segu.vmonitor_bd_indice min
                        where  ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
               return v_consulta;


         END;

 /*******************************
 #TRANSACCION:  SEG_MONIND_CONT
 #DESCRIPCION:	Contar registros del monitor de objetos de bd (indices)
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONIND_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(min.indexrelid)
                            from segu.vmonitor_bd_indice min
                            where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;
/*******************************
 #TRANSACCION:  SEG_MONREC_SEL
 #DESCRIPCION:	Monitorear recursos usados por el sistema
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		
***********************************/
     elsif(p_transaccion='SEG_MONREC_SEL')then

          --consulta:=';
          BEGIN
                v_resp=segu.f_monitorear_recursos();
                --raise exception 'llega';
               v_consulta:='select *
                            from tt_monitor_recursos mr
                            where  ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
                --raise exception '%',v_parametros.puntero;
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_patron_evento_ime (OID = 305073) : 
--

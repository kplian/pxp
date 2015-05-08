--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_sesion_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************

 FUNCION: 		segu.ft_sesion_sel
 DESCRIPCIÓN: 	consultar la ultima sesion de un suario especificado
 AUTOR: 		KPLIAN(rac)
 FECHA:			19/07/2010
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
v_resp 				varchar;
v_pid_web        integer;
v_id_sesion        integer;

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_sesion_sel';

/*******************************    
 #TRANSACCION:  SEG_SESION_SEL
 #DESCRIPCION:	Listado de las sesiones activas en el sistema
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		19/07/2010
***********************************/
     if(par_transaccion='SEG_SESION_SEL')then

          --consulta:=';
          BEGIN
                select pid_web,id_sesion
                into v_pid_web,v_id_sesion
                from segu.tsesion
                where id_usuario=v_parametros.id_usuario
                    and estado_reg='activo';
                    
                    raise notice 'v_pid_web: % v_id_sesion: %', v_pid_web, v_id_sesion;
                    
                --raise exception '%,%',v_pid_web,v_parametros.pid;
                if(v_pid_web!=v_parametros.pid)then
                    update segu.tsesion
                    set pid_web=v_parametros.pid,
                        inicio_proceso=now()
                    where id_sesion=v_id_sesion;
                end if;
               v_consulta:='select
                            id_usuario,
                            variable,
                            ip,
                            datos,
                            m,
                            e,
                            k,
                            p,
                            x,
                            z
                        from segu.tsesion 
                        where estado_reg=''activo'' 
                        and id_sesion= ';
               v_consulta:=v_consulta||v_id_sesion;
               v_consulta:=v_consulta||'  order by  id_sesion desc LIMIT 1 OFFSET 0';
	
               return v_consulta;


         END;


/*******************************    
 #TRANSACCION:  SEG_RECLLAVES_SEL
 #DESCRIPCION:	recupera llaves seugn el dis proporcionado
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		13/03/2015
***********************************/
     elseif(par_transaccion='SEG_RECLLAVES_SEL')then

          --consulta:=';
          BEGIN
                
               v_consulta:='select
                            m,
                            e,
                            k,
                            p,
                            x,
                            z
                        from segu.tsesion 
                        where estado_reg=''activo'' 
                        and variable= ''';
                        
               v_consulta:=v_consulta||v_parametros.sessionid||''' ';
               v_consulta:=v_consulta||'  order by  id_sesion desc LIMIT 1 OFFSET 0';
	
               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_SESION_CONT
 #DESCRIPCION:	Contar  las sesiones activas en el sistema
 #AUTOR:		KPLIAN(rac)
 #FECHA:		19/07/2010
***********************************/
     elsif(par_transaccion='SEG_SESION_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(s.id_sesion)
                            from segu.tsesion s
                            where usuact.estado_reg=''activo'' and s.id_usuario = ';
               v_consulta:=v_consulta||v_parametros.id_usuario;
               return v_consulta;
         END;

     else
        
         
          raise exception 'No existe la transaccion: %',par_transaccion;

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
SECURITY DEFINER
COST 100;
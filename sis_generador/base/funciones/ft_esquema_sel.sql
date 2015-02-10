CREATE OR REPLACE FUNCTION gen.ft_esquema_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_esquema_sel
 DESCRIPCION:   lista las interfaces en el generador
 AUTOR: 	jrr	
 FECHA:	        25/01/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
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
     v_nombre_funcion:='segu.ft_esquema_sel';
     
/*******************************    
 #TRANSACCION:  GEN_ESQUEM_SEL
 #DESCRIPCION:	Listado de esquemas en los metadatos para el combo del generador
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		25/01/11	
***********************************/

     if(par_transaccion='GEN_ESQUEM_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT n.oid::integer,
                                n.nspname::varchar AS name,
                                u.usename::varchar
                            FROM pg_namespace n
                            LEFT OUTER JOIN pg_user u ON n.nspowner = u.usesysid
                            LEFT OUTER JOIN pg_description ds ON n.oid = ds.objoid
                            where n.nspname not like ''pg_%'' and
                                n.nspname not like ''information_schema'' and ';
               
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by n.nspname limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  GEN_ESQUEM_CONT
 #DESCRIPCION:	Listado de esquemas en los metadatos para el combo del generador
 #AUTOR:		Jaime Rivera Rojas	
 #FECHA:		25/01/11	
***********************************/
     elsif(par_transaccion='GEN_ESQUEM_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(n.oid)
                            FROM pg_namespace n
                            LEFT OUTER JOIN pg_user u ON n.nspowner = u.usesysid
                            LEFT OUTER JOIN pg_description ds ON n.oid = ds.objoid
                            where n.nspname not like ''pg_%'' and
                                n.nspname not like ''information_schema'' and ';
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_tabla_ime (OID = 303922) : 
--

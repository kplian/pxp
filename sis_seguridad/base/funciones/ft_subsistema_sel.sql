CREATE OR REPLACE FUNCTION segu.ft_subsistema_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.fvalidar_usuario
 DESCRIPCIÓN: 	verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion
 AUTOR: 		KPLIAN (rac)
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
v_resp 				varchar;


/*
PARAMETROS PREDEFINIDOS RECIBIDO PARA LA FUNCIONES TIPO SEL
'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN
     -- recupera datos pasados como parametros en el  servidor web
     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_subsistema_sel';

/*******************************    
 #TRANSACCION:  SEG_FUNCIO_SEL
 #DESCRIPCION:	Listado de los subsistemas registradas del sistema
 #AUTOR:		KPLIAN (rac)	
 #FECHA:		
***********************************/
     if(par_transaccion='SEG_SUBSIS_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                              subsis.id_subsistema,
                              subsis.codigo,
                              subsis.prefijo,
                              subsis.nombre,
                              subsis.fecha_reg,
                              subsis.estado_reg,
                              subsis.nombre_carpeta
                        FROM segu.tsubsistema subsis
                        WHERE subsis.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               --raise exception '%',v_consulta;

               return v_consulta;
              

         END;                          

/*******************************    
 #TRANSACCION:  SEG_SUBSIS_CONT
 #DESCRIPCION:	Contar  los subsistemas registrados del sistema
 #AUTOR:		KPLIAN (rac)	
 #FECHA:		
***********************************/
     elsif(par_transaccion='SEG_SUBSIS_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT
                                  count(subsis.id_subsistema)
                            FROM  segu.tsubsistema subsis
                            WHERE subsis.estado_reg=''activo'' and  ';
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
-- Definition for function ft_tipo_documento_sel (OID = 305097) : 
--

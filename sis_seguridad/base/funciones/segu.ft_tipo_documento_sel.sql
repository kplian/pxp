CREATE OR REPLACE FUNCTION segu.ft_tipo_documento_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.fprocedimiento_sel
 DESCRIPCIÓN: 	Realiza el listado de procedimientos (trasacciones)
 AUTOR: 		KPLIAN (rac)
 FECHA:			17/10/2010
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
     v_nombre_funcion:='segu.ft_tipo_documento_sel';

/*******************************    
 #TRANSACCION:  SEG_TIPDOC_SEL
 #DESCRIPCION:	Listado de los procedimientos de BD
 #AUTOR:		KPLIAN (rac)	
 #FECHA:		
***********************************/
     if(par_transaccion='SEG_TIPDOC_SEL')then
                        

          --consulta:=';
          BEGIN

               v_consulta:='select 
                            tipdoc.id_tipo_documento,
                            tipdoc.nombre,
                            tipdoc.fecha_reg,
                            tipdoc.estado_reg
                        from segu.ttipo_documento tipdoc
                        where tipdoc.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

/*******************************    
 #TRANSACCION:  SEG_FUNCIO_CONT
 #DESCRIPCION:	Contar  los procedimeintos de BD registradas del sistema
 #AUTOR:		KPLIAN (rac)
 #FECHA:		
***********************************/
     elsif(par_transaccion='SEG_TIPDOC_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select count(tipdoc.id_tipo_documento)
                            from segu.ttipo_documento tipdoc
                            where tipdoc.estado_reg=''activo'' and ';
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
-- Definition for function ft_usuario_actividad_ime (OID = 305098) : 
--

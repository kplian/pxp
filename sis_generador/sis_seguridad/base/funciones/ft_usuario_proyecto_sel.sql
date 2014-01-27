CREATE OR REPLACE FUNCTION segu.ft_usuario_proyecto_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_proyecto_sel
 DESCRIPCIÓN: 	manejo de proyectos por usuario
 AUTOR: 		KPLIAN(jrr)	
 FECHA:		    28/02/2008
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			16/11/2010			
***************************************************************************/

DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp varchar;


/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.ft_usuario_proyecto_sel';
 /*******************************    
 #TRANSACCION:  SEG_USUREG_SEL
 #DESCRIPCION:	lista las proyectos por usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/

     if(par_transaccion='SEG_USUPRO_SEL')then

       
          BEGIN

               v_consulta:='select 
                            usupro.id_usuario_proyecto,
                            usupro.id_usuario,
                            usupro.id_proyecto,
                            usupro.fecha_reg,
                            usupro.estado_reg,
                            proyec.nombre as desc_proyecto,
                            person.nombre_completo2 as desc_person
                        from segu.tusuario_proyecto usupro
                        inner join segu.tusuario usuari
                        on usuari.id_usuario=usupro.id_usuario
                        inner join segu.tproyecto proyec
                        on proyec.id_proyecto=usupro.id_proyecto
                        inner join segu.vpersona person
                        on person.id_persona=usuari.id_persona
                        where usupro.estado_reg=''activo'' and ';
               v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;
         
 /*******************************    
 #TRANSACCION:  SEG_USUREG_SEL
 #DESCRIPCION:	contar proyectos por usuario
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2010	
***********************************/

     elsif(par_transaccion='SEG_USUPRO_CONT')then

          --consulta:=';
          BEGIN

                 v_consulta:='SELECT 
                               count(usupro.id_usuario_proyecto)
                              FROM segu.tusuario_proyecto usupro
                              INNER JOIN segu.tusuario usuari
                                on usuari.id_usuario=usupro.id_usuario
                              INNER JOIN segu.tproyecto proyec
                                on proyec.id_proyecto=usupro.id_proyecto
                              WHERE usupro.estado_reg=''activo'' and ';
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
-- Definition for function ft_usuario_regional_ime (OID = 305104) : 
--

CREATE OR REPLACE FUNCTION segu.ft_usuario_rol_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_usuario_rol_sel
 DESCRIPCIÓN: 	listado de roles por usuario
 AUTOR: 		KPLIAN(rac)
 FECHA:			
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR: 		KPLIAN(rac)
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
     v_nombre_funcion:='segu.ft_usuario_rol_sel';

 /*******************************    
 #TRANSACCION:  SEG_USUROL_SEL
 #DESCRIPCION:	Lista los roles activos que corresponden al usuario
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		16-11-2010	
***********************************/


     if(par_transaccion='SEG_USUROL_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT 
                                usurol.id_usuario_rol,
                                usurol.id_rol,
                                usurol.id_usuario,
                                usurol.fecha_reg,
                                usurol.estado_reg,
                                rol.rol,
                                person.nombre_completo2,
                                sub.nombre
                             FROM segu.tusuario_rol usurol
                             INNER JOIN segu.tusuario usuari
                                on usuari.id_usuario=usurol.id_usuario
                             INNER JOIN  segu.trol rol
                               on rol.id_rol=usurol.id_rol
                             LEFT JOIN  segu.tsubsistema sub
                               on sub.id_subsistema=rol.id_subsistema
                             INNER JOIN  segu.vpersona person
                               on person.id_persona=usuari.id_persona
                             WHERE usurol.estado_reg=''activo'' and 
                               usurol.id_usuario = '|| v_parametros.id_usuario || '  and ';
              v_consulta:=v_consulta||v_parametros.filtro;
               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

               return v_consulta;


         END;

 /*******************************    
 #TRANSACCION:  SEG_USUROL_SEL
 #DESCRIPCION:	cuenta los roles activos que corresponden al usuario
 #AUTOR:		KPLIAN(rac)
 #FECHA:		16-11-2010	
***********************************/
     elsif(par_transaccion='SEG_USUROL_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='select 
                				count(usurol.id_usuario_rol)
                            from segu.tusuario_rol usurol
                            inner join segu.tusuario usuari
                            	on usuari.id_usuario=usurol.id_usuario
                            inner join segu.trol rol
                            	on rol.id_rol=usurol.id_rol
                            left join segu.tsubsistema sub
                            	on sub.id_subsistema=rol.id_subsistema
                            inner join segu.vpersona person
                            	on person.id_persona=usuari.id_persona
                            where usurol.estado_reg=''activo'' and  
                          usurol.id_usuario ='|| v_parametros.id_usuario || '  and ';
              
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
-- Definition for function ft_usuario_sel (OID = 305108) : 
--

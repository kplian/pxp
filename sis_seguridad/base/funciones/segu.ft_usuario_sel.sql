CREATE OR REPLACE FUNCTION segu.ft_usuario_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.fvalidar_usuario
 DESCRIPCIÓN: 	verifica si el login y contgrasena proporcionados son correctos
                esta funcion es especial porque corre con el usario generico de conexion
                que solo tiene el privilegio de correr esta funcion
 AUTOR: 		KPLIAN(rac)
 FECHA:			26/07/2010
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

v_consulta              varchar;
v_parametros            record;
v_mensaje_error         text;
v_nombre_funcion        text;
v_resp varchar;

/*

'login'
'password'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN
     v_nombre_funcion:='segu.ft_usuario_sel';
     v_parametros:=pxp.f_get_record(par_tabla);

/*******************************
 #TRANSACCION:  SEG_VALUSU_SEL
 #DESCRIPCION:	consulta los datos del usario segun contrasena y login
 #AUTOR:		KPLIAN(rac)
 #FECHA:		26/07/2010
***********************************/

     if(par_transaccion='SEG_VALUSU_SEL')then
          --consulta:=';
          BEGIN

               v_consulta:='SELECT u.id_usuario,
                                   u.cuenta,
                                   u.contrasena
                            FROM segu.tusuario u
                            WHERE u.cuenta='''||v_parametros.login || '''
                            and u.contrasena=''' || v_parametros.password || '''
                            and u.fecha_caducidad>=now()::date
                            and u.estado_reg=''activo''';

               return v_consulta;

          END;
/*******************************
 #TRANSACCION:  SEG_USUARI_SEL
 #DESCRIPCION:	Listar usuarios activos de sistema
 #AUTOR:		KPLIAN(rac)
 #FECHA:		26/07/2010
***********************************/

     elsif(par_transaccion='SEG_USUARI_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT USUARI.id_usuario,
                                   USUARI.id_clasificador,
                                   USUARI.cuenta,
                                   USUARI.contrasena,
                                   USUARI.fecha_caducidad,
                                   USUARI.fecha_reg,
                                   USUARI.estado_reg,
                                   USUARI.estilo,
                                   USUARI.contrasena_anterior,
                                   USUARI.id_persona,
                                   PERSON.nombre_completo2 as desc_person,
                                   CLASIF.descripcion,
                                   pxp.text_concat(UR.id_rol::text) as id_roles,
                                   USUARI.autentificacion

                            FROM segu.tusuario USUARI
                                 INNER JOIN segu.vpersona PERSON on PERSON.id_persona = USUARI.id_persona
                                 LEFT JOIN segu.tclasificador CLASIF on CLASIF.id_clasificador = USUARI.id_clasificador
                                 LEFT JOIN segu.tusuario_rol UR on ur.estado_reg= ''activo'' and ur.id_usuario = usuari.id_usuario

                            WHERE USUARI.estado_reg = ''activo'' and ';

               v_consulta:=v_consulta||v_parametros.filtro;

                   v_consulta:=v_consulta||'      GROUP BY USUARI.id_usuario,
                                               USUARI.id_clasificador,
                                               USUARI.cuenta,
                                               USUARI.contrasena,
                                               USUARI.fecha_caducidad,
                                               USUARI.fecha_reg,
                                               USUARI.estado_reg,
                                               USUARI.estilo,
                                               USUARI.contrasena_anterior,
                                               USUARI.id_persona,
                                               PERSON.nombre_completo2,
                                               PERSON.nombre,
                                               CLASIF.descripcion,
                                               USUARI.autentificacion';

               v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

				raise notice 'que esta pasando: %',v_consulta;
               return v_consulta;


         END;

/*******************************
 #TRANSACCION:  SEG_USUARI_CONT
 #DESCRIPCION:	Contar usuarios activos de sistema
 #AUTOR:		KPLIAN(rac)
 #FECHA:		26/07/2010
***********************************/
     elsif(par_transaccion='SEG_USUARI_CONT')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT count(USUARI.id_usuario)
                            FROM segu.tusuario USUARI
                            INNER JOIN segu.vpersona PERSON  ON PERSON.id_persona=USUARI.id_persona
                            LEFT JOIN segu.tclasificador CLASIF ON CLASIF.id_clasificador=USUARI.id_clasificador
                            WHERE USUARI.estado_reg=''activo'' AND ';
               v_consulta:=v_consulta||v_parametros.filtro;
               return v_consulta;
         END;

   /*******************************
   #TRANSACCION:  SEG_USGRU_SEL
   #DESCRIPCION:  Grupo de EPs ususarios
   #AUTOR:		Miguel Alejandro Mamani Villegas
   #FECHA:		30/05/2017
  ***********************************/

     elsif(par_transaccion='SEG_USGRU_SEL')then

          --consulta:=';
          BEGIN

               v_consulta:='SELECT DISTINCT  USUARI.id_usuario,
                                   USUARI.id_clasificador,
                                   USUARI.cuenta,
                                   USUARI.contrasena,
                                   USUARI.fecha_caducidad,
                                   USUARI.fecha_reg,
                                   USUARI.estado_reg,
                                   USUARI.estilo,
                                   USUARI.contrasena_anterior,
                                   USUARI.id_persona,
                                   PERSON.nombre_completo2 as desc_person,
                                   CLASIF.descripcion,
                                   USUARI.autentificacion,
                                   ug.id_grupo
                            	 FROM segu.tusuario USUARI
                                 INNER JOIN segu.vpersona PERSON on PERSON.id_persona = USUARI.id_persona
                                 INNER join segu.tusuario_grupo_ep ug on ug.id_usuario = USUARI.id_usuario
                                 LEFT JOIN segu.tclasificador CLASIF on CLASIF.id_clasificador =
                                 USUARI.id_clasificador
                                 WHERE USUARI.estado_reg = ''activo'' and ';

               v_consulta:=v_consulta||v_parametros.filtro;


             v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;

				raise notice 'que esta pasando: %',v_consulta;
               return v_consulta;
               end;


 /*******************************
 #TRANSACCION:  SEG_USGRU_CONT
 #DESCRIPCION:	Contar usuarios activos de sistema
 #AUTOR:		Miguel Alejandro Mamani Villegas
 #FECHA:		30/05/2017
***********************************/
     elsif(par_transaccion='SEG_USGRU_CONT')then


          BEGIN

               v_consulta:='SELECT count(DISTINCT  USUARI.id_usuario)
                             FROM segu.tusuario USUARI
                                 INNER JOIN segu.vpersona PERSON on PERSON.id_persona = USUARI.id_persona
                                 INNER join segu.tusuario_grupo_ep ug on ug.id_usuario = USUARI.id_usuario
                                 LEFT JOIN segu.tclasificador CLASIF on CLASIF.id_clasificador =
                                 USUARI.id_clasificador
                                 WHERE USUARI.estado_reg = ''activo'' and ';



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
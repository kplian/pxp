CREATE OR REPLACE FUNCTION segu.f_agregar_ep (
  par_url_log varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.f_agregar_ep
 DESCRIPCION: 	Actualiza la tabla log a partir de los logs del
                motor de bd
 AUTOR: 		KPLIAN(jrr)
 FECHA:			08/03/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/
DECLARE
    v_registros       record;
    v_nombre_funcion  varchar;
    v_resp            varchar;
    v_fecha_actual    date;
    v_fecha_max_log   timestamp;
    v_fecha_tope	  date;
    v_fecha_archivo	  date;
    v_fecha_min_tt    timestamp;
    v_tipo_log        varchar;
    v_consulta        varchar;
BEGIN
    v_nombre_funcion:='segu.f_agregar_ep';

    for v_registros in (SELECT USUARI.id_usuario,
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
                      LEFT JOIN segu.tusuario_rol UR on ur.estado_reg= 'activo' and ur.id_usuario = usuari.id_usuario
                      WHERE USUARI.estado_reg = 'activo'
                      GROUP BY USUARI.id_usuario,
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
                      USUARI.autentificacion)loop
    
          IF NOT EXISTS(SELECT estado_reg,
                    id_usuario,
                    id_grupo,
                    fecha_reg,
                    id_usuario_reg,
                    fecha_mod,
                    id_usuario_mod FROM segu.tusuario_grupo_ep WHERE id_usuario=v_registros.id_usuario AND id_grupo=2)then
          
              insert into segu.tusuario_grupo_ep(
              estado_reg,
              id_usuario,
              id_grupo,
              fecha_reg,
              id_usuario_reg,
              fecha_mod,
              id_usuario_mod
              ) values(
              'activo',
              v_registros.id_usuario,
              2,--GRUPO
              now(),
              1,--USUARIO REG
              null,
              null);
          end if;
    
          IF NOT EXISTS(SELECT estado_reg,
                    id_usuario,
                    id_grupo,
                    fecha_reg,
                    id_usuario_reg,
                    fecha_mod,
                    id_usuario_mod FROM segu.tusuario_grupo_ep WHERE id_usuario=v_registros.id_usuario AND id_grupo=3)then
          
              insert into segu.tusuario_grupo_ep(
              estado_reg,
              id_usuario,
              id_grupo,
              fecha_reg,
              id_usuario_reg,
              fecha_mod,
              id_usuario_mod
              ) values(
              'activo',
              v_registros.id_usuario,
              3,--GRUPO
              now(),
              1,--USUARIO REG
              null,
              null);
          end if;
     
    end loop;

    return 'exito';

EXCEPTION

       WHEN OTHERS THEN

       	v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
    	v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
  		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%,%',v_resp,v_consulta;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
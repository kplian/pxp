CREATE OR REPLACE FUNCTION segu.ft_subsistema_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_subsistema
 DESCRIPCIÓN: 	gestion de subsistemas
 AUTOR: 		KPLIAN(rac)
 FECHA:			16/9/2010
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:


 #ISSUE		FECHA				AUTOR				DESCRIPCION
 #0         26-07-2010      RAC             Creación
 #103		09-01-2020	  	RAC				adiciona columnas para manejo de importacion de git y reportes
 #104			27-02-2020 				MMV ETR     			Import github commit data, problems, branch and repository

***************************************************************************/


DECLARE

v_consulta  				varchar;
v_parametros                record;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id                        integer;
v_esquema                   varchar;
v_resp 						varchar;
v_id_gui  					varchar;
v_valor						varchar;
v_branch_json				json;
v_issues_json				json;
v_json_branch				record;
v_json_issues				record;
v_branch					varchar; -- #104
v_issues 					varchar;

v_issues_aux				integer;
v_created_at				timestamp;
v_updated_at				timestamp;
v_closed_at					timestamp;
v_fecha_commit				date;
v_fecha_issues				date;
v_fecha_actual				date;  -- #104

BEGIN

     v_nombre_funcion:='segu.ft_subsistema_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************
 #TRANSACCION:  SEG_SUBSIS_INS
 #DESCRIPCION:	Inserta Subsistemas
 #AUTOR:		KPLIAN(rac)
 #FECHA:		16/9/2010
***********************************/
     if(par_transaccion='SEG_SUBSIS_INS')then


          BEGIN
            INSERT INTO segu.tsubsistema(
                      codigo,
                      nombre,
                      prefijo,
                      nombre_carpeta,
                      organizacion_git,  --#103
                      codigo_git,
                      sw_importacion
                   )
             values(
                      v_parametros.codigo,
                      v_parametros.nombre,
                      v_parametros.prefijo,
                      v_parametros.nombre_carpeta,
                      v_parametros.organizacion_git,  --#103
                      v_parametros.codigo_git,
                      v_parametros.sw_importacion
                   )
             RETURNING id_subsistema into v_id;

               -- crear el esquema para el subsistema creado
               v_esquema:=v_parametros.codigo;
               if not exists(SELECT 1 from pg_namespace
                             WHERE lower(nspname)=lower(v_parametros.codigo)) THEN

                  v_consulta:='CREATE SCHEMA '||v_esquema||' ';--AUTHORIZATION postgres;

                  execute(v_consulta);
               end if;

               --crear el metaproceso para el subsistema
               if not exists(SELECT 1 from segu.tgui
                             WHERE lower(codigo_gui)=v_parametros.codigo
                             AND id_subsistema=v_id) THEN

                  INSERT INTO segu.tgui(
                            codigo_gui,
                            descripcion,
                            id_subsistema,
                            nombre,
                            nivel,
                            orden_logico
                            )
                  VALUES(
                           v_parametros.codigo,
                            '',
                           v_id,
                           upper(v_parametros.nombre),
                           1,
                           1) returning  id_gui into v_id_gui;

                  v_resp = (select pxp.f_insert_testructura_gui(v_parametros.codigo,'SISTEMA', NULL));
               end if;

               --return 'Subsistema insertado con exito';


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema insertado con exito '||v_id_gui);
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_id_gui::varchar);


         END;

 /*******************************
 #TRANSACCION:  SEG_SUBSIS_MOD
 #DESCRIPCION:	Modifica el subsistema seleccionada
 #AUTOR:		KPLIAN(rac)
 #FECHA:
***********************************/
     elsif(par_transaccion='SEG_SUBSIS_MOD')then

          BEGIN

               UPDATE segu.tsubsistema SET

                      codigo = v_parametros.codigo,
                      prefijo = v_parametros.prefijo,
                      nombre = v_parametros.nombre,
                      nombre_carpeta = v_parametros.nombre_carpeta,
                      organizacion_git =v_parametros.organizacion_git,  --#103
                      codigo_git = v_parametros.codigo_git,
                      sw_importacion = v_parametros.sw_importacion
               WHERE id_subsistema=v_parametros.id_subsistema;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);


          END;

/*******************************
 #TRANSACCION:   SEG_SUBSIS_ELI
 #DESCRIPCION:	Inactiva el subsistema selecionado
 #AUTOR:		KPLIAN(rac)
 #FECHA:
***********************************/
    elsif(par_transaccion='SEG_SUBSIS_ELI')then


          BEGIN
               UPDATE segu.tsubsistema
               SET estado_reg='inactivo'
               WHERE id_subsistema=v_parametros.id_subsistema;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema eliminado con exito '||v_parametros.id_subsistema);
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);

         END;

    /*******************************
     #TRANSACCION:   SEG_OBTVARGLO_MOD
     #DESCRIPCION:	obtiene variables globales
     #AUTOR:		KPLIAN(rac)
     #FECHA:
    ***********************************/

    elsif(par_transaccion = 'SEG_OBTVARGLO_MOD')then


          BEGIN

               v_valor = pxp.f_get_variable_global(v_parametros.codigo);
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','variable global');
               v_resp = pxp.f_agrega_clave(v_resp,'codigo',v_parametros.codigo::varchar);
               v_resp = pxp.f_agrega_clave(v_resp,'valor',v_valor::varchar);

         END;

     /*******************************
     #TRANSACCION:  SEG_GIT_INS  #104
     #DESCRIPCION:	Importar api rest git hub
     #AUTOR:		MMV
     #FECHA:		10-01-2020
	***********************************/
     elsif(par_transaccion='SEG_GIT_INS')then

          BEGIN
         -- raise exception '--->%<---',v_parametros.commit_data;

               v_branch_json = v_parametros.branch_json::json;
               v_issues_json = v_parametros.issues_json::json;
              -- v_commit_json = v_parametros.commit_data::json;


                 for v_json_branch in (select json_array_elements(v_branch_json))loop
                 		v_branch = v_json_branch.json_array_elements::json;

                        if not exists  (select 1
                                     from segu.tbranches br
                                     where br.id_subsistema = v_parametros.id_subsistema
                                     and br.name = v_branch::json->>'name'::varchar) then

                                      INSERT INTO segu.tbranches( name,
                                                    sha,
                                                    url,
                                                    protected,
                                                    id_subsistema
                                                  )
                                                  VALUES (
                                                    v_branch::json->>'name'::varchar,
                                                    v_branch::json->>'sha'::text,
                                                    v_branch::json->>'url'::text,
                                                    true,
                                                   v_parametros.id_subsistema
                                                  );
                        end if;

                 end loop;



                 for v_json_issues in (select json_array_elements(v_issues_json))loop
                 	v_issues = v_json_issues.json_array_elements::json;
                    ---
                    v_issues_aux = v_issues::json->>'number_issues';
                    ---
                    v_created_at = v_issues::json->>'created_at';
                    v_updated_at = v_issues::json->>'updated_at';
                    v_closed_at = v_issues::json->>'closed_at';
                    ---


                  if not exists  (select 1
                                   from segu.tissues us
                                   where us.id_subsistema = v_parametros.id_subsistema
                                   and us.number_issues = v_issues_aux) then

                    INSERT INTO segu.tissues( id_programador,
                                              html_url,
                                              number_issues,
                                              title,
                                              author,
                                              state,
                                              created_at,
                                              updated_at,
                                              closed_at,
                                              id_subsistema
                                            )
                                            VALUES (
                                               null,
                                               v_issues::json->>'html_url'::text,
                                               v_issues_aux,
                 							   v_issues::json->>'title'::text,
                                               v_issues::json->>'author'::varchar,
                                               v_issues::json->>'state'::varchar,
                                               v_created_at,
                                               v_updated_at,
                                               v_closed_at,
                                               v_parametros.id_subsistema
                                            );
                    end if;
                 end loop;

                 PERFORM segu.f_obtener_programador(v_parametros.id_subsistema);

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);

          END;

	 /*******************************
     #TRANSACCION:  SEG_DATE_INS  #104
     #DESCRIPCION:	Obtener la ultima registro fecha
     #AUTOR:		MMV
     #FECHA:		21/01/2020
    ***********************************/
     elsif(par_transaccion='SEG_DATE_INS')then

          BEGIN

          		v_fecha_issues = null;
               	v_fecha_commit = null;

               select max(iss.created_at::date) into v_fecha_issues
               from segu.tissues iss
               where iss.id_subsistema = v_parametros.id_subsistema;


               select max(com.fecha::date) into v_fecha_commit
               from segu.tcommit com
               where com.id_subsistema = v_parametros.id_subsistema;

               if v_fecha_issues is null and v_fecha_commit is null  then
               		v_fecha_actual = now()::date;
               		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
               end if;

               if v_fecha_issues is null then
               		v_fecha_actual = v_fecha_commit;
               		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
               end if;

			  if v_fecha_commit is null then
              		v_fecha_actual = v_fecha_issues;
                    v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
              end if;

              if v_fecha_commit > v_fecha_issues then
               		v_fecha_actual = v_fecha_commit;
               		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
              end if;

              if v_fecha_issues > v_fecha_commit then
               		v_fecha_actual = v_fecha_issues;
               		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
              end if;



              if v_fecha_issues = v_fecha_commit or v_fecha_commit = v_fecha_issues then
               		v_fecha_actual = v_fecha_issues;
               		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema);
                    v_resp = pxp.f_agrega_clave(v_resp,'fecha_actual','%'||v_fecha_actual||'%'::varchar);
              end if;
          END;

     else

         raise exception 'No existe la transaccion: %',par_transaccion;
     end if;



--retorna respuesta en formato JSON
 return v_resp;

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

ALTER FUNCTION segu.ft_subsistema_ime (par_administrador integer, par_id_usuario integer, par_tabla varchar, par_transaccion varchar)
  OWNER TO postgres;
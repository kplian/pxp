CREATE OR REPLACE FUNCTION orga.ft_funcionario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		orga.ft_funcionario_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 	    KPLIAN (mzm)
 FECHA:
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:		KPLIAN (rac)
 FECHA:		21-01-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_funcion  				integer;
v_ids						varchar[];
v_tamano					integer;
v_i 						integer;
v_id_funcionario			integer;
v_email_empresa             varchar;
v_registros					record;
v_asunto					varchar;
v_destinatorio				varchar;
v_template					varchar;
v_id_alarma					integer[];
v_titulo					varchar;
v_clase						varchar;
v_parametros_ad				varchar;
v_acceso_directo			varchar;
v_id_biometrico       integer;

BEGIN

     v_nombre_funcion:='orga.ft_funcionario_ime';
     v_parametros:=pxp.f_get_record(par_tabla);


 /*******************************
 #TRANSACCION:   RH_FUNCIO_INS
 #DESCRIPCION:	Inserta Funcionarios
 #AUTOR:
 #FECHA:		25-01-2011
***********************************/
     if(par_transaccion='RH_FUNCIO_INS')then


          BEGIN


               --insercion de nuevo FUNCIONARIO
               if exists (select 1 from orga.tfuncionario where codigo=v_parametros.codigo and estado_reg='activo') then
                  raise exception 'Insercion no realizada. CODIGO EN USO';
               end if;

               if exists(select 1 from orga.tfuncionario where id_persona=v_parametros.id_persona and estado_reg='activo') then
                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
               end if;

               SELECT nextval('orga.tfuncionario_id_biometrico_seq') INTO v_id_biometrico;
               INSERT INTO orga.tfuncionario(
		               codigo, id_persona,
		               estado_reg,
		               fecha_reg,
		               id_usuario_reg,
		               email_empresa,
		               interno,		              
		               telefono_ofi,
		               antiguedad_anterior,
		               id_oficina,
                   id_biometrico)
               values(
                      v_parametros.codigo,
                      v_parametros.id_persona,
                      'activo',now()::date,
                      par_id_usuario,
                      v_parametros.id_persona,
                      v_parametros.interno,                      
                      v_parametros.telefono_ofi,
                      v_parametros.antiguedad_anterior,
                      v_parametros.id_oficina,
                      v_id_biometrico)
               RETURNING id_funcionario into v_id_funcionario;

               update segu.tpersona
               	set estado_civil = v_parametros.estado_civil,
               	genero = v_parametros.genero,
               	fecha_nacimiento = v_parametros.fecha_nacimiento,
               	id_lugar = v_parametros.id_lugar,
               	nacionalidad = v_parametros.nacionalidad,
               	discapacitado = v_parametros.discapacitado,
               	carnet_discapacitado = v_parametros.carnet_discapacitado
               where id_persona = v_parametros.id_persona;


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','funcionario '||v_parametros.codigo ||' insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_id_funcion::varchar);
         END;
 /*******************************
 #TRANSACCION:      RH_FUNCIO_MOD
 #DESCRIPCION:	Modifica la parametrizacion seleccionada
 #AUTOR:
 #FECHA:		25-01-2011
***********************************/
     elsif(par_transaccion='RH_FUNCIO_MOD')then


          BEGIN


                if exists (select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and codigo=v_parametros.codigo
                			and estado_reg='activo') then
                  raise exception 'Modificacion no realizada. CODIGO EN USO';
                end if;

                if exists(select 1 from orga.tfuncionario
                			where id_funcionario!=v_parametros.id_funcionario
                			and id_persona=v_parametros.id_persona and estado_reg='activo') then
                  raise exception 'Insercion no realizada. Esta persona ya está registrada como funcionario';
               end if;

                update orga.tfuncionario set
                	codigo=v_parametros.codigo,
                    id_usuario_mod=par_id_usuario,
                    id_persona=v_parametros.id_persona,
                    estado_reg=v_parametros.estado_reg,
                    email_empresa=v_parametros.email_empresa,
                    interno=v_parametros.interno,                    
                    fecha_mod=now()::date,
                    telefono_ofi= v_parametros.telefono_ofi,
                    antiguedad_anterior =  v_parametros.antiguedad_anterior,
                    id_oficina = v_parametros.id_oficina
                where id_funcionario=v_parametros.id_funcionario;

                update segu.tpersona
               	set estado_civil = v_parametros.estado_civil,
               	genero = v_parametros.genero,
               	fecha_nacimiento = v_parametros.fecha_nacimiento,
               	id_lugar = v_parametros.id_lugar,
               	nacionalidad = v_parametros.nacionalidad,
               	discapacitado = v_parametros.discapacitado,
               	carnet_discapacitado = v_parametros.carnet_discapacitado
               where id_persona = v_parametros.id_persona;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario modificado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);


          END;

/*******************************
 #TRANSACCION:  RH_FUNCIO_ELI
 #DESCRIPCION:	Inactiva la parametrizacion selecionada
 #AUTOR:
 #FECHA:		25-01-2011
***********************************/

    elsif(par_transaccion='RH_FUNCIO_ELI')then
        BEGIN

         --inactivacion de la periodo
               update orga.tfuncionario
               set estado_reg='inactivo'
               where id_funcionario=v_parametros.id_funcionario;
               return 'Funcionario eliminado con exito';

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcionario eliminado con exito '||v_parametros.id_funcionario);
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario',v_parametros.id_funcionario::varchar);

        END;

/*******************************
 #TRANSACCION:  RH_MAILFUN_GET
 #DESCRIPCION:	Recuepra el email del funcionario
 #AUTOR:	    RAC
 #FECHA:		04-02-2014
***********************************/

    elsif(par_transaccion='RH_MAILFUN_GET')then
        BEGIN

         --inactivacion de la periodo
              select
              fun.email_empresa
              into
              v_email_empresa
              from orga.tfuncionario fun
              where fun.id_funcionario = v_parametros.id_funcionario;

              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Recupera el correo del funcionario');
              v_resp = pxp.f_agrega_clave(v_resp,'email_empresa',v_email_empresa::varchar);

        END;

    /*********************************
 	#TRANSACCION:  'RH_CUMPLECORR_INS'
 	#DESCRIPCION:	  Registra alertas para felicitar cumpleanero del dia
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		11-08-2016
	***********************************/

	ELSEIF (par_transaccion='RH_CUMPLECORR_INS')then

       begin

        -- seleccionar los cumpleaneros del dia
         FOR v_registros in (SELECT FUNCIO.id_funcionario,
                                     FUNCIO.nombre::varchar,
                                     FUNCIO.ap_paterno,
                                     FUNCIO.ap_materno,
                                     CAR.nombre,
                                     F.email_empresa,
                                     usu.id_usuario
                              FROM orga.vfuncionario_personareporte FUNCIO
                                   INNER JOIN orga.tfuncionario F ON F.id_funcionario = FUNCIO.id_funcionario
                                   INNER JOIN SEGU.tpersona PERSON ON PERSON.id_persona = F.id_persona
                                   INNER JOIN orga.tuo_funcionario uofun on uofun.id_funcionario =
                                     FUNCIO.id_funcionario and uofun.estado_reg = 'activo' and
                                     uofun.fecha_asignacion <= now() ::date
                                     and (uofun.fecha_finalizacion >= now() ::date or uofun.fecha_finalizacion is null)
                                   INNER JOIN orga.tcargo car on car.id_cargo = uofun.id_cargo
                                   LEFT JOIN segu.tusuario usu on usu.id_persona=PERSON.id_persona
                              WHERE extract(day from PERSON.fecha_nacimiento) = extract(day from current_date)
                               AND extract(month from PERSON.fecha_nacimiento) = extract(month from current_date))  LOOP


                ----------------------------
                -- arma template de correo
                -----------------------------

                v_asunto = 'Hoy es tu cumpleaños y BoA quiere festejar contigo!!!';

                v_template = '<div style="width:400px; background-color: #019ADB; margin-right: auto; margin-left: auto;">
 							  <table width="400" style="background-color: #019ADB; font-family:''Helvetica Neue'',Helvetica,Arial,sans-serif; color: #ffffff; width: 400px;">
        					  <tr bgcolor="#019ADB">
				              <td>
                				<img src="http://www.boa.bo/Content/Aniversarios/fondo_cumple.jpg" alt="400">
            				  </td>
        					  </tr>
        					  <tr bgcolor="#019ADB" style="background-color: #019ADB;">
            				  <td style="background-color: #019ADB; font-size: 20px;" align="center">'||
                			  v_registros.nombre::varchar ||
            				  '</td>
        					  </tr>
                              <tr bgcolor="#019ADB" style="background-color: #019ADB;">
            				  <td style="background-color: #019ADB; font-size: 20px;" align="center">'||
                			  COALESCE(v_registros.ap_paterno,'')::varchar || '  ' || COALESCE(v_registros.ap_materno,'')::varchar ||
            				  '</td>
        					  </tr>
        					  <tr>
            				  <td style="background-color: #019ADB; font-size: 12px; padding-left: 20px; padding-right: 20px;" align="center">
                			  <br />
                			  Todos los que integramos la familia Boliviana de Aviaci&oacute;n nos sentimos agradecidos de poder ser
                			  parte de la celebraci&oacute;n de tu cumpleaños; fluyen palabras de buenos deseos, esperando que este d&iacute;a
                			  recibas grandes bendiciones.
                			  Que la salud nunca falte y que el &eacute;xito y la prosperidad sean constantes todos los d&iacute;as de
                			  tu vida a nivel personal, familiar y profesional.
                			  Recibe nuestro reconocimiento y sincero cariño
            				  </td>
        					  </tr>
        					  <tr>
            				  <td>
                				<table width="400" style="color: #ffffff; font-family:''Helvetica Neue'',Helvetica,Arial,sans-serif; font-size: 12px; width: 400px;">
                    		  <tr>
                        	  <td style="width: 100%; color: #ffffff;" align="center">
                              <br/>
                              <img src="http://www.boa.bo/Content/Aniversarios/fi.png" width="200" ><br />
                              <span >Ing. Ronald S. Casso Casso</span><br />
                              <span >GERENTE GENERAL</span><br />
                              <span >Empresa Pública Nacional Estratégica</span><br />
                              <span >Boliviana de Aviaci&oacute;n - BoA</span>
                        	  </td>
                    		  </tr>
                    		  <tr>
                        	  <td colspan="2">
                              <hr/>
                        	  </td>
                    		  </tr>
                			  </table>
            				  </td>
        					  </tr>
    						  </table>
							  </div>';

                v_titulo = ''|| v_registros.nombre || ' ' || COALESCE(v_registros.ap_paterno,'')::varchar || ' ' || COALESCE(v_registros.ap_materno,'')::varchar || '';
                v_acceso_directo = '';
                v_clase = '';
                v_parametros_ad = '{}';

                -- inserta registros de alarmas par ael usario que creo la obligacion
                v_id_alarma[1]:=param.f_inserta_alarma(v_registros.id_funcionario,
                                                    v_template ,    --descripcion alarmce
                                                    COALESCE(v_acceso_directo,''),--acceso directo
                                                    now()::date,
                                                    'felicitacion',
                                                    '',   -->
                                                    par_id_usuario,
                                                    v_clase,
                                                    v_titulo,--titulo
                                                    COALESCE(v_parametros_ad,''),
                                                    v_registros.id_usuario::integer,  --destino de la alarma
                                                    v_asunto);

       END LOOP;
       end;


    else

         raise exception 'No existe la transaccion: %',par_transaccion;
    end if;

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
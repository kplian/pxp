CREATE OR REPLACE FUNCTION orga.ft_uo_funcionario_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)

  RETURNS varchar AS
  $body$
  /**************************************************************************
   FUNCION: 		orga.ft_uofunc_ime
   DESCRIPCIÓN:   modificaciones de funciones
   AUTOR: 	    KPLIAN (mzm)
   FECHA:
   COMENTARIOS:
  ***************************************************************************
   HISTORIA DE MODIFICACIONES:

   DESCRIPCION:
   AUTOR:
   FECHA:		03-06-2011
   ***************************************************************************/
  DECLARE


    v_parametros                record;
    v_resp                      varchar;
    v_nombre_funcion            text;
    v_mensaje_error             text;

    v_id_uo  				integer;
    v_id_funcionario integer;

    --10abr12
    v_respuesta_sinc       varchar;
    v_id_uo_funcionario     integer;


  BEGIN

    v_nombre_funcion:='orga.ft_uo_funcionario_ime';
    v_parametros:=pxp.f_get_record(par_tabla);


    /*******************************
    #TRANSACCION:  RH_UOFUNC_INS
    #DESCRIPCION:	Inserta uos funcionario
    #AUTOR:		KPLIAN (mzm)
    #FECHA:		25-06-2011
   ***********************************/
    if(par_transaccion='RH_UOFUNC_INS')then


      BEGIN

        -- verificar si la uo permite multiples asignaciones de funcionario
        --RAC NO ESTA FUNCIOANNDO ESTO DEL CARGO INDIVIDUAL
        /*if (select count(*)=1
           from orga.tuo_funcionario where id_uo=v_parametros.id_uo and estado_reg=v_parametros.estado_reg and
            id_uo=(select id_uo from orga.tuo where  id_uo=v_parametros.id_uo and estado_reg='activo' and cargo_individual='si')) then
                      raise exception 'El cargo es individual y ya existe otro funcionario asignado actualmente';
        end if;*/

        --verficar que el funcionario no este activo en dos unidades simultaneamente

        /* if ( ((select count(id_funcionario) from
                    orga.tuo_funcionario  UOF
                    where     id_funcionario=v_parametros.id_funcionario AND uof.estado_reg='activo' ))>0) then

                    raise exception 'El Funcionario se encuentra en otro cargo vigente primero inactive su asignacion actual';
         end if;

        --insercion de nuevo uo
        if exists (select 1 from orga.tuo_funcionario where id_funcionario=v_parametros.id_funcionario and
        id_uo=v_parametros.id_uo and estado_reg='activo') then
           raise exception 'Insercion no realizada. El funcionacio ya esta asignado a la unidad';
        end if;*/

        if (v_parametros.fecha_finalizacion is not null and v_parametros.fecha_finalizacion <= v_parametros.fecha_asignacion)then
          raise exception 'La fecha de finalización no puede ser menor o igual a la fecha de asignación';
        end if;

        INSERT INTO orga.tuo_funcionario
        (	id_uo, 						id_funcionario, 						fecha_asignacion,
           fecha_finalizacion,			id_cargo,								observaciones_finalizacion,
           nro_documento_asignacion,	fecha_documento_asignacion,				id_usuario_reg,
           tipo)
        values(		v_parametros.id_uo, 		v_parametros.id_funcionario,			v_parametros.fecha_asignacion,
                   v_parametros.fecha_finalizacion,v_parametros.id_cargo,				v_parametros.observaciones_finalizacion,
                   v_parametros.nro_documento_asignacion,v_parametros.fecha_documento_asignacion,par_id_usuario,
                   v_parametros.tipo)
        RETURNING id_uo_funcionario INTO v_id_uo_funcionario;


        --10-04-2012: sincronizacion de UO entre BD
        /* v_respuesta_sinc:=orga.f_sincroniza_uo_empleado_entre_bd(v_id_uo_funcionario,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'INSERT');

         if(v_respuesta_sinc!='si')  then
            raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
         end if;*/

        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Asignacion empleado-uo registrada con exito: Funcionario ('|| (select desc_funcionario1 from orga.vfuncionario where id_funcionario=v_parametros.id_funcionario) || ') - UO'|| (select nombre_unidad from orga.tuo where id_uo=v_parametros.id_uo));
        v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_id_uo::varchar);
      END;
    /*******************************
    #TRANSACCION:  RH_UOFUNC_MOD
    #DESCRIPCION:	Modifica la parametrizacion seleccionada
    #AUTOR:		KPLIAN (mzm)
    #FECHA:		03-06-2011
   ***********************************/
    elsif(par_transaccion='RH_UOFUNC_MOD')then


      BEGIN
        -- raise exception 'rererer: % % %',v_parametros.id_uo,v_parametros.estado_reg,v_parametros.id_funcionario;
        /*if ( select count(*)=1 from
                     orga.tuo_funcionario
                     where    id_uo=v_parametros.id_uo
                          and estado_reg=v_parametros.estado_reg and
                              id_funcionario!=v_parametros.id_funcionario and
                              id_uo=(select id_uo from orga.tuo where estado_reg='activo' and cargo_individual='si')
                              and id_uo=v_parametros.id_uo) then

                     raise exception 'El cargo es individual y ya existe otro funcionario asignado actualmente';
         end if;*/


        --verficar que el funcionario no este activo en dos unidades simultaneamente
        --raise exception '%    %',v_parametros.id_funcionario,v_parametros.id_uo;
        if ( ((select count(id_funcionario) from
          orga.tuo_funcionario  a
        where a.id_funcionario=v_parametros.id_funcionario
              and a.estado_reg = 'activo' and
              a.fecha_finalizacion > v_parametros.fecha_asignacion
              and a.id_uo != v_parametros.id_uo))>0) then

          raise exception 'El Funcionario se encuentra en otro cargo vigente primero inactive su asignacion actual';
        end if;



        --si el estado es inactivo == la fecha finalizacion debe ser llenada


        if (v_parametros.fecha_finalizacion is not null and v_parametros.fecha_finalizacion <= v_parametros.fecha_asignacion)then
          raise exception 'La fecha de finalización no puede ser menor o igual a la fecha de asignación';
        end if;

        update orga.tuo_funcionario
        set
          observaciones_finalizacion = v_parametros.observaciones_finalizacion,
          nro_documento_asignacion = v_parametros.nro_documento_asignacion,
          fecha_documento_asignacion = v_parametros.fecha_documento_asignacion,
          fecha_finalizacion = v_parametros.fecha_finalizacion
        where id_uo=v_parametros.id_uo
              and id_uo_funcionario=v_parametros.id_uo_funcionario;

        --10-04-2012: sincronizacion de UO entre BD
        /*                v_respuesta_sinc:=orga.f_sincroniza_uo_empleado_entre_bd(v_parametros.id_uo_funcionario,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'UPDATE');

                        if(v_respuesta_sinc!='si')  then
                          raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
                        end if;*/

        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Modificacion a asignacion empleado-uo modificada con exito '||v_parametros.id_uo_funcionario||': Funcionario ('|| (select desc_funcionario1 from orga.vfuncionario where id_funcionario=v_parametros.id_funcionario) || ') - UO'|| (select nombre_unidad from orga.tuo where id_uo=v_parametros.id_uo));
        v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_parametros.id_uo::varchar);
      END;

    /*******************************
     #TRANSACCION:  RH_UOFUNC_ELI
     #DESCRIPCION:	Inactiva la parametrizacion selecionada
     #AUTOR:	    KPLIAN (mzm)
     #FECHA:		03-06-2011
    ***********************************/
    elsif(par_transaccion='RH_UOFUNC_ELI')then
      BEGIN

        --inactivacion de la uo
        select id_funcionario,id_uo
        into v_id_funcionario, v_id_uo
        from orga.tuo_funcionario
        where  id_uo_funcionario=v_parametros.id_uo_funcionario;

        --elimina siempre que puede: como el registro de uo_fun es referncial en ORGA, se posible eliminarlo todo el tiempo
        -- se debe cuidar q en el diseno cuando se requiera obtener la dependencia de un funcionario, se deb guardar la referencia vigente de uo_funcionario
        update orga.tuo_funcionario
        set estado_reg = 'inactivo'
        where id_uo_funcionario=v_parametros.id_uo_funcionario;

        --10-04-2012: sincronizacion de UO entre BD
        /* v_respuesta_sinc:=orga.f_sincroniza_uo_empleado_entre_bd(v_parametros.id_uo_funcionario,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'DELETE');

         if(v_respuesta_sinc!='si')  then
           raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
         end if;*/

        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','asignacion empleado-uo eliminada con exito '||v_parametros.id_uo_funcionario||': Funcionario ('|| (select desc_funcionario1 from orga.vfuncionario where id_funcionario=v_id_funcionario) || ') - UO'|| (select nombre_unidad from orga.tuo where id_uo=v_id_uo));
        v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_id_uo::varchar);

      END;


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
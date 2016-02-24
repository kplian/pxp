--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		param.ft_depto_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 		KPLIAN
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		06-06-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_funcion  				integer;

BEGIN

     v_nombre_funcion:='param.ft_depto_ime';
     v_parametros:=pxp.f_get_record(par_tabla);


 /*******************************
 #TRANSACCION:   PM_DEPPTO_INS
 #DESCRIPCION:	Inserta deptos
 #AUTOR:		KPLIAN	
 #FECHA:		06-06-2011	
***********************************/
     if(par_transaccion='PM_DEPPTO_INS')then


          BEGIN

               --verificar unicidad de codigo
               if exists (select 1 from param.tdepto where upper(codigo)=upper(v_parametros.codigo) and estado_reg='activo' and id_subsistema=v_parametros.id_subsistema) then
                   raise exception 'Insercion no realizada. Codigo% en uso para subsistema%', upper(v_parametros.codigo),  (select nombre from segu.tsubsistema where id_subsistema=v_parametros.id_subsistema) ;
               end if;
               --insercion de nuevo depto
               INSERT INTO param.tdepto(
                   codigo, 
                   id_subsistema, 
                   nombre, 
                   nombre_corto, 
                   estado_reg,
                   fecha_reg, 
                   id_usuario_reg,
                   id_lugares,
                   prioridad,
                   modulo,
                   id_entidad
                   )
               values(
                   v_parametros.codigo,
                   v_parametros.id_subsistema, 
                   v_parametros.nombre, 
                   v_parametros.nombre_corto,
                   'activo',
                   now()::date, 
                   par_id_usuario,
                   string_to_array(v_parametros.id_lugares,',')::integer[],
                   v_parametros.prioridad,
                   v_parametros.modulo,
                   v_parametros.id_entidad
               );

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','depto insertado con exito '||v_parametros.nombre_corto || 'para Subsis.' || (select nombre from segu.tsubsistema where id_subsistema=v_parametros.id_subsistema));
               v_resp = pxp.f_agrega_clave(v_resp,'id_depto',v_id_funcion::varchar);


         END;
 /*******************************
 #TRANSACCION:  PM_DEPPTO_MOD
 #DESCRIPCION:	Modifica la depto seleccionada
 #AUTOR:		KPLIAN	
 #FECHA:		06-06-2011
***********************************/
     elsif(par_transaccion='PM_DEPPTO_MOD')then


          BEGIN
               --modificacion de depto
               update param.tdepto set
                 codigo = v_parametros.codigo,
                 nombre_corto = v_parametros.nombre_corto,
                 nombre = v_parametros.nombre,
                 id_subsistema = v_parametros.id_subsistema,
                 id_usuario_mod = par_id_usuario,
                 fecha_mod = now(),
                 id_lugares = string_to_array(v_parametros.id_lugares,',')::integer[],
                 prioridad = v_parametros.prioridad,
                 modulo = v_parametros.modulo,
                 id_entidad = v_parametros.id_entidad
               where id_depto = v_parametros.id_depto;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','depto modificado con exito '||v_parametros.codigo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_depto',v_parametros.id_depto::varchar);


          END;

/*******************************
 #TRANSACCION:  PM_DEPPTO_ELI
 #DESCRIPCION:	Inactiva el depto selecionado
 #AUTOR:		KPLIAN	
 #FECHA:		06-06-2011
***********************************/

    elsif(par_transaccion='PM_DEPPTO_ELI')then
        BEGIN

         --inactivacion de la depto
               update param.tdepto set estado_reg='inactivo'
               where id_depto=v_parametros.id_depto;
               return 'depto eliminado con exito';

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','depto eliminado con exito '||v_parametros.id_depto);
               v_resp = pxp.f_agrega_clave(v_resp,'id_depto',v_parametros.id_depto::varchar);

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
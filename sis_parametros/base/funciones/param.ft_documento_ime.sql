--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_documento_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		param.ft_documento_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 		KPLIAN
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

v_id_funcion  				integer;

v_id_uo           integer;
v_id_depto        integer;
v_id_depto_uo     integer;
v_formato 		varchar;

BEGIN

     v_nombre_funcion:='param.ft_documento_ime';
     v_parametros:=pxp.f_get_record(par_tabla);


 /*******************************
 #TRANSACCION:   PM_DOCUME_INS
 #DESCRIPCION:	Inserta Documentos
 #AUTOR:		KPLIAN	
 #FECHA:		03-06-2011	
***********************************/
     if(par_transaccion='PM_DOCUME_INS')then


          BEGIN
               --verificar unicidad de codigo
               if exists (select 1 from param.tdocumento where upper(codigo)=upper(v_parametros.codigo) and estado_reg='activo' and id_subsistema=v_parametros.id_subsistema) then
                   raise exception 'Insercion no realizada. Codigo% en uso para subsistema%', upper(v_parametros.codigo),  (select nombre from segu.tsubsistema where id_subsistema=v_parametros.id_subsistema) ;
               end if;
               --insercion de nuevo documento
              
              --evita formato en blanco
              v_formato = NULL;
              IF(v_parametros.formato is not NULL and trim(v_parametros.formato) <>'' )THEN
                v_formato =  v_parametros.formato;
             
              END IF;
               
               INSERT INTO param.tdocumento(
               		codigo, 
               		descripcion, 
                    id_subsistema, 
                    estado_reg,
 					fecha_reg, 
                    id_usuario_reg, 
                    periodo_gestion, 
                    tipo, 
                    tipo_numeracion, 
                    formato)
               values (
               		v_parametros.codigo, 
                    v_parametros.descripcion,
                    v_parametros.id_subsistema, 
                    'activo', 
                    now() ::date,
                 	par_id_usuario, 
                    v_parametros.periodo_gestion, 
                    v_parametros.tipo, 
                    v_parametros.tipo_numeracion, 
                    v_formato);


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Documento insertado con exito '||v_parametros.codigo || 'para Subsis.' || (select nombre from segu.tsubsistema where id_subsistema=v_parametros.id_subsistema));
               v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_id_funcion::varchar);


         END;
 /*******************************
 #TRANSACCION:  PM_DOCUME_MOD
 #DESCRIPCION:	Modifica la documento seleccionada
 #AUTOR:		KPLIAN	
 #FECHA:		03-06-2011
***********************************/
     elsif(par_transaccion='PM_DOCUME_MOD')then


          BEGIN
          
          
               /*validar que si ya se tienen correlativos generados para este tipo de doc==> no se pueda modificar ni el tipo_numeracion, ni tipo*/
               if exists (select 1 from param.tcorrelativo where id_documento=v_parametros.id_documento) then
                  if exists (select 1 from param.tdocumento where id_documento=v_parametros.id_documento and (tipo!=v_parametros.tipo or tipo_numeracion!=v_parametros.tipo_numeracion or formato!=v_parametros.formato)) then
                     raise exception 'No es posible modificar la forma en la que se numera este documento. Tiene numeracion generada';
                  end if;                                                                                                             
               end if;
               
              --evita formato en blanco
              v_formato = NULL;
              IF(v_parametros.formato is not NULL and trim(v_parametros.formato) <>'' )THEN
                v_formato =  v_parametros.formato;
              END IF;
                    
               --modificacion de documento
               update param.tdocumento set
               codigo=v_parametros.codigo,
               descripcion=v_parametros.descripcion,
               id_subsistema=v_parametros.id_subsistema,
               id_usuario_mod=par_id_usuario,
               fecha_mod=now(),
               estado_reg=v_parametros.estado_reg,
               periodo_gestion=v_parametros.periodo_gestion,
               tipo=v_parametros.tipo,
               tipo_numeracion=v_parametros.tipo_numeracion  ,
               formato=v_formato
               where id_documento=v_parametros.id_documento;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','documento modificado con exito '||v_parametros.codigo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_parametros.id_documento::varchar);


          END;

/*******************************
 #TRANSACCION:  PM_DOCUME_ELI
 #DESCRIPCION:	Inactiva el documento selecionado
 #AUTOR:		KPLIAN	
 #FECHA:		03-06-2011
***********************************/

    elsif(par_transaccion='PM_DOCUME_ELI')then
        BEGIN

         --inactivacion de la documento
               update param.tdocumento set estado_reg='eliminado'
               where id_documento=v_parametros.id_documento;
               return 'documento eliminado con exito';

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','documento eliminado con exito '||v_parametros.id_documento);
               v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_parametros.id_documento::varchar);

        END;



/*******************************
#TRANSACCION:  PM_DOCUME_INSPL
#DESCRIPCION:	sube plantilla
#AUTOR:		KPLIAN
#FECHA:		28-06-2011
***********************************/

     elsif(par_transaccion='PM_DOCUME_INSPL')then
       BEGIN

         update param.tdocumento set
           ruta_plantilla = v_parametros.ruta_archivo
           where id_documento = v_parametros.id_documento;

         v_resp = pxp.f_agrega_clave(v_resp,'mensaje','documento eliminado con exito '||v_parametros.id_documento);
         v_resp = pxp.f_agrega_clave(v_resp,'id_documento',v_parametros.id_documento::varchar);

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
CREATE OR REPLACE FUNCTION param.ft_periodo_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		param.ft_periodo_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 		KPLIAN
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		12-01-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_funcion  				integer;

BEGIN

     v_nombre_funcion:='segu.ft_periodo_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:   PM_PERIOD_INS
 #DESCRIPCION:	Inserta Funciones
 #AUTOR:		KPLIAN	
 #FECHA:		07-01-2011	
***********************************/
     if(par_transaccion='PM_PERIOD_INS')then

        
          BEGIN
          
          if exists (select 1 from param.tperiodo where periodo=v_parametros.periodo and estado_reg!='eliminado' and id_gestion=v_parametros.id_gestion) then
            raise exception 'Insercion no realizada. Periodo existente';
          end if;
          --insercion de nueva funcion
               INSERT INTO param.tperiodo(periodo, estado_reg,fecha_reg, id_gestion, id_usuario_reg)
               values(v_parametros.periodo,'activo',now()::date, v_parametros.id_gestion, par_id_usuario);
              

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','periodo insertada con exito '||v_parametros.periodo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_id_funcion::varchar);


         END;
 /*******************************    
 #TRANSACCION:  PM_PERIOD_MOD
 #DESCRIPCION:	Modifica la periodo seleccionada
 #AUTOR:		KPLIAN	
 #FECHA:		12-01-2011
***********************************/
     elsif(par_transaccion='PM_PERIOD_MOD')then

          
          BEGIN
          
               if exists (select 1 from param.tperiodo where periodo=v_parametros.periodo and id_periodo!=v_parametros.id_periodo and estado_reg!='eliminado' and id_gestion=v_parametros.id_gestion) then
                  raise exception 'Modificacion no realizada. Periodo existente';
               end if;
               --modificacion de periodo
               update param.tperiodo set
               periodo=v_parametros.periodo,
               estado_reg=v_parametros.estado_reg
               where id_periodo=v_parametros.id_periodo;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','periodo modificada con exito '||v_parametros.id_periodo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);

             
          END;
          
/*******************************    
 #TRANSACCION:  PM_PERIOD_ELI
 #DESCRIPCION:	Inactiva la periodo selecionada
 #AUTOR:		KPLIAN	
 #FECHA:		12-01-2011
***********************************/

    elsif(par_transaccion='PM_PERIOD_ELI')then
        BEGIN
        
         --inactivacion de la periodo
               update param.tperiodo set estado_reg='eliminado'
               where id_periodo=v_parametros.id_periodo;
               return 'periodo eliminado con exito';
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','periodo eliminada con exito '||v_parametros.id_periodo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_periodo_sel (OID = 304044) : 
--

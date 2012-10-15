CREATE OR REPLACE FUNCTION param.ft_gestion_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		param.ft_gestion_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 		KPLIAN
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		07-01-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_funcion  				integer;
i                 integer;
BEGIN

     v_nombre_funcion:='segu.ft_funcion_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:   PM_GESTIO_INS
 #DESCRIPCION:	Inserta Funciones
 #AUTOR:		KPLIAN	
 #FECHA:		07-01-2011	
***********************************/
     if(par_transaccion='PM_GESTIO_INS')then

        
          BEGIN
          
          --insercion de nueva funcion
               if exists (select 1 from param.tgestion where gestion=v_parametros.gestion and estado_reg!='eliminado') then
                  raise exception 'Insercion no realizada. Gestion existente';
               end if;
               INSERT INTO param.tgestion(gestion, estado_reg,fecha_reg, id_usuario_reg)
               values(v_parametros.gestion,'activo',now()::date, par_id_usuario);
              
              
               for i in 1..12 loop
                 insert into param.tperiodo(periodo, id_gestion, id_usuario_reg, fecha_reg, estado_reg)
                 values (i, (select id_gestion from param.tgestion where gestion=v_parametros.gestion and estado_reg='activo'), par_id_usuario, now()::date,'activo');
               end loop;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion insertada con exito '||v_parametros.gestion);
               v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_id_funcion::varchar);


         END;
 /*******************************    
 #TRANSACCION:  PM_GESTIO_MOD
 #DESCRIPCION:	Modifica la gestion seleccionada
 #AUTOR:		KPLIAN	
 #FECHA:		07-01-2011
***********************************/
     elsif(par_transaccion='PM_GESTIO_MOD')then

          
          BEGIN

               if exists (select 1 from param.tgestion where gestion=v_parametros.gestion and id_gestion!=v_parametros.id_gestion and estado_reg!='eliminado') then
                  raise exception 'Modificacion no realizada. Gestion existente';
               end if;
               --modificacion de gestion
               update param.tgestion set

                     gestion=v_parametros.gestion,
                     estado_reg=v_parametros.estado_reg

               where id_gestion=v_parametros.id_gestion;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion modificada con exito '||v_parametros.gestion);
               v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_parametros.id_gestion::varchar);

             
          END;
          
/*******************************    
 #TRANSACCION:   PM_GESTIO_ELI
 #DESCRIPCION:	Inactiva la gestion selecionada
 #AUTOR:		KPLIAN	
 #FECHA:		07-01-2011
***********************************/

    elsif(par_transaccion='PM_GESTIO_ELI')then
        BEGIN
        
               -- verificar que la gestion no tenga dependencias
               -- en esquema param con tcorrelativo
               --inactivacion de la gestion
               update param.tgestion set estado_reg='eliminado'
               where id_gestion=v_parametros.id_gestion;
               return 'Gestion eliminada con exito';

               -- si existen periodos para la gestion que se esta eliminando, eliminar tb los periodos
               if exists (select 1 from param.tperiodo where id_gestion=v_parametros.id_gestion and estado_reg!='eliminado') then
                  update param.tperiodo set estado_reg='eliminado'
                  where id_gestion=v_parametros.id_gestion;
               end if;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion eliminada con exito '||v_parametros.id_gestion);
               v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_parametros.id_gestion::varchar);

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
-- Definition for function ft_gestion_sel (OID = 304036) : 
--

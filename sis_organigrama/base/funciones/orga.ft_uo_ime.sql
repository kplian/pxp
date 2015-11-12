CREATE OR REPLACE FUNCTION orga.ft_uo_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		orga.ft_uo_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 	    KPLIAN (mzm)
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		23-05-2011
 ***************************************************************************/
DECLARE


v_parametros                record;
v_resp                      varchar;
v_nombre_funcion            text;
v_mensaje_error             text;

v_id_uo  				integer;


BEGIN

     v_nombre_funcion:='orga.ft_uo_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:  RH_UO_INS
 #DESCRIPCION:	Inserta uos
 #AUTOR:			
 #FECHA:		25-03-2011	
***********************************/
     if(par_transaccion='RH_UO_INS')then

        
          BEGIN


               --insercion de nuevo uo
               if exists (select 1 from orga.tuo where codigo=v_parametros.codigo and estado_reg='activo') then
                  raise exception 'Insercion no realizada. CODIGO DE UO EN USO';
               end if;

               INSERT INTO orga.tuo(cargo_individual,codigo,             descripcion,              estado_reg,  fecha_reg,   id_usuario_reg, nombre_cargo,              nombre_unidad, presupuesta)
               values(v_parametros.cargo_individual, v_parametros.codigo,v_parametros.descripcion, 'activo',    now()::date, par_id_usuario, v_parametros.nombre_cargo, v_parametros.nombre_unidad, v_parametros.presupuesta);
              

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','uo '||v_parametros.codigo ||' insertado con exito ');
               v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_id_uo::varchar);
         END;
 /*******************************    
 #TRANSACCION:  RH_UO_MOD
 #DESCRIPCION:	Modifica la parametrizacion seleccionada
 #AUTOR:			
 #FECHA:		25-01-2011
***********************************/
     elsif(par_transaccion='RH_UO_MOD')then

          
          BEGIN    raise exception 'entra a ft_uo_ime';
                if exists (select 1 from orga.tuo where id_uo!=v_parametros.id_uo and codigo=v_parametros.codigo and estado_reg='activo') then
                  raise exception 'Modificacion no realizada. CODIGO DE UO EN USO';
                end if;
                
                update orga.tuo
                set 
                    cargo_individual=v_parametros.cargo_individual,
                    codigo=v_parametros.codigo,
                    descripcion=v_parametros.descripcion,
                    nombre_cargo=v_parametros.nombre_cargo,
                    nombre_unidad=v_parametros.nombre_unidad,
                    presupuesta=v_parametros.presupuesta,
                    fecha_mod=now()::date,
                    id_usuario_mod=par_id_usuario
                where id_uo=v_parametros.id_uo;
                
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','uo modificado con exito '||v_parametros.id_uo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_parametros.id_uo::varchar);
          END;
          
/*******************************    
 #TRANSACCION:  RH_UO_ELI
 #DESCRIPCION:	Inactiva la parametrizacion selecionada
 #AUTOR:			
 #FECHA:		25-03-2011
***********************************/

    elsif(par_transaccion='RH_UO_ELI')then
        BEGIN
        
         --inactivacion de la uo
               update orga.tuo
               set estado_reg='inactivo'
               where id_uo=v_parametros.id_uo;
              
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','uo eliminada con exito '||v_parametros.id_uo);
               v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_parametros.id_uo::varchar);

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
-- Definition for function ft_uo_sel (OID = 304963) : 
--

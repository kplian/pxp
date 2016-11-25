CREATE OR REPLACE FUNCTION orga.ft_estructura_uo_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		rhum.ft_estructura_uo_ime
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

v_id_uo  				    integer;



--10-04-2012: sincronizacion de UO entre BD
v_respuesta_sinc            varchar;

BEGIN

  

     v_nombre_funcion:='orga.ft_estructura_uo_ime';
     v_parametros:=pxp.f_get_record(par_tabla);
     
     
 /*******************************    
 #TRANSACCION:  RH_ESTRUO_INS
 #DESCRIPCION:	Inserta estructura de uos
 #AUTOR:			
 #FECHA:		23-05-2011	
***********************************/
     if(par_transaccion='RH_ESTRUO_INS')then

        
          BEGIN  
          
                               
               -- validacion de un solo nodo_base
               if exists (select distinct 1 from orga.tuo where nodo_base='si' and estado_reg='activo' and v_parametros.nodo_base='si') then
                  raise exception 'Insercion no realizada. Ya se definio alguna unidad como nodo base';
               end if;
               
               -- verificar duplicidad de codigo de uo
               if exists (select distinct 1 from orga.tuo where lower(codigo)=lower(v_parametros.codigo) and estado_reg='activo') then
               end if;
               -- insercion de uo nueva
              
              
               insert into orga.tuo( 
                   codigo,      
                   nombre_unidad,nombre_cargo,   
                   descripcion, 
                   cargo_individual,
                   presupuesta,    
                   estado_reg,  
                   fecha_reg,
                   id_usuario_reg, 
                   nodo_base, 
                   correspondencia, 
                   gerencia,
                   id_nivel_organizacional)
               values(
                 upper(v_parametros.codigo), 
                 v_parametros.nombre_unidad, 
                 v_parametros.nombre_cargo, 
                 v_parametros.descripcion,
                 v_parametros.cargo_individual,
                 v_parametros.presupuesta, 
                 'activo', 
                 now()::date, 
                 par_id_usuario, 
                 v_parametros.nodo_base, 
                 v_parametros.correspondencia, 
                 v_parametros.gerencia,
                 v_parametros.id_nivel_organizacional)
                 
               RETURNING id_uo into v_id_uo;

               -- relacion de uo_hijo a o_padre
                
               
                
                IF(v_parametros.id_uo_padre <> 'id') THEN
                
                
                INSERT INTO orga.testructura_uo(
                 id_uo_hijo, 
                 id_uo_padre, 
                 estado_reg, 
                 id_usuario_reg, 
                 fecha_reg)
                 values
                 ( v_id_uo, 
                  (v_parametros.id_uo_padre)::integer,
                  'activo',    
                   par_id_usuario, 
                   now()::date);
                   
                 ELSE   
                    
                    if(v_parametros.nodo_base='no')then
                    
                    raise exception 'Cuando se trata de la raiz del organigrama tienes que colocar nodo_base = si';
                    
                    end if;
              
                
                END IF;
               
                      
             
                 
            
              
               
              /* --10-04-2012: sincronizacion de UO entre BD
               v_respuesta_sinc:=orga.f_sincroniza_uo_entre_bd(v_id_uo,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'INSERT');
      
               if(v_respuesta_sinc!='si')  then
                     raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
               end if;  */
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','estructura uo '||v_parametros.nombre_unidad ||' insertado con exito a ' || v_parametros.id_uo_padre);
               v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_id_uo::varchar);
         END;
 /*******************************    
 #TRANSACCION:  RH_ESTRUO_MOD
 #DESCRIPCION:	Modifica la parametrizacion seleccionada
 #AUTOR:			
 #FECHA:		23-05-2011
***********************************/
     elsif(par_transaccion='RH_ESTRUO_MOD')then

          
          BEGIN   
          
         
               -- validacion de un solo nodo_base
               if exists (select distinct 1 from orga.tuo where nodo_base='si' and estado_reg='activo' and id_uo!=v_parametros.id_uo and v_parametros.nodo_base='si') then
                  raise exception 'Insercion no realizada. Ya se definio alguna unidad como nodo base';
               end if;
               
               update orga.tuo
               set codigo=upper(v_parametros.codigo),
                   nombre_unidad= v_parametros.nombre_unidad,
                   nombre_cargo=v_parametros.nombre_cargo,
                   descripcion=v_parametros.descripcion,
                   cargo_individual=v_parametros.cargo_individual,
                   presupuesta=v_parametros.presupuesta,
                   nodo_base=v_parametros.nodo_base,
                   correspondencia=v_parametros.correspondencia,
                   gerencia=v_parametros.gerencia,
                   id_nivel_organizacional = v_parametros.id_nivel_organizacional
                where id_uo=v_parametros.id_uo;
                
               /* --10-04-2012: sincronizacion de UO entre BD
                v_respuesta_sinc:=orga.f_sincroniza_uo_entre_bd(v_parametros.id_uo,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'UPDATE');
      
                if(v_respuesta_sinc!='si')  then
                     raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
                end if; */
                
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','estructura uo modificado con exito '||v_parametros.id_uo);
                v_resp = pxp.f_agrega_clave(v_resp,'id_uo',v_parametros.id_uo::varchar);
          END;
          
/*******************************    
 #TRANSACCION:  RH_ESTRUO_ELI
 #DESCRIPCION:	Inactiva la parametrizacion selecionada. Verifica dependencias hacia abajo
 #AUTOR:			
 #FECHA:		23-05-2011
 *********************************
 #AUTOR_MOD:	KPLIAN (rac)		
 #FECHA_MOD:	23-05-2011
 #DESC_MON:		Valida la eliminacion de nodos solo si sus hijos estan inactivos
***********************************/

    elsif(par_transaccion='RH_ESTRUO_ELI')then
        BEGIN
        
        
         
             
           --1) verificamos si tiene relaciones activas con sus hijos (asumimos que si tiene hijos tendra relaciones activas con ellos)
            
            if exists ( select DISTINCT 1 
                          from orga.tuo uo
                          inner join  orga.testructura_uo euo on uo.id_uo = euo.id_uo_padre and euo.estado_reg='activo' 
                          where uo.id_uo = v_parametros.id_uo) then
               
                        --NOTA) sera necesario adicionar  una trsaccion que realize una eliminacion recursiva
                        --      previa confirmacion del usuario despues de este error 
                             
                        raise exception 'Eliminacion no realizada.  La Unidad que se inactiva tiene dependencias  elimine primero los hijos';
              
              end if;
              
              --2) se fija que no tenga funcionarios en estado activo asignados a este uo 
              if exists ( select DISTINCT 1 
                          from orga.tuo_funcionario uof
                          where uof.id_uo = v_parametros.id_uo and uof.estado_reg='activo') then
             
                             
                        raise exception 'Eliminacion no realizada. La Unidad que se intenta eliminar tiene relaciones vigentes con empleados';
              
              end if;
               
               --3) inactiva la unidad
               update orga.tuo
               set estado_reg='inactivo'
               where id_uo=v_parametros.id_uo;
               
               
               -- 4) inactiva las relaciones con los padres (para que se cumpla siempre la regla en 1)
               update orga.testructura_uo
               set estado_reg='inactivo'
               where id_uo_hijo=v_parametros.id_uo;
              
               --10-04-2012: sincronizacion de UO entre BD
               /* v_respuesta_sinc:=orga.f_sincroniza_uo_entre_bd(v_parametros.id_uo,'10.172.0.13','5432','db_link','db_link','dbendesis' ,'DELETE');
      
                if(v_respuesta_sinc!='si')  then
                     raise exception 'Sincronizacion de UO en BD externa no realizada%',v_respuesta_sinc;
                end if;*/
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','estructura uo eliminada con exito '||v_parametros.id_uo);
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
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
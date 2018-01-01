--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_generar_auxiliares_proveedores (
)
RETURNS boolean AS
$body$
DECLARE

  v_r record;
  v_reg_cuenta record;
  v_tabla varchar;
  v_resp varchar;
  v_id_proveedor integer;
  v_sigla varchar;
  v_cont integer;
  
  v_desc_proveedor   varchar;
  v_id_auxiliar  integer;
  v_id_config_subtipo_cuenta  integer;
  v_codigo_gen  varchar;
  
  p_id_usuario   integer;
  

BEGIN
  
  
    v_cont = 1;
  
  
  FOR v_r in ( select 
                 p.id_proveedor,
                 p.nit,
                 p.codigo,
                 p.desc_proveedor,
                 p.tipo
              from param.vproveedor p
              inner join param.tproveedor p1 on p1.id_proveedor = p.id_proveedor
              where p1.id_auxiliar is null
                   and p1.estado_reg = 'activo') LOOP
                   
                   
                   
             v_desc_proveedor = v_r.desc_proveedor;
             v_id_proveedor = v_r.id_proveedor;
             v_codigo_gen = v_r.codigo;
             p_id_usuario = 1;
                    
                    
                         --  verificamos que el codigo no este duplicado
                  
                        IF  exists(select
                               1
                            from conta.tauxiliar a
                            where      a.estado_reg = 'activo'
                                  and  upper(a.codigo_auxiliar) = upper(v_codigo_gen)) THEN
                           
                           raise exception 'Ya existe un auxiliar con el código %',v_codigo_gen;           
                                  
                        END IF;
                        
                       
                        
                        
                         IF  exists(select
                               1
                            from conta.tauxiliar a
                            where      a.estado_reg = 'activo'
                                  and  a.nombre_auxiliar =  v_desc_proveedor ) THEN
                                  
                                  
                           v_desc_proveedor = v_desc_proveedor || ' (PROVEEDOR)';
                           
                           --raise exception 'Ya existe un auxiliar con esta descripcion:  %',v_desc_proveedor;           
                                  
                         END IF;
                  
                        --Sentencia de la insercion
                        insert into conta.tauxiliar(
                          
                            estado_reg,
                            codigo_auxiliar,
                            nombre_auxiliar,
                            fecha_reg,
                            id_usuario_reg,
                            id_usuario_mod,
                            fecha_mod,
                            corriente
                        ) values(
                            'activo',
                            upper(v_codigo_gen),
                            v_desc_proveedor,
                            now(),
                            p_id_usuario,
                            null,
                            null,
                            'si'
            							
                        )RETURNING id_auxiliar into v_id_auxiliar;
                        
                        update param.tproveedor p set
                          id_auxiliar = v_id_auxiliar
                        where p.id_proveedor = v_id_proveedor;
                        
                        --relaciona el auxiliar con las cuentas de proveedores (proveedores por pagar, retenciones)
                        
                        SELECT 
                          csc.id_config_subtipo_cuenta
                         into
                          v_id_config_subtipo_cuenta
                        FROM conta.tconfig_subtipo_cuenta csc
                        where   upper(csc.nombre) in ('PROVEEDORES','CUENTAS POR PAGAR')
                               and csc.estado_reg = 'activo';
                               
                               
                        if v_id_config_subtipo_cuenta is null then       
                            raise exception ' no tiene configurado un subtipo de cuenta para PROVEEDORES o CUENTAS POR PAGAR';
                        end if;
                        
                        for v_reg_cuenta in (
                                   select 
                                      c.id_cuenta
                                   from conta.tcuenta c
                                   where c.id_config_subtipo_cuenta = v_id_config_subtipo_cuenta
                                         and c.estado_reg = 'activo'
                                         and c.sw_transaccional = 'movimiento') LOOP
                                         
                               --  verificar si el auxilair no esta asociado 
                               IF not exists (select 1
                                               from conta.tcuenta_auxiliar ca 
                                               where ca.estado_reg = 'activo'
                                                     and ca.id_cuenta = v_reg_cuenta.id_cuenta 
                                                     and ca.id_auxiliar = v_id_auxiliar) THEN
                                                     
                               
                                      --asociamos el auxilar a las cuentas  de proveedores
                                      insert into conta.tcuenta_auxiliar(
                                              estado_reg,
                                              id_auxiliar,
                                              id_cuenta,
                                              id_usuario_reg,
                                              fecha_reg,
                                              id_usuario_mod,
                                              fecha_mod
                                         ) values(
                                              'activo',
                                              v_id_auxiliar,
                                              v_reg_cuenta.id_cuenta ,
                                              p_id_usuario,
                                              now(),
                                              null,
                                              null);
                               END IF;                       
                               
                         END LOOP;          
                        
      
  END LOOP;

  RETURN TRUE;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
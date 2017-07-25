--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_tproveedor_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tproveedor_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tproveedor'
 AUTOR: 		 (mzm)
 FECHA:	        15-11-2011 10:44:58
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento         integer;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_proveedor          integer;
    v_codigo                varchar;
    
    --10abr12   
    v_respuesta_sinc        	varchar;  
    v_id_auxiliar 				integer; 
    v_desc_proveedor			varchar;  
    v_id_config_subtipo_cuenta	integer;   
    v_reg_cuenta				record; 
    v_registros_prov 			record;  
    v_id_persona				integer;
    v_id_institucion   			integer;
    v_num_seq					integer;
    v_codigo_gen				varchar;
    v_desc_proveedor_antes 		varchar; 
    
BEGIN
                           
    v_nombre_funcion = 'param.f_tproveedor_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_INS'
     #DESCRIPCION:    Insercion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    if(p_transaccion='PM_PROVEE_INS')then
                    
        begin      
        
         
           
           --verificar que el codigo de proveedor sea unico
           --verificar que el proveedor no se duplique  para la misma institucion 
           IF  exists(select 1 from param.tproveedor p where p.estado_reg = 'activo' and p.codigo = v_codigo_gen)   THEN
             raise exception 'El código esta duplicado (Revise la posición actual de la secuencia seq_codigo_proveedor )';
           END IF;
           
           
           if v_parametros.register = 'before_registered' then
           
                     IF( v_parametros.id_institucion is not NULL 
                          and (exists (select 1 from param.tproveedor  p
                                where p.id_institucion =  v_parametros.id_institucion
                                and p.estado_reg ='activo'))) THEN
                                
                         raise exception 'Proveedor ya registrado';
                     
                     
                     END IF;
                     
                     
                     IF( v_parametros.id_persona is Not NULL 
                         and (exists (select 1 from param.tproveedor  p
                                where p.id_persona =  v_parametros.id_persona
                                and p.estado_reg ='activo'))) THEN
                                
                         raise exception 'Proveedor ya registrado';
                     END IF;
                     
                     
                     --recupera codigo de proveedor
                     v_num_seq =  nextval('param.seq_codigo_proveedor');
                     v_codigo_gen = 'PR'||pxp.f_llenar_ceros(v_num_seq, 6);
           
           
                    insert into param.tproveedor
                    (id_usuario_reg, 				fecha_reg,					estado_reg,
                     id_institucion,				id_persona,					tipo,
                     numero_sigma,					codigo,						nit,
                     id_lugar,						rotulo_comercial, 			contacto)
                    values 
                    (p_id_usuario,					now(),						'activo',
                    v_parametros.id_institucion,	v_parametros.id_persona,	case when v_parametros.id_persona is NULL THEN
                                                                                    'institucion'
                                                                                else
                                                                                    'persona'
                                                                                end,
                    v_parametros.numero_sigma,		v_codigo_gen,		v_parametros.nit,
                    v_parametros.id_lugar,			v_parametros.rotulo_comercial,	v_parametros.contacto)RETURNING id_proveedor into v_id_proveedor;
           else
                    if (v_parametros.tipo = 'persona')then
                        
                        
                        insert into segu.tpersona (
                                   nombre,
                                   apellido_paterno,
                                   apellido_materno,
                                   ci,
                                   correo,
                                   celular1,
                                   telefono1,
                                   telefono2,
                                   celular2,
                                   --foto,
                                   --extension,
                                   genero,
                                   fecha_nacimiento,
                                   direccion)
                         values(
                                v_parametros.nombre,
                                v_parametros.apellido_paterno,
                                v_parametros.apellido_materno,
                                v_parametros.ci,
                                v_parametros.correo,
                                v_parametros.celular1,
                                v_parametros.telefono1,
                                v_parametros.telefono2,
                                v_parametros.celular2,
                                --v_parametros.foto,
                                --v_parametros.extension,
                                v_parametros.genero,
                                v_parametros.fecha_nacimiento,
                                v_parametros.direccion)  
                            
                        RETURNING id_persona INTO v_id_persona;
                    else
                         
                         --verificar que el codigo no se duplique
                         
                         IF   exists(select  
                                       1 
                                    from param.tinstitucion i 
                                    where i.estado_reg = 'activo' 
                                          and  i.codigo =  v_parametros.codigo_institucion ) THEN
                             raise exception 'Ya existe una institución con esta sigla %',  v_parametros.codigo_institucion;
                         END IF;
                         
                         --generar codigo de proveedores
                         v_num_seq =  nextval('param.seq_codigo_proveedor');
                          v_codigo_gen = 'PR'||pxp.f_llenar_ceros(v_num_seq, 6);
                    
                        --Sentencia de la insercion
                        insert into param.tinstitucion(
                            fax,
                            estado_reg,        			
                            casilla,
                            direccion,
                            doc_id,
                            telefono2,
                            email2,
                            celular1,
                            email1,        			
                            nombre,
                            observaciones,
                            telefono1,
                            celular2,
                            codigo_banco,
                            pag_web,
                            id_usuario_reg,
                            fecha_reg,
                            id_usuario_mod,
                            fecha_mod,
                            codigo
                        ) values(
                            v_parametros.fax,
                            'activo',
                            v_parametros.casilla,
                            v_parametros.direccion_institucion,
                            v_parametros.nit, --v_parametros.doc_id,
                            v_parametros.telefono2_institucion,
                            v_parametros.email2_institucion,
                            v_parametros.celular1_institucion,
                            v_parametros.email1_institucion,
                            v_parametros.nombre_institucion,
                            v_parametros.observaciones,
                            v_parametros.telefono1_institucion,
                            v_parametros.celular2_institucion,
                            v_parametros.codigo_banco,
                            v_parametros.pag_web,
                            p_id_usuario,
                            now(),
                            null,
                            null,
                            COALESCE(v_parametros.codigo_institucion,v_codigo_gen)
                        
                        )RETURNING id_institucion into v_id_institucion;
                    end if;
                    
                     
                    
                    
                    
                     insert into param.tproveedor
                        (id_usuario_reg, 				fecha_reg,					estado_reg,
                         id_institucion,				id_persona,					tipo,
                         numero_sigma,					codigo,						nit,
                         id_lugar,						rotulo_comercial,			contacto)
                      values 
                        (p_id_usuario,					now(),						'activo',
                        v_id_institucion,				v_id_persona,				case when v_id_persona is NULL THEN
                                                                                        'institucion'
                                                                                    else
                                                                                        'persona'
                                                                                    end,
                        v_parametros.numero_sigma,		v_codigo_gen,		v_parametros.nit,
                        v_parametros.id_lugar,			v_parametros.rotulo_comercial, v_parametros.contacto)RETURNING id_proveedor into v_id_proveedor;
                end if;
            
            --insertar auxiliar
            -- chequear si existe el esquema de contabilidad
            IF EXISTS (
                       SELECT 1
                       FROM   information_schema.tables 
                       WHERE  table_schema = 'conta'
                       AND    table_name = 'tauxiliar'
                    ) THEN
                    
                    
                    
                       --  verificamos que el codigo no este duplicado
                  
                        IF  exists(select
                               1
                            from conta.tauxiliar a
                            where      a.estado_reg = 'activo'
                                  and  upper(a.codigo_auxiliar) = upper(v_codigo_gen)) THEN
                           
                           raise exception 'Ya existe un auxiliar con el código %',v_parametros.codigo;           
                                  
                        END IF;
                        
                        
                        
                        select 
                         p.desc_proveedor
                        INTO 
                          v_desc_proveedor  
                        from param.vproveedor p
                        where p.id_proveedor = v_id_proveedor;
                        
                        
                         IF  exists(select
                               1
                            from conta.tauxiliar a
                            where      a.estado_reg = 'activo'
                                  and  a.nombre_auxiliar =  v_desc_proveedor ) THEN
                           
                           raise exception 'Ya existe un auxiliar con esta descripcion:  %',v_desc_proveedor;           
                                  
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
                        where   upper(csc.nombre) = 'PROVEEDORES'
                               and csc.estado_reg = 'activo';
                               
                               
                        if v_id_config_subtipo_cuenta is null then       
                            raise exception ' no tiene configurado un subtipo de cuenta para proveedores';
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
                        
             END IF;      
        
            
                         
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores almacenado(a) con exito (id_proveedor'||v_id_proveedor||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_id_proveedor::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_MOD'
     #DESCRIPCION:    Modificacion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    elsif(p_transaccion='PM_PROVEE_MOD')then

        begin
          
            
            
           if exists(select 1 from param.tproveedor
                    where codigo = v_parametros.codigo
                    and id_proveedor != v_parametros.id_proveedor) then
                raise exception 'Código de Proveedor duplicado';
            end if;
            
            --recuepra datos previos del proveedor
            select 
                  *
               into
                v_registros_prov
            from param.tproveedor pr
            where pr.id_proveedor = v_parametros.id_proveedor;
            
            select 
                   p.desc_proveedor
               INTO 
                  v_desc_proveedor_antes  
            from param.vproveedor p
            where p.id_proveedor = v_id_proveedor;  
            
            
            
            --Sentencia de la modificacion
            
            update param.tproveedor set
                numero_sigma = v_parametros.numero_sigma,
                id_institucion = v_parametros.id_institucion,
                id_persona = v_parametros.id_persona,
                id_lugar = v_parametros.id_lugar,
                nit = v_parametros.nit,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                rotulo_comercial = v_parametros.rotulo_comercial,
                contacto = v_parametros.contacto
            where id_proveedor=v_parametros.id_proveedor;
            
            
            --modificar datos basicos de proveedor y persona ,....isntitucion el nit
            if (v_parametros.tipo = 'persona')then
                    
                    
                    update  segu.tpersona  set 
                       nombre = v_parametros.nombre,
                       apellido_paterno = v_parametros.apellido_paterno,
                       apellido_materno = v_parametros.apellido_materno,
                       ci = v_parametros.ci,
                       correo = v_parametros.correo,
                       celular1 =v_parametros.celular1,
                       telefono1 =v_parametros.telefono1,
                       telefono2 =v_parametros.telefono2,
                       celular2 =v_parametros.celular2,
                       genero = v_parametros.genero,
                       fecha_nacimiento =v_parametros.fecha_nacimiento,
                       direccion = v_parametros.direccion
                     WHERE id_persona  = v_parametros.id_persona;
            
            else
            
                      IF   exists(select  
                                       1 
                                    from param.tinstitucion i 
                                    where i.estado_reg = 'activo' 
                                          and  i.codigo =  v_parametros.codigo_institucion 
                                          and i.id_institucion != v_parametros.id_institucion) THEN
                             raise exception 'Ya existe una institución con esta sigla %',  v_parametros.codigo_institucion;
                         END IF;
            
                     --Sentencia de la insercion  --modifica datos de la institucion
                     
                        update  param.tinstitucion set
                            fax = v_parametros.fax,
                            casilla = v_parametros.casilla,
                            direccion = v_parametros.direccion_institucion,
                            doc_id =  v_parametros.nit,
                            telefono2 = v_parametros.telefono2_institucion,
                            email2 = v_parametros.email2_institucion,
                            celular1 = v_parametros.celular1_institucion,
                            email1 =  v_parametros.email1_institucion,        			
                            nombre = v_parametros.nombre_institucion,
                            observaciones = v_parametros.observaciones,
                            telefono1 =  v_parametros.telefono1_institucion,
                            celular2 = v_parametros.celular2_institucion,
                            pag_web = v_parametros.pag_web,
                            id_usuario_mod = p_id_usuario,
                            fecha_mod = now(),
                            codigo = v_parametros.codigo_institucion
                       WHERE id_institucion = v_parametros.id_institucion;
                   
            
            end if;
            
            
            
            
            
            --si etenemos sitema de contabildiad
            
            IF EXISTS (
                       SELECT 1
                       FROM   information_schema.tables 
                       WHERE  table_schema = 'conta'
                       AND    table_name = 'tauxiliar'
                    ) THEN
                    
                    
                  select 
                         p.desc_proveedor
                      INTO 
                         v_desc_proveedor  
                   from param.vproveedor p
                   where p.id_proveedor = v_id_proveedor;
                   
                    
                  -- si fue cambiado el codigo o la descripcion del proveedor
                  IF v_desc_proveedor_antes != v_desc_proveedor  THEN
                  
                      IF  exists(select
                               1
                            from conta.tauxiliar a
                            where      a.estado_reg = 'activo'
                                  and   a.nombre_auxiliar =  v_desc_proveedor 
                                  and  a.id_auxiliar !=  v_registros_prov.id_auxiliar ) THEN
                           
                           raise exception 'Ya existe otro auxiliar con esta descripcion  %',v_desc_proveedor;           
                                  
                      END IF;
                  
                       update conta.tauxiliar aux set
                         nombre_auxiliar = v_desc_proveedor
                       where aux.id_auxiliar = v_registros_prov.id_auxiliar;
                  END IF;
              END IF;
            
            
            
            
           
        
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_parametros.id_proveedor::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
        end;

    /*********************************    
     #TRANSACCION:  'PM_PROVEE_ELI'
     #DESCRIPCION:    Eliminacion de registros
     #AUTOR:        mzm    
     #FECHA:        15-11-2011 10:44:58
    ***********************************/

    elsif(p_transaccion='PM_PROVEE_ELI')then

        begin
            
             IF EXISTS (
                       SELECT 1
                       FROM   information_schema.tables 
                       WHERE  table_schema = 'conta'
                       AND    table_name = 'tauxiliar'
                    ) THEN
                    
                       
                   select 
                          *
                       into
                        v_registros_prov
                    from param.tproveedor pr
                    where pr.id_proveedor = v_parametros.id_proveedor;
                    
                    
                    
                    delete   from conta.tcuenta_auxiliar ca 
                    where  ca.id_auxiliar = v_registros_prov.id_auxiliar;
                    
                    delete   from conta.tauxiliar a 
                    where  a.id_auxiliar = v_registros_prov.id_auxiliar;
              
                    
             END IF;
            
            
            --Sentencia de la eliminacion
            delete from param.tproveedor
            where id_proveedor=v_parametros.id_proveedor;
             
            
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proveedores eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_parametros.id_proveedor::varchar);
              
            --Devuelve la respuesta
            return v_resp;

        end;
         
    else
     
        raise exception 'Transaccion inexistente: %',p_transaccion;

    end if;

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
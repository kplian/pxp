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
    v_reg_pres           	record;
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
    v_codigo_wf 				varchar;
    v_id_gestion				integer;
    v_num_tramite				varchar;
    v_id_proceso_wf				integer;
    v_id_estado_wf				integer;
    v_codigo_estado 			varchar;
    v_operacion					varchar;
    v_registros_pp				record;
    v_id_tipo_estado				integer;
    v_id_funcionario				integer;
    v_id_usuario_reg				integer;
    v_id_depto						integer;
    v_id_estado_wf_ant 				integer;
    v_acceso_directo 				varchar;
    v_clase 						varchar;
    v_parametros_ad 				varchar;
    v_tipo_noti 					varchar;
    v_titulo  						varchar;
    v_id_estado_actual 				integer;
    v_registros_proc				record; 
    v_codigo_estado_siguiente		varchar;
    v_obs							varchar;
    v_codigo_tipo_pro  				varchar; 
    
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
                    v_parametros.id_institucion,	v_parametros.id_persona,	v_parametros.tipo,
                    v_parametros.numero_sigma,		v_codigo_gen,		v_parametros.nit,
                    v_parametros.id_lugar,			v_parametros.rotulo_comercial,	v_parametros.contacto) RETURNING id_proveedor into v_id_proveedor;
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
                contacto = v_parametros.contacto,
                tipo = v_parametros.tipo
            where id_proveedor=v_parametros.id_proveedor;
            
            
            --modificar datos basicos de proveedor y persona ,....isntitucion el nit
            if v_parametros.id_persona is not null then
                    
                    
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
    /*********************************    
 	#TRANSACCION:  'PM_INITRA_IME'
 	#DESCRIPCION:	Iniciar tramite de proveedores
 	#AUTOR:		Rensi Artega Copari (KPLIAN)
 	#FECHA:		05/09/2017 00:30:39
	***********************************/

	elsif(p_transaccion='PM_INITRA_IME')then

		begin
        
                
               select
                   pr.codigo,
                   pr.nro_tramite
               into
                   v_reg_pres
              from param.tproveedor pr
              where pr.id_proveedor = v_parametros.id_proveedor;
              
              select 
                 per.id_gestion
              into
                 v_id_gestion
              from param.tperiodo per
              where   now()::Date BETWEEN per.fecha_ini and per.fecha_fin;
                 
                 
              v_codigo_wf = pxp.f_get_variable_global('param_wf_codigo_proveedor');
                           
              IF  v_reg_pres.nro_tramite is not NULL or  v_reg_pres.nro_tramite !='' THEN
                 raise exception 'El trámite ya fue iniciado % ', v_reg_pres.nro_tramite;              
              END IF;
        
              -- obtiene numero de tramite
                 SELECT 
                       ps_num_tramite ,
                       ps_id_proceso_wf ,
                       ps_id_estado_wf ,
                       ps_codigo_estado 
                    into
                       v_num_tramite,
                       v_id_proceso_wf,
                       v_id_estado_wf,
                       v_codigo_estado   
                        
                  FROM wf.f_inicia_tramite(
                       p_id_usuario, 
                       v_parametros._id_usuario_ai,
                       v_parametros._nombre_usuario_ai,
                       v_id_gestion, 
                       v_codigo_wf, 
                       v_parametros.id_funcionario_usu,
                       NULL,
                       'Inicio de tramite.... ',
                       v_reg_pres.codigo);
			
            
            
            update param.tproveedor  p  set
               nro_tramite = v_num_tramite,
               id_estado_wf = v_id_estado_wf,
               id_proceso_wf = v_id_proceso_wf,
               estado = v_codigo_estado
            where p.id_proveedor = v_parametros.id_proveedor;
            
            
            
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','se inicio el tramite de proveedores' ); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proveedor',v_parametros.id_proveedor::varchar);
            
              
            --Devuelve la respuesta
            return v_resp;

		end;   
      
      /*********************************    
      #TRANSACCION:  'PM_ANTEPRO_IME'
      #DESCRIPCION: retrocede el estado de proveedores
      #AUTOR:		RAC	
      #FECHA:		06-09-2017 12:12:51
      ***********************************/

	elseif(p_transaccion='PM_ANTEPRO_IME')then   
        begin
        
        v_operacion = 'anterior';
        
        IF  pxp.f_existe_parametro(p_tabla , 'estado_destino')  THEN
           v_operacion = v_parametros.estado_destino;
        END IF;
        
      
        
        --obtenermos datos basicos
        select
            pp.id_proveedor,
            pp.id_proceso_wf,
            pp.estado,
            pwf.id_tipo_proceso
        into 
            v_registros_pp
            
        from param.tproveedor  pp
        inner  join wf.tproceso_wf pwf  on  pwf.id_proceso_wf = pp.id_proceso_wf
        where pp.id_proceso_wf  = v_parametros.id_proceso_wf;
        
        
       
        v_id_proceso_wf = v_registros_pp.id_proceso_wf;
        
        IF  v_operacion = 'anterior' THEN
            --------------------------------------------------
            --Retrocede al estado inmediatamente anterior
            -------------------------------------------------
           --recuperaq estado anterior segun Log del WF
              SELECT  
             
                 ps_id_tipo_estado,
                 ps_id_funcionario,
                 ps_id_usuario_reg,
                 ps_id_depto,
                 ps_codigo_estado,
                 ps_id_estado_wf_ant
              into
                 v_id_tipo_estado,
                 v_id_funcionario,
                 v_id_usuario_reg,
                 v_id_depto,
                 v_codigo_estado,
                 v_id_estado_wf_ant 
              FROM wf.f_obtener_estado_ant_log_wf(v_parametros.id_estado_wf);
              
              
             
              
              
        ELSE
           --recupera el estado inicial
           -- recuperamos el estado inicial segun tipo_proceso
             
             SELECT  
               ps_id_tipo_estado,
               ps_codigo_estado
             into
               v_id_tipo_estado,
               v_codigo_estado
             FROM wf.f_obtener_tipo_estado_inicial_del_tipo_proceso(v_registros_pp.id_tipo_proceso);
             
             
             
             --busca en log e estado de wf que identificamos como el inicial
             SELECT 
               ps_id_funcionario,
              ps_id_depto
             into
              v_id_funcionario,
             v_id_depto
               
                
             FROM wf.f_obtener_estado_segun_log_wf(v_id_estado_wf, v_id_tipo_estado);
             
            
        
        
        END IF; 
          
          
          
         --configurar acceso directo para la alarma   
             v_acceso_directo = '';
             v_clase = '';
             v_parametros_ad = '';
             v_tipo_noti = 'notificacion';
             v_titulo  = 'Visto Bueno';
             
           
           IF   v_codigo_estado_siguiente not in('borrador','aprobado','anulado')   THEN
                  v_acceso_directo = '../../../sis_parametros/vista/proveedor/ProveedorVb.php';
                 v_clase = 'ProveedorVb';
                 v_parametros_ad = '{filtro_directo:{campo:"provee.id_proceso_wf",valor:"'||v_id_proceso_wf::varchar||'"}}';
                 v_tipo_noti = 'notificacion';
                 v_titulo  = 'Visto Bueno';
             
           END IF;
             
          
          -- registra nuevo estado
                      
          v_id_estado_actual = wf.f_registra_estado_wf(
              v_id_tipo_estado,                --  id_tipo_estado al que retrocede
              v_id_funcionario,                --  funcionario del estado anterior
              v_parametros.id_estado_wf,       --  estado actual ...
              v_id_proceso_wf,                 --  id del proceso actual
              p_id_usuario,                    -- usuario que registra
              v_parametros._id_usuario_ai,
              v_parametros._nombre_usuario_ai,
              v_id_depto,                       --depto del estado anterior
              '[RETROCESO] '|| v_parametros.obs,
              v_acceso_directo,
              v_clase,
              v_parametros_ad,
              v_tipo_noti,
              v_titulo);
                      
              IF  not param.f_fun_regreso_proveedor_wf(p_id_usuario, 
                                                   v_parametros._id_usuario_ai, 
                                                   v_parametros._nombre_usuario_ai, 
                                                   v_id_estado_actual, 
                                                   v_parametros.id_proceso_wf, 
                                                   v_codigo_estado) THEN
            
               raise exception 'Error al retroceder estado';
            
            END IF;              
                         
                         
         -- si hay mas de un estado disponible  preguntamos al usuario
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
                        
                              
          --Devuelve la respuesta
            return v_resp;
              
        
        end; 
        
    /*********************************    
 	#TRANSACCION:  'PM_SIGESTP_IME'
 	#DESCRIPCION:  cambia al siguiente estado	
 	#AUTOR:		RAC	
 	#FECHA:		06-09-2017 12:12:51
	***********************************/

	elseif(p_transaccion='PM_SIGESTP_IME')then   
        begin
        
         /*   PARAMETROS
         
        $this->setParametro('id_proceso_wf_act','id_proceso_wf_act','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_funcionario_wf','id_funcionario_wf','int4');
        $this->setParametro('id_depto_wf','id_depto_wf','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('json_procesos','json_procesos','text');
        */
        
        --obtenermos datos basicos
          select
              p.id_proceso_wf,
              p.id_estado_wf,
              p.estado
              
             into
              v_id_proceso_wf,
              v_id_estado_wf,
              v_codigo_estado
              
          from param.tproveedor p
          where p.id_proveedor = v_parametros.id_proveedor;
          
          
          -- recupera datos del estado
         
           select 
            ew.id_tipo_estado ,
            te.codigo
           into 
            v_id_tipo_estado,
            v_codigo_estado
          from wf.testado_wf ew
          inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado
          where ew.id_estado_wf = v_parametros.id_estado_wf_act;
        
         
          
           -- obtener datos tipo estado
           select
                 te.codigo
            into
                 v_codigo_estado_siguiente
           from wf.ttipo_estado te
           where te.id_tipo_estado = v_parametros.id_tipo_estado;
                
           IF  pxp.f_existe_parametro(p_tabla,'id_depto_wf') THEN
              v_id_depto = v_parametros.id_depto_wf;
           END IF;
                
           IF  pxp.f_existe_parametro(p_tabla,'obs') THEN
                  v_obs=v_parametros.obs;
           ELSE
                  v_obs='---';
           END IF;
            
           ---------------------------------------
           -- REGISTA EL SIGUIENTE ESTADO DEL WF.
           ---------------------------------------
            
           v_id_estado_actual =  wf.f_registra_estado_wf(  v_parametros.id_tipo_estado, 
                                                           v_parametros.id_funcionario_wf, 
                                                           v_parametros.id_estado_wf_act, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           v_parametros._id_usuario_ai,
                                                           v_parametros._nombre_usuario_ai,
                                                           v_id_depto,
                                                           v_obs);
                                                             
          --------------------------------------
          -- registra los procesos disparados
          --------------------------------------
         
          FOR v_registros_proc in ( select * from json_populate_recordset(null::wf.proceso_disparado_wf, v_parametros.json_procesos::json)) LOOP
    
               -- get cdigo tipo proceso
               select   
                  tp.codigo 
               into 
                  v_codigo_tipo_pro   
               from wf.ttipo_proceso tp 
               where  tp.id_tipo_proceso =  v_registros_proc.id_tipo_proceso_pro;
          
          
              -- disparar creacion de procesos seleccionados
              SELECT
                       ps_id_proceso_wf,
                       ps_id_estado_wf,
                       ps_codigo_estado
                 into
                       v_id_proceso_wf,
                       v_id_estado_wf,
                       v_codigo_estado
              FROM wf.f_registra_proceso_disparado_wf(
                       p_id_usuario,
                       v_parametros._id_usuario_ai,
                       v_parametros._nombre_usuario_ai,
                       v_id_estado_actual, 
                       v_registros_proc.id_funcionario_wf_pro, 
                       v_registros_proc.id_depto_wf_pro,
                       v_registros_proc.obs_pro,
                       v_codigo_tipo_pro,    
                       v_codigo_tipo_pro);
                       
                       
           END LOOP; 
           
           
           
          --------------------------------------------------
          --  ACTUALIZA EL NUEVO ESTADO DEL PRESUPUESTO
          ----------------------------------------------------
               
           
          IF  param.f_fun_inicio_proveedor_wf(p_id_usuario, 
           									v_parametros._id_usuario_ai, 
                                            v_parametros._nombre_usuario_ai, 
                                            v_id_estado_actual, 
                                            v_id_proceso_wf, 
                                            v_codigo_estado_siguiente) THEN
          
                                              
          END IF;
          
         
             
          -- si hay mas de un estado disponible  preguntamos al usuario
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado del proveedor id='||v_parametros.id_proveedor); 
          v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
          
          
          -- Devuelve la respuesta
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
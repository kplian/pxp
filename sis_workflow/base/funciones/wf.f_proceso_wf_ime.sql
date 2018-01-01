--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.f_proceso_wf_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_wf_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tproceso_wf'
 AUTOR: 		 (admin)
 FECHA:	        18-04-2013 09:01:51
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
    v_reg_tipo_estado   	record;
    v_registro_estado_wf_ant  record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_proceso_wf	integer;
    v_id_periodo integer;
    v_id_gestion integer;
    v_codigo_tipo_proceso varchar;
    
    v_num_tramite varchar;
    v_id_estado_wf integer;
    v_codigo_estado  varchar;
    v_registros 	record;
    
    va_id_tipo_estado integer [];
    va_codigo_estado varchar [];
    va_disparador varchar [];
    va_regla varchar [];
    va_prioridad integer [];
    va_id_depto integer [];
    v_filtro  varchar;
    v_consulta varchar;
    
    v_num_estados integer;
    v_num_funcionarios bigint;
    v_num_deptos integer;
    v_fecha_ini date;
    
    
    
    v_id_depto integer;
    v_id_funcionario_estado integer;
    v_id_depto_estado integer;
    v_id_estado_actual  integer;
    
    
     v_id_tipo_estado integer;
     v_id_funcionario integer;
     v_id_usuario_reg integer;
    
   
     v_id_estado_wf_ant integer;
     v_id_tipo_proceso integer;
     v_registro_est_sig  record;
     v_registros_proc  record;
     v_ejec varchar;
     sw_coma  BOOLEAN;
     v_json varchar;
     v_codigo_tipo_pro  varchar;
     
     
     v_procesos_json  json;
     v_id_tabla		integer;
     v_tabla		record;
     v_query		text;
     v_plantilla_correo   varchar;
     v_plantilla_asunto   varchar;
     v_total_registros  integer;
     v_res_validacion	text;
     v_valid_campos		boolean;
     v_documentos		record;
   

BEGIN
	
    v_nombre_funcion = 'wf.f_proceso_wf_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PWF_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	if(p_transaccion='WF_PWF_INS')then
					
        begin
        
        
           
           select per.id_periodo,
                  ges.id_gestion
           into v_id_periodo,
                v_id_gestion
           from param.tperiodo per
                inner join param.tgestion ges on ges.id_gestion = per.id_gestion
           where per.fecha_ini <= v_parametros.fecha_ini and
                 per.fecha_fin >= v_parametros.fecha_ini
           limit 1 offset 0;
           
           
         --  raise exception 'sss %',v_parametros.fecha_ini ;
           
           select 
           tp.codigo
           into
           v_codigo_tipo_proceso
           from wf.ttipo_proceso tp 
           where tp.id_tipo_proceso = v_parametros.id_tipo_proceso;
        
       
            --todo obtener numero de documento
        
        
           -- inciiar el tramite en el sistema de WF
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
                       v_codigo_tipo_proceso, 
                       v_parametros.id_funcionario_usu,
                       NULL,
                       'Inicio de tramite.... ',
                       'NUM CORRE');
        
             
           
          
            
            
            update wf.tproceso_wf set
              id_persona = v_parametros.id_persona,
              id_institucion = v_parametros.id_institucion,
              tipo_ini=v_parametros.tipo_ini
			where id_proceso_wf=v_id_proceso_wf;
        
        			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF almacenado(a) con exito (id_proceso_wf'||v_id_proceso_wf||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_id_proceso_wf::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tproceso_wf set
			
			id_persona = v_parametros.id_persona,
			id_institucion = v_parametros.id_institucion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            tipo_ini=v_parametros.tipo_ini
			where id_proceso_wf=v_parametros.id_proceso_wf;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PWF_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_PWF_ELI')then

		begin
			--Sentencia de la eliminacion
            
           v_id_estado_actual =   wf.f_cancela_proceso_wf (
                                     'anulado',
                                      v_parametros.id_proceso_wf,
                                      p_id_usuario,
                                      'se elimina el proceso'
                                    );
            
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF anulado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'WF_EVAPLA_IME'
 	#DESCRIPCION:	Evalua plantilla de estado para el WF
 	#AUTOR:		rac	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_EVAPLA_IME')then

		begin
			--captura de datos
            --recupera datos del tipo estado siguiente
    
            SELECT 
             te.alerta,
             s.nombre,
             s.codigo,
             s.id_subsistema,
             te.nombre_estado,
             pm.nombre as nombre_proceso_macro,
             te.plantilla_mensaje,
             te.plantilla_mensaje_asunto,
             te.disparador,
             te.cargo_depto,
             te.id_tipo_estado,
             ew.id_estado_anterior,
             ew.obs,
             ew.id_proceso_wf,
             ew.id_usuario_reg
            INTO
             v_registros
            FROM wf.ttipo_estado te
            inner join wf.ttipo_proceso tp on tp.id_tipo_proceso  = te.id_tipo_proceso
            inner join wf.tproceso_macro pm on tp.id_proceso_macro = pm.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema 
            inner join wf.testado_wf ew  on ew.id_tipo_estado = te.id_tipo_estado
            WHERE ew.id_estado_wf =  v_parametros.id_estado_wf;
            
            
            v_plantilla_correo =  wf.f_procesar_plantilla(v_registros.id_usuario_reg, v_registros.id_proceso_wf, v_registros.plantilla_mensaje, v_registros.id_tipo_estado, v_registros.id_estado_anterior, v_registros.obs);
            v_plantilla_asunto =  wf.f_procesar_plantilla(v_registros.id_usuario_reg, v_registros.id_proceso_wf, v_registros.plantilla_mensaje_asunto,v_registros.id_tipo_estado, v_registros.id_estado_anterior, v_registros.obs);
                  
                  
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantilla procesada)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'plantilla_correo',v_plantilla_correo::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'plantilla_asunto',v_plantilla_asunto::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;    
        
         
	
        
     /*********************************    
 	#TRANSACCION:  'WF_VERSIGPRO_IME'
 	#DESCRIPCION:   Verifica los parametros necesarios para tomar la decision sobre el sisguiente estado
 	#AUTOR:		RAC	
 	#FECHA:		23-03-2014 12:12:51
	***********************************/

	elseif(p_transaccion='WF_VERSIGPRO_IME')then   
        begin
        
        --obtenermos datos basicos
          
          select
            pw.id_proceso_wf,
            ew.id_estado_wf,
            te.codigo,
            pw.fecha_ini,
            te.id_tipo_estado,
            te.pedir_obs,
            pw.nro_tramite
          into 
            v_registros
            
          from wf.tproceso_wf pw
          inner join wf.testado_wf ew  on ew.id_proceso_wf = pw.id_proceso_wf and ew.estado_reg = 'activo'
          inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
          where pw.id_proceso_wf =  v_parametros.id_proceso_wf;
          
          v_res_validacion = wf.f_valida_cambio_estado(v_registros.id_estado_wf,NULL,NULL,p_id_usuario);
          raise notice 'v_res_validacion %',v_res_validacion;
          IF  (v_res_validacion IS NOT NULL AND v_res_validacion != '') THEN
          		v_resp = pxp.f_agrega_clave(v_resp,'otro_dato','si');
          	  v_resp = pxp.f_agrega_clave(v_resp,'error_validacion_campos','si');
              v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Es necesario registrar los siguientes campos en el formulario: '|| v_res_validacion);
              return v_resp;
          ELSE
          		v_resp = pxp.f_agrega_clave(v_resp,'otro_dato','si');
          		v_resp = pxp.f_agrega_clave(v_resp,'error_validacion_campos','no');
          END IF;
          
          --validacion de documentos
          
          for v_documentos in (
          		select
                    dwf.id_documento_wf,                    
                    dwf.id_tipo_documento,
                    wf.f_priorizar_documento(v_parametros.id_proceso_wf , p_id_usuario
                         ,dwf.id_tipo_documento,'ASC' ) as priorizacion
                from wf.tdocumento_wf dwf
                inner join wf.tproceso_wf pw on pw.id_proceso_wf = dwf.id_proceso_wf
                where  pw.nro_tramite = COALESCE(v_registros.nro_tramite,'--')) loop
                
                if (v_documentos.priorizacion in (0,9)) then
                	v_resp = pxp.f_agrega_clave(v_resp,'otro_dato','si');
          	  		v_resp = pxp.f_agrega_clave(v_resp,'error_validacion_documentos','si');
              		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Es necesario subir algun(os) documento(s) antes de pasar al siguiente estado');
                    return v_resp;
                end if;
          
          end loop;
          v_resp = pxp.f_agrega_clave(v_resp,'otro_dato','si');
          v_resp = pxp.f_agrega_clave(v_resp,'error_validacion_documentos','no'); 
          
         
        
         ------------------------------------------------------------------------------------------------------- 
         -- Verifica  los posibles estados sigueintes para que desde la interfaz se tome la decision si es necesario
         ------------------------------------------------------------------------------------------------------
          IF  v_parametros.operacion = 'verificar' THEN
          
                  --buscamos siguiente estado correpondiente al proceso del WF
                 
                  ----- variables de retorno------
                  
                  v_num_estados=0;
                  v_num_funcionarios=0;
                  v_num_deptos=0;
                  
                  --------------------------------- 
              
                 SELECT  
                     ps_id_tipo_estado,
                     ps_codigo_estado,
                     ps_disparador,
                     ps_regla,
                     ps_prioridad
                 into
                    va_id_tipo_estado,
                    va_codigo_estado,
                    va_disparador,
                    va_regla,
                    va_prioridad
                
                FROM wf.f_obtener_estado_wf(
                v_registros.id_proceso_wf,
                 NULL,
                 v_registros.id_tipo_estado,
                 'siguiente',
                 p_id_usuario); 
          
                raise notice 'verifica';
                
                v_num_estados= array_length(va_id_tipo_estado, 1);
            
                 --  raise exception 'Estados...  %',v_registros.pedir_obs;
           
              
                                   
                 --verificamos el numero de deptos
                 raise notice 'verificamos el numero de deptos';
                             
                raise notice 'va_id_tipo_estado[1] %', va_id_tipo_estado[1]; 
                                            
                  SELECT 
                  *
                  into
                    v_num_deptos 
                 FROM wf.f_depto_wf_sel(
                     p_id_usuario, 
                     va_id_tipo_estado[1], 
                     v_registros.fecha_ini,
                     v_registros.id_estado_wf,
                     TRUE) AS (total bigint);

                --recupera el depto   
                IF v_num_deptos >= 1 THEN
                  
                  SELECT 
                       id_depto
                         into
                       v_id_depto_estado
                  FROM wf.f_depto_wf_sel(
                       p_id_usuario, 
                       va_id_tipo_estado[1], 
                       v_registros.fecha_ini,
                       v_registros.id_estado_wf,
                       FALSE) 
                       AS (id_depto integer,
                         codigo_depto varchar,
                         nombre_corto_depto varchar,
                         nombre_depto varchar,
                         prioridad integer,
                         subsistema varchar);
               
                END IF;
                -- si solo hay un estado,  verificamos si tiene mas de un funcionario por este estado
                 raise notice ' si solo hay un estado';
                   SELECT 
                   *
                    into
                   v_num_funcionarios 
                   FROM wf.f_funcionario_wf_sel(
                       p_id_usuario, 
                       va_id_tipo_estado[1], 
                       v_registros.fecha_ini,
                       v_registros.id_estado_wf,
                       TRUE,1,0,'0=0', COALESCE(v_id_depto_estado,0)) AS (total bigint);              
                             
                  -- si hay mas de un estado disponible  preguntamos al usuario
                  v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Verificacion para el siguiente estado)'); 
                  v_resp = pxp.f_agrega_clave(v_resp,'estados', array_to_string(va_id_tipo_estado, ','));
                  v_resp = pxp.f_agrega_clave(v_resp,'operacion','preguntar_todo');
                  v_resp = pxp.f_agrega_clave(v_resp,'num_estados',v_num_estados::varchar);
                  v_resp = pxp.f_agrega_clave(v_resp,'num_funcionarios',v_num_funcionarios::varchar);
                  v_resp = pxp.f_agrega_clave(v_resp,'num_deptos',v_num_deptos::varchar);
                  v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_estado',v_id_funcionario_estado::varchar);
                  v_resp = pxp.f_agrega_clave(v_resp,'id_depto_estado',v_id_depto_estado::varchar);
                  v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_estado', va_id_tipo_estado[1]::varchar);
                  
           END IF;
           
          --Devuelve la respuesta
            return v_resp;
        
        end;   
   
     
    /*********************************    
 	#TRANSACCION:  'WF_CHKSTA_IME'
 	#DESCRIPCION:   Este procedimiento verifica los procesos disparados disponibles  y
                    retorna los datos para configurar el la interface wizard de wf (vista)
 	#AUTOR:		RAC	
 	#FECHA:	823-03-2014 12:12:51
	***********************************/

	elseif(p_transaccion='WF_CHKSTA_IME')then   
        begin
        
        
          IF v_parametros.id_proceso_wf is NULL THEN
          
             raise exception 'El Identificador de proceso WF no puede ser nulo';
          
          END IF;
          
          
          
        
         --obtenermos datos basicos del proceso
          
          select
            pw.id_proceso_wf,
            ew.id_estado_wf,
            te.codigo,
            pw.fecha_ini,
            te.id_tipo_estado,
            te.pedir_obs,
            pw.nro_tramite
          into 
            v_registros
            
          from wf.tproceso_wf pw
          inner join wf.testado_wf ew  on ew.id_proceso_wf = pw.id_proceso_wf and ew.estado_reg = 'activo'
          inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
          where pw.id_proceso_wf =  v_parametros.id_proceso_wf;
          
         
         v_json = '[';
         sw_coma = FALSE;  -- el primer elemento no tiene coma
         --obtenemos datos del estado siguiente
         FOR v_registro_est_sig in (
                    select 
                      tp.tipo_disparo,
                      tp.funcion_validacion_wf,
                      tp.nombre,
                      tp.codigo,
                      tp.descripcion,
                      tp.id_tipo_proceso
                   from  wf.ttipo_proceso tp
                   inner join wf.ttipo_estado te on te.id_tipo_estado = tp.id_tipo_estado 
                   where tp.estado_reg = 'activo' and tp.tipo_disparo != 'manual' and   tp.id_tipo_estado   = v_parametros.id_tipo_estado_sig
                   
                  UNION
                 select 
                      po.tipo_disparo,
                      po.funcion_validacion_wf,
                      tp.nombre,
                      tp.codigo,
                      tp.descripcion,
                      tp.id_tipo_proceso
                   from  wf.ttipo_proceso tp
                   inner join wf.ttipo_proceso_origen po on po.id_tipo_proceso = tp.id_tipo_proceso
                   inner join wf.ttipo_estado te on te.id_tipo_estado = po.id_tipo_estado 
                   where tp.estado_reg = 'activo'  and po.tipo_disparo != 'manual'
                         and   po.id_tipo_estado   = v_parametros.id_tipo_estado_sig 
                   
                  ) LOOP
         
         
                 --ejecuta funcion de validacion de procesos disparados
                 IF v_registro_est_sig.funcion_validacion_wf is  NULL or v_registro_est_sig.funcion_validacion_wf = '' THEN
                      v_ejec = 'true';
                 ELSE
                    --TODO  obenter funcion de validacion
                    EXECUTE  'select ' || v_registro_est_sig.funcion_validacion_wf  ||'('||p_id_usuario::varchar||','|| v_parametros.id_proceso_wf::varchar||')' into v_ejec;
                             
		 
                
         
         
                 END IF;
                 
                 
                 IF v_ejec = 'true' THEN
                     IF  sw_coma THEN
                         v_json = v_json ||',';
                     ELSE
                        sw_coma = TRUE;
                     END IF;
                     v_json = v_json ||'{''nombre'':'''|| v_registro_est_sig.nombre||''',''codigo'':'''|| v_registro_est_sig.codigo||''',''id_tipo_proceso'':'|| v_registro_est_sig.id_tipo_proceso||',''tipo_disparo'':'''|| COALESCE(v_registro_est_sig.tipo_disparo,'')||'''}';
                 END IF;
          END LOOP;
          
          v_json=v_json||']';
          
         --raise exception '%',v_json;
         
         -- si hay mas de un estado disponible  preguntamos al usuario
         v_resp = pxp.f_agrega_clave(v_resp,'mensaje','check procesos disparado'); 
         v_resp = pxp.f_agrega_clave(v_resp,'json_procesos',v_json);
           
         --Devuelve la respuesta
         return v_resp;
        
        end;      
        
    
    /*********************************    
 	#TRANSACCION:  'WF_ANTEPRO_IME'
 	#DESCRIPCION:	Trasaacion utilizada  pasar a  estado anterior del proceso
                    segun la operacion definida
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elseif(p_transaccion='WF_ANTEPRO_IME')then   
        begin
        
        --------------------------------------------------
        --REtrocede al estado inmediatamente anterior
        -------------------------------------------------
         IF  v_parametros.operacion = 'cambiar' THEN
               
               raise notice 'es_estaado_wf %',v_parametros.id_estado_wf;
               
               --verificar si existe un tipo_estado_wf anterior
               
               select te.id_tipo_estado_anterior,tea.codigo 
               		into v_id_tipo_estado,v_codigo_estado
               from wf.testado_wf ewf
               inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
               left join wf.ttipo_estado tea on tea.id_tipo_estado = te.id_tipo_estado_anterior
               where ewf.id_estado_wf = v_parametros.id_estado_wf;
               
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
                
         	
              
                      --recupera  estado anterior segun Log del WF
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
                        
                         --
                      select 
                           ew.id_proceso_wf
                        into 
                           v_id_proceso_wf
                      from wf.testado_wf ew
                      where ew.id_estado_wf= v_id_estado_wf_ant;
                
                 
                      
                      -- registra nuevo estado
                      
                      v_id_estado_actual = wf.f_registra_estado_wf(
                          v_id_tipo_estado, 
                          v_id_funcionario, 
                          v_parametros.id_estado_wf, 
                          v_id_proceso_wf, 
                          p_id_usuario,
                          v_parametros._id_usuario_ai,
                          v_parametros._nombre_usuario_ai,
                          v_id_depto,
                          '[RETROCESO] '|| v_parametros.obs); 
                          
                      
                      
                      /*jrr: Actualizar la tabla del proceso si es que existe*/
                       select id_tabla
                       into v_id_tabla
                       from wf.tproceso_wf p
                       inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = p.id_tipo_proceso
                       inner join wf.ttabla ta on tp.id_tipo_proceso = ta.id_tipo_proceso
                       where p.id_proceso_wf =  v_id_proceso_wf and ta.vista_tipo = 'maestro';
                       
                       if ( v_id_tabla is not null ) then
                          select lower(s.codigo) as esquema, t.*
                          into v_tabla
                          from wf.ttabla t 
                          inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
                          inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
                          inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
                          where t.id_tabla = v_id_tabla;
                          
                          v_query = ' update  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '  
                                  set estado = ''' || v_codigo_estado || ''',
                                  id_estado_wf = ' ||  v_id_estado_actual || ',
                                  id_usuario_mod = ' ||  p_id_usuario || ',
                                  fecha_mod=now()
                                  where id_proceso_wf=' || v_id_proceso_wf;
                                                                       
                          execute (v_query);           
                          
                       end if;
                      
                      
                        --RAC si el tipo_estado tiene funcion de retroceso la ejecuta
                        
                        select 
                         te.funcion_regreso
                        into 
                          v_reg_tipo_estado
                        from wf.ttipo_estado te 
                        where te.id_tipo_estado = v_id_tipo_estado;
                        
                        
                      
                        IF  v_reg_tipo_estado.funcion_regreso is not NULL THEN
                        
                         EXECUTE ( 'select ' || v_reg_tipo_estado.funcion_regreso  ||'('||p_id_usuario::varchar||','||COALESCE(v_parametros._id_usuario_ai::varchar,'NULL')||','||COALESCE(''''|| v_parametros._nombre_usuario_ai::varchar||'''','NULL')||','|| v_id_estado_actual::varchar||','|| v_id_proceso_wf::varchar||','||COALESCE(''''||v_codigo_estado||'''','NULL')||')');
                        
                        
                        END IF;
                        
                        -- si hay mas de un estado disponible  preguntamos al usuario
                        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
                        v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
                        
                              
                      --Devuelve la respuesta
                        return v_resp;
                        
           ----------------------------------------------------------------------
           -- PAra retornar al estado borrador de la solicitud de manera directa
           ---------------------------------------------------------------------
           ELSEIF  v_parametros.operacion = 'inicio' THEN
             
             SELECT
              ew.id_estado_wf,
              pw.id_tipo_proceso,
              pw.id_proceso_wf
             into
              v_id_estado_wf,
              v_id_tipo_proceso,
              v_id_proceso_wf
               
             FROM  wf.tproceso_wf pw 
             inner join wf.testado_wf ew on ew.id_proceso_wf  =  pw.id_proceso_wf
             WHERE  pw.id_proceso_wf = v_parametros.id_proceso_wf;
           
           
           
             raise notice 'BUSCAMOS EL INICIO PARA %',v_id_tipo_proceso;
             
            -- recuperamos el estado inicial segun tipo_proceso
             
             SELECT  
               ps_id_tipo_estado,
               ps_codigo_estado
             into
               v_id_tipo_estado,
               v_codigo_estado
             FROM wf.f_obtener_tipo_estado_inicial_del_tipo_proceso(v_id_tipo_proceso);
             
             --recupera el funcionario segun ultimo log borrador
             raise notice 'CODIGO ESTADO BUSCADO %',v_codigo_estado ;
             
             SELECT 
               ps_id_funcionario,
               ps_codigo_estado,
               ps_id_depto 
             into
              v_id_funcionario,
              v_codigo_estado,
              v_id_depto
               
                
             FROM wf.f_obtener_estado_segun_log_wf(v_id_estado_wf, v_id_tipo_estado);
            
              raise exception 'CODIGO ESTADO ENCONTRADO % , %',v_codigo_estado, v_id_depto ;
             
             --registra estado borrador
              v_id_estado_actual = wf.f_registra_estado_wf(
                  v_id_tipo_estado, 
                  v_id_funcionario, 
                  v_parametros.id_estado_wf, 
                  v_id_proceso_wf, 
                  p_id_usuario,
                  v_parametros._id_usuario_ai,
                  v_parametros._nombre_usuario_ai,
                  v_id_depto,
                  v_parametros.obs);
                      
             
              
               -- si hay mas de un estado disponible  preguntamos al usuario
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se regresoa borrador con exito)'); 
                v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
                        
                              
              --Devuelve la respuesta
                return v_resp;
              
           
           
           ELSE
           
           		raise exception 'Operacion no reconocida %',v_parametros.operacion;
           
           END IF;
        
        
        
        end;
    
    /*********************************    
 	#TRANSACCION:  'WF_SESPRO_IME'
 	#DESCRIPCION:	 Cambio de estado en el proceso de WF, controla tambien el inicio de los procesos disparados
 	#AUTOR:		RAC	
 	#FECHA:		07-04-2014 12:12:51
	***********************************/

	elseif(p_transaccion='WF_SESPRO_IME')then   
        begin
        
           /*
                    PARAMETROS:
               v_parametros.id_estado_wf_act      -- id_estado_wf donde estamos parados actualmente
               v_parametros.id_tipo_estado,       --  tipo de estado siguiente 
               v_parametros.id_funcionario_wf, 
               v_parametros.id_proceso_wf_act,     --id de procesowf actual
               v_parametros.id_depto_wf,
               v_parametros.obs,           
               v_parametros.json_procesos           -- procesos disparados
           
           */
        
        --  captura datos basicos del estado actual del proceso WF       
          select 
            ew.estado_reg,
            ew.id_estado_wf,
            te.codigo,
            te.id_tipo_estado,
            te.pedir_obs 
          into 
            v_registro_estado_wf_ant
          FROM wf.testado_wf ew
          inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado 
          WHERE ew.id_estado_wf = v_parametros.id_estado_wf_act;           -- id_estado_wf donde estamos parados actualmente
          
       --  validamos que el estado wf actual este activo
          IF v_registro_estado_wf_ant.estado_reg = 'inactivo' THEN
            raise exception 'Por favor actualice sus datos antes de continuar%',v_parametros.id_estado_wf_act;
          END IF;
          
          
          select
             te.codigo
            into
             v_codigo_estado    
          from wf.ttipo_estado te
          where te.id_tipo_estado = v_parametros.id_tipo_estado;   --p_id_tipo_estado_siguiente
         
         -------------------------------------
         --cambia el estado de proceso actual
         -------------------------------------
        
         -- hay que recuperar el supervidor que seria el estado inmediato,...
         v_id_estado_actual =  wf.f_registra_estado_wf(v_parametros.id_tipo_estado,   --p_id_tipo_estado_siguiente
                                                       v_parametros.id_funcionario_wf, 
                                                       v_registro_estado_wf_ant.id_estado_wf,   --  p_id_estado_wf_anterior
                                                       v_parametros.id_proceso_wf_act,
                                                       p_id_usuario,
                                                       v_parametros._id_usuario_ai,
                                                       v_parametros._nombre_usuario_ai,
                                                       v_parametros.id_depto_wf,
                                                       v_parametros.obs);
         
         /*jrr: Actualizar la tabla del proceso si es que existe*/
         select id_tabla
         into v_id_tabla
         from wf.tproceso_wf p
         inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = p.id_tipo_proceso
         inner join wf.ttabla ta on tp.id_tipo_proceso = ta.id_tipo_proceso
         where p.id_proceso_wf =  v_parametros.id_proceso_wf_act and ta.vista_tipo = 'maestro';
         
         if ( v_id_tabla is not null ) then
         	select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = v_id_tabla;
            
            v_query = ' update  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '  
                    set estado = ''' || v_codigo_estado || ''',
                    id_estado_wf = ' ||  v_id_estado_actual || ',
                    id_usuario_mod = ' ||  p_id_usuario || ',
                    fecha_mod=now()
                    where id_proceso_wf=' || v_parametros.id_proceso_wf_act;
                                                          
            execute (v_query);           
            
         end if;
         
         	
        
         
          --------------------------------------
          -- registra los procesos disparados
          --------------------------------------
          FOR v_registros_proc in ( select * from json_populate_recordset(null::wf.proceso_disparado_wf, v_parametros.json_procesos::json)) LOOP
   
               --get cdigo tipo proceso
               select   
                  tp.codigo 
               into 
                  v_codigo_tipo_pro   
               from wf.ttipo_proceso tp 
                where  tp.id_tipo_proceso =  v_registros_proc.id_tipo_proceso_pro;
          -- raise exception 'llega... %',v_registros_proc;  
         
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
                       v_id_estado_actual::integer, 
                       v_registros_proc.id_funcionario_wf_pro::integer, 
                       v_registros_proc.id_depto_wf_pro::integer,
                       v_registros_proc.obs_pro,
                       v_codigo_tipo_pro,    
                       v_codigo_tipo_pro);
                       
                       
               --TODO ejecutar funcion personalizada para registro de procesos wf
               --caso se quiera uan ejecucion de datos especiales
               --  ejm al dispara obligacione sde pago desde la cotizacion es necesario copiar el detalle de la cotizacion adjudicada        
                     
                      
           END LOOP;
           
           
            --RAC si el tipo_estado tiene funcion de inicial la ejecuta
                        
            select 
             te.funcion_inicial
            into 
              v_reg_tipo_estado
            from wf.ttipo_estado te 
            where te.id_tipo_estado = v_parametros.id_tipo_estado;
            --raise exception 'gonzalo %',v_parametros.id_tipo_estado;          
            IF  v_reg_tipo_estado.funcion_inicial is not NULL THEN
                EXECUTE ( 'select ' || v_reg_tipo_estado.funcion_inicial  ||'('||p_id_usuario::varchar||','||COALESCE(v_parametros._id_usuario_ai::varchar,'NULL')||','||COALESCE(''''|| v_parametros._nombre_usuario_ai::varchar||'''','NULL')||','|| v_id_estado_actual::varchar||','|| v_parametros.id_proceso_wf_act::varchar||','||COALESCE(''''||v_codigo_estado||'''','NULL')||')');
            END IF;
          
           -- si hay mas de un estado disponible  preguntamos al usuario
           v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
           v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
          
          
          --Devuelve la respuesta
            return v_resp;
        
        end;
   
 
    /*********************************    
 	#TRANSACCION:  'WF_SIGPRO_IME'
 	#DESCRIPCION:	funcion que controla el cambio al Siguiente esado del tipo_proceso, valido solo para mobile y estados simple, sin disparon sin varios funcionarios
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elseif(p_transaccion='WF_SIGPRO_IME')then   
        begin
        
             
         
        --validamos que el estado wf actual este activo
        
        select 
          ew.estado_reg,
          ew.id_estado_wf,
          te.codigo,
          te.id_tipo_estado,
          te.pedir_obs 
        into 
          v_registro_estado_wf_ant
        FROM wf.testado_wf ew
        inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado 
        WHERE ew.id_estado_wf = v_parametros.id_estado_wf;
        
        IF v_registro_estado_wf_ant.estado_reg = 'inactivo' THEN
          raise exception 'Por favor actualice sus datos antes de continuar';
        END IF;
        
        --buscamos siguiente estado correpondiente al proceso del WF
             
        ----- variables de retorno------
              
          v_num_estados=0;
          v_num_funcionarios=0;
          v_num_deptos=0;
              
        --------------------------------- 
              
         SELECT  
               ps_id_tipo_estado,
               ps_codigo_estado,
               ps_disparador,
               ps_regla,
               ps_prioridad
         into
              va_id_tipo_estado,
              va_codigo_estado,
              va_disparador,
              va_regla,
              va_prioridad
            
          FROM wf.f_obtener_estado_wf(
          v_parametros.id_proceso_wf, 
          NULL,
          v_registro_estado_wf_ant.id_tipo_estado,
          'siguiente',
          p_id_usuario); 
          
         
            
          v_num_estados= array_length(va_id_tipo_estado, 1);
            
          
           
         IF v_num_estados = 1 then
                     
                    -- si solo hay un estado,  verificamos si tiene mas de un funcionario por este estado
                                  
                                   
                   SELECT 
                   *
                    into
                   v_num_funcionarios 
                   FROM wf.f_funcionario_wf_sel(
                       p_id_usuario, 
                       va_id_tipo_estado[1], 
                       v_fecha_ini,
                       v_registro_estado_wf_ant.id_estado_wf,     --id_estado ef actual que llega desde la interface
                       TRUE) AS (total bigint);
                             
                        
                    IF v_num_funcionarios = 1 THEN
                                    
                      raise notice ' si solo es un funcionario, recuperamos el funcionario correspondiente';
                    -- si solo es un funcionario, recuperamos el funcionario correspondiente
                         SELECT 
                             id_funcionario
                               into
                             v_id_funcionario_estado
                         FROM wf.f_funcionario_wf_sel(
                             p_id_usuario, 
                             va_id_tipo_estado[1], 
                             v_fecha_ini,
                             v_registro_estado_wf_ant.id_estado_wf,
                             FALSE) 
                             AS (id_funcionario integer,
                               desc_funcionario text,
                               desc_funcionario_cargo text,
                               prioridad integer);
                                   
                       
                    ELSIF v_num_funcionarios  > 1 THEN
                                    
                       raise exception 'La version mobile no admite mas de un funcionario';
                                    
                    END IF;    
                             
                      
                      --verificamos el numero de deptos
                       raise notice 'verificamos el numero de deptos';
                       
                      
                   SELECT 
                    *
                   into
                      v_num_deptos 
                   FROM wf.f_depto_wf_sel(
                       p_id_usuario, 
                       va_id_tipo_estado[1], 
                       v_fecha_ini,
                       v_registro_estado_wf_ant.id_estado_wf,
                       TRUE) AS (total bigint);
                                   
                               
                   IF v_num_deptos = 1 THEN
                        -- si solo es un funcionario, recuperamos el funcionario correspondiente
                         raise notice 'si solo es un funcionario, recuperamos el funcionario correspondiente';
                               
                             SELECT 
                                 id_depto
                                   into
                                 v_id_depto_estado
                            FROM wf.f_depto_wf_sel(
                                 p_id_usuario, 
                                 va_id_tipo_estado[1], 
                                 v_fecha_ini,
                                 v_registro_estado_wf_ant.id_estado_wf,
                                 FALSE) 
                                 AS (id_depto integer,
                                   codigo_depto varchar,
                                   nombre_corto_depto varchar,
                                   nombre_depto varchar,
                                   prioridad integer,
                                   subsistema varchar);
                                
                    ELSIF v_num_deptos  > 1 THEN
                                  
                         raise exception 'La version mobile no admite mas de un departamento';
                                
                                
                    END IF;
                  
             
       ELSIF v_num_estados > 1 then
            raise exception 'La version mobile no admite mas de un estado destino';
       ELSE
       
           raise exception 'No se encontro ningun estado siguiente';
       
       END IF;
        
        -- obtener datos tipo estado al que pasamos 
         select
           te.codigo,
           te.funcion_inicial
         into
           v_reg_tipo_estado
        from wf.ttipo_estado te
        where te.id_tipo_estado = va_id_tipo_estado[1];
        
        IF  pxp.f_existe_parametro('p_tabla','id_depto') THEN
               v_id_depto = v_parametros.id_depto;
        END IF;
            
        -- hay que recuperar el supervidor que seria el estado inmediato,...
        v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado[1], 
                                                       v_id_funcionario_estado, 
                                                       v_registro_estado_wf_ant.id_estado_wf,   -- ojo
                                                       v_parametros.id_proceso_wf,
                                                       p_id_usuario,
                                                       v_parametros._id_usuario_ai,
                                                       v_parametros._nombre_usuario_ai,
                                                       v_id_depto_estado,
                                                       v_parametros.obs);
            
        
        /*jrr: Actualizar la tabla del proceso si es que existe*/
         select id_tabla
         into v_id_tabla
         from wf.tproceso_wf p
         inner join wf.ttipo_proceso tp on tp.id_tipo_proceso = p.id_tipo_proceso
         inner join wf.ttabla ta on tp.id_tipo_proceso = ta.id_tipo_proceso
         where p.id_proceso_wf =  v_parametros.id_proceso_wf and ta.vista_tipo = 'maestro';
         
         if ( v_id_tabla is not null ) then
         	select lower(s.codigo) as esquema, t.*
            into v_tabla
            from wf.ttabla t 
            inner join wf.ttipo_proceso tp on t.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
            inner join segu.tsubsistema s on pm.id_subsistema = s.id_subsistema
            where t.id_tabla = v_id_tabla;
            
            v_query = ' update  ' || v_tabla.esquema || '.t' || v_tabla.bd_nombre_tabla || '  
                    set estado = ''' || v_reg_tipo_estado.codigo || ''',
                    id_estado_wf = ' ||  v_id_estado_actual || ',
                    id_usuario_mod = ' ||  p_id_usuario || ',
                    fecha_mod=now()
                    where id_proceso_wf=' || v_parametros.id_proceso_wf;
                                                          
            execute (v_query);           
            
         end if;
        
         --RAC si el tipo_estado tiene funcion de inicial la ejecuta
                       
            IF  v_reg_tipo_estado.funcion_inicial is not NULL THEN
                EXECUTE ( 'select ' || v_reg_tipo_estado.funcion_inicial  ||'('||p_id_usuario::varchar||','||COALESCE(v_parametros._id_usuario_ai::varchar,'NULL')||','||COALESCE(''''|| v_parametros._nombre_usuario_ai::varchar||'''','NULL')||','|| v_id_estado_actual::varchar||','|| v_parametros.id_proceso_wf::varchar||','||COALESCE(''''||v_reg_tipo_estado.codigo||'''','NULL')||')');
            END IF;
        
          -- si hay mas de un estado disponible  preguntamos al usuario
         v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
         v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
         --Devuelve la respuesta
          return v_resp;
        
      end;
      
       
    /*********************************    
 	#TRANSACCION:  'WF_CHECKVB_IME'
 	#DESCRIPCION:	Chequea si existen nuevos registros desde la ultima consulta, se usa en la interface mobile para lanzar alertas sonora
 	#AUTOR:		rac	
 	#FECHA:		18-04-2013 09:01:51
	***********************************/

	elsif(p_transaccion='WF_CHECKVB_IME')then

		begin
        
              select  
                   pxp.aggarray(depu.id_depto)
               into 
                     va_id_depto
              from param.tdepto_usuario depu 
              where depu.id_usuario =  p_id_usuario; 
              
             v_filtro='';
              
            --interface para visto de procesos simple, generalemte usado en mobile
            
            IF p_administrador !=1 THEN
                    v_filtro = 'lower(te.mobile)=''si''  and (ew.id_funcionario='||v_parametros.id_funcionario_usu::varchar||'   or  (ew.id_depto  in ('|| COALESCE(array_to_string(va_id_depto,','),'0')||')))  ';
            ELSE
                     v_filtro = ' lower(te.mobile)=''si''  ';
                    --v_filtro = '0=0 and ';
            END IF;
            
            if v_parametros.fecha_pivote is not null THEN
                   
                 --Sentencia de la consulta de conteo de registros
                 v_consulta:='select count(pwf.id_proceso_wf) as total_registros
                              from wf.tproceso_wf pwf
                                 inner join wf.ttipo_proceso tp on pwf.id_tipo_proceso = tp.id_tipo_proceso
                                 inner join wf.testado_wf ew on ew.id_proceso_wf = pwf.id_proceso_wf and  ew.estado_reg = ''activo''
                                 inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
                              where  ew.fecha_reg > '''||v_parametros.fecha_pivote ||''' and    '||v_filtro;
      			
                  --raise exception 'llega %',v_parametros.fecha_pivote;
                  
                  execute v_consulta into v_total_registros;
             ELSE
               v_total_registros = 0 ;
             END If; 

              -- agregamos variable  de retorno que llegan hasta la interface
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Chequeo de estados)'); 
             v_resp = pxp.f_agrega_clave(v_resp,'total_registros',v_total_registros::varchar); 
             v_resp = pxp.f_agrega_clave(v_resp,'fecha_pivote',to_char(now(), 'DD/MM/YY HH24:mi:ss')); 
              
              
              
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
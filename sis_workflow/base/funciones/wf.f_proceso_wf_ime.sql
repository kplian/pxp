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
           
           
           select 
           tp.codigo
           into
           v_codigo_tipo_proceso
           from wf.ttipo_proceso tp 
           where tp.id_tipo_proceso = v_parametros.id_tipo_proceso;
        
        
        
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
                       v_id_gestion, 
                       v_codigo_tipo_proceso, 
                       v_parametros.id_funcionario_usu);
        
        
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
			delete from wf.tproceso_wf
            where id_proceso_wf=v_parametros.id_proceso_wf;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PROCESO WF eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_wf',v_parametros.id_proceso_wf::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	/*********************************    
 	#TRANSACCION:  'WF_SIGPRO_IME'
 	#DESCRIPCION:	funcion que controla el cambio al Siguiente esado del tipo_proceso
 	#AUTOR:		RAC	
 	#FECHA:		19-02-2013 12:12:51
	***********************************/

	elseif(p_transaccion='WF_SIGPRO_IME')then   
        begin
        
        --obtenermos datos basicos
          
          select
            pw.id_proceso_wf,
            ew.id_estado_wf,
            te.codigo,
            pw.fecha_ini,
            te.id_tipo_estado,
            te.pedir_obs
          into 
            v_registros
            
          from wf.tproceso_wf pw
          inner join wf.testado_wf ew  on ew.id_proceso_wf = pw.id_proceso_wf and ew.estado_reg = 'activo'
          inner join wf.ttipo_estado te on ew.id_tipo_estado = te.id_tipo_estado
          where pw.id_proceso_wf =  v_parametros.id_proceso_wf;
          
         
        
         --------------------------------------------- 
         -- Verifica  los posibles estados sigueintes para que desde la interfaz se tome la decision si es necesario
         --------------------------------------------------
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
            
            FROM wf.f_obtener_estado_wf(v_registros.id_proceso_wf, NULL,v_registros.id_tipo_estado,'siguiente'); 
          
            raise notice 'verifica';
            
            v_num_estados= array_length(va_id_tipo_estado, 1);
            
          --  raise exception 'Estados...  %',v_registros.pedir_obs;
           
          IF v_registros.pedir_obs = 'no' THEN
            
                      
                IF v_num_estados = 1 then
                      -- si solo hay un estado,  verificamos si tiene mas de un funcionario por este estado
                       raise notice ' si solo hay un estado';
                         SELECT 
                         *
                          into
                         v_num_funcionarios 
                         FROM wf.f_funcionario_wf_sel(
                             p_id_usuario, 
                             va_id_tipo_estado[1], 
                             v_fecha_ini,
                             v_registros.id_estado_wf,
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
                                 v_registros.id_estado_wf,
                                 FALSE) 
                                 AS (id_funcionario integer,
                                   desc_funcionario text,
                                   desc_funcionario_cargo text,
                                   prioridad integer);
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
                           v_registros.id_estado_wf,
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
                                   v_registros.id_estado_wf,
                                   FALSE) 
                                   AS (id_depto integer,
                                     codigo_depto varchar,
                                     nombre_corto_depto varchar,
                                     nombre_depto varchar,
                                     prioridad integer);
                      END IF;
                  
                END IF;
            
             
             END IF;
             raise notice 'si hay mas de un estado disponible  preguntamos al usuario';
             
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
            
            
           ----------------------------------------
           --Se se solicita cambiar de estado a la solicitud
           ------------------------------------------
           ELSEIF  v_parametros.operacion = 'cambiar' THEN
          		
           		 -- obtener datos tipo estado
                
                select
                 te.codigo
                into
                 v_codigo_estado
                from wf.ttipo_estado te
                where te.id_tipo_estado = v_parametros.id_tipo_estado;
                
                IF  pxp.f_existe_parametro('p_tabla','id_depto') THEN
                 
                 v_id_depto = v_parametros.id_depto;
            
            END IF;
            
           
            
            -- hay que recuperar el supervidor que seria el estado inmediato,...
             v_id_estado_actual =  wf.f_registra_estado_wf(v_parametros.id_tipo_estado, 
                                                           v_parametros.id_funcionario, 
                                                           v_registros.id_estado_wf, 
                                                           v_registros.id_proceso_wf,
                                                           p_id_usuario,
                                                           v_id_depto,
                                                           v_parametros.obs);
            
           -- si hay mas de un estado disponible  preguntamos al usuario
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se realizo el cambio de estado)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'operacion','cambio_exitoso');
          
          
          END IF;

        
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
                          v_id_depto);
                      
                    
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
            
              raise notice 'CODIGO ESTADO ENCONTRADO %',v_codigo_estado ;
             
             --registra estado borrador
              v_id_estado_actual = wf.f_registra_estado_wf(
                  v_id_tipo_estado, 
                  v_id_funcionario, 
                  v_parametros.id_estado_wf, 
                  v_id_proceso_wf, 
                  p_id_usuario,
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
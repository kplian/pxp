--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_alarma_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_alarma_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.talarma'
 AUTOR: 		 (fprudencio)
 FECHA:	        18-11-2011 11:59:10
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
	v_id_alarma	integer;  
    v_registros_config		record;
    v_registros_detalle		record;
    v_registros				record;
    
    v_dif_dias				integer;
    v_id_funcionario		integer;
    v_id_subsistema			integer;
    v_consulta_config	    text;
    v_consulta_detalle		text;
    --Ids que se necesitan para  SAJ
    v_id_rpc				integer;
    v_id_sup    			integer;
    v_id_rep_legal			integer; 
    v_id_sup_boleta			integer;
    va_mensajes				varchar[];
    va_id_alarmas			varchar[];
    v_i						integer;
    v_fecha_acuse			timestamp;
    v_modificado 			varchar;
    v_cont					integer;
    v_uos_repote			varchar;
    va_id_uos_rep			varchar[];
    va_id_funcionarios		integer[];
    v_cont2					integer;
    v_cont3					integer;
    v_param_comunicado		varchar;
    v_id_usuario			integer;
BEGIN           

    v_nombre_funcion = 'param.ft_alarma_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ALARM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	if(p_transaccion='PM_ALARM_INS')then
					
        begin
        	
            --Sentencia de la insercion
        	insert into param.talarma(
              titulo,
              titulo_correo,
              fecha,
              estado_reg,
              descripcion,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod,
              id_uos,
              tipo,
              estado_comunicado
          	) values(
              v_parametros.titulo,
              v_parametros.titulo_correo,
              now()::Date,
              'activo',
              v_parametros.descripcion,
              p_id_usuario,
              now()::date,
              null,
              null,
              string_to_array(v_parametros.id_uos,',')::integer[],
              'comunicado',
              'borrador'
			)RETURNING id_alarma into v_id_alarma;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarmas almacenado(a) con exito (id_alarma'||v_id_alarma||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_id_alarma::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_ALARM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_ALARM_MOD')then

		begin
			--Sentencia de la modificacion
			update param.talarma set
                titulo =  v_parametros.titulo,
                titulo_correo =  v_parametros.titulo_correo,
                descripcion = v_parametros.descripcion,
                id_uos = string_to_array(v_parametros.id_uos,',')::integer[],
                id_usuario_mod = p_id_usuario,
                fecha_mod = now()
			where id_alarma=v_parametros.id_alarma;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarmas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_parametros.id_alarma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;


	/*********************************    
 	#TRANSACCION:  'PM_DESCCOR_MOD'
 	#DESCRIPCION:	Desactiva el envio de correo
 	#AUTOR:		rarteaga	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_DESCCOR_MOD')then

		begin
			
             
        
             va_mensajes =  string_to_array(v_parametros.errores_msg, '###+###');
            
             --raise exception 'va_mensajes %',va_mensajes;
             --primero marcamos los errores
             
             FOR v_i IN 1 .. COALESCE(array_length(va_mensajes, 1),0) LOOP
                   va_id_alarmas =  string_to_array(va_mensajes[v_i], '<oo#oo>');
                   
                   update param.talarma set 
                     estado_envio = 'falla',
                     desc_falla = va_id_alarmas[2]
                   where id_alarma = va_id_alarmas[1]::integer;
                  
              
              END LOOP;
            
             -- modifica al estado enviado a todos los ceorreos sin falla
             
             update param.talarma set 
                sw_correo = 1,
                pendiente = 'no'
             where sw_correo = 0 and estado_envio = 'exito' and pendiente = v_parametros.pendiente;
             
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Desactiva envio de correo para alarmas'); 
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_RECVORR_MOD'
 	#DESCRIPCION:	marca el correo para reenviar
 	#AUTOR:		rarteaga	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_RECVORR_MOD')then

		begin
			
             
              update param.talarma set 
               estado_envio = 'exito',
               sw_correo = 0,
               id_usuario_mod = p_id_usuario,
               fecha_mod = now()
             where id_alarma =v_parametros.id_alarma;
                  
              
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','cambiar alamar para reenviar el correo'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_parametros.id_alarma::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
     /*********************************    
 	#TRANSACCION:  'PM_CAMDESTINO_MOD'
 	#DESCRIPCION:	Cambiar el destino del correo
 	#AUTOR:		rarteaga	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_CAMDESTINO_MOD')then

		begin
			
             
              update param.talarma set 
               correos = v_parametros.correos,
               estado_envio = 'exito',
               sw_correo = 0,
               id_usuario_mod = p_id_usuario,
               fecha_mod = now()
             where id_alarma =v_parametros.id_alarma;
                  
              
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarmas modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_parametros.id_alarma::varchar);
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
        
	/*********************************    
 	#TRANSACCION:  'PM_ALARM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		fprudencio	
 	#FECHA:		18-11-2011 11:59:10
	***********************************/

	elsif(p_transaccion='PM_ALARM_ELI')then

		begin
			
            --elima las alrmas dependientes
			delete from param.talarma
            where id_alarma_fk = v_parametros.id_alarma;
            
            
            --elimina la alrma
			delete from param.talarma
            where id_alarma=v_parametros.id_alarma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarma eliminada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_parametros.id_alarma::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    
    /*********************************    
 	#TRANSACCION:  'PM_CONACUSE_MOD'
 	#DESCRIPCION:	confirma el acuse de recibo para la alerta indicada
 	#AUTOR:		rarteaga	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_CONACUSE_MOD')then

		begin
             
        
             select  
               ala.id_alarma,
               pc.mensaje_acuse,
               ala.recibido,
               ala.fecha_recibido
            into
              v_registros   
  			from param.talarma ala 
            inner join wf.tplantilla_correo pc on pc.id_plantilla_correo = ala.id_plantilla_correo  
  			where    md5('llave'||id_alarma::text)  =   v_parametros.alarma;
         
            IF v_registros.recibido = '--'  or v_registros.recibido = 'no' THEN
            
            
                v_fecha_acuse = now();
                update param.talarma a set 
                 recibido = 'si',
                 fecha_recibido = v_fecha_acuse
               where id_alarma = v_registros.id_alarma;
               
               v_modificado = 'si';
             
             
            ELSE
                v_modificado = 'no';
                v_fecha_acuse = v_registros.fecha_recibido;
            END IF;      
              
			--Definicion de la respuesta
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','cambiar alamar para reenviar el correo'); 
             v_resp = pxp.f_agrega_clave(v_resp,'alarma',v_parametros.alarma);
             v_resp = pxp.f_agrega_clave(v_resp,'modificado',v_modificado);
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje_acuse',v_registros.mensaje_acuse);
             v_resp = pxp.f_agrega_clave(v_resp,'fecha_acuse',v_fecha_acuse::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;    
    
     /*********************************    
 	#TRANSACCION:  'PM_GENDETCOM_MOD'
 	#DESCRIPCION:	generar el detalle de comunicados y cambio de estado
 	#AUTOR:		rarteaga	
 	#FECHA:		29-04-2015 11:59:10
	***********************************/

	elsif(p_transaccion='PM_GENDETCOM_MOD')then

		begin
        
            --variable global para comunicados por usuario o por funcionario
             v_param_comunicado = pxp.f_get_variable_global('param_comunicado');
             
            -- recupera datos de origen
            
            select 
              a.id_alarma,
              a.id_uos,
              a.descripcion,
              a.titulo,
              a.titulo_correo,
              a.estado_comunicado
            into
              v_registros
            from param.talarma a
            where a.id_alarma = v_parametros.id_alarma;
           
        
            IF v_registros.estado_comunicado != 'borrador' THEN
               raise exception 'el comunicado ya fue inicado para entrega';
            END IF;
        
           IF  v_registros.id_uos is not null THEN
           --recorre las gerencias que se tienen que reportar
             FOR v_cont IN 1..array_length(v_registros.id_uos, 1 ) LOOP
             
                  -- recupera las uo de la gerencia
                  v_uos_repote =  orga.f_get_uos_x_gerencia(v_registros.id_uos[v_cont]); 
                   
                  --conviere en array
                  va_id_uos_rep = string_to_array(v_uos_repote::text,',');
                  
                 
                  IF  va_id_uos_rep is not null THEN
                    -- FOR recorre  las UO de la gerencia 
                          FOR v_cont2 IN 1..array_length(va_id_uos_rep, 1 ) LOOP
                          
                          
                         
                                -- busca los funcionarios de la UO
                                va_id_funcionarios = orga.f_obtener_funcionarios_x_uo_array(va_id_uos_rep[v_cont2]::integer, now()::Date);
                                
                                
                                IF  va_id_funcionarios is not null THEN
                                    --FOR  recorre los funcionario de la UO
                                    FOR v_cont3 IN 1..array_length(va_id_funcionarios, 1 ) LOOP
                                     
                                     
                                     
                                     
                                            v_id_usuario = NULL;
                                            v_id_funcionario = NULL;
                                             
                                            IF v_param_comunicado = 'usuario' THEN
                                               -- buscar el usuario del funcionario, ...
                                               
                                               --  bajo premisa de que 
                                               --  un funcionario solo puede tener un usuario
                                               select 
                                                 u.id_usuario
                                               into
                                                 v_id_usuario
                                               from orga.tfuncionario f
                                               inner join segu.tusuario u on u.id_persona = f.id_persona
                                               where f.id_funcionario = va_id_funcionarios[v_cont3];
                                               
                                               
                                               v_id_usuario = NULL;
                                               v_id_funcionario = va_id_funcionarios[v_cont3];
                                            ELSE
                                               v_id_usuario = NULL;
                                               v_id_funcionario = va_id_funcionarios[v_cont3];
                                            END IF;
                                            
                                           
                                     
                                           --si tenemos un usuario o un funcionario
                                          IF   v_id_usuario is not null  OR   v_id_funcionario is not null THEN
                                          
                                          
                                      
                                          
                                                -- inserta  la alarma para el funcionario encontrado
                                                insert into param.talarma(
                                                                        titulo,
                                                                        titulo_correo,
                                                                        id_funcionario,
                                                                        id_usuario,
                                                                        fecha,
                                                                        estado_reg,
                                                                        descripcion,
                                                                        id_usuario_reg,
                                                                        fecha_reg,
                                                                        tipo,
                                                                        id_alarma_fk,
                                                                        estado_comunicado
                                                                      ) values(
                                                                        v_registros.titulo,
                                                                        v_registros.titulo_correo,
                                                                        v_id_funcionario,
                                                                        v_id_usuario,
                                                                        now()::Date,
                                                                        'activo',
                                                                        v_registros.descripcion,
                                                                        p_id_usuario,
                                                                        now()::date,
                                                                        'comunicado',
                                                                        v_registros.id_alarma,
                                                                        'enviado'
                                                                    )RETURNING id_alarma into v_id_alarma;
                                             END IF;
                                     END LOOP;
                                END IF;
                           END LOOP;
                     END IF;
                END LOOP;
            END IF;
            
            update param.talarma a set
               estado_comunicado = 'enviado'
            where a.id_alarma = v_parametros.id_alarma;
           
           
            
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','registro detallado del comunicado id: ' || v_parametros.id_alarma); 
            v_resp = pxp.f_agrega_clave(v_resp,'alarma',v_parametros.id_alarma::varchar);
               
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
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
			acceso_directo,
			id_funcionario,
			fecha,
			estado_reg,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.acceso_directo,
			v_parametros.id_funcionario,
			v_parametros.fecha,
			'activo',
			v_parametros.descripcion,
			p_id_usuario,
			now()::date,
			null,
			null
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
			acceso_directo = v_parametros.acceso_directo,
			id_funcionario = v_parametros.id_funcionario,
			fecha = v_parametros.fecha,
			descripcion = v_parametros.descripcion,
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
                sw_correo = 1
             where sw_correo = 0 and estado_envio = 'exito';
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
			
             
             
             select
               ala.id_proceso_wf,
               ala.id_estado_wf,
               pc.funcion_creacion_correo
             into
               v_registros
             from param.talarma ala
             inner join wf.tplantilla_correo pc on pc.id_plantilla_correo = ala.id_plantilla_correo
             where ala.id_alarma = v_parametros.id_alarma;
             
              update param.talarma set 
               estado_envio = 'exito',
               sw_correo = 0,
               id_usuario_mod = p_id_usuario,
               fecha_mod = now()
             where id_alarma =v_parametros.id_alarma;
              
             
             --si teiene funcion de acuse parametrizada la ejecuta            
             IF  v_registros.funcion_creacion_correo is not NULL THEN
                   EXECUTE ( 'select ' || v_registros.funcion_creacion_correo  ||'('||v_parametros.id_alarma::varchar||','||COALESCE(v_registros.id_proceso_wf::varchar,'NULL')||','||COALESCE(v_registros.id_estado_wf::varchar,'NULL')||')');
             END IF;
                  
              
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
			  select
               ala.id_proceso_wf,
               ala.id_estado_wf,
               pc.funcion_creacion_correo
             into
               v_registros
             from param.talarma ala
             inner join wf.tplantilla_correo pc on pc.id_plantilla_correo = ala.id_plantilla_correo
             where ala.id_alarma = v_parametros.id_alarma;
             
              update param.talarma set 
               correos = v_parametros.correos,
               estado_envio = 'exito',
               sw_correo = 0,
               id_usuario_mod = p_id_usuario,
               fecha_mod = now()
             where id_alarma =v_parametros.id_alarma;
              
             
             --si teiene funcion de acuse parametrizada la ejecuta            
             IF  v_registros.funcion_creacion_correo is not NULL THEN
                   EXECUTE ( 'select ' || v_registros.funcion_creacion_correo  ||'('||v_parametros.id_alarma::varchar||','||COALESCE(v_registros.id_proceso_wf::varchar,'NULL')||','||COALESCE(v_registros.id_estado_wf::varchar,'NULL')||')');
             END IF;  
              
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
			--Sentencia de la eliminacion
			delete from param.talarma
            where id_alarma=v_parametros.id_alarma;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Alarmas eliminado(a)'); 
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
               ala.fecha_recibido,
               pc.funcion_acuse_recibo,
               ala.id_proceso_wf,
               ala.id_estado_wf
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
            
            
            --si teiene funcion de acuse parametrizada la ejecuta
            
            IF  v_registros.funcion_acuse_recibo is not NULL THEN
                 EXECUTE ( 'select ' || v_registros.funcion_acuse_recibo  ||'('||v_registros.id_alarma::varchar||','||COALESCE(v_registros.id_proceso_wf::varchar,'NULL')||','||COALESCE(v_registros.id_estado_wf::varchar,'NULL')||')');
           
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
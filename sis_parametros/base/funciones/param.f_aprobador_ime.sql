--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_aprobador_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_aprobador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.taprobador'
 AUTOR: 		 (admin)
 FECHA:	        09-01-2013 21:58:35
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
	v_id_aprobador	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_aprobador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_APRO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-01-2013 21:58:35
	***********************************/

	if(p_transaccion='PM_APRO_INS')then
					
        begin
        
           
          IF v_parametros.fecha_fin is not null THEN
          
             IF v_parametros.fecha_fin < v_parametros.fecha_ini THEN
             
               raise exception 'La fecha de finalización no puede ser anterior a la fecha de inicio';
               
             END IF;
          
          END IF;
          
          
           IF v_parametros.monto_max is not null THEN
          
             IF v_parametros.monto_max < v_parametros.monto_min THEN
             
               raise exception 'El monto maximo no puede ser menor al monto mínimo';
               
             END IF;
          
          END IF;
          
          
          
          
          IF v_parametros.id_uo_cargo is null and v_parametros.id_funcionario is null THEN
           
              raise exception  'Tiene que especificar almenos un cargo o un funcionario';
          
          END IF;
        
        	--Sentencia de la insercion
        	insert into param.taprobador(
			estado_reg,
			id_centro_costo,
			monto_min,
			id_funcionario,
			obs,
			id_uo,
			fecha_ini,
			monto_max,
			fecha_fin,
			id_subsistema,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            id_ep,
            id_uo_cargo,
            id_proceso_macro
          	) values(
			'activo',
			v_parametros.id_centro_costo,
			v_parametros.monto_min,
			v_parametros.id_funcionario,
			v_parametros.obs,
			v_parametros.id_uo,
			v_parametros.fecha_ini,
			v_parametros.monto_max,
			v_parametros.fecha_fin,
			v_parametros.id_subsistema,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.id_ep,
            v_parametros.id_uo_cargo,
            v_parametros.id_proceso_macro
							
			)RETURNING id_aprobador into v_id_aprobador;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Aprobador almacenado(a) con exito (id_aprobador'||v_id_aprobador||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_aprobador',v_id_aprobador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_APRO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-01-2013 21:58:35
	***********************************/

	elsif(p_transaccion='PM_APRO_MOD')then

		begin
          IF v_parametros.fecha_fin is not null THEN
          
             IF v_parametros.fecha_fin < v_parametros.fecha_ini THEN
             
               raise exception 'La fecha de finalizacion no puede ser anterior a la fecha de inicio';
               
             END IF;
          
          END IF;
          
           IF v_parametros.monto_max is not null THEN
          
             IF v_parametros.monto_max < v_parametros.monto_min THEN
             
               raise exception 'El monto maximo no puede ser menor al monto mínimo';
               
             END IF;
          
          END IF;
          
          IF v_parametros.id_uo_cargo is null and v_parametros.id_funcionario is null THEN
           
              raise exception  'Tiene que especificar almenos un cargo o un funcionario';
          
          END IF;
        
        
			--Sentencia de la modificacion
			update param.taprobador set
			id_centro_costo = v_parametros.id_centro_costo,
			monto_min = v_parametros.monto_min,
			id_funcionario = v_parametros.id_funcionario,
			obs = v_parametros.obs,
			id_uo = v_parametros.id_uo,
			fecha_ini = v_parametros.fecha_ini,
			monto_max = v_parametros.monto_max,
			fecha_fin = v_parametros.fecha_fin,
			id_subsistema = v_parametros.id_subsistema,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            id_ep = v_parametros.id_ep,
            id_uo_cargo= v_parametros.id_uo_cargo,
            id_proceso_macro=v_parametros.id_proceso_macro
			where id_aprobador=v_parametros.id_aprobador;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Aprobador modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_aprobador',v_parametros.id_aprobador::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_APRO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		09-01-2013 21:58:35
	***********************************/

	elsif(p_transaccion='PM_APRO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.taprobador
            where id_aprobador=v_parametros.id_aprobador;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Aprobador eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_aprobador',v_parametros.id_aprobador::varchar);
              
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
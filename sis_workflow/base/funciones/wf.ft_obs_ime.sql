CREATE OR REPLACE FUNCTION wf.ft_obs_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_obs_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tobs'
 AUTOR: 		 (admin)
 FECHA:	        20-11-2014 18:53:55
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
    v_registros				record;
    v_registros_fun			record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_obs				integer;
    v_id_alarma   		 	integer;
    v_descripcion    		text;
    v_desc_persona			varchar;
    			    
BEGIN

    v_nombre_funcion = 'wf.ft_obs_ime';
    v_parametros = pxp.f_get_record(p_tabla);
    

	/*********************************    
 	#TRANSACCION:  'WF_OBS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	if(p_transaccion='WF_OBS_INS')then
					
        begin
        	-- datos del estado
            select 
              pwf.nro_tramite
            into
              v_registros
            from wf.testado_wf ewf
            inner join wf.tproceso_wf pwf 
              on pwf.id_proceso_wf = ewf.id_proceso_wf
            where ewf.id_estado_wf = v_parametros.id_estado_wf;
           
            --recupera datos del funcionario
            select 
             fun.desc_funcionario1,
             fun.id_persona
            into
              v_registros_fun
            from orga.vfuncionario_persona  fun
            where  fun.id_funcionario = v_parametros.id_funcionario_resp;
            
            
            
             -- Sentencia de la insercion
        	
            insert into wf.tobs(
              estado_reg,
              estado,
              descripcion,
              id_funcionario_resp,
              titulo,
              usuario_ai,
              fecha_reg,
              id_usuario_reg,
              id_usuario_ai,
              id_usuario_mod,
              fecha_mod,
              id_estado_wf,
              num_tramite
          	) 
            values(
			  'activo',
              'abierto',
              v_parametros.descripcion,
              v_parametros.id_funcionario_resp,
              v_parametros.titulo,
              v_parametros._nombre_usuario_ai,
              now(),
              p_id_usuario,
              v_parametros._id_usuario_ai,
              null,
              null,
              v_parametros.id_estado_wf,
              v_registros.nro_tramite
			)RETURNING id_obs into v_id_obs;
            
            -- TODO, insertar alarma  para el funcionario responsable
            
            v_descripcion =  'Estimado, '|| v_registros_fun.desc_funcionario1||'<br>'||'tiene una observación para el trámite #'||v_registros.nro_tramite||'<br>con las siguiente descripción:<br><b>'||  v_parametros.descripcion ||'</b><br> (Tiene que resolver o hacer resolver la observación para continuar con el trámite)';
            
            select u.desc_persona into v_desc_persona
            from segu.vusuario u
            where id_usuario  = p_id_usuario;
            
            v_id_alarma :=  param.f_inserta_alarma(
                                                  v_parametros.id_funcionario_resp,
                                                  v_descripcion,    --descripcion alarmce
                                                  '../../../sis_workflow/vista/obs/ObsFuncionario.php',--acceso directo
                                                  now()::date,
                                                  'notificacion',
                                                  '',   -->
                                                  p_id_usuario,
                                                  'ObsFuncionario',
                                                  v_desc_persona,--titulo
                                                  '{filtro_directo:{campo:"id_obs",valor:"'||v_id_obs::varchar||'"}}',
                                                  NULL::integer,
                                                  'Observacion #'||v_registros.nro_tramite
                                                     );
            
                
            
            update wf.tobs set
              id_alarma = v_id_alarma
			where id_obs=v_id_obs;
            
            --marca el proceso como observado
            
            --obtiene el proceso inicial
            
            --marca el proceso inicial como observado
            
           
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones almacenado(a) con exito (id_obs'||v_id_obs||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_id_obs::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_OBS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBS_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tobs set
              descripcion = v_parametros.descripcion,
              id_funcionario_resp = v_parametros.id_funcionario_resp,
              titulo = v_parametros.titulo,
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai
			where id_obs=v_parametros.id_obs;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_parametros.id_obs::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
    
    /*********************************    
 	#TRANSACCION:  'WF_CERRAROBS_MOD'
 	#DESCRIPCION:	Cerrar obligaciones de pago
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_CERRAROBS_MOD')then

		begin
			
            select 
             o.estado,
             o.fecha_reg,
             o.descripcion,
             o.id_usuario_ai,
             o.id_usuario_reg,
             o.id_alarma
            into
             v_registros
            from wf.tobs o
            where o.id_obs=v_parametros.id_obs;
            
            if v_registros.estado = 'cerrado' then
              raise exception 'La observación se encuentra cerrada';
            end if;
            
            --si el usuario no es administrador validamos que el usuario que creo la observacion sea el usuario que cierre
            if p_administrador != 1 then
               if v_registros.id_usuario_reg != p_id_usuario then
                  raise exception 'Solo el usuario que creo la observación o un administrador de sistema pueden cerrar '; 
               end if;
            end if;
            
            
            --elimina alarma relacionada
             delete from param.talarma a where a.id_alarma = v_registros.id_alarma; 
           
            
            --Sentencia de la modificacion
			update wf.tobs  set
              estado = 'cerrado',
              fecha_fin = now(),
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai
			where id_obs=v_parametros.id_obs;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','La observacion fue cerrada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_parametros.id_obs::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;


	/*********************************    
 	#TRANSACCION:  'WF_OBS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-11-2014 18:53:55
	***********************************/

	elsif(p_transaccion='WF_OBS_ELI')then

		begin
        
        
            select 
             o.estado,
             o.fecha_reg,
             o.descripcion,
             o.id_usuario_ai,
             o.id_usuario_reg,
             o.id_alarma
            into
             v_registros
            from wf.tobs o
            where o.id_obs=v_parametros.id_obs;
            
             --si el usuario no es administrador validamos que el usuario que creo la observacion sea el usuario que cierre
             if p_administrador != 1 then
               if v_registros.id_usuario_reg != p_id_usuario then
                  raise exception 'Solo el usuario que creo la observación o un administrador de sistema pueden eliminar '; 
               end if;
             end if;
            
            
            --elimina alarma relacionada
             delete from param.talarma a where a.id_alarma = v_registros.id_alarma; 
           
            --Sentencia de la modificacion
			update wf.tobs  set
              estado_reg = 'inactivo',
              id_usuario_ai = v_parametros._id_usuario_ai,
              usuario_ai = v_parametros._nombre_usuario_ai
			where id_obs=v_parametros.id_obs;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Observaciones eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_obs',v_parametros.id_obs::varchar);
              
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
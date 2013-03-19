--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_periodo_subsistema_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_periodo_subsistema_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tperiodo_subsistema'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2013 13:58:30
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
	v_id_periodo_subsistema	integer;
    g_registros				record;
    v_id_subsistema			integer;
    v_estado_periodo		varchar;
			    
BEGIN

    v_nombre_funcion = 'param.ft_periodo_subsistema_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PESU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:			admin	
 	#FECHA:			19-03-2013 13:58:30
	***********************************/

	if(p_transaccion='PM_PESU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tperiodo_subsistema(
			estado_reg,
			id_subsistema,
			id_periodo,
			estado,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_subsistema,
			v_parametros.id_periodo,
			v_parametros.estado,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_periodo_subsistema into v_id_periodo_subsistema;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PeriodoSubsistema almacenado(a) con exito (id_periodo_subsistema'||v_id_periodo_subsistema||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo_subsistema',v_id_periodo_subsistema::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PESU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2013 13:58:30
	***********************************/

	elsif(p_transaccion='PM_PESU_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tperiodo_subsistema set
			estado = v_parametros.estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_periodo_subsistema=v_parametros.id_periodo_subsistema;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PeriodoSubsistema modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo_subsistema',v_parametros.id_periodo_subsistema::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PESU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:			admin	
 	#FECHA:			19-03-2013 13:58:30
	***********************************/

	elsif(p_transaccion='PM_PESU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tperiodo_subsistema
            where id_periodo_subsistema=v_parametros.id_periodo_subsistema;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PeriodoSubsistema eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo_subsistema',v_parametros.id_periodo_subsistema::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'PM_PESUGEN_INS'
 	#DESCRIPCION:	Genracion de registros para un subsistema
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			19-03-2013 13:58:30
	***********************************/

	elsif(p_transaccion='PM_PESUGEN_INS')then

		begin
			
        	--obtener el id_subsistema
            select id_subsistema into v_id_subsistema
            from segu.tsubsistema
            where codigo ilike v_parametros.codigo_subsistema;
            
        	--obtener los registros de la tabla periodo que no esten en la tabla parametro_subsistema
            FOR g_registros in  (
                select  
                    per.id_periodo
                from param.tperiodo as per
                where per.estado_reg = 'activo'
                and per.id_periodo not in (
                	select pesu.id_periodo 
                    from param.tperiodo_subsistema pesu
                    where pesu.id_subsistema = v_id_subsistema
                )
            ) LOOP
            --insertar todos esos registros con estado = abierto
            	insert into param.tperiodo_subsistema (
                    estado_reg,
                    id_subsistema,
                    id_periodo,
                    estado,
                    fecha_reg,
                    id_usuario_reg,
                    fecha_mod,
                    id_usuario_mod
                ) values(
                    'activo',
                    v_id_subsistema,
                    g_registros.id_periodo,
                    'abierto',
                    now(),
                    p_id_usuario,
                    null,
                    null				
                );
            END LOOP;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Periodos generados para el Subsistema '||v_parametros.codigo_subsistema); 
            v_resp = pxp.f_agrega_clave(v_resp,'codigo_subsistema',v_parametros.codigo_subsistema::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'PM_SWESTPE_MOD'
 	#DESCRIPCION:	Cambio de estado para un periodo_subsistema
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			19-03-2013 13:58:30
	***********************************/

	elsif(p_transaccion='PM_SWESTPE_MOD')then

		begin
			
        	select estado into v_estado_periodo
            from param.tperiodo_subsistema
            where id_periodo_subsistema = v_parametros.id_periodo_subsistema;
        	
            IF (v_estado_periodo = 'abierto') THEN
            	v_estado_periodo = 'cerrado';
            ELSE
            	v_estado_periodo = 'abierto';
            END IF;
            
			update param.tperiodo_subsistema set
				estado = v_estado_periodo,
				fecha_mod = now(),
				id_usuario_mod = p_id_usuario
			where id_periodo_subsistema=v_parametros.id_periodo_subsistema;
               
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PeriodoSubsistema modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo_subsistema',v_parametros.id_periodo_subsistema::varchar);
               
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
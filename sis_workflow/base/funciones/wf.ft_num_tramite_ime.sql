CREATE OR REPLACE FUNCTION wf.ft_num_tramite_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_num_tramite_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tnum_tramite'
 AUTOR: 		 (FRH)
 FECHA:	        19-02-2013 13:51:54
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
	v_id_num_tramite	integer;
    v_codigo_siguiente varchar;
    v_cont_gestion integer;
    v_num_siguiente integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_num_tramite_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_NUMTRAM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:54
	***********************************/

	if(p_transaccion='WF_NUMTRAM_INS')then
					
        begin
        	SELECT count(id_gestion)
            INTO v_cont_gestion
            FROM wf.tnum_tramite
            WHERE id_gestion = v_parametros.id_gestion and estado_reg ilike 'activo';
            
            IF v_cont_gestion >= 1 THEN
        		RAISE EXCEPTION 'La gestión que intenta registrar ya existe.';
        	END IF; 
        	
        	--Sentencia de la insercion
        	insert into wf.tnum_tramite(
			id_proceso_macro,
			estado_reg,
			id_gestion,
			num_siguiente,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_proceso_macro,
			'activo',
			v_parametros.id_gestion,
			COALESCE(v_parametros.num_siguiente,null),
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_num_tramite into v_id_num_tramite;
			
            v_codigo_siguiente = wf.f_get_numero_siguiente(v_id_num_tramite);
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Numero de Tramite almacenado(a) con exito (id_num_tramite'||v_id_num_tramite||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_num_tramite',v_id_num_tramite::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_NUMTRAM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:54
	***********************************/

	elsif(p_transaccion='WF_NUMTRAM_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tnum_tramite set
			id_proceso_macro = v_parametros.id_proceso_macro,
			id_gestion = v_parametros.id_gestion,
			num_siguiente = v_parametros.num_siguiente,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_num_tramite=v_parametros.id_num_tramite;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Numero de Tramite modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_num_tramite',v_parametros.id_num_tramite::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_NUMTRAM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:54
	***********************************/

	elsif(p_transaccion='WF_NUMTRAM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tnum_tramite
            where id_num_tramite=v_parametros.id_num_tramite;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Numero de Tramite eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_num_tramite',v_parametros.id_num_tramite::varchar);
              
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
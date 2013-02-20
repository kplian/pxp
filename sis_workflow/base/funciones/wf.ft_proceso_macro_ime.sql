CREATE OR REPLACE FUNCTION "wf"."ft_proceso_macro_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.f_proceso_macro_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.proceso_macro'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 13:51:29
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
	v_id_proceso_macro	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_proceso_macro_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	if(p_transaccion='WF_PROMAC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tproceso_macro(
			id_subsistema,
			nombre,
			codigo,
			inicio,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_subsistema,
			v_parametros.nombre,
			v_parametros.codigo,
			v_parametros.inicio,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_proceso_macro into v_id_proceso_macro;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro almacenado(a) con exito (id_proceso_macro'||v_id_proceso_macro||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_id_proceso_macro::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tproceso_macro set
			id_subsistema = v_parametros.id_subsistema,
			nombre = v_parametros.nombre,
			codigo = v_parametros.codigo,
			inicio = v_parametros.inicio,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_proceso_macro=v_parametros.id_proceso_macro;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_parametros.id_proceso_macro::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PROMAC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 13:51:29
	***********************************/

	elsif(p_transaccion='WF_PROMAC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tproceso_macro
            where id_proceso_macro=v_parametros.id_proceso_macro;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proceso Macro eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proceso_macro',v_parametros.id_proceso_macro::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "wf"."ft_proceso_macro_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

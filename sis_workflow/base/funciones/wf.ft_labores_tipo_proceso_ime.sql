CREATE OR REPLACE FUNCTION wf.ft_labores_tipo_proceso_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_labores_tipo_proceso_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tlabores_tipo_proceso'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 16:08:41
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
	v_id_labores_tipo_proceso	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_labores_tipo_proceso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_LABTPROC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 16:08:41
	***********************************/

	if(p_transaccion='WF_LABTPROC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tlabores_tipo_proceso(
			id_tipo_proceso,
			codigo,
			nombre,
			descripcion,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_tipo_proceso,
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.descripcion,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_labores_tipo_proceso into v_id_labores_tipo_proceso;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definicion Labores x Proceso almacenado(a) con exito (id_labores_tipo_proceso'||v_id_labores_tipo_proceso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_labores_tipo_proceso',v_id_labores_tipo_proceso::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_LABTPROC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 16:08:41
	***********************************/

	elsif(p_transaccion='WF_LABTPROC_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tlabores_tipo_proceso set
			id_tipo_proceso = v_parametros.id_tipo_proceso,
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_labores_tipo_proceso=v_parametros.id_labores_tipo_proceso;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definicion Labores x Proceso modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_labores_tipo_proceso',v_parametros.id_labores_tipo_proceso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_LABTPROC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 16:08:41
	***********************************/

	elsif(p_transaccion='WF_LABTPROC_ELI')then

		begin
			--Sentencia de la eliminacion
			update wf.tlabores_tipo_proceso
            set estado_reg = 'inactivo'
            where id_labores_tipo_proceso=v_parametros.id_labores_tipo_proceso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Definicion Labores x Proceso eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_labores_tipo_proceso',v_parametros.id_labores_tipo_proceso::varchar);
              
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_empresa_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_empresa_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tempresa'
 AUTOR: 		 (admin)
 FECHA:	        04-02-2013 16:03:19
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
	v_id_empresa			integer;
    v_registros				record;
			    
BEGIN

    v_nombre_funcion = 'param.f_empresa_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_EMP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	if(p_transaccion='PM_EMP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tempresa(
			estado_reg,
			
			nombre,
			nit,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            codigo
          	) values(
			'activo',
		
			v_parametros.nombre,
			v_parametros.nit,
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.codigo
							
			)RETURNING id_empresa into v_id_empresa;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa almacenado(a) con exito (id_empresa'||v_id_empresa||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_id_empresa::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_EMP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_EMP_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tempresa set
			
			nombre = v_parametros.nombre,
			nit = v_parametros.nit,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
            codigo=v_parametros.codigo
			where id_empresa=v_parametros.id_empresa;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;
        
        
    /*********************************    
 	#TRANSACCION:  'PM_LOGMOD_IME'
 	#DESCRIPCION:	Modifica la ruta de logo
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_LOGMOD_IME')then

		begin
			--Sentencia de la eliminacion
			UPDATE  param.tempresa set
            logo = v_parametros.ruta_archivo
            where id_empresa=v_parametros.id_empresa;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Logo Modificado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	 
        

	/*********************************    
 	#TRANSACCION:  'PM_EMP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_EMP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tempresa
            where id_empresa=v_parametros.id_empresa;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_parametros.id_empresa::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	
    /*********************************    
 	#TRANSACCION:  'PM_EMPGET_GET'
 	#DESCRIPCION:	Recupera datos de la empresa
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_EMPGET_GET')then

		begin
			--Sentencia de la eliminacion
			
            select
              e.id_empresa ,
              e.nit,
              e.nombre
            into
              v_registros
            from param.tempresa e
            where e.estado_reg = 'activo'
            limit 1 OFFSET 0;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa recuperada(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_empresa',v_registros.id_empresa::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nit',v_registros.nit::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_registros.nombre::varchar);
             
            
            
              
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
CREATE OR REPLACE FUNCTION wf.ft_tipo_documento_estado_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_documento_estado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_documento_estado'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 03:12:38
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
	v_id_tipo_documento_estado	integer;
    v_id_tipo_estado		integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_documento_estado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_DES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	if(p_transaccion='WF_DES_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_documento_estado(
			id_tipo_estado,
			id_tipo_documento,
			id_tipo_proceso,
			estado_reg,
			momento,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            tipo_busqueda,
            regla
          	) values(
			v_parametros.id_tipo_estado,
			v_parametros.id_tipo_documento,
			v_parametros.id_tipo_proceso,
			'activo',
			v_parametros.momento,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.tipo_busqueda,
            v_parametros.regla
							
			)RETURNING id_tipo_documento_estado into v_id_tipo_documento_estado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Momentos por Estados  almacenado(a) con exito (id_tipo_documento_estado'||v_id_tipo_documento_estado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento_estado',v_id_tipo_documento_estado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_DES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	elsif(p_transaccion='WF_DES_MOD')then

		begin
			--Sentencia de la modificacion
            select id_tipo_estado
            into v_id_tipo_estado
            from wf.ttipo_documento_estado
            where id_tipo_documento_estado = v_parametros.id_tipo_documento_estado;
            
            if (v_id_tipo_estado = v_parametros.id_tipo_estado)then
            	update wf.ttipo_documento_estado set			
                momento = v_parametros.momento,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario,
                tipo_busqueda = v_parametros.tipo_busqueda,
                regla = v_parametros.regla
                where id_tipo_documento_estado=v_parametros.id_tipo_documento_estado;
                v_id_tipo_documento_estado = v_parametros.id_tipo_documento_estado;
			else
            	update wf.ttipo_documento_estado set
                        estado_reg = 'inactivo'
                where id_tipo_documento_estado=v_parametros.id_tipo_documento_estado;
                
				insert into wf.ttipo_documento_estado(
                id_tipo_estado,
                id_tipo_documento,
                id_tipo_proceso,
                estado_reg,
                momento,
                fecha_reg,
                id_usuario_reg,
                fecha_mod,
                id_usuario_mod,
                tipo_busqueda,
                regla
                ) values(
                v_parametros.id_tipo_estado,
                v_parametros.id_tipo_documento,
                v_parametros.id_tipo_proceso,
                'activo',
                v_parametros.momento,
                now(),
                p_id_usuario,
                null,
                null,
                v_parametros.tipo_busqueda,
                v_parametros.regla
    							
                )RETURNING id_tipo_documento_estado into v_id_tipo_documento_estado;
            
            end if;   
			
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Momentos por Estados  modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento_estado',v_parametros.id_tipo_documento_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_DES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 03:12:38
	***********************************/

	elsif(p_transaccion='WF_DES_ELI')then

		begin
			--Sentencia de la eliminacion
			update wf.ttipo_documento_estado
            set estado_reg = 'inactivo'
            where id_tipo_documento_estado=v_parametros.id_tipo_documento_estado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Momentos por Estados  eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_documento_estado',v_parametros.id_tipo_documento_estado::varchar);
              
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_entidad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_entidad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tentidad'
 AUTOR: 		 (admin)
 FECHA:	        20-09-2015 19:11:44
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
	v_id_entidad			integer;
    v_registros				record;
			    
BEGIN

    v_nombre_funcion = 'param.ft_entidad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ENT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-09-2015 19:11:44
	***********************************/

	if(p_transaccion='PM_ENT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tentidad(
			tipo_venta_producto,
			nit,
			estado_reg,
			nombre,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod,
			estados_comprobante_venta,
			estados_anulacion_venta,
			pagina_entidad,
            direccion_matriz,
            identificador_min_trabajo,
            identificador_caja_salud
          	) values(
			v_parametros.tipo_venta_producto,
			v_parametros.nit,
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null,
			v_parametros.estados_comprobante_venta,
			v_parametros.estados_anulacion_venta,
			v_parametros.pagina_entidad	,
            v_parametros.direccion_matriz,
            v_parametros.identificador_min_trabajo,
            v_parametros.identificador_caja_salud			
			
			
			)RETURNING id_entidad into v_id_entidad;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Entidad almacenado(a) con exito (id_entidad'||v_id_entidad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_entidad',v_id_entidad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ENT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-09-2015 19:11:44
	***********************************/

	elsif(p_transaccion='PM_ENT_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tentidad set
			tipo_venta_producto = v_parametros.tipo_venta_producto,
			nit = v_parametros.nit,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
			estados_comprobante_venta = v_parametros.estados_comprobante_venta,
			estados_anulacion_venta = v_parametros.estados_anulacion_venta,
			pagina_entidad = v_parametros.pagina_entidad,
            direccion_matriz = v_parametros.direccion_matriz,
            identificador_min_trabajo = v_parametros.identificador_min_trabajo,
            identificador_caja_salud = v_parametros.identificador_caja_salud		
			where id_entidad = v_parametros.id_entidad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Entidad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_entidad',v_parametros.id_entidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ENT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-09-2015 19:11:44
	***********************************/

	elsif(p_transaccion='PM_ENT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tentidad
            where id_entidad=v_parametros.id_entidad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Entidad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_entidad',v_parametros.id_entidad::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_ENTGET_GET'
 	#DESCRIPCION:	Recupera los datos de la entidad a partir del depto
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_ENTGET_GET')then

		begin
			--Sentencia de la eliminacion
			
            select
             e.nit,
             e.nombre,
             e.id_entidad,
             e.direccion_matriz
            into
              v_registros
            from param.tentidad e
            inner join param.tdepto d on d.id_entidad = e.id_entidad
            where e.estado_reg = 'activo'
                  AND d.id_depto = v_parametros.id_depto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa recuperada(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_entidad',v_registros.id_entidad::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nit',v_registros.nit::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_registros.nombre::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'direccion_matriz',v_registros.direccion_matriz::varchar);
            
             
            
            
              
            --Devuelve la respuesta
            return v_resp;

		end;    
    
   /*********************************    
 	#TRANSACCION:  'PM_ENT_GET'
 	#DESCRIPCION:	Recupera los datos de la entidad 
 	#AUTOR:		admin	
 	#FECHA:		04-02-2013 16:03:19
	***********************************/

	elsif(p_transaccion='PM_ENT_GET')then

		begin
			--Sentencia de la eliminacion
			
            select
             e.nit,
             e.nombre,
             e.id_entidad,
             e.direccion_matriz
            into
              v_registros
            from param.tentidad e
            where e.estado_reg = 'activo'
                  AND e.id_entidad = v_parametros.id_entidad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Empresa recuperada(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_entidad',v_registros.id_entidad::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nit',v_registros.nit::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'nombre',v_registros.nombre::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'direccion_matriz',v_registros.direccion_matriz::varchar);
             
            
            
              
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
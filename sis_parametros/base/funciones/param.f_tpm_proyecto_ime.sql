CREATE OR REPLACE FUNCTION param.f_tpm_proyecto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_tpm_proyecto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tpm_proyecto'
 AUTOR: 		 (rac)
 FECHA:	        26-10-2011 11:40:13
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
	v_id_proyecto	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_tpm_proyecto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PRO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2011 11:40:13
	***********************************/

	if(p_transaccion='PM_PRO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tpm_proyecto(
			id_usuario,
			descripcion_proyecto,
			codigo_sisin,
			hora_ultima_modificacion,
			codigo_proyecto,
			hora_registro,
			nombre_corto,
			fecha_ultima_modificacion,
			fecha_registro,
			nombre_proyecto,
			id_proyecto_actif
          	) values(
			v_parametros.id_usuario,
			v_parametros.descripcion_proyecto,
			v_parametros.codigo_sisin,
			v_parametros.hora_ultima_modificacion,
			v_parametros.codigo_proyecto,
			v_parametros.hora_registro,
			v_parametros.nombre_corto,
			v_parametros.fecha_ultima_modificacion,
			v_parametros.fecha_registro,
			v_parametros.nombre_proyecto,
			v_parametros.id_proyecto_actif
			)RETURNING id_proyecto into v_id_proyecto;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PRO almacenado(a) con exito (id_proyecto'||v_id_proyecto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_id_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2011 11:40:13
	***********************************/

	elsif(p_transaccion='PM_PRO_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tpm_proyecto set
			id_usuario = v_parametros.id_usuario,
			descripcion_proyecto = v_parametros.descripcion_proyecto,
			codigo_sisin = v_parametros.codigo_sisin,
			hora_ultima_modificacion = v_parametros.hora_ultima_modificacion,
			codigo_proyecto = v_parametros.codigo_proyecto,
			hora_registro = v_parametros.hora_registro,
			nombre_corto = v_parametros.nombre_corto,
			fecha_ultima_modificacion = v_parametros.fecha_ultima_modificacion,
			fecha_registro = v_parametros.fecha_registro,
			nombre_proyecto = v_parametros.nombre_proyecto,
			id_proyecto_actif = v_parametros.id_proyecto_actif
			where id_proyecto=v_parametros.id_proyecto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PRO modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PRO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		26-10-2011 11:40:13
	***********************************/

	elsif(p_transaccion='PM_PRO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tpm_proyecto
            where id_proyecto=v_parametros.id_proyecto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','PRO eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);
              
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
    LANGUAGE plpgsql;
--
-- Definition for function f_tpm_proyecto_sel (OID = 304019) : 
--

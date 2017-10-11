--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_plantilla_correo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_plantilla_correo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tplantilla_correo'
 AUTOR: 		 (jrivera)
 FECHA:	        20-08-2014 21:52:38
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
	v_id_plantilla_correo	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_plantilla_correo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_PCORREO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		20-08-2014 21:52:38
	***********************************/

	if(p_transaccion='WF_PCORREO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tplantilla_correo(
			id_tipo_estado,
			regla,
			plantilla,
			correos,
			codigo_plantilla,
			documentos,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod,
			asunto,
            requiere_acuse,
            url_acuse,
            mensaje_acuse,
            mensaje_link_acuse,
            mandar_automaticamente,
            funcion_creacion_correo,
            funcion_acuse_recibo,
            cc,
            bcc
          	) values(
			v_parametros.id_tipo_estado,
			v_parametros.regla,
			v_parametros.plantilla,
			string_to_array(v_parametros.correos, ','),
			v_parametros.codigo_plantilla,
			string_to_array(v_parametros.documentos, ','),
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null,
			v_parametros.asunto,
            v_parametros.requiere_acuse,
            v_parametros.url_acuse,
            v_parametros.mensaje_acuse,
            v_parametros.mensaje_link_acuse,
            v_parametros.mandar_automaticamente,
            v_parametros.funcion_creacion_correo,
            v_parametros.funcion_acuse_recibo,

			string_to_array(v_parametros.cc, ','),
      string_to_array(v_parametros.bcc, ',')

			
			)RETURNING id_plantilla_correo into v_id_plantilla_correo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantillas de Correo almacenado(a) con exito (id_plantilla_correo'||v_id_plantilla_correo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_id_plantilla_correo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_PCORREO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		20-08-2014 21:52:38
	***********************************/

	elsif(p_transaccion='WF_PCORREO_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tplantilla_correo set
			regla = v_parametros.regla,
			plantilla = v_parametros.plantilla,
			correos = string_to_array(v_parametros.correos, ','),			
			documentos = string_to_array(v_parametros.documentos, ','),
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai,
			asunto = v_parametros.asunto,
            requiere_acuse = v_parametros.requiere_acuse,
            url_acuse = v_parametros.url_acuse,
            mensaje_acuse = v_parametros.mensaje_acuse,
            mensaje_link_acuse = v_parametros.mensaje_link_acuse,
            mandar_automaticamente = v_parametros.mandar_automaticamente,
            funcion_acuse_recibo = v_parametros.funcion_acuse_recibo,
            funcion_creacion_correo = v_parametros.funcion_creacion_correo,

            cc = string_to_array(v_parametros.cc, ','),
            bcc = string_to_array(v_parametros.bcc, ',')
			where id_plantilla_correo=v_parametros.id_plantilla_correo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantillas de Correo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_parametros.id_plantilla_correo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_PCORREO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		jrivera	
 	#FECHA:		20-08-2014 21:52:38
	***********************************/

	elsif(p_transaccion='WF_PCORREO_ELI')then

		begin
			--Sentencia de la eliminacion
			update wf.tplantilla_correo
            set estado_reg = 'inactivo'
            where id_plantilla_correo=v_parametros.id_plantilla_correo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Plantillas de Correo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_plantilla_correo',v_parametros.id_plantilla_correo::varchar);
              
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
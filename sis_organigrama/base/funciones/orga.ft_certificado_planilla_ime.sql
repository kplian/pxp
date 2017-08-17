CREATE OR REPLACE FUNCTION "orga"."ft_certificado_planilla_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_certificado_planilla_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcertificado_planilla'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        24-07-2017 14:48:34
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
	v_id_certificado_planilla	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_certificado_planilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_PLANC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	if(p_transaccion='OR_PLANC_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tcertificado_planilla(
			tipo_certificado,
			fecha_solicitud,
			beneficiario,
			id_funcionario,
			estado_reg,
			importe_viatico,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.tipo_certificado,
			v_parametros.fecha_solicitud,
			v_parametros.beneficiario,
			v_parametros.id_funcionario,
			'activo',
			v_parametros.importe_viatico,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_certificado_planilla into v_id_certificado_planilla;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla almacenado(a) con exito (id_certificado_planilla'||v_id_certificado_planilla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_id_certificado_planilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_PLANC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_PLANC_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tcertificado_planilla set
			tipo_certificado = v_parametros.tipo_certificado,
			fecha_solicitud = v_parametros.fecha_solicitud,
			beneficiario = v_parametros.beneficiario,
			id_funcionario = v_parametros.id_funcionario,
			importe_viatico = v_parametros.importe_viatico,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_certificado_planilla=v_parametros.id_certificado_planilla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_parametros.id_certificado_planilla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_PLANC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		24-07-2017 14:48:34
	***********************************/

	elsif(p_transaccion='OR_PLANC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tcertificado_planilla
            where id_certificado_planilla=v_parametros.id_certificado_planilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Certificado Planilla eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_certificado_planilla',v_parametros.id_certificado_planilla::varchar);
              
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
ALTER FUNCTION "orga"."ft_certificado_planilla_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

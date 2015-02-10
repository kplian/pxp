CREATE OR REPLACE FUNCTION param.ft_institucion_ime (
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
 FUNCION: 		param.ft_institucion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tinstitucion'
 AUTOR: 		 (gvelasquez)
 FECHA:	        21-09-2011 10:50:03
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
	v_id_institucion	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_institucion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_INSTIT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gvelasquez	
 	#FECHA:		21-09-2011 10:50:03
	***********************************/

	if(p_transaccion='PM_INSTIT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tinstitucion(
			fax,
			estado_reg,
			
			casilla,
			direccion,
			doc_id,
			telefono2,
			id_persona,
			email2,
			celular1,
			email1,
			
			nombre,
			observaciones,
			telefono1,
			celular2,
			codigo_banco,
			pag_web,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
            codigo,
            es_banco,
            cargo_representante
          	) values(
			v_parametros.fax,
			'activo',
			v_parametros.casilla,
			v_parametros.direccion,
			v_parametros.doc_id,
			v_parametros.telefono2,
			v_parametros.id_persona,
			v_parametros.email2,
			v_parametros.celular1,
			v_parametros.email1,
			v_parametros.nombre,
			v_parametros.observaciones,
			v_parametros.telefono1,
			v_parametros.celular2,
			v_parametros.codigo_banco,
			v_parametros.pag_web,
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.codigo,
            v_parametros.es_banco,
            v_parametros.cargo_representante
            
			)RETURNING id_institucion into v_id_institucion;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Institución almacenado(a) con exito (id_institucion'||v_id_institucion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion',v_id_institucion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gvelasquez	
 	#FECHA:		21-09-2011 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIT_MOD')then

		begin
        
      --  raise exception 'ss  %',v_parametros.id_institucion;
			--Sentencia de la modificacion
			update param.tinstitucion set
			fax = v_parametros.fax,
			
			casilla = v_parametros.casilla,
			direccion = v_parametros.direccion,
			doc_id = v_parametros.doc_id,
			telefono2 = v_parametros.telefono2,
			id_persona = v_parametros.id_persona,
			email2 = v_parametros.email2,
			celular1 = v_parametros.celular1,
			email1 = v_parametros.email1,
			
			nombre = v_parametros.nombre,
			observaciones = v_parametros.observaciones,
			telefono1 = v_parametros.telefono1,
			celular2 = v_parametros.celular2,
			codigo_banco = v_parametros.codigo_banco,
			pag_web = v_parametros.pag_web,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
            codigo = v_parametros.codigo,
            es_banco = v_parametros.es_banco,
            cargo_representante = v_parametros.cargo_representante
			where id_institucion=v_parametros.id_institucion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Institución modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion',v_parametros.id_institucion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_INSTIT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gvelasquez	
 	#FECHA:		21-09-2011 10:50:03
	***********************************/

	elsif(p_transaccion='PM_INSTIT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tinstitucion
            where id_institucion=v_parametros.id_institucion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Institución eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_institucion',v_parametros.id_institucion::varchar);
              
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
-- Definition for function ft_institucion_sel (OID = 304038) : 
--

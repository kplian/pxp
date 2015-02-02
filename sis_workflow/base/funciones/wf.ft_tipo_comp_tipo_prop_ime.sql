CREATE OR REPLACE FUNCTION "wf"."ft_tipo_comp_tipo_prop_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_tipo_comp_tipo_prop_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.ttipo_comp_tipo_prop'
 AUTOR: 		 (admin)
 FECHA:	        15-05-2014 20:53:23
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
	v_id_tipo_comp_tipo_prop	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_tipo_comp_tipo_prop_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_TCOTPR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:53:23
	***********************************/

	if(p_transaccion='WF_TCOTPR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.ttipo_comp_tipo_prop(
			estado_reg,
			obligatorio,
			id_tipo_propiedad,
			id_tipo_componente,
			tipo_dato,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.obligatorio,
			v_parametros.id_tipo_propiedad,
			v_parametros.id_tipo_componente,
			v_parametros.tipo_dato,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_tipo_comp_tipo_prop into v_id_tipo_comp_tipo_prop;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Componente - Propiedades almacenado(a) con exito (id_tipo_comp_tipo_prop'||v_id_tipo_comp_tipo_prop||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comp_tipo_prop',v_id_tipo_comp_tipo_prop::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_TCOTPR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:53:23
	***********************************/

	elsif(p_transaccion='WF_TCOTPR_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.ttipo_comp_tipo_prop set
			obligatorio = v_parametros.obligatorio,
			id_tipo_propiedad = v_parametros.id_tipo_propiedad,
			id_tipo_componente = v_parametros.id_tipo_componente,
			tipo_dato = v_parametros.tipo_dato,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_tipo_comp_tipo_prop=v_parametros.id_tipo_comp_tipo_prop;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Componente - Propiedades modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comp_tipo_prop',v_parametros.id_tipo_comp_tipo_prop::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_TCOTPR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-05-2014 20:53:23
	***********************************/

	elsif(p_transaccion='WF_TCOTPR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.ttipo_comp_tipo_prop
            where id_tipo_comp_tipo_prop=v_parametros.id_tipo_comp_tipo_prop;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Componente - Propiedades eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_comp_tipo_prop',v_parametros.id_tipo_comp_tipo_prop::varchar);
              
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
ALTER FUNCTION "wf"."ft_tipo_comp_tipo_prop_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

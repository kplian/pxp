CREATE OR REPLACE FUNCTION "wf"."ft_columna_estado_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_columna_estado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.tcolumna_estado'
 AUTOR: 		 (admin)
 FECHA:	        07-05-2014 21:41:18
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
	v_id_columna_estado	integer;
			    
BEGIN

    v_nombre_funcion = 'wf.ft_columna_estado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_COLEST_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	if(p_transaccion='WF_COLEST_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into wf.tcolumna_estado(
			id_tipo_estado,
			id_tipo_columna,
			estado_reg,
			momento,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_tipo_estado,
			v_parametros.id_tipo_columna,
			'activo',
			v_parametros.momento,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_columna_estado into v_id_columna_estado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estados almacenado(a) con exito (id_columna_estado'||v_id_columna_estado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_estado',v_id_columna_estado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_COLEST_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	elsif(p_transaccion='WF_COLEST_MOD')then

		begin
			--Sentencia de la modificacion
			update wf.tcolumna_estado set
			id_tipo_estado = v_parametros.id_tipo_estado,
			id_tipo_columna = v_parametros.id_tipo_columna,
			momento = v_parametros.momento,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_columna_estado=v_parametros.id_columna_estado;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estados modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_estado',v_parametros.id_columna_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_COLEST_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-05-2014 21:41:18
	***********************************/

	elsif(p_transaccion='WF_COLEST_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from wf.tcolumna_estado
            where id_columna_estado=v_parametros.id_columna_estado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estados eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna_estado',v_parametros.id_columna_estado::varchar);
              
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
ALTER FUNCTION "wf"."ft_columna_estado_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

CREATE OR REPLACE FUNCTION "param"."ft_columna_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_columna_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcolumna'
 AUTOR: 		 (egutierrez)
 FECHA:	        07-08-2019 15:43:48
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				07-08-2019 15:43:48								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcolumna'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_columna	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_columna_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_COL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		egutierrez	
 	#FECHA:		07-08-2019 15:43:48
	***********************************/

	if(p_transaccion='PM_COL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcolumna(
			estado_reg,
			nombre_columna,
			tipo_dato,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre_columna,
			v_parametros.tipo_dato,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_columna into v_id_columna;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL almacenado(a) con exito (id_columna'||v_id_columna||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_id_columna::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_COL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		egutierrez	
 	#FECHA:		07-08-2019 15:43:48
	***********************************/

	elsif(p_transaccion='PM_COL_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcolumna set
			nombre_columna = v_parametros.nombre_columna,
			tipo_dato = v_parametros.tipo_dato,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_columna=v_parametros.id_columna;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_COL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		egutierrez	
 	#FECHA:		07-08-2019 15:43:48
	***********************************/

	elsif(p_transaccion='PM_COL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcolumna
            where id_columna=v_parametros.id_columna;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','COL eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_columna',v_parametros.id_columna::varchar);
              
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
ALTER FUNCTION "param"."ft_columna_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

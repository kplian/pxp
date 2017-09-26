CREATE OR REPLACE FUNCTION param.ft_archivo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tarchivo'
 AUTOR: 		 (favio.figueroa)
 FECHA:	        05-12-2016 15:04:48
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
	v_id_archivo	integer;
	v_registros_json RECORD;
	v_record_anterior record;

	v_record_tipo_archivo RECORD;
    v_ruta					varchar;
			    
BEGIN

    v_nombre_funcion = 'param.ft_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_ARCH_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:04:48
	***********************************/

	if(p_transaccion='PM_ARCH_INS')then
					
        begin




					--Sentencia de la insercion
        	insert into param.tarchivo(
			estado_reg,
			folder,
			extension,
			id_tabla,
			nombre_archivo,
			id_tipo_archivo,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod,
			nombre_descriptivo
          	) values(
			'activo',
			v_parametros.folder,
			v_parametros.extension,
			v_parametros.id_tabla,
			v_parametros.nombre_archivo,
			v_parametros.id_tipo_archivo,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null,
			v_parametros.nombre_descriptivo
							
			
			
			)RETURNING id_archivo into v_id_archivo;


					select *
					INTO v_record_tipo_archivo
						FROM param.ttipo_archivo
							where id_tipo_archivo = v_parametros.id_tipo_archivo;

					--RAISE EXCEPTION '%',v_record_tipo_archivo.multiple;

					--si es diferente de si el multiple entonces  se tomara en cuenta los archivos historicos
					IF v_record_tipo_archivo.multiple != 'si' or v_record_tipo_archivo.multiple is null THEN

						IF EXISTS (SELECT 0 FROM param.tarchivo
						where id_tipo_archivo = v_parametros.id_tipo_archivo
									and id_tabla = v_parametros.id_tabla
									and id_archivo_fk is NULL and id_archivo != v_id_archivo )
						THEN
							--stuff here

							--	RAISE EXCEPTION '%','ya existe un documento se ira al historial';


							--obtenemos el archivo que se modificara y se llavara al historico
							select *
							into v_record_anterior
							FROM param.tarchivo
							where id_tipo_archivo = v_parametros.id_tipo_archivo
										AND id_tabla = v_parametros.id_tabla;

							UPDATE param.tarchivo
							SET id_archivo_fk = v_id_archivo
							where id_tipo_archivo = v_parametros.id_tipo_archivo
										AND id_tabla = v_parametros.id_tabla
										and id_archivo_fk is NULL and id_archivo != v_id_archivo;

						ELSE



						END IF;

					END IF;






					--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo almacenado(a) con exito (id_archivo'||v_id_archivo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo',v_id_archivo::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'url',(v_parametros.folder || v_parametros.nombre_archivo || '.' || v_parametros.extension)::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_ARCH_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:04:48
	***********************************/

	elsif(p_transaccion='PM_ARCH_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tarchivo set
			folder = v_parametros.folder,
			extension = v_parametros.extension,
			id_tabla = v_parametros.id_tabla,
			nombre_archivo = v_parametros.nombre_archivo,
			id_tipo_archivo = v_parametros.id_tipo_archivo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_archivo=v_parametros.id_archivo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo',v_parametros.id_archivo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_ARCH_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-12-2016 15:04:48
	***********************************/

	elsif(p_transaccion='PM_ARCH_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tarchivo
            where id_archivo=v_parametros.id_archivo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo',v_parametros.id_archivo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
	/*********************************
 	#TRANSACCION:  'PM_ARCHJSON_INS'
 	#DESCRIPCION:	insercion mediante json de registros
 	#AUTOR:		admin
 	#FECHA:		05-12-2016 15:04:48
	***********************************/

	elsif(p_transaccion='PM_ARCHJSON_INS')then

		begin
			--Sentencia de la eliminacion

			FOR v_registros_json
			IN (SELECT *
					FROM json_populate_recordset(NULL :: param.json_archivos_ins, v_parametros.arra_json :: JSON))
			LOOP


				--Sentencia de la insercion
				insert into param.tarchivo(
					estado_reg,
					folder,
					extension,
					id_tabla,
					nombre_archivo,
					id_tipo_archivo,
					fecha_reg,
					usuario_ai,
					id_usuario_reg,
					id_usuario_ai,
					id_usuario_mod,
					fecha_mod
				) values(
					'activo',
					v_registros_json.folder,
					v_registros_json.extension,
					v_parametros.id_tabla,
					v_registros_json.nombre_archivo,
					v_parametros.id_tipo_archivo,
					now(),
					v_parametros._nombre_usuario_ai,
					p_id_usuario,
					v_parametros._id_usuario_ai,
					null,
					null



				);

			END LOOP;



            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivos subidos');
            v_resp = pxp.f_agrega_clave(v_resp,'id_archivo','correctos'::VARCHAR);

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
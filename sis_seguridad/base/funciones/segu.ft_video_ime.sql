CREATE OR REPLACE FUNCTION "segu"."ft_video_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_video_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tvideo'
 AUTOR: 		 (admin)
 FECHA:	        23-04-2014 13:14:54
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
	v_id_video	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_video_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_TUTO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-04-2014 13:14:54
	***********************************/

	if(p_transaccion='SG_TUTO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tvideo(
			id_subsistema,
			estado_reg,
			url,
			descripcion,
			titulo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_subsistema,
			'activo',
			v_parametros.url,
			v_parametros.descripcion,
			v_parametros.titulo,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_video into v_id_video;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tutorial almacenado(a) con exito (id_video'||v_id_video||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_video',v_id_video::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_TUTO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-04-2014 13:14:54
	***********************************/

	elsif(p_transaccion='SG_TUTO_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tvideo set
			id_subsistema = v_parametros.id_subsistema,
			url = v_parametros.url,
			descripcion = v_parametros.descripcion,
			titulo = v_parametros.titulo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_video=v_parametros.id_video;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tutorial modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_video',v_parametros.id_video::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_TUTO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-04-2014 13:14:54
	***********************************/

	elsif(p_transaccion='SG_TUTO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tvideo
            where id_video=v_parametros.id_video;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tutorial eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_video',v_parametros.id_video::varchar);
              
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
ALTER FUNCTION "segu"."ft_video_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_usuario_grupo_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_usuario_grupo_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.tusuario_grupo_ep'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 15:53:08
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
	v_id_usuario_grupo_ep	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_usuario_grupo_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_UEP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 15:53:08
	***********************************/

	if(p_transaccion='SG_UEP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.tusuario_grupo_ep(
			estado_reg,
			id_usuario,
			id_grupo,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_usuario,
			v_parametros.id_grupo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_usuario_grupo_ep into v_id_usuario_grupo_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario EP almacenado(a) con exito (id_usuario_grupo_ep'||v_id_usuario_grupo_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_grupo_ep',v_id_usuario_grupo_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_UEP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 15:53:08
	***********************************/

	elsif(p_transaccion='SG_UEP_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.tusuario_grupo_ep set
			id_usuario = v_parametros.id_usuario,
			id_grupo = v_parametros.id_grupo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_usuario_grupo_ep=v_parametros.id_usuario_grupo_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_grupo_ep',v_parametros.id_usuario_grupo_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_UEP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 15:53:08
	***********************************/

	elsif(p_transaccion='SG_UEP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.tusuario_grupo_ep
            where id_usuario_grupo_ep=v_parametros.id_usuario_grupo_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Usuario EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_grupo_ep',v_parametros.id_usuario_grupo_ep::varchar);
              
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
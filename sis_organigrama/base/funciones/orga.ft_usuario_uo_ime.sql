CREATE OR REPLACE FUNCTION orga.ft_usuario_uo_ime (
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
 FUNCION: 		param.ft_usuario_uo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tusuario_uo'
 AUTOR: 		 (rac)
 FECHA:	        13-12-2011 11:14:34
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
	v_id_usuario_uo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_usuario_uo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_uuo_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		13-12-2011 11:14:34
	***********************************/

	if(p_transaccion='PM_uuo_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tusuario_uo(
			estado_reg,
			id_uo,
			id_usuario,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_uo,
			v_parametros.id_usuario,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_usuario_uo into v_id_usuario_uo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','usuario_uo almacenado(a) con exito (id_usuario_uo'||v_id_usuario_uo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_uo',v_id_usuario_uo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_uuo_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		13-12-2011 11:14:34
	***********************************/

	elsif(p_transaccion='PM_uuo_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tusuario_uo set
			id_uo = v_parametros.id_uo,
			id_usuario = v_parametros.id_usuario,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_usuario_uo=v_parametros.id_usuario_uo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','usuario_uo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_uo',v_parametros.id_usuario_uo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_uuo_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		13-12-2011 11:14:34
	***********************************/

	elsif(p_transaccion='PM_uuo_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tusuario_uo
            where id_usuario_uo=v_parametros.id_usuario_uo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','usuario_uo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_usuario_uo',v_parametros.id_usuario_uo::varchar);
              
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
-- Definition for function ft_usuario_uo_sel (OID = 304046) : 
--

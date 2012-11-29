CREATE OR REPLACE FUNCTION param.ft_catalogo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_catalogo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcatalogo'
 AUTOR: 		 (admin)
 FECHA:	        16-11-2012 17:01:40
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
	v_id_catalogo	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_catalogo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CAT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-11-2012 17:01:40
	***********************************/

	if(p_transaccion='PM_CAT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tcatalogo(
			estado_reg,
			descripcion,
			codigo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
			id_catalogo_tipo
          	) values(
			'activo',
			v_parametros.descripcion,
			v_parametros.codigo,
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.id_catalogo_tipo
			)RETURNING id_catalogo into v_id_catalogo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catalogo almacenado(a) con exito (id_catalogo'||v_id_catalogo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_id_catalogo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CAT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-11-2012 17:01:40
	***********************************/

	elsif(p_transaccion='PM_CAT_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tcatalogo set
			descripcion = v_parametros.descripcion,
			codigo = v_parametros.codigo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_catalogo_tipo = v_parametros.id_catalogo_tipo
			where id_catalogo=v_parametros.id_catalogo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catalogo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_parametros.id_catalogo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CAT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		16-11-2012 17:01:40
	***********************************/

	elsif(p_transaccion='PM_CAT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tcatalogo
            where id_catalogo=v_parametros.id_catalogo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Catalogo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_catalogo',v_parametros.id_catalogo::varchar);
              
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
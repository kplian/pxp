--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_unidad_medida_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_unidad_medida_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tunidad_medida'
 AUTOR: 		 (admin)
 FECHA:	        08-08-2012 22:49:22
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
	v_id_unidad_medida	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_unidad_medida_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_UME_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-08-2012 22:49:22
	***********************************/

	if(p_transaccion='PM_UME_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tunidad_medida(
			estado_reg,
			codigo,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod,
			tipo
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.descripcion,
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.tipo
			)RETURNING id_unidad_medida into v_id_unidad_medida;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Unidad de Medida almacenado(a) con exito (id_unidad_medida'||v_id_unidad_medida||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_unidad_medida',v_id_unidad_medida::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_UME_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-08-2012 22:49:22
	***********************************/

	elsif(p_transaccion='PM_UME_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tunidad_medida set
			codigo = v_parametros.codigo,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			tipo = v_parametros.tipo
			where id_unidad_medida=v_parametros.id_unidad_medida;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Unidad de Medida modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_unidad_medida',v_parametros.id_unidad_medida::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_UME_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-08-2012 22:49:22
	***********************************/

	elsif(p_transaccion='PM_UME_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tunidad_medida
            where id_unidad_medida=v_parametros.id_unidad_medida;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Unidad de Medida eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_unidad_medida',v_parametros.id_unidad_medida::varchar);
              
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
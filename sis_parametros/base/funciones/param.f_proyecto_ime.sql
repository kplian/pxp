--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_proyecto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_proyecto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tproyecto'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        06-02-2013 17:04:17
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
	v_id_proyecto	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_proyecto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_PROY_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 17:04:17
	***********************************/

	if(p_transaccion='PM_PROY_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tproyecto(
			estado_reg,
			
			id_proyecto_cat_prog,
			codigo_proyecto,
			descripcion_proyecto,
			nombre_proyecto,
			nombre_corto,
		
			codigo_sisin,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			
			v_parametros.id_proyecto_cat_prog,
			v_parametros.codigo_proyecto,
			v_parametros.descripcion_proyecto,
			v_parametros.nombre_proyecto,
			v_parametros.nombre_corto,
			
			v_parametros.codigo_sisin,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_proyecto into v_id_proyecto;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto almacenado(a) con exito (id_proyecto'||v_id_proyecto||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_id_proyecto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_PROY_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 17:04:17
	***********************************/

	elsif(p_transaccion='PM_PROY_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tproyecto set
               
                id_proyecto_cat_prog = v_parametros.id_proyecto_cat_prog,
                codigo_proyecto = v_parametros.codigo_proyecto,
                descripcion_proyecto = v_parametros.descripcion_proyecto,
                nombre_proyecto = v_parametros.nombre_proyecto,
                nombre_corto = v_parametros.nombre_corto,
    			
                codigo_sisin = v_parametros.codigo_sisin,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario
			where id_proyecto=v_parametros.id_proyecto;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_PROY_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		06-02-2013 17:04:17
	***********************************/

	elsif(p_transaccion='PM_PROY_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tproyecto
            where id_proyecto=v_parametros.id_proyecto;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Proyecto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_proyecto',v_parametros.id_proyecto::varchar);
              
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
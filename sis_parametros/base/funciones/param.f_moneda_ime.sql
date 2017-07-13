--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_moneda_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_moneda_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tmoneda'
 AUTOR: 		 (admin)
 FECHA:	        05-02-2013 18:17:03
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
	v_id_moneda				integer;
    v_desc_moneda			varchar;
			    
BEGIN

    v_nombre_funcion = 'param.f_moneda_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	if(p_transaccion='PM_MONEDA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tmoneda(
                prioridad,
                origen,
                tipo_actualizacion,
                estado_reg,
                codigo,
                moneda,
                tipo_moneda,
                id_usuario_reg,
                fecha_reg,
                id_usuario_mod,
                fecha_mod,
                triangulacion,
                contabilidad,
                codigo_internacional,
                show_combo,
                actualizacion
          	) values(
              v_parametros.prioridad,
              v_parametros.origen,
              v_parametros.tipo_actualizacion,
              'activo',
              v_parametros.codigo,
              v_parametros.moneda,
              v_parametros.tipo_moneda,
              p_id_usuario,
              now(),
              null,
              null,
              v_parametros.triangulacion,
              v_parametros.contabilidad,
              v_parametros.codigo_internacional,
              v_parametros.show_combo,
              v_parametros.actualizacion
							
			)RETURNING id_moneda into v_id_moneda;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda almacenada con exito (id_moneda'||v_id_moneda||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_id_moneda::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	elsif(p_transaccion='PM_MONEDA_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tmoneda set
              prioridad = v_parametros.prioridad,
              origen = v_parametros.origen,
              tipo_actualizacion = v_parametros.tipo_actualizacion,
              codigo = v_parametros.codigo,
              moneda = v_parametros.moneda,
              tipo_moneda = v_parametros.tipo_moneda,
              id_usuario_mod = p_id_usuario,
              fecha_mod = now(),
              triangulacion =  v_parametros.triangulacion,
              contabilidad =  v_parametros.contabilidad,
              codigo_internacional = v_parametros.codigo_internacional,
              show_combo = v_parametros.show_combo,
              actualizacion = v_parametros.actualizacion
			where id_moneda = v_parametros.id_moneda;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_parametros.id_moneda::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_MONEDA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 18:17:03
	***********************************/

	elsif(p_transaccion='PM_MONEDA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tmoneda
            where id_moneda=v_parametros.id_moneda;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_parametros.id_moneda::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'PM_MONBASE_GET'
 	#DESCRIPCION:	Obtener la moneda base
 	#AUTOR:			RCM
 	#FECHA:			19/06/2017
	***********************************/

	elsif(p_transaccion='PM_MONBASE_GET')then

		begin
			--Obtener la moneda base
			v_id_moneda = param.f_get_moneda_base();
            
            --Obtener descripcion
            select moneda into v_desc_moneda from param.tmoneda where id_moneda = v_id_moneda;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Moneda base encontrada'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_moneda',v_id_moneda::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'moneda',v_desc_moneda);
              
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
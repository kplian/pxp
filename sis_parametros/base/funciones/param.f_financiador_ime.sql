--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_financiador_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_financiador_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tfinanciador'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        05-02-2013 22:30:22
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
	v_id_financiador	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_financiador_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_fin_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		05-02-2013 22:30:22
	***********************************/

	if(p_transaccion='PM_fin_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tfinanciador(
			estado_reg,
			nombre_financiador,
			--id_financiador_actif,
			descripcion_financiador,
			codigo_financiador,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.nombre_financiador,
		--	v_parametros.id_financiador_actif,
			v_parametros.descripcion_financiador,
			v_parametros.codigo_financiador,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_financiador into v_id_financiador;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador almacenado(a) con exito (id_financiador'||v_id_financiador||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_financiador',v_id_financiador::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_fin_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		05-02-2013 22:30:22
	***********************************/

	elsif(p_transaccion='PM_fin_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tfinanciador set
			nombre_financiador = v_parametros.nombre_financiador,
			--id_financiador_actif = v_parametros.id_financiador_actif,
			descripcion_financiador = v_parametros.descripcion_financiador,
			codigo_financiador = v_parametros.codigo_financiador,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_financiador=v_parametros.id_financiador;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_financiador',v_parametros.id_financiador::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_fin_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas	
 	#FECHA:		05-02-2013 22:30:22
	***********************************/

	elsif(p_transaccion='PM_fin_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tfinanciador
            where id_financiador=v_parametros.id_financiador;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Financiador eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_financiador',v_parametros.id_financiador::varchar);
              
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
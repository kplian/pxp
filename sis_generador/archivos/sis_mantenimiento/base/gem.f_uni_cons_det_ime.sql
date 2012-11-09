--------------- SQL ---------------

CREATE OR REPLACE FUNCTION gem.f_uni_cons_det_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Mantenimiento Industrial - Plantas y Estaciones
 FUNCION: 		gem.f_uni_cons_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'gem.tuni_cons_det'
 AUTOR: 		 (admin)
 FECHA:	        08-11-2012 21:12:55
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
	v_id_uni_cons_det	integer;
			    
BEGIN

    v_nombre_funcion = 'gem.f_uni_cons_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'GM_UCDET_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 21:12:55
	***********************************/

	if(p_transaccion='GM_UCDET_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into gem.tuni_cons_det(
			id_unidad_medida,
			id_uni_cons,
			codigo,
			nombre,
			descripcion,
			valor,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_unidad_medida,
			v_parametros.id_uni_cons,
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.descripcion,
			v_parametros.valor,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_uni_cons_det into v_id_uni_cons_det;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Quipo almacenado(a) con exito (id_uni_cons_det'||v_id_uni_cons_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_det',v_id_uni_cons_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'GM_UCDET_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 21:12:55
	***********************************/

	elsif(p_transaccion='GM_UCDET_MOD')then

		begin
			--Sentencia de la modificacion
			update gem.tuni_cons_det set
			id_unidad_medida = v_parametros.id_unidad_medida,
			id_uni_cons = v_parametros.id_uni_cons,
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			descripcion = v_parametros.descripcion,
			valor = v_parametros.valor,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_uni_cons_det=v_parametros.id_uni_cons_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Quipo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_det',v_parametros.id_uni_cons_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'GM_UCDET_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		08-11-2012 21:12:55
	***********************************/

	elsif(p_transaccion='GM_UCDET_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from gem.tuni_cons_det
            where id_uni_cons_det=v_parametros.id_uni_cons_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle de Quipo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_uni_cons_det',v_parametros.id_uni_cons_det::varchar);
              
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
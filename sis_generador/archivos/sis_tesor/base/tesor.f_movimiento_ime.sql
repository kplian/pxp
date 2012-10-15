CREATE OR REPLACE FUNCTION "tesor"."f_movimiento_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Tesoreria
 FUNCION: 		tesor.f_movimiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'tesor.tmovimiento'
 AUTOR: 		 (rac)
 FECHA:	        16-08-2012 00:59:54
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
	v_id_movimiento	integer;
			    
BEGIN

    v_nombre_funcion = 'tesor.f_movimiento_ime';
    v_parametros = f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	if(p_transaccion='TSR_MOV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into tesor.tmovimiento(
			estado_reg,
			nro_movimiento,
			fecha,
			id_persona_des,
			id_concepto,
			id_persona_or,
			monto,
			detalle,
			estado,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nro_movimiento,
			v_parametros.fecha,
			v_parametros.id_persona_des,
			v_parametros.id_concepto,
			v_parametros.id_persona_or,
			v_parametros.monto,
			v_parametros.detalle,
			v_parametros.estado,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_movimiento into v_id_movimiento;
               
			--Definicion de la respuesta
			v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento almacenado(a) con exito (id_movimiento'||v_id_movimiento||')'); 
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_id_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	elsif(p_transaccion='TSR_MOV_MOD')then

		begin
			--Sentencia de la modificacion
			update tesor.tmovimiento set
			nro_movimiento = v_parametros.nro_movimiento,
			fecha = v_parametros.fecha,
			id_persona_des = v_parametros.id_persona_des,
			id_concepto = v_parametros.id_concepto,
			id_persona_or = v_parametros.id_persona_or,
			monto = v_parametros.monto,
			detalle = v_parametros.detalle,
			estado = v_parametros.estado,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_movimiento=v_parametros.id_movimiento;
               
			--Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento modificado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TSR_MOV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		16-08-2012 00:59:54
	***********************************/

	elsif(p_transaccion='TSR_MOV_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from tesor.tmovimiento
            where id_movimiento=v_parametros.id_movimiento;
               
            --Definicion de la respuesta
            v_resp = f_agrega_clave(v_resp,'mensaje','Movimiento eliminado(a)'); 
            v_resp = f_agrega_clave(v_resp,'id_movimiento',v_parametros.id_movimiento::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "tesor"."f_movimiento_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

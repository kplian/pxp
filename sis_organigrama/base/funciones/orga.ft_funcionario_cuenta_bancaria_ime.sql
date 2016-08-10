CREATE OR REPLACE FUNCTION orga.ft_funcionario_cuenta_bancaria_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_funcionario_cuenta_bancaria_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tfuncionario_cuenta_bancaria'
 AUTOR: 		 (admin)
 FECHA:	        20-01-2014 14:16:37
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
	v_id_funcionario_cuenta_bancaria	integer;
	v_max_fecha_ini			date;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_funcionario_cuenta_bancaria_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_FUNCUE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-01-2014 14:16:37
	***********************************/

	if(p_transaccion='OR_FUNCUE_INS')then
					
        begin
        	select max(fecha_ini) into v_max_fecha_ini
        	from orga.tfuncionario_cuenta_bancaria
            where id_funcionario = v_parametros.id_funcionario;
        	
        	if (v_max_fecha_ini + interval '1 day' >= v_parametros.fecha_ini)then
        		raise exception 'Ya existe una cuenta bancaria asignada para este empleado con fecha inicio: %',v_max_fecha_ini;
        	end if;
        	
        	update orga.tfuncionario_cuenta_bancaria set
				fecha_fin = v_parametros.fecha_ini - interval '1 day'
			where fecha_fin is null and id_funcionario = v_parametros.id_funcionario;
			
			
        	--Sentencia de la insercion
        	insert into orga.tfuncionario_cuenta_bancaria(
			id_funcionario,
			id_institucion,
			nro_cuenta,
			fecha_ini,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_funcionario,
			v_parametros.id_institucion,
			v_parametros.nro_cuenta,
			v_parametros.fecha_ini,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_funcionario_cuenta_bancaria into v_id_funcionario_cuenta_bancaria;
			
			
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta Bancaria almacenado(a) con exito (id_funcionario_cuenta_bancaria'||v_id_funcionario_cuenta_bancaria||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_cuenta_bancaria',v_id_funcionario_cuenta_bancaria::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_FUNCUE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-01-2014 14:16:37
	***********************************/

	elsif(p_transaccion='OR_FUNCUE_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tfuncionario_cuenta_bancaria set
			id_funcionario = v_parametros.id_funcionario,
			id_institucion = v_parametros.id_institucion,
			nro_cuenta = v_parametros.nro_cuenta,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_funcionario_cuenta_bancaria=v_parametros.id_funcionario_cuenta_bancaria;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta Bancaria modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_cuenta_bancaria',v_parametros.id_funcionario_cuenta_bancaria::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_FUNCUE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		20-01-2014 14:16:37
	***********************************/

	elsif(p_transaccion='OR_FUNCUE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tfuncionario_cuenta_bancaria
            where id_funcionario_cuenta_bancaria=v_parametros.id_funcionario_cuenta_bancaria;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cuenta Bancaria eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_cuenta_bancaria',v_parametros.id_funcionario_cuenta_bancaria::varchar);
              
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
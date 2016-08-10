CREATE OR REPLACE FUNCTION orga.ft_funcionario_especialidad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Recursos Humanos
 FUNCION: 		orga.f_funcionario_especialidad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tfuncionario_especialidad'
 AUTOR: 		 (admin)
 FECHA:	        17-08-2012 17:48:37
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
	v_id_funcionario_especialidad	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.f_funcionario_especialidad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	if(p_transaccion='RH_RHESFU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tfuncionario_especialidad(
			id_funcionario,
			estado_reg,
			id_especialidad,
            fecha,
            numero_especialidad,
            descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_funcionario,
			'activo',
			v_parametros.id_especialidad,
            v_parametros.fecha,
            v_parametros.numero_especialidad,
            v_parametros.descripcion,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_funcionario_especialidad into v_id_funcionario_especialidad;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios almacenado(a) con exito (id_funcionario_especialidad'||v_id_funcionario_especialidad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_especialidad',v_id_funcionario_especialidad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	elsif(p_transaccion='RH_RHESFU_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tfuncionario_especialidad set
			id_funcionario = v_parametros.id_funcionario,
			id_especialidad = v_parametros.id_especialidad,
            fecha = v_parametros.fecha,
            numero_especialidad = v_parametros.numero_especialidad,
            descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_funcionario_especialidad=v_parametros.id_funcionario_especialidad;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_especialidad',v_parametros.id_funcionario_especialidad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'RH_RHESFU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-08-2012 17:48:37
	***********************************/

	elsif(p_transaccion='RH_RHESFU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tfuncionario_especialidad
            where id_funcionario_especialidad=v_parametros.id_funcionario_especialidad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Especialidades Funcionarios eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_funcionario_especialidad',v_parametros.id_funcionario_especialidad::varchar);
              
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
ALTER FUNCTION orga.ft_funcionario_especialidad_ime(integer, integer, character varying, character varying) OWNER TO postgres;


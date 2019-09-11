CREATE OR REPLACE FUNCTION "orga"."ft_codigo_funcionario_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_codigo_funcionario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcodigo_funcionario'
 AUTOR: 		 (miguel.mamani)
 FECHA:	        10-09-2019 19:35:19
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				10-09-2019 19:35:19								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcodigo_funcionario'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_codigo_funcionario	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_codigo_funcionario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CFO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		10-09-2019 19:35:19
	***********************************/

	if(p_transaccion='OR_CFO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tcodigo_funcionario(
			estado_reg,
			codigo,
			id_funcionario,
			fecha_asignacion,
			fecha_finalizacion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_ai,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.codigo,
			v_parametros.id_funcionario,
			v_parametros.fecha_asignacion,
			v_parametros.fecha_finalizacion,
			p_id_usuario,
			now(),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_codigo_funcionario into v_id_codigo_funcionario;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Código funcionario almacenado(a) con exito (id_codigo_funcionario'||v_id_codigo_funcionario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_codigo_funcionario',v_id_codigo_funcionario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_CFO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		10-09-2019 19:35:19
	***********************************/

	elsif(p_transaccion='OR_CFO_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tcodigo_funcionario set
			codigo = v_parametros.codigo,
			id_funcionario = v_parametros.id_funcionario,
			fecha_asignacion = v_parametros.fecha_asignacion,
			fecha_finalizacion = v_parametros.fecha_finalizacion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_codigo_funcionario=v_parametros.id_codigo_funcionario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Código funcionario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_codigo_funcionario',v_parametros.id_codigo_funcionario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CFO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		miguel.mamani	
 	#FECHA:		10-09-2019 19:35:19
	***********************************/

	elsif(p_transaccion='OR_CFO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tcodigo_funcionario
            where id_codigo_funcionario=v_parametros.id_codigo_funcionario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Código funcionario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_codigo_funcionario',v_parametros.id_codigo_funcionario::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "orga"."ft_codigo_funcionario_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

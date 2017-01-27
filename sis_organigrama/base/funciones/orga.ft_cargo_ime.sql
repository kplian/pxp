CREATE OR REPLACE FUNCTION orga.ft_cargo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
  RETURNS varchar AS
  $body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_cargo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcargo'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 19:16:06
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
	v_id_cargo	integer;
	v_nombre_cargo			varchar;
	v_id_lugar				integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_cargo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CARGO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:16:06
	***********************************/

	if(p_transaccion='OR_CARGO_INS')then
					
        begin
        	select id_lugar into v_id_lugar
        	from orga.toficina
        	where id_oficina = v_parametros.id_oficina;
        	
        	
        	
        	
        	--Sentencia de la insercion
        	insert into orga.tcargo(
			id_tipo_contrato,
			id_lugar,
			id_uo,			
			id_escala_salarial,
			codigo,
			nombre,
			fecha_ini,
			estado_reg,
			fecha_fin,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
			id_oficina
          	) values(
			v_parametros.id_tipo_contrato,
			v_id_lugar,
			v_parametros.id_uo,			
			v_parametros.id_escala_salarial,
			v_parametros.codigo,
			v_parametros.nombre,
			v_parametros.fecha_ini,
			'activo',
			v_parametros.fecha_fin,
			now(),
			p_id_usuario,
			null,
			null,
			v_parametros.id_oficina
							
			)RETURNING id_cargo into v_id_cargo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo almacenado(a) con exito (id_cargo'||v_id_cargo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_id_cargo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARGO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:16:06
	***********************************/

	elsif(p_transaccion='OR_CARGO_MOD')then

		begin
		
        	
        	select id_lugar into v_id_lugar
        	from orga.toficina
        	where id_oficina = v_parametros.id_oficina;
			
			--Sentencia de la modificacion
			update orga.tcargo set
			id_lugar = v_id_lugar,
			codigo = v_parametros.codigo,			
			fecha_ini = v_parametros.fecha_ini,
			fecha_fin = v_parametros.fecha_fin,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,			
			id_oficina = v_parametros.id_oficina
			where id_cargo=v_parametros.id_cargo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_parametros.id_cargo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARGO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 19:16:06
	***********************************/

	elsif(p_transaccion='OR_CARGO_ELI')then

		begin
		
			if (exists (select 1 from orga.tuo_funcionario
						where estado_reg = 'activo' and (fecha_finalizacion > now()::date or fecha_finalizacion is null) 
							and id_cargo = v_parametros.id_cargo))then
				raise exception 'No es posible eliminar un cargo asignado a un empleado';
			end if;
			--Sentencia de la eliminacion
			update orga.tcargo
			set estado_reg = 'inactivo'
            where id_cargo=v_parametros.id_cargo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cargo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo',v_parametros.id_cargo::varchar);
              
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
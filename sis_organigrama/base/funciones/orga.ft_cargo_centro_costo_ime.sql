CREATE OR REPLACE FUNCTION orga.ft_cargo_centro_costo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_cargo_centro_costo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcargo_centro_costo'
 AUTOR: 		 (admin)
 FECHA:	        15-01-2014 13:05:35
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
	v_id_cargo_centro_costo	integer;
	v_id_gestion			integer;
	v_suma_porcentaje		numeric;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_cargo_centro_costo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CARCC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:05:35
	***********************************/

	if(p_transaccion='OR_CARCC_INS')then
					
        begin
        	select cc.id_gestion into v_id_gestion
        	from param.tcentro_costo cc
        	where id_centro_costo = v_parametros.id_centro_costo;
            
            if (pxp.f_get_variable_global('orga_exigir_ot') = 'si') then
            	if (v_parametros.id_ot is null) then
                	raise exception 'Debe registrar la OT ya que es un campo obligatorio';
                end if;
            end if;
        	
        	--Sentencia de la insercion
        	insert into orga.tcargo_centro_costo(
			id_cargo,
			id_gestion,
			id_centro_costo,
			porcentaje,
			fecha_ini,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod,
            id_ot
          	) values(
			v_parametros.id_cargo,
			v_id_gestion,
			v_parametros.id_centro_costo,
			v_parametros.porcentaje,
			v_parametros.fecha_ini,
			'activo',
			p_id_usuario,
			now(),
			null,
			null,
            v_parametros.id_ot
							
			)RETURNING id_cargo_centro_costo into v_id_cargo_centro_costo;
			
			select sum(porcentaje) into v_suma_porcentaje
			from  orga.tcargo_centro_costo
			where fecha_ini = v_parametros.fecha_ini and estado_reg = 'activo';
			
			if (v_suma_porcentaje > 100) then
				raise exception 'La suma de los porcentajes de presupuestos no debe superar el 100 porciento';
			end if;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Asignado por Cargo almacenado(a) con exito (id_cargo_centro_costo'||v_id_cargo_centro_costo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo_centro_costo',v_id_cargo_centro_costo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARCC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:05:35
	***********************************/

	elsif(p_transaccion='OR_CARCC_MOD')then

		begin
        
        	if (pxp.f_get_variable_global('orga_exigir_ot') = 'si') then
            	if (v_parametros.id_ot is null) then
                	raise exception 'Debe registrar la OT ya que es un campo obligatorio';
                end if;
            end if;	
        
			--Sentencia de la modificacion
			update orga.tcargo_centro_costo set
			id_cargo = v_parametros.id_cargo,
			id_gestion = v_parametros.id_gestion,
			id_centro_costo = v_parametros.id_centro_costo,
			porcentaje = v_parametros.porcentaje,
			fecha_ini = v_parametros.fecha_ini,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            id_ot = v_parametros.id_ot
			where id_cargo_centro_costo=v_parametros.id_cargo_centro_costo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Asignado por Cargo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo_centro_costo',v_parametros.id_cargo_centro_costo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CARCC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-01-2014 13:05:35
	***********************************/

	elsif(p_transaccion='OR_CARCC_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tcargo_centro_costo
            where id_cargo_centro_costo=v_parametros.id_cargo_centro_costo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Presupuesto Asignado por Cargo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_cargo_centro_costo',v_parametros.id_cargo_centro_costo::varchar);
              
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
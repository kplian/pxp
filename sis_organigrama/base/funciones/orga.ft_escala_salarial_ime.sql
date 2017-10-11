CREATE OR REPLACE FUNCTION orga.ft_escala_salarial_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_escala_salarial_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tescala_salarial'
 AUTOR: 		 (admin)
 FECHA:	        14-01-2014 00:28:29
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
	v_id_escala_salarial	integer;
	v_reg_old				record;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_escala_salarial_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_ESCSAL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:29
	***********************************/

	if(p_transaccion='OR_ESCSAL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tescala_salarial(
			aprobado,
			id_categoria_salarial,
			estado_reg,
			haber_basico,
			nombre,
			nro_casos,
			codigo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
			fecha_ini
          	) values(
			v_parametros.aprobado,
			v_parametros.id_categoria_salarial,
			'activo',
			v_parametros.haber_basico,
			v_parametros.nombre,
			v_parametros.nro_casos,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null,
			v_parametros.fecha_ini
							
			)RETURNING id_escala_salarial into v_id_escala_salarial;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Escala Salarial almacenado(a) con exito (id_escala_salarial'||v_id_escala_salarial||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_escala_salarial',v_id_escala_salarial::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_ESCSAL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:29
	***********************************/

	elsif(p_transaccion='OR_ESCSAL_MOD')then

		begin
			select * into v_reg_old 
			from orga.tescala_salarial
			where id_escala_salarial = v_parametros.id_escala_salarial;
			
			if (v_reg_old.haber_basico != v_parametros.haber_basico) then
				if (v_parametros.fecha_ini is null) then
					raise exception 'Si cambia el haber básico, debe definir la fecha desde la que se aplicará el cambio';
				end if;
				insert into orga.tescala_salarial (
						aprobado , 			haber_basico,			nombre,
						nro_casos,			codigo,					id_categoria_salarial,
						fecha_ini,			fecha_fin,				estado_reg,id_escala_padre) 
				values (v_reg_old.aprobado ,v_reg_old.haber_basico,	v_reg_old.nombre,
						v_reg_old.nro_casos,v_reg_old.codigo,		v_reg_old.id_categoria_salarial,
						v_reg_old.fecha_ini,(v_parametros.fecha_ini - interval '1 day'), 'inactivo',v_parametros.id_escala_salarial);
			end if;
			--Sentencia de la modificacion
			update orga.tescala_salarial set
			aprobado = v_parametros.aprobado,
			haber_basico = v_parametros.haber_basico,
			nombre = v_parametros.nombre,
			nro_casos = v_parametros.nro_casos,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
      fecha_ini = v_parametros.fecha_ini
			where id_escala_salarial=v_parametros.id_escala_salarial;
			
			if (v_parametros.fecha_ini is not null and v_reg_old.haber_basico != v_parametros.haber_basico) then
				update orga.tescala_salarial set
				fecha_ini = v_parametros.fecha_ini
				where id_escala_salarial=v_parametros.id_escala_salarial;
			end if;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Escala Salarial modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_escala_salarial',v_parametros.id_escala_salarial::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_ESCSAL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		14-01-2014 00:28:29
	***********************************/

	elsif(p_transaccion='OR_ESCSAL_ELI')then

		begin
			if (exists (select 1 from orga.tcargo 
						where id_escala_salarial = v_parametros.id_escala_salarial and estado_reg='activo'))then
				raise exception 'No es posible eliminar una escala salarial que tiene items activos';		
			end if;
			--Sentencia de la eliminacion
			update orga.tescala_salarial
			set estado_reg = 'inactivo'
            where id_escala_salarial=v_parametros.id_escala_salarial;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Escala Salarial eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_escala_salarial',v_parametros.id_escala_salarial::varchar);
              
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
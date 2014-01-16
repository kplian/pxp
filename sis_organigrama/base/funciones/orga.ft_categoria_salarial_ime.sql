CREATE OR REPLACE FUNCTION "orga"."ft_categoria_salarial_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_categoria_salarial_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tcategoria_salarial'
 AUTOR: 		 (admin)
 FECHA:	        13-01-2014 23:53:05
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
	v_id_categoria_salarial	integer;
	v_reg_escala			record;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_categoria_salarial_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_CATSAL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:53:05
	***********************************/

	if(p_transaccion='OR_CATSAL_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tcategoria_salarial(
			estado_reg,
			nombre,
			codigo,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros.codigo,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_categoria_salarial into v_id_categoria_salarial;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Salarial almacenado(a) con exito (id_categoria_salarial'||v_id_categoria_salarial||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_salarial',v_id_categoria_salarial::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_CATSAL_MOD'
 	#DESCRIPCION:	Modificacion de categoria salarial e incremento salarial por categoria
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:53:05
	***********************************/

	elsif(p_transaccion='OR_CATSAL_MOD')then

		begin
			if (pxp.f_existe_parametro(p_tabla, 'fecha_ini') and pxp.f_existe_parametro(p_tabla, 'incremento') 
				and v_parametros.fecha_ini is not null and v_parametros.incremento is not null) then
			
				for v_reg_escala in (select * from orga.tescala_salarial 
									where id_categoria_salarial = v_parametros.id_categoria_salarial) loop
					
					insert into orga.tescala_salarial (
							aprobado , 			haber_basico,			nombre,
							nro_casos,			codigo,					id_categoria_salarial,
							fecha_ini,			fecha_fin,				estado_reg) 
					values (v_reg_escala.aprobado ,v_reg_escala.haber_basico,	v_reg_escala.nombre,
							v_reg_escala.nro_casos,v_reg_escala.codigo,		v_reg_escala.id_categoria_salarial,
							v_reg_escala.fecha_ini,(v_parametros.fecha_ini - interval '1 day'), 'inactivo');
							
					update orga.tescala_salarial set
					fecha_ini = v_parametros.fecha_ini,
					haber_basico = (v_reg_escala.haber_basico * (1 + (v_parametros.incremento/100))) 
					where id_escala_salarial=v_reg_escala.id_escala_salarial;
					 
				end loop;
			
				--Definicion de la respuesta
	            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Incremento Salarial realizado'); 
	            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_salarial',v_parametros.id_categoria_salarial::varchar);
			
			else
				--Sentencia de la modificacion
				update orga.tcategoria_salarial set
				nombre = v_parametros.nombre,
				codigo = v_parametros.codigo,
				id_usuario_mod = p_id_usuario,
				fecha_mod = now()
				where id_categoria_salarial=v_parametros.id_categoria_salarial;
	               
				--Definicion de la respuesta
	            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Salarial modificado(a)'); 
	            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_salarial',v_parametros.id_categoria_salarial::varchar);
	        end if;
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_CATSAL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:53:05
	***********************************/

	elsif(p_transaccion='OR_CATSAL_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tcategoria_salarial
            where id_categoria_salarial=v_parametros.id_categoria_salarial;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Categoria Salarial eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria_salarial',v_parametros.id_categoria_salarial::varchar);
              
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
ALTER FUNCTION "orga"."ft_categoria_salarial_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

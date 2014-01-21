CREATE OR REPLACE FUNCTION "orga"."ft_nivel_organizacional_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Organigrama
 FUNCION: 		orga.ft_nivel_organizacional_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'orga.tnivel_organizacional'
 AUTOR: 		 (admin)
 FECHA:	        13-01-2014 23:54:12
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
	v_id_nivel_organizacional	integer;
			    
BEGIN

    v_nombre_funcion = 'orga.ft_nivel_organizacional_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'OR_NIVORG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:12
	***********************************/

	if(p_transaccion='OR_NIVORG_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into orga.tnivel_organizacional(
			numero_nivel,
			estado_reg,
			nombre_nivel,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.numero_nivel,
			'activo',
			v_parametros.nombre_nivel,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_nivel_organizacional into v_id_nivel_organizacional;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Nivel Organizacional almacenado(a) con exito (id_nivel_organizacional'||v_id_nivel_organizacional||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nivel_organizacional',v_id_nivel_organizacional::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'OR_NIVORG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:12
	***********************************/

	elsif(p_transaccion='OR_NIVORG_MOD')then

		begin
			--Sentencia de la modificacion
			update orga.tnivel_organizacional set
			numero_nivel = v_parametros.numero_nivel,
			nombre_nivel = v_parametros.nombre_nivel,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_nivel_organizacional=v_parametros.id_nivel_organizacional;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Nivel Organizacional modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nivel_organizacional',v_parametros.id_nivel_organizacional::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'OR_NIVORG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		13-01-2014 23:54:12
	***********************************/

	elsif(p_transaccion='OR_NIVORG_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from orga.tnivel_organizacional
            where id_nivel_organizacional=v_parametros.id_nivel_organizacional;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Nivel Organizacional eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_nivel_organizacional',v_parametros.id_nivel_organizacional::varchar);
              
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
ALTER FUNCTION "orga"."ft_nivel_organizacional_ime"(integer, integer, character varying, character varying) OWNER TO postgres;

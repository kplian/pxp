CREATE OR REPLACE FUNCTION segu.ft_libreta_her_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 SISTEMA:		Sistema de Seguridad
 FUNCION: 		segu.ft_libreta_her_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'segu.libreta_her'
 AUTOR: 		 (rac)
 FECHA:	        18-06-2012 16:45:50
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
	v_id_libreta_her	integer;
			    
BEGIN

    v_nombre_funcion = 'segu.ft_libreta_her_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SG_LIB_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-06-2012 16:45:50
	***********************************/

	if(p_transaccion='SG_LIB_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into segu.libreta_her(
			estado_reg,
			telefono,
			nombre,
			obs,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.telefono,
			v_parametros.nombre,
			v_parametros.obs,
			p_id_usuario,
			now(),
			null,
			null
			)RETURNING id_libreta_her into v_id_libreta_her;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','LIBRETA almacenado(a) con exito (id_libreta_her'||v_id_libreta_her||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_libreta_her',v_id_libreta_her::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SG_LIB_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-06-2012 16:45:50
	***********************************/

	elsif(p_transaccion='SG_LIB_MOD')then

		begin
			--Sentencia de la modificacion
			update segu.libreta_her set
			telefono = v_parametros.telefono,
			nombre = v_parametros.nombre,
			obs = v_parametros.obs,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_libreta_her=v_parametros.id_libreta_her;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','LIBRETA modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_libreta_her',v_parametros.id_libreta_her::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SG_LIB_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		rac	
 	#FECHA:		18-06-2012 16:45:50
	***********************************/

	elsif(p_transaccion='SG_LIB_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from segu.libreta_her
            where id_libreta_her=v_parametros.id_libreta_her;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','LIBRETA eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_libreta_her',v_parametros.id_libreta_her::varchar);
              
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
    LANGUAGE plpgsql;
--
-- Definition for function ft_libreta_her_sel (OID = 305068) : 
--

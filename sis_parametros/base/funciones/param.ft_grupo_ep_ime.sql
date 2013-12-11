--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_grupo_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_grupo_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tgrupo_ep'
 AUTOR: 		 (admin)
 FECHA:	        22-04-2013 14:49:40
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
	v_id_grupo_ep	integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_grupo_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GQP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:49:40
	***********************************/

	if(p_transaccion='PM_GQP_INS')then
					
        begin
        
            if EXISTS (  select 1 from param.tgrupo_ep gep
                         where  ( gep.id_ep = v_parametros.id_ep or (id_ep is NULL  and  v_parametros.id_ep is null) ) 
                             and  (gep.id_uo = v_parametros.id_uo or (id_uo is NULL  and  v_parametros.id_uo is null) ) 
                             and gep.id_grupo = v_parametros.id_grupo) THEN
                 
               raise exception 'La EP/UO no puede duplicarce';
                      
            END IF;
        
        
        	--Sentencia de la insercion
        	insert into param.tgrupo_ep(
			estado_reg,
			id_grupo,
			id_ep,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            id_uo
          	) values(
			'activo',
			v_parametros.id_grupo,
			v_parametros.id_ep,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.id_uo
							
			)RETURNING id_grupo_ep into v_id_grupo_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo EP almacenado(a) con exito (id_grupo_ep'||v_id_grupo_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_ep',v_id_grupo_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_GQP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:49:40
	***********************************/

	elsif(p_transaccion='PM_GQP_MOD')then

		begin
         
            
             if EXISTS (  select 1 from param.tgrupo_ep gep
                         where  ( gep.id_ep = v_parametros.id_ep or (id_ep is NULL  and  v_parametros.id_ep is null) ) 
                             and  (gep.id_uo = v_parametros.id_uo or (id_uo is NULL  and  v_parametros.id_uo is null) ) 
                             and gep.id_grupo = v_parametros.id_grupo
                             and gep.id_grupo_ep!=v_parametros.id_grupo_ep) THEN
                 
               raise exception 'La EP/UO no puede duplicarce';
                      
            END IF;
        
        
			--Sentencia de la modificacion
			update param.tgrupo_ep set
			id_grupo = v_parametros.id_grupo,
			id_ep = v_parametros.id_ep,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
            id_uo =  v_parametros.id_uo
			where id_grupo_ep=v_parametros.id_grupo_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_ep',v_parametros.id_grupo_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GQP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-04-2013 14:49:40
	***********************************/

	elsif(p_transaccion='PM_GQP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tgrupo_ep
            where id_grupo_ep=v_parametros.id_grupo_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_grupo_ep',v_parametros.id_grupo_ep::varchar);
              
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
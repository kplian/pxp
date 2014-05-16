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
    v_array_ep			INTEGER[];
    v_registros    record;
    v_count        integer;
			    
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
    /*********************************    
 	#TRANSACCION:  'PM_SINCGREPUO_IME'
 	#DESCRIPCION:	Sincronizar todas las ep o uo en el grupo selecionado
 	#AUTOR:		rac(kplian)	
 	#FECHA:		12-05-2014 15:15:03
	***********************************/

	elsif(p_transaccion='PM_SINCGREPUO_IME')then

		begin
			--Sentencia de la eliminacion 
            
            
            
            if v_parametros.config = 'ep' then
             
               --obtiene todas la EP
               select  
               pxp.aggarray(gep.id_ep) 
                into  
                v_array_ep 
               from param.tgrupo_ep  gep 
               where gep.id_grupo = v_parametros.id_grupo  and gep.id_uo is NULL and gep.estado_reg = 'activo'; 
               
               v_count = 0;
                           
               FOR v_registros in execute('select id_ep from param.tep  where estado_reg = ''activo''  and id_ep  not in ('||COALESCE(array_to_string(v_array_ep,','),'0')||')') LOOP
              
                 
                   insert into param.tgrupo_ep  ( id_grupo, 
                                                     id_ep,  
                                                     id_uo,  
                                                     id_usuario_reg, 
                                                     fecha_reg) 
                                            values ( v_parametros.id_grupo,
                                            		 v_registros.id_ep, 
                                                     NULL, 
                                                     p_id_usuario, 
                                                     now());
                                            
                                            
                  v_count = v_count +1;
               
               
               END LOOP;
            
            else
            
                --obtiene todas la UO
               
               select  
               pxp.aggarray(gep.id_uo) 
                into  
                v_array_ep 
               from param.tgrupo_ep  gep 
               where gep.id_grupo = v_parametros.id_grupo  and gep.id_ep is NULL and gep.estado_reg = 'activo';
               
               v_count = 0;
                           
               FOR v_registros in execute('select id_uo from orga.tuo  uo where uo.presupuesta = ''si'' and uo.estado_reg = ''activo'' and  id_uo  not in ('||COALESCE(array_to_string(v_array_ep,','),'0')||')') LOOP
              
                 
                   insert into param.tgrupo_ep  ( id_grupo, 
                                                     id_ep,  
                                                     id_uo,  
                                                     id_usuario_reg, 
                                                     fecha_reg) 
                                            values ( v_parametros.id_grupo,
                                            		 NULL,
                                                      v_registros.id_uo,  
                                                     p_id_usuario, 
                                                     now());
                                            
                                            
                  v_count = v_count +1;
               
               
               END LOOP;
            
            
            
            end if;
            
           
			
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','grupo ep  total  '||v_parametros.config ||' sincronizados '|| v_count::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'msg','total '||v_parametros.config ||' sincronizados '|| v_count::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'count',v_count::varchar);
          
           
              
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
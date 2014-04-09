--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.ft_depto_uo_ep_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_depto_uo_ep_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tdepto_uo_ep'
 AUTOR: 		 (admin)
 FECHA:	        03-06-2013 15:15:03
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
	v_id_depto_uo_ep	integer;
    v_array_ep			INTEGER[];
    v_registros    record;
    v_count        integer;
			    
BEGIN

    v_nombre_funcion = 'param.ft_depto_uo_ep_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_DUE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	if(p_transaccion='PM_DUE_INS')then
					
        begin
        
           IF  v_parametros.id_uo  is NULL  and v_parametros.id_ep is NULL THEN
        
              raise exception 'EP y UO no pueden ser nulos simultaneamente';
        
           END IF;
           
            IF  v_parametros.id_depto is NULL THEN
        
              raise exception 'El departamento no puede ser nulo';
        
           END IF;
        
        	--Sentencia de la insercion
        	insert into param.tdepto_uo_ep(
			id_uo,
			id_depto,
			id_ep,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_uo,
			v_parametros.id_depto,
			v_parametros.id_ep,
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_depto_uo_ep into v_id_depto_uo_ep;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP almacenado(a) con exito (id_depto_uo_ep'||v_id_depto_uo_ep||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_id_depto_uo_ep::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_DUE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_DUE_MOD')then

		begin
        
            IF  v_parametros.id_uo  is NULL  and v_parametros.id_ep is NULL THEN
        
              raise exception 'EP y UO no pueden ser nulos simultaneamente';
        
           END IF;
           
            IF  v_parametros.id_depto is NULL THEN
        
              raise exception 'El departamento no puede ser nulo';
        
           END IF;
        
			--Sentencia de la modificacion
			update param.tdepto_uo_ep set
			id_uo = v_parametros.id_uo,
			id_depto = v_parametros.id_depto,
			id_ep = v_parametros.id_ep,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_depto_uo_ep=v_parametros.id_depto_uo_ep;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_parametros.id_depto_uo_ep::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_DUE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_DUE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tdepto_uo_ep
            where id_depto_uo_ep=v_parametros.id_depto_uo_ep;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DEPTO, UO, EP eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_depto_uo_ep',v_parametros.id_depto_uo_ep::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'PM_SINCEPUO_IME'
 	#DESCRIPCION:	Sincronizar todas las ep o uo en el depto selecionado
 	#AUTOR:		admin	
 	#FECHA:		03-06-2013 15:15:03
	***********************************/

	elsif(p_transaccion='PM_SINCEPUO_IME')then

		begin
			--Sentencia de la eliminacion 
            
            
            
            if v_parametros.config = 'ep' then
             
               --obtiene todas la EP
               select  
               pxp.aggarray(due.id_ep) 
                into  
                v_array_ep 
               from param.tdepto_uo_ep  due 
               where due.id_depto = v_parametros.id_depto  and due.id_uo is NULL and due.estado_reg = 'activo'; 
               
               v_count = 0;
                           
               FOR v_registros in execute('select id_ep from param.tep  where estado_reg = ''activo''  and id_ep  not in ('||COALESCE(array_to_string(v_array_ep,','),'0')||')') LOOP
              
                 
                   insert into param.tdepto_uo_ep  ( id_depto, 
                                                     id_ep,  
                                                     id_uo,  
                                                     id_usuario_reg, 
                                                     fecha_reg) 
                                            values ( v_parametros.id_depto,
                                            		 v_registros.id_ep, 
                                                     NULL, 
                                                     p_id_usuario, 
                                                     now());
                                            
                                            
                  v_count = v_count +1;
               
               
               END LOOP;
            
            else
            
                --obtiene todas la UO
               
               select  
               pxp.aggarray(due.id_uo) 
                into  
                v_array_ep 
               from param.tdepto_uo_ep  due 
               where due.id_depto = v_parametros.id_depto  and due.id_ep is NULL and due.estado_reg = 'activo';
               
               v_count = 0;
                           
               FOR v_registros in execute('select id_uo from orga.tuo  uo where uo.presupuesta = ''si'' and uo.estado_reg = ''activo'' and  id_uo  not in ('||COALESCE(array_to_string(v_array_ep,','),'0')||')') LOOP
              
                 
                   insert into param.tdepto_uo_ep  ( id_depto, 
                                                     id_ep,  
                                                     id_uo,  
                                                     id_usuario_reg, 
                                                     fecha_reg) 
                                            values ( v_parametros.id_depto,
                                            		 NULL,
                                                      v_registros.id_uo,  
                                                     p_id_usuario, 
                                                     now());
                                            
                                            
                  v_count = v_count +1;
               
               
               END LOOP;
            
            
            
            end if;
            
           
			
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','total '||v_parametros.config ||' sincronizados '|| v_count::varchar); 
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
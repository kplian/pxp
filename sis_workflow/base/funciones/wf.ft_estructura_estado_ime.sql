--------------- SQL ---------------

CREATE OR REPLACE FUNCTION wf.ft_estructura_estado_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Work Flow
 FUNCION: 		wf.ft_estructura_estado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'wf.testructura_estado'
 AUTOR: 		 (FRH)
 FECHA:	        21-02-2013 15:25:45
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
	v_id_estructura_estado	integer;
    v_disparador			varchar;
    v_fin 					varchar;
    v_id_tipo_estado		integer;
    v_bucle 				varchar;
    va_id_tipo_estado 		integer[];
	va_codigo_estado 		varchar[];
    
			    
BEGIN

    v_nombre_funcion = 'wf.ft_estructura_estado_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'WF_ESTES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:25:45
	***********************************/

	if(p_transaccion='WF_ESTES_INS')then
					
        begin
        	--Validar que un tipo_estado 'fin' no tenga hijos
        	SELECT te.fin
            INTO v_fin 
            FROM wf.ttipo_estado te
            LEFT JOIN wf.testructura_estado et ON te.id_tipo_estado = et.id_tipo_estado_padre
            WHERE te.id_tipo_estado = v_parametros.id_tipo_estado_padre;
            
            IF v_fin ilike 'si' THEN
                RAISE EXCEPTION 'No puede definirse hijos es un estado ''fin''.';
            END IF;
            
            v_bucle = 'no';
             --revisa si el nuevo hijo ocaciona un bucle
             SELECT 
              oe.ps_id_tipo_estado,
              oe.ps_codigo_estado
             into 
               va_id_tipo_estado,
               va_codigo_estado
              FROM wf.f_obtener_cadena_tipos_estados_anteriores_wf(v_parametros.id_tipo_estado_padre) oe;
            
            IF v_parametros.id_tipo_estado_hijo = ANY (va_id_tipo_estado) THEN
            
              v_bucle = 'si';
              
            END IF;
            
            
   
        	--Sentencia de la insercion
        	insert into wf.testructura_estado(
			id_tipo_estado_padre,
			id_tipo_estado_hijo,
			prioridad,
			regla,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod,
            bucle
          	) values(
			v_parametros.id_tipo_estado_padre,
			v_parametros.id_tipo_estado_hijo,
			v_parametros.prioridad,
			v_parametros.regla,
			'activo',
			now(),
			p_id_usuario,
			null,
			null,
            v_bucle
							
			)RETURNING id_estructura_estado into v_id_estructura_estado;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estrutura de estados almacenado(a) con exito (id_estructura_estado'||v_id_estructura_estado||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_estado',v_id_estructura_estado::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'WF_ESTES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:25:45
	***********************************/

	elsif(p_transaccion='WF_ESTES_MOD')then

		begin
        	--Validar que un tipo_estado 'disparador' no tenga hijos
        	SELECT te.fin
            INTO v_fin  
            FROM wf.ttipo_estado te
            LEFT JOIN wf.testructura_estado et ON te.id_tipo_estado = et.id_tipo_estado_padre
            WHERE te.id_tipo_estado = v_parametros.id_tipo_estado_padre;
            
            IF v_fin ilike 'si' THEN
                RAISE EXCEPTION 'No puede definirse hijos para un Tipo Estado Padre seleccionado. Debido a que es un estado ''disparador''.';
            END IF;
            
            
            --Sentencia de la modificacion
            select id_tipo_estado_hijo
            into v_id_tipo_estado
            from wf.testructura_estado
            where id_estructura_estado = v_parametros.id_estructura_estado;
            
            if (v_id_tipo_estado = v_parametros.id_tipo_estado_hijo)then
            	--Sentencia de la modificacion
                update wf.testructura_estado set
                prioridad = v_parametros.prioridad,
                regla = v_parametros.regla,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario
                where id_estructura_estado=v_parametros.id_estructura_estado;
                v_id_estructura_estado = v_parametros.id_estructura_estado;
			else
            	update wf.testructura_estado set
                        estado_reg = 'inactivo'
                where id_estructura_estado=v_parametros.id_estructura_estado;
                
                v_bucle = 'no';
               --revisa si el nuevo hijo ocaciona un bucle
                SELECT 
                  oe.ps_id_tipo_estado,
                  oe.ps_codigo_estado
                into 
                  va_id_tipo_estado,
                  va_codigo_estado
                FROM wf.f_obtener_cadena_tipos_estados_anteriores_wf(v_parametros.id_tipo_estado_padre) oe;
              
                IF v_parametros.id_tipo_estado_hijo = ANY (va_id_tipo_estado) THEN
                
                  v_bucle = 'si';
                  
                END IF;
                
                
				--Sentencia de la insercion
                insert into wf.testructura_estado(
                id_tipo_estado_padre,
                id_tipo_estado_hijo,
                prioridad,
                regla,
                estado_reg,
                fecha_reg,
                id_usuario_reg,
                fecha_mod,
                id_usuario_mod,
                bucle
                ) values(
                v_parametros.id_tipo_estado_padre,
                v_parametros.id_tipo_estado_hijo,
                v_parametros.prioridad,
                v_parametros.regla,
                'activo',
                now(),
                p_id_usuario,
                null,
                null,
                v_bucle
    							
                )RETURNING id_estructura_estado into v_id_estructura_estado;
            
            end if;  		
			               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estrutura de estados modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_estado',v_parametros.id_estructura_estado::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'WF_ESTES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-02-2013 15:25:45
	***********************************/

	elsif(p_transaccion='WF_ESTES_ELI')then

		begin
			--Sentencia de la eliminacion
			update wf.testructura_estado
            set estado_reg = 'inactivo'
            where id_estructura_estado=v_parametros.id_estructura_estado;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estrutura de estados eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_estado',v_parametros.id_estructura_estado::varchar);
              
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
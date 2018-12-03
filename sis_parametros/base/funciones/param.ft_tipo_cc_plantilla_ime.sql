CREATE OR REPLACE FUNCTION param.ft_tipo_cc_plantilla_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.ft_tipo_cc_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_cc'
 AUTOR: 		 (admin)
 FECHA:	        26-05-2017 10:10:19
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:	
 
 
                 COMENTARIOS:	 
  #33  ETR       18/07/2018        RAC KPLIAN        Modificar tipos de centros operativos o no
  	
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_cc_plantilla			integer;
    v_id_tipo_cc_fk			integer;
    v_reg_control			record;
    va_mov_pres_str			varchar[];
    va_momento_pres			varchar[];
			   
BEGIN

    v_nombre_funcion = 'param.ft_tipo_cc_plantilla_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_TCCPL_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Rensi Arteaga	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	if(p_transaccion='PM_TCCPL_INS')then
					
        begin
              IF v_parametros.id_tipo_cc_fk != 'id' and v_parametros.id_tipo_cc_fk != '' THEN
                   v_id_tipo_cc_fk  = v_parametros.id_tipo_cc_fk::integer;
              END IF;
             --raise EXCEPTION 'parametro %',v_parametros.id_tipo_cc_fk;
         

        
            IF EXISTS(
              select 
               1
              from param.ttipo_cc_plantilla tcc 
              where tcc.codigo = upper(v_parametros.codigo) 
                    and tcc.estado_reg = 'activo') THEN                  
               raise exception 'ya existe otra orden con el código %',v_parametros.codigo;      
            END IF;
            
            -----------------------------
            --validar nodos demoviemto
            ----------------------------
                -- cuando el nodo es de movimiento  , debe tener por lo menos un padre con techo presupeustario o el mismo 
                IF  v_parametros.movimiento = 'si'  THEN
                    IF   v_parametros.control_techo = 'no' THEN 
                         
                           v_reg_control = NULL;
                          --  verificamos que tenga un techo por encima 
                          WITH RECURSIVE tipo_cc_plantilla(id_tipo_cc_plantilla, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc_plantilla,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc_plantilla c  
                            where c.id_tipo_cc_plantilla  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc_plantilla,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc_plantilla c2, tipo_cc_plantilla pc
                            WHERE c2.id_tipo_cc_plantilla = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc_plantilla where control_techo = 'si';
                            
                            IF v_reg_control is null THEN
                               raise exception 'Todo nodo de transaccional debe tener un techo presupeustario, determine en que nodo se hará el control presupuestario';
                            END IF;
                      
                    END IF;
                    
                    
                    --cuando es un nodo hijo debe tener de manera obligatoria un EP relacioanda
                    
                   -- IF v_parametros.id_ep is null THEN
                     -- raise exception 'tiene que determinar un EP para los nodos de movimeitno';
                    --END IF;
                
                END IF;
                
                
                 -- cuando el nodo es de movimiento=si o transaccional, no debe deberia insertar mas hijos 
                IF  v_parametros.codigo is not null   THEN
                                       
                           v_reg_control = NULL;
                          --verificamos que tenga un padre tipo hoja por encima 
                            select 
                              c.id_tipo_cc_plantilla,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo,
                              c.movimiento
                            from param.ttipo_cc_plantilla c  
                            where c.id_tipo_cc_plantilla  = v_id_tipo_cc_fk and c.estado_reg = 'activo' and movimiento = 'si'
                             into v_reg_control ;           
                            IF v_reg_control is not null THEN
                               raise exception 'Un nodo transaccional no puede tener nodos dependientes';
                            END IF;
                   
                END IF;
                
                
                -- cuando un nodo es techo   presupeustario validar que no tenga otro nodo por ensima que sea techo
                 IF   v_parametros.control_techo = 'si' THEN 
                           v_reg_control = NULL;
                          --  verificamos que tenga un techo por encima 
                          WITH RECURSIVE tipo_cc_plantilla(id_tipo_cc_plantilla, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc_plantilla,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc_plantilla c  
                            where c.id_tipo_cc_plantilla  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc_plantilla,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc_plantilla c2, tipo_cc_plantilla pc
                            WHERE c2.id_tipo_cc_plantilla = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc_plantilla where control_techo = 'si';
                            
                            IF v_reg_control is not null THEN
                               raise exception 'Ya fue determiando un nodo del tipo control de techo presupeustario %', v_reg_control.codigo;
                            END IF;
                      
                END IF;
            
            IF pxp.f_existe_parametro(p_tabla,'mov_pres_str') THEN
               va_mov_pres_str = string_to_array(v_parametros.mov_pres_str,',');
            ELSE
               va_mov_pres_str = string_to_array(v_parametros.mov_pres,',');
            END IF;
            
            IF pxp.f_existe_parametro(p_tabla,'momento_pres_str') THEN
               va_momento_pres = string_to_array(v_parametros.momento_pres_str,',');
            ELSE
               va_momento_pres = string_to_array(v_parametros.momento_pres,',');
            END IF;
            
        	--Sentencia de la insercion
        	insert into param.ttipo_cc_plantilla(
                codigo,
                control_techo,
                mov_pres,
                estado_reg,
                movimiento,
                id_tipo_cc_fk,
                descripcion,
                tipo,
                control_partida,
                momento_pres,
                fecha_reg,
                usuario_ai,
                id_usuario_reg,
                id_usuario_ai,
                id_usuario_mod,
                fecha_mod,
                operativo	 -- #33 ++
          	) values(
                  upper(v_parametros.codigo),
                  v_parametros.control_techo,
                  va_mov_pres_str,
                  'activo',
                  v_parametros.movimiento,
                  v_id_tipo_cc_fk,
                  v_parametros.descripcion,
                  v_parametros.tipo,
                  v_parametros.control_partida,
                  va_momento_pres,
                  now(),
                  v_parametros._nombre_usuario_ai,
                  p_id_usuario,
                  v_parametros._id_usuario_ai,
                  null,
                  null,
                  v_parametros.operativo	-- #33 ++
			)RETURNING id_tipo_cc_plantilla into v_id_tipo_cc_plantilla;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo almacenado(a) con exito (id_tipo_cc_plantilla'||v_id_tipo_cc_plantilla||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc_plantilla',v_id_tipo_cc_plantilla::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_TCCPL_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	elsif(p_transaccion='PM_TCCPL_MOD')then

		begin
        
             IF v_parametros.id_tipo_cc_fk != 'id' and v_parametros.id_tipo_cc_fk != '' THEN
                   v_id_tipo_cc_fk  = v_parametros.id_tipo_cc_fk::integer;
             END IF;
              
        
            IF EXISTS(
                select 
                 1
                from param.ttipo_cc_plantilla tcc 
                where tcc.codigo = upper(v_parametros.codigo) 
                      and tcc.estado_reg = 'activo' 
                      and tcc.id_tipo_cc_plantilla !=  v_parametros.id_tipo_cc_plantilla) THEN  
                                      
               raise exception 'ya existe otra orden con el código %',v_parametros.codigo; 
                    
            END IF;
           
            
            -----------------------------
            --validar nodos 
            ----------------------------
            --   si es de movimeinto necesita un EP
            IF  v_parametros.movimiento = 'si'  THEN
               
                 
                 --validar que no tenga hijos activos
                 IF  exists (select 1 from param.ttipo_cc_plantilla tc where tc.id_tipo_cc_fk = v_parametros.id_tipo_cc_plantilla  and tc.estado_reg = 'activo'  )THEN
                   raise EXCEPTION 'Un nodo de movimiento no puede tener nodos hijos, elimine primero todos los hijos antes de convertir';
                 END IF;
                
                 --validar el techo presupuestario , todo nodo de movimeitno debe tener un techo
                 IF   v_parametros.control_techo = 'no'    THEN
                            --  verificamos que tenga un techo por encima 
                            WITH RECURSIVE tipo_cc_plantilla(id_tipo_cc_plantilla, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc_plantilla,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc_plantilla c  
                            where c.id_tipo_cc_plantilla  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc_plantilla,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc_plantilla c2, tipo_cc_plantilla pc
                            WHERE c2.id_tipo_cc_plantilla = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc_plantilla where control_techo = 'si';
                            
                            IF v_reg_control is null THEN
                               raise exception 'Todo nodo de transaccional debe tener un techo presupeustario, determine en que nodo se hará el control presupuestario';
                            END IF;
                 END IF;
                     
            
                --validar ep 
               -- IF  v_parametros.id_ep is null   THEN
                 --  raise exception 'los nodos de movimeinto deben tener un EP relacioanda';
                --END IF;
            END IF;
            
            IF  v_parametros.control_techo = 'si'  THEN
                  
                  v_reg_control = NULL;
                  -- validar que no tenga un techo abajo
                  WITH RECURSIVE tipo_cc_plantilla(id_tipo_cc_plantilla, id_tipo_cc_fk, codigo, control_techo) AS (
                    select 
                      c.id_tipo_cc_plantilla,
                      c.id_tipo_cc_fk,
                      c.codigo,
                      c.control_techo
                    from param.ttipo_cc_plantilla c  
                    where c.id_tipo_cc_fk  = v_parametros.id_tipo_cc_plantilla  and c.estado_reg = 'activo'
                    UNION
                    SELECT
                     c2.id_tipo_cc_plantilla,
                     c2.id_tipo_cc_fk,
                     c2.codigo,
                     c2.control_techo
                    FROM param.ttipo_cc_plantilla c2, tipo_cc_plantilla pc
                    WHERE c2.id_tipo_cc_fk = pc.id_tipo_cc_plantilla and c2.estado_reg = 'activo'
                    )
                  
                    SELECT * into v_reg_control  FROM tipo_cc_plantilla where control_techo = 'si';
                            
                    IF v_reg_control is not null THEN
                       raise exception 'Ya fue determiando un nodo del tipo control de techo presupeustario por debajo código:  %', v_reg_control.codigo;
                    END IF;
                  
                  v_reg_control = NULL;
                  -- validar que no tenga un techo encima                
                  WITH RECURSIVE tipo_cc_plantilla(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                    select 
                      c.id_tipo_cc_plantilla,
                      c.id_tipo_cc_fk,
                      c.codigo,
                      c.control_techo
                    from param.ttipo_cc_plantilla c  
                    where c.id_tipo_cc_plantilla  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                    UNION
                    SELECT
                     c2.id_tipo_cc_plantilla,
                     c2.id_tipo_cc_fk,
                     c2.codigo,
                     c2.control_techo
                    FROM param.ttipo_cc_plantilla c2, tipo_cc_plantilla pc
                    WHERE c2.id_tipo_cc_plantilla = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                    )
                    SELECT * into v_reg_control  FROM tipo_cc_plantilla where control_techo = 'si';
                            
                    IF v_reg_control is not null THEN
                       raise exception 'Ya fue determiando un nodo del tipo control de techo presupeustario mas arriba, código:  %', v_reg_control.codigo;
                    END IF;
                  
                 
                  
            END IF;
            
            IF pxp.f_existe_parametro(p_tabla,'mov_pres_str') THEN
               va_mov_pres_str = string_to_array(v_parametros.mov_pres_str,',');
            ELSE
               va_mov_pres_str = string_to_array(v_parametros.mov_pres,',');
            END IF;
            
            
            IF pxp.f_existe_parametro(p_tabla,'momento_pres_str') THEN
               va_momento_pres = string_to_array(v_parametros.momento_pres_str,',');
            ELSE
               va_momento_pres = string_to_array(v_parametros.momento_pres,',');
            END IF;
            
            
            
               
			--Sentencia de la modificacion
			update param.ttipo_cc_plantilla set
                  codigo = upper(v_parametros.codigo),
                  control_techo = v_parametros.control_techo,
                  mov_pres =  va_mov_pres_str,
                  movimiento = v_parametros.movimiento,
                  id_tipo_cc_fk = v_id_tipo_cc_fk,
                  descripcion = v_parametros.descripcion,
                  tipo = v_parametros.tipo,
                  control_partida = v_parametros.control_partida,
                  momento_pres = va_momento_pres,
                  id_usuario_mod = p_id_usuario,
                  fecha_mod = now(),
                  id_usuario_ai = v_parametros._id_usuario_ai,
                  usuario_ai = v_parametros._nombre_usuario_ai,
                  operativo = v_parametros.operativo
            where id_tipo_cc_plantilla=v_parametros.id_tipo_cc_plantilla;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc_plantilla',v_parametros.id_tipo_cc_plantilla::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_TCCPL_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-05-2017 10:10:19
	***********************************/

	elsif(p_transaccion='PM_TCCPL_ELI')then

		begin
			
            
            --verificar que no tenga nodos hijos
            IF exists (select 
             				1
                        from param.ttipo_cc_plantilla tc
                        where tc.id_tipo_cc_fk = v_parametros.id_tipo_cc_plantilla) THEN
                      raise exception 'El nodo que quiere eliminar tiene nodos hijos, elimine los hijos primeramente';
            END IF;   
            
            --revisar que no este relacioando a ningun centor de costos -ver relacion de centro de costo con plantilla
            
            --IF exists (select 
             	--			1
             --           from param.tcentro_costo cc
               --         where cc.id_tipo_cc_plantilla = v_parametros.id_tipo_cc_plantilla) THEN
                 --     raise exception 'El nodo que quiere eliminar tiene centros de costos relacionados, elimine la relación antes de continuar';
            --END IF;  
                    
            
            --Sentencia de la eliminacion
			delete from param.ttipo_cc_plantilla
            where id_tipo_cc_plantilla=v_parametros.id_tipo_cc_plantilla;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_parametros.id_tipo_cc_plantilla::varchar);
              
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
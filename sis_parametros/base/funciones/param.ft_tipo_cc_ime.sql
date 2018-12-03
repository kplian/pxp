CREATE OR REPLACE FUNCTION param.ft_tipo_cc_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:    Parametros Generales
 FUNCION:     param.ft_tipo_cc_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.ttipo_cc'
 AUTOR:      (admin)
 FECHA:          26-05-2017 10:10:19
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

  v_nro_requerimiento      integer;
  v_parametros             record;
  v_id_requerimiento       integer;
  v_resp                varchar;
  v_nombre_funcion        text;
  v_mensaje_error         text;
  v_id_tipo_cc      integer;
    v_id_tipo_cc_fk      integer;
    v_reg_control      record;
    va_mov_pres_str      varchar[];
    va_momento_pres      varchar[];
    
    item          record;
    item_padre        record;
    item_hijos        record;
    v_codigo        varchar;
    v_padre              varchar;
    v_padre_id         integer;
    v_comparacion           integer;
    v_agrupador        varchar;
    v_tipo_array      varchar[];
          
BEGIN

    v_nombre_funcion = 'param.ft_tipo_cc_ime';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
   #TRANSACCION:  'PM_TCC_INS'
   #DESCRIPCION:  Insercion de registros
   #AUTOR:    Rensi Arteaga  
   #FECHA:    26-05-2017 10:10:19
  ***********************************/

  if(p_transaccion='PM_TCC_INS')then
          
        begin
        
              IF v_parametros.id_tipo_cc_fk != 'id' and v_parametros.id_tipo_cc_fk != '' THEN
                   v_id_tipo_cc_fk  = v_parametros.id_tipo_cc_fk::integer;
              END IF;
              
        
            IF EXISTS(
              select 
               1
              from param.ttipo_cc tcc 
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
                          WITH RECURSIVE tipo_cc(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc c  
                            where c.id_tipo_cc  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc c2, tipo_cc pc
                            WHERE c2.id_tipo_cc = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc where control_techo = 'si';
                            
                            IF v_reg_control is null THEN
                               raise exception 'Todo nodo de transaccional debe tener un techo presupeustario, determine en que nodo se hará el control presupuestario';
                            END IF;
                      
                    END IF;
                    
                    
                    --cuando es un nodo hijo debe tener de manera obligatoria un EP relacioanda
                    
                    IF v_parametros.id_ep is null THEN
                      raise exception 'tiene que determinar un EP para los nodos de movimeitno';
                    END IF;
                
                END IF;
                
                
                -- cuando un nodo es techo   presupeustario validar que no tenga otro nodo por ensima que sea techo
                 IF   v_parametros.control_techo = 'si' THEN 
                           v_reg_control = NULL;
                          --  verificamos que tenga un techo por encima 
                          WITH RECURSIVE tipo_cc(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc c  
                            where c.id_tipo_cc  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc c2, tipo_cc pc
                            WHERE c2.id_tipo_cc = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc where control_techo = 'si';
                            
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
          insert into param.ttipo_cc(
                codigo,
                control_techo,
                mov_pres,
                estado_reg,
                movimiento,
                id_ep,
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
                fecha_inicio,
                fecha_final,
                operativo   -- #33 ++
            ) values(
                  upper(v_parametros.codigo),
                  v_parametros.control_techo,
                  va_mov_pres_str,
                  'activo',
                  v_parametros.movimiento,
                  v_parametros.id_ep,
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
                  v_parametros.fecha_inicio,
                  v_parametros.fecha_final,
                  v_parametros.operativo  -- #33 ++
      )RETURNING id_tipo_cc into v_id_tipo_cc;
      
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo almacenado(a) con exito (id_tipo_cc'||v_id_tipo_cc||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_id_tipo_cc::varchar);

            --Devuelve la respuesta
            return v_resp;

    end;

  /*********************************    
   #TRANSACCION:  'PM_TCC_MOD'
   #DESCRIPCION:  Modificacion de registros
   #AUTOR:    admin  
   #FECHA:    26-05-2017 10:10:19
  ***********************************/

  elsif(p_transaccion='PM_TCC_MOD')then

    begin
        
             IF v_parametros.id_tipo_cc_fk != 'id' and v_parametros.id_tipo_cc_fk != '' THEN
                   v_id_tipo_cc_fk  = v_parametros.id_tipo_cc_fk::integer;
             END IF;
              
        
            IF EXISTS(
                select 
                 1
                from param.ttipo_cc tcc 
                where tcc.codigo = upper(v_parametros.codigo) 
                      and tcc.estado_reg = 'activo' 
                      and tcc.id_tipo_cc !=  v_parametros.id_tipo_cc) THEN  
                                      
               raise exception 'ya existe otra orden con el código %',v_parametros.codigo; 
                    
            END IF;
           
            
            -----------------------------
            --validar nodos 
            ----------------------------
            --   si es de movimeinto necesita un EP
            IF  v_parametros.movimiento = 'si'  THEN
               
                 
                 --validar que no tenga hijos activos
                 IF  exists (select 1 from param.ttipo_cc tc where tc.id_tipo_cc_fk = v_parametros.id_tipo_cc  and tc.estado_reg = 'activo'  )THEN
                   raise EXCEPTION 'Un nodo de movimiento no puede tener nodos hijos, elimine primero todos los hijos antes de convertir';
                 END IF;
                
                 --validar el techo presupuestario , todo nodo de movimeitno debe tener un techo
                 IF   v_parametros.control_techo = 'no'    THEN
                            --  verificamos que tenga un techo por encima 
                            WITH RECURSIVE tipo_cc(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                            select 
                              c.id_tipo_cc,
                              c.id_tipo_cc_fk,
                              c.codigo,
                              c.control_techo
                            from param.ttipo_cc c  
                            where c.id_tipo_cc  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                            UNION
                            SELECT
                             c2.id_tipo_cc,
                             c2.id_tipo_cc_fk,
                             c2.codigo,
                             c2.control_techo
                            FROM param.ttipo_cc c2, tipo_cc pc
                            WHERE c2.id_tipo_cc = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                            )
                            SELECT * into v_reg_control  FROM tipo_cc where control_techo = 'si';
                            
                            IF v_reg_control is null THEN
                               raise exception 'Todo nodo de transaccional debe tener un techo presupeustario, determine en que nodo se hará el control presupuestario';
                            END IF;
                 END IF;
                     
            
                --validar ep 
                IF  v_parametros.id_ep is null   THEN
                   raise exception 'los nodos de movimeinto deben tener un EP relacioanda';
                END IF;
            END IF;
            
            IF  v_parametros.control_techo = 'si'  THEN
                  
                  v_reg_control = NULL;
                  -- validar que no tenga un techo abajo
                  WITH RECURSIVE tipo_cc(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                    select 
                      c.id_tipo_cc,
                      c.id_tipo_cc_fk,
                      c.codigo,
                      c.control_techo
                    from param.ttipo_cc c  
                    where c.id_tipo_cc_fk  = v_parametros.id_tipo_cc  and c.estado_reg = 'activo'
                    UNION
                    SELECT
                     c2.id_tipo_cc,
                     c2.id_tipo_cc_fk,
                     c2.codigo,
                     c2.control_techo
                    FROM param.ttipo_cc c2, tipo_cc pc
                    WHERE c2.id_tipo_cc_fk = pc.id_tipo_cc and c2.estado_reg = 'activo'
                    )
                  
                    SELECT * into v_reg_control  FROM tipo_cc where control_techo = 'si';
                            
                    IF v_reg_control is not null THEN
                       raise exception 'Ya fue determiando un nodo del tipo control de techo presupeustario por debajo código:  %', v_reg_control.codigo;
                    END IF;
                  
                  v_reg_control = NULL;
                  -- validar que no tenga un techo encima                
                  WITH RECURSIVE tipo_cc(id_tipo_cc, id_tipo_cc_fk, codigo, control_techo) AS (
                    select 
                      c.id_tipo_cc,
                      c.id_tipo_cc_fk,
                      c.codigo,
                      c.control_techo
                    from param.ttipo_cc c  
                    where c.id_tipo_cc  = v_id_tipo_cc_fk  and c.estado_reg = 'activo'
                    UNION
                    SELECT
                     c2.id_tipo_cc,
                     c2.id_tipo_cc_fk,
                     c2.codigo,
                     c2.control_techo
                    FROM param.ttipo_cc c2, tipo_cc pc
                    WHERE c2.id_tipo_cc = pc.id_tipo_cc_fk and c2.estado_reg = 'activo'
                    )
                    SELECT * into v_reg_control  FROM tipo_cc where control_techo = 'si';
                            
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
      update param.ttipo_cc set
                  codigo = upper(v_parametros.codigo),
                  control_techo = v_parametros.control_techo,
                  mov_pres =  va_mov_pres_str,
                  movimiento = v_parametros.movimiento,
                  id_ep = v_parametros.id_ep,
                  id_tipo_cc_fk = v_id_tipo_cc_fk,
                  descripcion = v_parametros.descripcion,
                  tipo = v_parametros.tipo,
                  control_partida = v_parametros.control_partida,
                  momento_pres = va_momento_pres,
                  id_usuario_mod = p_id_usuario,
                  fecha_mod = now(),
                  id_usuario_ai = v_parametros._id_usuario_ai,
                  usuario_ai = v_parametros._nombre_usuario_ai,
                  fecha_inicio = v_parametros.fecha_inicio,
                  fecha_final = v_parametros.fecha_final,
                  operativo = v_parametros.operativo
            where id_tipo_cc=v_parametros.id_tipo_cc;
               
      --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_parametros.id_tipo_cc::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
    end;

  /*********************************    
   #TRANSACCION:  'PM_TCC_ELI'
   #DESCRIPCION:  Eliminacion de registros
   #AUTOR:    admin  
   #FECHA:    26-05-2017 10:10:19
  ***********************************/

  elsif(p_transaccion='PM_TCC_ELI')then

    begin
      
            
            --verificar que no tenga nodos hijos
            IF exists (select 
                     1
                        from param.ttipo_cc tc
                        where tc.id_tipo_cc_fk = v_parametros.id_tipo_cc) THEN
                      raise exception 'El nodo que quiere eliminar tiene nodos hijos, elimine los hijos primeramente';
            END IF;   
            
            --revisar que no este relacioando a ningun centor de costos
            IF exists (select 
                     1
                        from param.tcentro_costo cc
                        where cc.id_tipo_cc = v_parametros.id_tipo_cc) THEN
                      raise exception 'El nodo que quiere eliminar tiene centros de costos relacionados, elimine la relación antes de continuar';
            END IF;  
                    
            
            --Sentencia de la eliminacion
      delete from param.ttipo_cc
            where id_tipo_cc=v_parametros.id_tipo_cc;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_parametros.id_tipo_cc::varchar);
              
            --Devuelve la respuesta
            return v_resp;

    end;
     
        
  /*********************************    
   #TRANSACCION:  'PM_TCCAP_INS'
   #DESCRIPCION:  Insercion de registros de plantilla
   #AUTOR:      EGS
   #FECHA:      16/08/2018
  ***********************************/

  elsif(p_transaccion='PM_TCCAP_INS')then
          
        begin
           
             FOR item IN (
               ---nota :el padre en la consulta siempre esta ordenado antes que los hijos --
                      WITH RECURSIVE arbol  AS(   SELECT r.id_tipo_cc_plantilla,
                                                         r.id_tipo_cc_fk, 
                                                         r.descripcion,
                                                         r.tipo,
                                                         r.codigo,
                                                         r.mov_pres,
                                                         r.control_techo,
                                                         r.control_partida,
                                                         r.momento_pres,
                                                         r.movimiento,
                                                         r.operativo,
                                                         r.codigo as padre_codigo  
                                                    FROM param.ttipo_cc_plantilla r
                                                   WHERE r.id_tipo_cc_plantilla = v_parametros.id_tipo_cc_plantilla
                                              UNION ALL
                                                       SELECT  t.id_tipo_cc_plantilla,
                                                               t.id_tipo_cc_fk, 
                                                               t.descripcion,
                                                               t.tipo,
                                                               t.codigo,
                                                               t.mov_pres,
                                                               t.control_techo,
                                                               t.control_partida,
                                                               t.momento_pres,
                                                               t.movimiento,
                                                               t.operativo,
                                                        al.codigo as padre_codigo  
                                                       FROM param.ttipo_cc_plantilla t
                                                       JOIN arbol al ON al.id_tipo_cc_plantilla=t.id_tipo_cc_fk
                                                        )
                        select * from arbol
                    order by arbol.id_tipo_cc_plantilla ASC
              )LOOP
              
              
               v_codigo = v_parametros.codigo||'-'||item.codigo;     
              --raise exception 'codigo encadenado %',v_codigo;
             
            IF(item.id_tipo_cc_fk is  null)then
                  v_id_tipo_cc_fk = v_parametros.id_tipo_cc;
                    
                     insert into param.ttipo_cc(
                                   id_tipo_cc_fk, 
                                   descripcion,
                                   tipo,
                                   codigo,
                                   mov_pres,
                                   control_techo,
                                   control_partida,
                                   momento_pres,
                                   movimiento,
                                   operativo,  -- #33 ++
                                   fecha_reg,
                                   id_usuario_reg
                                   
                            ) values(                   
                                     v_id_tipo_cc_fk,
                                     item.descripcion::VARCHAR,
                                     item.tipo::VARCHAR,
                                     upper(v_codigo)::VARCHAR,
                                     item.mov_pres::character varying[],
                                     item.control_techo::VARCHAR,
                                     item.control_partida::VARCHAR,
                                     item.momento_pres::character varying[] ,
                                     item.movimiento::VARCHAR,
                                     item.operativo::VARCHAR,  -- #33 ++
                                     now(),
                                     p_id_usuario
                                     
                            );
     
                     -- raise exception 'hola fk%',v_id_tipo_cc_fk ;
              ELSE   
             
                       v_padre = v_parametros.codigo||'-'||item.padre_codigo;
                          /*
                          for item_padre in (select t.id_tipo_cc,
                                                     t.codigo,
                                                     t.id_tipo_cc_fk 
                                          from param.ttipo_cc t 
                                          where 
                                          t.codigo = v_padre)loop
                                          
                                          v_padre_id= item_padre.id_tipo_cc;*/
                                          
                            select t.id_tipo_cc
                                          from param.ttipo_cc t 
                                          where 
                                          t.codigo = v_padre
                                          into v_padre_id;
                  
                        -- end loop;   
                                   insert into param.ttipo_cc(
                                   id_tipo_cc_fk, 
                                   descripcion,
                                   tipo,
                                   codigo,
                                   mov_pres,
                                   control_techo,
                                   control_partida,
                                   momento_pres,
                                   movimiento,
                                   operativo,  -- #33 ++
                                   fecha_reg,
                                   id_usuario_reg
                                   
                            ) values(                   
                                     v_padre_id,
                                     item.descripcion::VARCHAR,
                                     item.tipo::VARCHAR,
                                     upper(v_codigo)::VARCHAR,
                                     item.mov_pres::character varying[],
                                     item.control_techo::VARCHAR,
                                     item.control_partida::VARCHAR,
                                     item.momento_pres::character varying[] ,
                                     item.movimiento::VARCHAR,
                                     item.operativo::VARCHAR,  -- #33 ++
                                     now(),
                                     p_id_usuario
                                     
                            );
                     
                          
                  
              END IF;
             
              
              END LOOP;
                       
         
      
      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Centro de Costo desde planilla almacenado(a) con exito'); 
           --v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_id_tipo_cc::varchar);

            --Devuelve la respuesta
            return v_resp;

    end;
    /*********************************    
   #TRANSACCION:  'PM_AUTO_INS'
   #DESCRIPCION:  Asignar autorizacion
   #AUTOR:      MMV
   #FECHA:      20/08/2018
  ***********************************/
    elsif(p_transaccion='PM_AUTO_INS')then
          
        begin
        
    -- raise exception 'llegas %',v_parametros.id_tipo_cc;
     
     
         WITH RECURSIVE tipo_cc(id_tipo_cc_fk,codigo,descripcion,id_tipo_cc) AS(
                        select   tcc.id_tipo_cc_fk,
                            tcc.codigo,
                                tcc.descripcion,
                                tcc.id_tipo_cc
                        from param.ttipo_cc tcc
                        where tcc.id_tipo_cc = v_parametros.id_tipo_cc
                        union all
                        select   tcc2.id_tipo_cc_fk,
                            tcc2.codigo,
                                tcc2.descripcion,
                                tcc2.id_tipo_cc
                        from tipo_cc tcc1 
                        inner join param.ttipo_cc tcc2 on tcc2.id_tipo_cc_fk = tcc1.id_tipo_cc
                        )SELECT pxp.list(cc.id_tipo_cc::varchar)
                         into
                         v_agrupador
                         FROM tipo_cc cc;
              
            v_tipo_array = string_to_array(v_agrupador,',');
            
             update param.ttipo_cc set 
              autorizacion = string_to_array(v_parametros.autorizacion,',')::varchar[] 
              where id_tipo_cc::varchar = ANY(v_tipo_array);
        
          --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se registro las autorizacion con exito'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_cc',v_parametros.id_tipo_cc::varchar);

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
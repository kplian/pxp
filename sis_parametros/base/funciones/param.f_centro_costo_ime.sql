--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_centro_costo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_centro_costo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tcentro_costo'
 AUTOR: 		 (admin)
 FECHA:	        19-02-2013 22:53:59
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
	v_id_centro_costo		integer;
    v_registros				record;
			    
BEGIN

    v_nombre_funcion = 'param.f_centro_costo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CEC_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	if(p_transaccion='PM_CEC_INS')then
					
        begin
        
             --  validar que el el id_tipo_cc sea un nodo hoja y tenga un techo presupeustario definidio
             
             select 
               tcc.movimiento,
               tcc.id_ep,
               tcc.codigo,
               tcc.descripcion
              into
               v_registros
             from param.ttipo_cc tcc
             where tcc.id_tipo_cc = v_parametros.id_tipo_cc;
            
            IF  v_registros.movimiento != 'si' THEN
               raise exception 'solo puede crear centro de costos para tipos que sean de  movimiento';
            END IF;
            
            --  validar que cada id_tipo_cc solo se use para una vez en cada gestion
            IF  EXISTS (select 1
                        from param.tcentro_costo cc 
                        where    cc.id_tipo_cc = v_parametros.id_tipo_cc 
                             and cc.id_gestion = v_parametros.id_gestion 
                             and cc.estado_reg = 'activo') THEN
                 raise exception 'este tipo ya tiene un centro de costo registrado para esta gestión';
            END IF;
            
        
        	--Sentencia de la insercion
        	insert into param.tcentro_costo(
              estado_reg,
              id_ep,
              id_gestion,
              id_uo,
              id_usuario_reg,
              fecha_reg,
              id_usuario_mod,
              fecha_mod,
              id_tipo_cc
          	) values(
              'activo',
              v_registros.id_ep,  --RAC 05/06/2017 la ep se origina en el tipo de centro
              v_parametros.id_gestion,
              v_parametros.id_uo,
              p_id_usuario,
              now(),
              null,
              null,
              v_parametros.id_tipo_cc							
			)RETURNING id_centro_costo into v_id_centro_costo;
            
            -- chequear si existe el esquema de presupeustos
            IF EXISTS (
               SELECT 1
               FROM   information_schema.tables 
               WHERE  table_schema = 'pre'
               AND    table_name = 'tpresupuesto'
            ) THEN
            
            -- si existe insertar el presupuesto para este centro de costo con el mismo ID
                
             --Sentencia de la insercion
                  insert into pre.tpresupuesto(
                    id_presupuesto,
                    id_centro_costo,
                    estado,
                    estado_reg,
                    id_usuario_reg,
                    fecha_reg,
                    descripcion
                  ) values(
                    v_id_centro_costo,
                    v_id_centro_costo,
                    'borrador', --crea el presupeusto en estado borrador
                    'activo',
                    p_id_usuario,
                    now(),
                    ('('||v_registros.codigo||') '||v_registros.descripcion)::varchar
      							
                  );
                
                -- el tipo de presupeusto
            
            END IF;
            
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos almacenado(a) con exito (id_centro_costo'||v_id_centro_costo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_id_centro_costo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_MOD')then

		begin
            
            
             select 
               tcc.movimiento,
               tcc.id_ep,
               tcc.codigo,
               tcc.descripcion
              into
               v_registros
             from param.ttipo_cc tcc
             where tcc.id_tipo_cc = v_parametros.id_tipo_cc;
            
            IF  v_registros.movimiento != 'si' THEN
               raise exception 'solo puede crear centro de costos para tipos que sean de  movimiento';
            END IF;
            
            --  validar que cada id_tipo_cc solo se use para una vez en cada gestion
            IF  EXISTS (select 1
                        from param.tcentro_costo cc 
                        where    cc.id_tipo_cc = v_parametros.id_tipo_cc 
                             and cc.id_gestion = v_parametros.id_gestion 
                             and cc.estado_reg = 'activo'
                             and cc.id_centro_costo !=  v_parametros.id_centro_costo) THEN
                             
                 raise exception 'este tipo ya tiene un centro de costo registrado para esta gestión';
            END IF;
            
        
			--Sentencia de la modificacion
			update param.tcentro_costo set
                id_ep =   v_registros.id_ep,  --RAC 05/06/"017 la ep se origina en el tipo de centro
                id_gestion = v_parametros.id_gestion,
                id_uo = v_parametros.id_uo,
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_tipo_cc = v_parametros.id_tipo_cc
			where id_centro_costo=v_parametros.id_centro_costo;
            
            
            --modificamos el presupeusto si existe
             -- chequear si existe el esquema de presupeustos
            IF EXISTS (
               SELECT 1
               FROM   information_schema.tables 
               WHERE  table_schema = 'pre'
               AND    table_name = 'tpresupuesto'
            ) THEN
            
                 --Sentencia de la insercion
                 update  pre.tpresupuesto set
                   descripcion = ('('||v_registros.codigo||') '||v_registros.descripcion)::varchar
                 where id_presupuesto = v_parametros.id_centro_costo;	
            END IF;
            
            
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CEC_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-02-2013 22:53:59
	***********************************/

	elsif(p_transaccion='PM_CEC_ELI')then

		begin
			
            
            
             -- chequear si existe el esquema de presupeustos
            IF EXISTS (
               SELECT 1
               FROM   information_schema.tables 
               WHERE  table_schema = 'pre'
               AND    table_name = 'tpresupuesto'
            ) THEN
            
               --Sentencia de la eliminacion
                delete from pre.tpresupuesto
                where id_presupuesto=v_parametros.id_centro_costo;
            
            END IF;
            
            
            
            --Sentencia de la eliminacion
			delete from param.tcentro_costo
            where id_centro_costo=v_parametros.id_centro_costo;
            
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Centro de Costos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_centro_costo',v_parametros.id_centro_costo::varchar);
              
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
--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_concepto_ingas_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_concepto_ingas_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tconcepto_ingas'
 AUTOR: 		 (admin)
 FECHA:	        25-02-2013 19:49:23
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
    v_registros				record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_concepto_ingas		integer;
    v_dim 					integer;
    v_consulta				varchar;
    v_nombre_conexion		varchar;
    v_id_concepto_endesis	integer;
			    
BEGIN

    v_nombre_funcion = 'param.f_concepto_ingas_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_CONIG_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	if (p_transaccion='PM_CONIG_INS') then
					
        begin
        	--Sentencia de la insercion
        	insert into param.tconcepto_ingas(
                desc_ingas,
                tipo,
                movimiento,
                sw_tes,
    		
                estado_reg,
                id_usuario_reg,
                fecha_reg,
                fecha_mod,
                id_usuario_mod,
                activo_fijo,
                almacenable,
                id_unidad_medida,
                nandina,
                id_cat_concepto
          	) values(
                v_parametros.desc_ingas,
                v_parametros.tipo,
                v_parametros.movimiento,
                v_parametros.sw_tes,		
                'activo',
                p_id_usuario,
                now(),
                null,
                null,
                v_parametros.activo_fijo,
                v_parametros.almacenable,
                v_parametros.id_unidad_medida,
                v_parametros.nandina,
              	v_parametros.id_cat_concepto				
			)RETURNING id_concepto_ingas into v_id_concepto_ingas;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Conceptos de Ingreso/Gasto almacenado(a) con exito (id_concepto_ingas'||v_id_concepto_ingas||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_id_concepto_ingas::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONIG_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIG_MOD')then

		begin
       
			--Sentencia de la modificacion
			update param.tconcepto_ingas set
                desc_ingas = v_parametros.desc_ingas,
                tipo = v_parametros.tipo,
                movimiento = v_parametros.movimiento,
                sw_tes = v_parametros.sw_tes,
                id_unidad_medida = v_parametros.id_unidad_medida,
                nandina = v_parametros.nandina,
    			fecha_mod = now(),
                id_usuario_mod = p_id_usuario,
                activo_fijo=v_parametros.activo_fijo,
                almacenable =v_parametros.almacenable,
                id_cat_concepto = v_parametros.id_cat_concepto
			where id_concepto_ingas=v_parametros.id_concepto_ingas;
            --si se integra con endesis actualizamos la tabla conceptoingas  
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
             
                select * into v_nombre_conexion from migra.f_crear_conexion();
                
                for v_registros in (select id_concepto_ingas 
                                    from migra.tconcepto_ids ci 
                                    where id_concepto_ingas_pxp = v_parametros.id_concepto_ingas) loop
                                   -- raise exception 'llega%',v_registros.id_concepto_ingas;
                    select * FROM dblink(v_nombre_conexion,'
                        select migracion.f_mig_concepto_ingas__tpr_concepto_ingas(' || v_registros.id_concepto_ingas || 
                        ',''UPD'',''' || v_parametros.desc_ingas || 
                        ''',NULL,' || v_parametros.sw_tes ||
                        ',NULL,'''|| v_parametros.tipo ||
                        ''','''|| v_parametros.activo_fijo ||
                        ''','''|| v_parametros.almacenable ||
                        ''','|| p_id_usuario ||                    
                    ')',true) AS (id_concepto_endesis integer) into v_id_concepto_endesis;
                
                end loop;
            	select * into v_resp from migra.f_cerrar_conexion(v_nombre_conexion,'exito');
             
             end if;
                   
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Conceptos de Ingreso/Gasto modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_CONIG_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONIG_ELI')then

		begin
			--Sentencia de la eliminacion
			update param.tconcepto_ingas
            set estado_reg = 'inactivo'
            where id_concepto_ingas=v_parametros.id_concepto_ingas;
            
            --si se integra con endesis actualizamos la tabla conceptoingas  
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
            	if (EXISTS(select 1 from pre.tconcepto_partida cp 
                		   where cp.id_concepto_ingas = v_parametros.id_concepto_ingas and
                           cp.estado_reg = 'activo')) then
                	raise exception 'Existen partidas asociadas a este concepto, Eliminelas antes de eliminar este concepto';
                
                end if;
            end if;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Conceptos de Ingreso/Gasto eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
     
    /*********************************    
 	#TRANSACCION:  'PM_CONEDOT_IME'
 	#DESCRIPCION:	Permite adicionar o quitar la grupos de OT autorizados para este concepto de gasto
 	#AUTOR:		admin	
 	#FECHA:		25-02-2013 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CONEDOT_IME')then

		begin
        
        
             v_dim = array_upper(string_to_array(v_parametros.id_grupo_ots,',')::integer[], 1);
             IF v_parametros.filtro_ot = 'listado'  THEN
                --si el filtro es de tipo listado preguntamos si tiene un listado de grupos
                IF v_dim < 1 or v_dim is null THEN
                  raise exception  'No definio nigún grupo de OTs';
                END IF;
             
             END IF;
        
        
			update param.tconcepto_ingas set
			id_grupo_ots = string_to_array(v_parametros.id_grupo_ots,',')::integer[],
            filtro_ot = v_parametros.filtro_ot ,
            requiere_ot = v_parametros.requiere_ot
            where id_concepto_ingas=v_parametros.id_concepto_ingas;
               
            if (pxp.f_get_variable_global('sincronizar') = 'true') then
             
                select * into v_nombre_conexion from migra.f_crear_conexion(); 
                
                --recupera datos del concepto ... 
                select 
                   COALESCE(pxp.list(cid.id_concepto_ingas::text),'0') as listado
                into v_registros
                from param.tconcepto_ingas ci 
                inner join migra.tconcepto_ids cid on cid.id_concepto_ingas_pxp = ci.id_concepto_ingas
                where ci.id_concepto_ingas = v_parametros.id_concepto_ingas; 
                 
                
                 v_consulta = 'UPDATE 
                                  presto.tpr_concepto_ingas 
                                SET 
                                  id_grupo_ots = string_to_array('''||v_parametros.id_grupo_ots||''','','')::integer[]
                                WHERE 
                                  id_concepto_ingas in ('|| v_registros.listado ||')';
                 
                 perform  dblink(v_nombre_conexion, v_consulta, true);
                 
                 
                 select * into v_resp from migra.f_cerrar_conexion(v_nombre_conexion,'exito');
             
             end if;
            
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se modificaron las OT del concepto de gasto(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;   
        
    /*********************************    
 	#TRANSACCION:  'PM_COAUTO_IME'
 	#DESCRIPCION:	Permite configurar las autorizaciones para los conceptos de gastos (adquisiciones, caja, fondos en avances, pago directo)
 	#AUTOR:		rac	
 	#FECHA:		18-11-2014 19:49:23
	***********************************/

	elsif(p_transaccion='PM_COAUTO_IME')then

		begin
        
        
             update param.tconcepto_ingas set
			  sw_autorizacion = string_to_array(v_parametros.sw_autorizacion,',')::varchar[]
             where id_concepto_ingas=v_parametros.id_concepto_ingas;
             
             --si se integra con endesis actualizamos la tabla conceptoingas  
             if (pxp.f_get_variable_global('sincronizar') = 'true') then
             
                select * into v_nombre_conexion from migra.f_crear_conexion(); 
                
                --recupera datos del concepto ... 
                select 
                   COALESCE(pxp.list(cid.id_concepto_ingas::text),'0') as listado
                into v_registros
                from param.tconcepto_ingas ci 
                inner join migra.tconcepto_ids cid on cid.id_concepto_ingas_pxp = ci.id_concepto_ingas
                where ci.id_concepto_ingas = v_parametros.id_concepto_ingas; 
                 
                
                 v_consulta = 'UPDATE 
                                  presto.tpr_concepto_ingas 
                                SET 
                                  sw_autorizacion = string_to_array('''||v_parametros.sw_autorizacion||''','','')::varchar[]
                                WHERE 
                                  id_concepto_ingas in ('|| v_registros.listado ||')';
                 
                 perform  dblink(v_nombre_conexion, v_consulta, true);
                 
                 
                 select * into v_resp from migra.f_cerrar_conexion(v_nombre_conexion,'exito');
             
             end if;
             --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Se modificaron las OT del concepto de gasto(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end; 
         
	/*********************************    
 	#TRANSACCION:  'PM_CIGIMG_MOD'
 	#DESCRIPCION:	Subir imagen para el ceoncepto de gasto / ingreso
 	#AUTOR:		rac	
 	#FECHA:		26-10-2016 19:49:23
	***********************************/

	elsif(p_transaccion='PM_CIGIMG_MOD')then

		begin
       
			--Sentencia de la modificacion
			update param.tconcepto_ingas set
              ruta_foto = v_parametros.ruta_foto,	
              fecha_mod = now(),
              id_usuario_mod = p_id_usuario
			where id_concepto_ingas=v_parametros.id_concepto_ingas;
            
                   
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Imagen cambiada para concepto de gasto'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_concepto_ingas',v_parametros.id_concepto_ingas::varchar);
               
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
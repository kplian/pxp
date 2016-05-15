--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_gestion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_gestion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'param.tgestion'
 AUTOR: 		 (admin)
 FECHA:	        05-02-2013 09:56:59
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
	v_id_gestion			integer;
    v_fecha_ini 			date;
    v_fecha_fin 			date;
    v_cont 					integer;
    v_anho 					integer;
    v_id_periodo 			integer;
    v_rec					record;
    
    
    v_fecha_ini_quin DATE;
    v_fecha_fin_quin DATE;

    v_fecha_ini_quin_aux DATE;
    v_fecha_fin_quin_aux DATE;
    
			    
BEGIN

    v_nombre_funcion = 'param.f_gestion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'PM_GES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	if(p_transaccion='PM_GES_INS')then
    
		begin
           
            --(1) Validación de existencia de la gestión
            if exists(select 1 from param.tgestion
            		where gestion = v_parametros.gestion) THEN
              raise exception 'Gestión existente';
            end if;
           
        	--(2) Sentencia de la insercion
        	insert into param.tgestion(
			id_moneda_base,
			id_empresa,
			estado_reg,
			estado,
			gestion,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod,
            tipo
          	) values(
			v_parametros.id_moneda_base,
			v_parametros.id_empresa,
			'activo',
			v_parametros.estado,
			v_parametros.gestion,
			now(),
			p_id_usuario,
			null,
			null,
            v_parametros.tipo
			) returning id_gestion into v_id_gestion;
            
            --(3) Generación de los Períodos y Períodos Subsistema
            v_cont =1;
            
			
            if(v_parametros.tipo = 'MES' or v_parametros.tipo = '' or v_parametros.tipo = null)
                THEN
                
            while v_cont <= 12 loop
            
            	
                
	            --Obtención del primer día del mes correspondiente a la fecha_ini
	            v_fecha_ini= ('01-'||v_cont||'-'||v_parametros.gestion)::date;
	            
	            --Obtención el último dia del mes correspondiente a la fecha_fin
	            v_fecha_fin=(date_trunc('MONTH', v_fecha_ini) + INTERVAL '1 MONTH - 1 day')::date;
	             
	            insert into param.tperiodo(
                  id_usuario_reg,
                  id_usuario_mod,
                  fecha_reg,
                  fecha_mod,
                  estado_reg,
                  periodo,
                  id_gestion,
                  fecha_ini,
                  fecha_fin
                ) VALUES (
                  p_id_usuario,
                  NULL,
                  now(),
                  NULL,
                  'activo',
                  v_cont,
                  v_id_gestion,
                  v_fecha_ini,
                  v_fecha_fin
                ) returning id_periodo into v_id_periodo;
                
                --Registro de los periodos de los subsistemas existentes
                for v_rec in (select id_subsistema
                			from segu.tsubsistema
                			where estado_reg = 'activo'
                			and codigo not in ('PXP','GEN','SEGU','WF','PARAM','ORGA','MIGRA')) loop
                	insert into param.tperiodo_subsistema(
                	id_periodo,
                	id_subsistema,
                	estado,
                	id_usuario_reg,
                	fecha_reg
                	) values(
                	v_id_periodo,
                	v_rec.id_subsistema,
                	'cerrado',
                	p_id_usuario,
                	now()
                	);
                	
                		
                end loop;     
            
               v_cont=v_cont+1;
            
            END LOOP;
            
            ELSIF(v_parametros.tipo = 'QUINCENAL')
                THEN
                
                while v_cont <= 24 loop
                
                

               
            if(v_cont % 2 != 0)
            then
            if(v_cont = 1)
            then
              v_fecha_ini = ('01-' || v_cont || '-' || v_parametros.gestion) :: DATE;
              else
              v_fecha_ini = ('01-' || v_cont-(v_cont/2) || '-' || v_parametros.gestion) :: DATE;

            end if;
              v_fecha_fin =(date_trunc('DAY', v_fecha_ini) + INTERVAL ' + 14 day') :: DATE;

              else
               v_fecha_ini=(date_trunc('DAY', v_fecha_ini) + INTERVAL ' + 15 day') :: DATE;
               v_fecha_fin=(date_trunc('MONTH', v_fecha_ini) + INTERVAL '1 MONTH - 1 day')::date;

            end if;

                
                insert into param.tperiodo(
                  id_usuario_reg,
                  id_usuario_mod,
                  fecha_reg,
                  fecha_mod,
                  estado_reg,
                  periodo,
                  id_gestion,
                  fecha_ini,
                  fecha_fin
                ) VALUES (
                  p_id_usuario,
                  NULL,
                  now(),
                  NULL,
                  'activo',
                  v_cont,
                  v_id_gestion,
                  v_fecha_ini,
                  v_fecha_fin
                ) returning id_periodo into v_id_periodo;
                
                
                for v_rec in (select id_subsistema
                			from segu.tsubsistema
                			where estado_reg = 'activo'
                			and codigo not in ('PXP','GEN','SEGU','WF','PARAM','ORGA','MIGRA')) loop
                	insert into param.tperiodo_subsistema(
                	id_periodo,
                	id_subsistema,
                	estado,
                	id_usuario_reg,
                	fecha_reg
                	) values(
                	v_id_periodo,
                	v_rec.id_subsistema,
                	'cerrado',
                	p_id_usuario,
                	now()
                	);
                	
                		
                end loop; 
                
        
                
                
                v_cont=v_cont+1;
                
                 end loop;     
            
               


            
            END IF;
            
            
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion almacenado(a) con exito (id_gestion'||v_id_gestion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_id_gestion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'PM_GES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	elsif(p_transaccion='PM_GES_MOD')then

		begin
			--Sentencia de la modificacion
			update param.tgestion set
			id_moneda_base = v_parametros.id_moneda_base,
			id_empresa = v_parametros.id_empresa,
			estado = v_parametros.estado,
			gestion = v_parametros.gestion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
            tipo = v_parametros.tipo
			where id_gestion=v_parametros.id_gestion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_parametros.id_gestion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'PM_GES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	elsif(p_transaccion='PM_GES_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from param.tgestion
            where id_gestion=v_parametros.id_gestion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestion eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_parametros.id_gestion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
        
        
        
        /*********************************    
 	#TRANSACCION:  'PM_GETGES_GET'
 	#DESCRIPCION:	Recuepra el id_gestion segun la fecha
 	#AUTOR:		admin	
 	#FECHA:		05-02-2013 09:56:59
	***********************************/

	elsif(p_transaccion='PM_GETGES_GET')then

		begin
            --todavia no se considera la existencia de multiples empresas
        
            v_anho = (date_part('year', v_parametros.fecha))::integer;
			
            select 
             ges.id_gestion
             into v_id_gestion
            from param.tgestion ges
            where ges.gestion = v_anho
            limit 1 offset 0;
            
            IF v_id_gestion is null THEN
            
              raise exception 'No se tiene una gestion configurada para la fecha %',v_parametros.fecha; 
            
            END IF;
       
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','id_gestion recuperado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_id_gestion::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'anho',v_anho::varchar);
           
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'PM_PERSUB_SIN'
 	#DESCRIPCION:	Generación de los periodos subsistema para los subsistemas recientes
 	#AUTOR:			RCM	
 	#FECHA:			03/09/2013
	***********************************/

	elsif(p_transaccion='PM_PERSUB_SIN')then
    
		begin
           
            --(1) Validación de existencia de la gestión
            if exists(select 1 from param.tgestion
            		where gestion = v_parametros.id_gestion) THEN
              raise exception 'Gestión existente';
            end if;
           
           --(2) Recorre todos los períodos de la gestión y crea los periodos subsistemas para todos los sistemas que no tengan
        	for v_rec in (select id_periodo 
        					from param.tperiodo
        					where id_gestion = v_parametros.id_gestion) loop

        		insert into param.tperiodo_subsistema(
				id_periodo, id_subsistema, id_usuario_reg, fecha_reg, estado
				)
				select
				v_rec.id_periodo, sis.id_subsistema,p_id_usuario, now(), 'activo'
				from segu.tsubsistema sis
				where sis.id_subsistema not in (select id_subsistema
												from param.tperiodo_subsistema
				                                where id_periodo = v_rec.id_periodo)
				and sis.codigo not in ('PXP','GEN','SEGU','WF','PARAM','ORGA','MIGRA');

        					
        	end loop;
            
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Sincronización de periodos de subsistemas nuevos relizao con éxito (id_gestion'||v_parametros.id_gestion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_id_gestion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'PM_GETGESID_GET'
 	#DESCRIPCION:	Recupera el id_gestion segun id
 	#AUTOR:		rac	
 	#FECHA:		22-04-2016 09:56:59
	***********************************/

	elsif(p_transaccion='PM_GETGESID_GET')then

		begin
            --todavia no se considera la existencia de multiples empresas
        
         
			
            select 
             ges.gestion
             into v_anho
            from param.tgestion ges
            where ges.id_gestion = v_parametros.id_gestion;
            
            IF v_anho is null THEN            
              raise exception 'No se tiene una gestion configurada para la fecha %',v_parametros.id_gestion;            
            END IF;
       
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','id_gestion recuperado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_gestion',v_parametros.id_gestion::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'anho',v_anho::varchar);
           
              
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
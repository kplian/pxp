CREATE OR REPLACE FUNCTION orga.f_prorratear_x_empleado (
  p_id_periodo integer,
  p_monto numeric,
  p_codigo_prorrateo varchar,
  p_cuentas text
)
RETURNS varchar AS
$body$
DECLARE  
  v_resp		            varchar;
  v_nombre_funcion        	text;
  v_mensaje_error         	text;
  v_periodo					record;
  v_registros				record;
  v_funcionarios			record;
  v_cuentas					record;
  v_id_funcionario			integer;
  v_id_centro_costo			integer;
  v_id_oficina				integer;
  v_suma					numeric;
  v_sql_tabla				varchar;
  
BEGIN
  	v_nombre_funcion = 'orga.f_prorratear_x_empleado';
  	 --Crear tabla temporal con detalle costos
    v_sql_tabla = 'CREATE TEMPORARY TABLE orga.temp_prorrateo
    		(	id_tabla INTEGER, 
            	id_funcionario INTEGER, 
                id_centro_costo, 
                monto NUMERIC(18,2)
  			) ON COMMIT DROP';     
    
    select * from param.tperiodo 
    where id_periodo = p_id_periodo;
    
    EXECUTE(v_sql_tabla);
  	if (p_codigo_prorrateo = 'PCELULAR') then
  		for v_registros in (
        	select * 
            from gecom.tconsumo c
            inner join gecom.tnumero_celular nc
            	on c.id_numero_celular = nc.id_numero_celular            
            where id_periodo = p_id_periodo) loop
        	
            v_id_funcionario = gecom.f_get_ultimo_funcionario_asignado(v_registro.id_numero_celular,p_id_periodo);
            if (v_id_funcionario is null) then
            	raise exception 'No existe un funcionario asignado para el nro % en el periodo %',v_registros.numero,v_periodo.periodo;
            end if;
            v_id_centro_costo = null;
            v_id_centro_costo = orga.f_get_ultimo_centro_costo_funcionario(v_id_funcionario,v_id_periodo);
            
            if (v_id_centro_costo is null) then
            	raise exception 'Existe un empleado que no tiene asignado centro de costo';
            end if;
            
            insert into temp_prorrateo (id_tabla,id_funcionario,id_centro_costo,monto) 
            values ( v_registros.id_numero_celular,v_id_funcionario,v_id_centro_costo,v_registros.monto);
        end loop;
  	elsif (p_codigo_prorrateo = 'PCUENTA') then
  		FOR v_cuentas in ( 	select * 
        					from json_populate_recordset(null::orga.cuenta_form, 
                            								v_parametros.json_cuentas::json)) LOOP
        	/*Obtener el id_oficina a partir de la cuenta*/
            /*Obtener funcionarios activos al ultimo dia del mes que se encuentran en la oficina v_id_oficina*/
            v_suma = 0;
            for v_funcionarios in (
            	select id_funcionario, count(id_funcionario) OVER () as total,row_number() OVER () as numero
                from orga.tuo_funcionario uofun
                inner join orga.tcargo car
                    on uofun.id_cargo = car.id_cargo
                where uofun.fecha_asignacion <= v_periodo.fecha_fin AND
                    (uofun.fecha_finalizacion >= v_periodo.fecha_fin or uofun.fecha_finalizacion is NULL)
                    and uofun.estado_reg = 'activo' and car.id_oficina = v_id_oficina )loop
                	v_id_centro_costo = null;
                	v_id_centro_costo = orga.f_get_ultimo_centro_costo_funcionario(v_id_funcionario,v_id_periodo);
                     
                    if (v_id_centro_costo is null) then
                        raise exception 'Existe un empleado que no tiene asignado centro de costo';
                    end if;
                    
                    if (v_funcionarios.total = v_funcionarios.numero) then
                    	
                        insert into temp_prorrateo (id_tabla,id_funcionario,id_centro_costo,monto) 
            			values ( v_cuentas.id_cuenta,v_funcionarios.id_funcionario,v_id_centro_costo,v_cuentas.monto - v_suma );
                    	
                        v_suma = v_cuentas.monto;
                    else
                    	insert into temp_prorrateo (id_tabla,id_funcionario,id_centro_costo,monto) 
            			values ( v_cuentas.id_cuenta,v_funcionarios.id_funcionario,v_id_centro_costo,round((v_cuentas.monto/v_funcionarios.total),2));
                    
                    	v_suma = v_suma + round((v_cuentas.monto/v_funcionarios.total),2);
                    end if;
            END LOOP;
                    
        END LOOP;
  
  	else
  		raise exception 'No existe el tipo de prorrateo: %',p_codigo_prorrateo;
  	end if;
    
  return 'exito';  
  
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
CREATE OR REPLACE FUNCTION pxp.f_delete_array_tabla_migracion (
  p_table_schema varchar,
  p_table_name varchar,
  p_column_name_key varchar
)
RETURNS void AS
$body$
/**************************************************************************************************************
  Author: EGS
  Descripcion : Actualiza los campos tipo array en el servidor esclavo cuando se usa etls 
                elimina los registros del esclavo que no se encuentran en la bd maestra
  Issue: #19             
**********************************************************************************************************************/
DECLARE

v_cadena                    varchar;
v_nombre_con                varchar;
v_consulta                  varchar;
v_migracion                 varchar;
v_registro_master         record;
v_registro_slave          record;
v_existe                    boolean;   
v_conexion                  varchar;   
BEGIN
    v_migracion =  pxp.f_get_variable_global('pxp_sincronizacion_etl');
    IF v_migracion = 'true' THEN 
      --iniciamos la conexion con dblink 
      --direccion de la bd maestra
      v_cadena = pxp.f_get_variable_global('pxp_host_master_bd_etl');
      select trunc(random()*100000)::varchar into v_nombre_con;
      v_nombre_con = 'pg_' || v_nombre_con;
      --v_nombre_con = 'connect_migracion_conta';
      --v_conexion = (SELECT dblink_connect(v_nombre_con,v_cadena));
      --IF v_conexion != 'OK' THEN
            perform dblink_connect(v_nombre_con, v_cadena);
            perform dblink_exec(v_nombre_con, 'begin;', true);
      --END IF;
      --creamos tablas para almacenar las id de la base de datos master y slave
      CREATE TEMPORARY TABLE temporal_master(
                                      id_master integer
                                     ) ON COMMIT DROP; 
      CREATE TEMPORARY TABLE temporal_slave(
                                      id_slave  integer
                                     ) ON COMMIT DROP;     

      --Realizamos la consulta de datos en cadena
      v_consulta = '
        Select
        t.'||p_column_name_key||'    
        FROM '||p_table_schema||'.'||p_table_name||' t';
       --guardamos los id del db slave 
      FOR v_registro_slave IN EXECUTE(
                           'Select
                           '||p_column_name_key||' as column_name_key    
                          FROM '||p_table_schema||'.'||p_table_name||''
                  )LOOP 
               --raise exception'v_registro %',v_registro_slave.column_name_key; 
                    insert into temporal_slave(
                        id_slave
                    )VALUES(
                    v_registro_slave.column_name_key                   
                    );
                  
       END LOOP;
       --guardamos los id del db master 
       FOR v_registro_master IN (
                     --recuperamos los datos del campo del servidor maestro 
                     SELECT
                      *
                     FROM dblink(v_nombre_con,v_consulta,TRUE) AS table_new(column_name_key integer)
                    )LOOP                 
                   
                   insert into temporal_master(
                        id_master
                    )VALUES(
                    v_registro_master.column_name_key                   
                    );              
        END LOOP;
        --verificamos si las id del master estan en el slave si una id esta demas en la slave se elimina
        -- asi quedan iguales el master y la slave
        FOR v_registro_slave IN (
            select 
                id_slave
            from temporal_slave       
        )LOOP
                v_existe = false;   
                FOR v_registro_master IN (
                  select 
                        id_master
                  from temporal_master  
                )LOOP
            
                    IF v_registro_slave.id_slave::integer = v_registro_master.id_master::integer THEN
                       v_existe = true ;        
                    END IF;
                  
                END LOOP;
                IF v_existe = false THEN
                    v_consulta = 'DELETE FROM '||p_table_schema||'.'||p_table_name||' WHERE '||p_column_name_key||' = '||v_registro_slave.id_slave||' ';
                    execute(v_consulta);
                END IF;
        END LOOP;
      perform dblink_disconnect(v_nombre_con);
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
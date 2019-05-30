CREATE OR REPLACE FUNCTION pxp.f_update_array_tabla_migracion (
  p_administrador integer,
  p_table_schema varchar,
  p_table_name varchar,
  p_column_name_key varchar,
  p_column_name varchar,
  p_column_name_type varchar
)
RETURNS void AS
$body$
/**************************************************************************************************************
  Author: EGS
  Descripcion : Actualiza los campos tipo array en el servidor esclavo cuando se usa etls deacuerdo a los datos de la db maestra
  Issue: #19              
**********************************************************************************************************************/
DECLARE
v_tabla                     record;
v_table_schema              varchar;
v_table_name                varchar;
v_column_name               varchar;
v_cadena                    varchar;
v_nombre_con                varchar;
v_consulta                  varchar;

v_dblink_consulta           varchar;

v_resp_dblink               varchar;
v_registro                  record;
v_record_column_name_key    record;
v_record_column_name        record;
v_tamano                    integer;
v_migracion                 varchar;
v_column_key_master         varchar;
v_column_key_slave          varchar;      
BEGIN
    p_column_name_type=upper(p_column_name_type);
    
    v_migracion =  pxp.f_get_variable_global('pxp_sincronizacion_etl');
    IF v_migracion = 'true' THEN 
      --iniciamos la conexion con dblink
      --direccion de la bd maestra
      v_cadena = pxp.f_get_variable_global('pxp_host_master_bd_etl');
      select trunc(random()*100000)::varchar into v_nombre_con;
      v_nombre_con = 'pg_' || v_nombre_con;
      perform dblink_connect(v_nombre_con, v_cadena);
      perform dblink_exec(v_nombre_con, 'begin;', true);

      --Realizamos la consulta de datos en cadena
      v_consulta = '
        Select
        t.'||p_column_name_key||',
        t.'||p_column_name||'    
        FROM '||p_table_schema||'.'||p_table_name||' t';
       --se ejecuta si tiene un campo array integer      
       IF p_column_name_type = 'INTEGER[]' THEN
         FOR v_registro IN (
                  --recuperamos los datos del campo del servidor maestro 
                  SELECT
                   *
                 FROM dblink(v_nombre_con,v_consulta,TRUE) AS table_new(column_name_key integer , column_name INTEGER[] )  

              )LOOP 
              --recuperamos el tamaño del arreglo del campo por registro 
                   v_tamano:=array_upper(v_registro.column_name,1);
                   IF v_tamano is not null THEN    
                      FOR i IN 1..(v_tamano) loop  
                       --Actualizamos los datos en la tabla del servidor esclavo                                               
                       v_consulta='UPDATE  '||p_table_schema||'.'||p_table_name||'  SET '||p_column_name|| ' = array_append('||p_column_name|| ','||v_registro.column_name[i]::varchar||') WHERE '||p_column_name_key||' = '||v_registro.column_name_key::varchar||' ;';
                                        EXECUTE(v_consulta);
                                     END LOOP;                          
                     END IF;   
                              
               
              END LOOP;
         --se ejecuta si tiene un campo array varchar       
        ELSIF p_column_name_type = 'VARCHAR[]' THEN
            
            FOR v_registro IN (
            --recuperamos los datos del campo del servidor maestro 
             SELECT
                   *
                 FROM dblink(v_nombre_con,v_consulta,TRUE) AS table_new(column_name_key integer,column_name VARCHAR[] )  

              )LOOP 
                   --recuperamos el tamaño del arreglo del campo por registro
                   v_tamano:=array_upper(v_registro.column_name,1);
                   IF v_tamano is not null THEN    
                       FOR i IN 1..(v_tamano) loop
                       --Actualizamos los datos en la tabla del servidor esclavo                                                
                       v_consulta='UPDATE '||p_table_schema||'.'||p_table_name||' SET '||p_column_name|| ' = array_append('||p_column_name|| ','''||v_registro.column_name[i]::varchar||''') WHERE '||p_column_name_key||' = '||v_registro.column_name_key::varchar||' ;';
                       EXECUTE(v_consulta);
                       END LOOP;                          
                     END IF;                                         
              END LOOP;             
        END IF;
      perform dblink_disconnect(v_nombre_con);
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
CREATE OR REPLACE FUNCTION pxp.f_json__tabla (
  p_id_administrador integer,
  p_schema_name varchar,
  p_table_name varchar,
  p_cmp_key varchar,
  p_id_table integer
)
RETURNS json AS
$body$
/**************************************************************************
 SISTEMA:       Sistema de Contabilidad
 FUNCION:       conta.f_json_tabla
 DESCRIPCION:   Devuelve los registros de una tabla en formato json esto cuando postgres no puede procesar 
                los json con sus funciones por defecto cuando los argumentos pasan de los 100
                p_schema_name : nombre del esquema que pertenece la tabla
                P_table_name :  nombre de la tabla
                p_cmp_key : nombre del campo llave o campo que e tomara como llave para la busqueda del where en la consulta (no es obligatorio)
                p_id_table : id del registro(s) que se quiere convertir en json en especifico (no es obligatorio)        
 AUTOR:         (EGS)  EndeETR
 FECHA:         29/05/2019            
 COMENTARIOS:    
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:    
 AUTOR:            
 FECHA:        
***************************************************************************/

DECLARE
  
    v_nombre_funcion        text;
    v_resp                  varchar; 
    v_json                  varchar;
    v_structure_table       varchar;
    v_table                 varchar;
    v_count                 integer; 
    v_consulta              varchar;                  
BEGIN

    v_nombre_funcion = 'conta.f_json_tabla';
     
      v_consulta = 'SELECT
                 row_to_json(t.*)
                 from '||p_schema_name||'.'||p_table_name||' t '; 
              
     
     IF p_id_table is not null  THEN
           IF p_id_table <> 0  THEN               
            v_consulta = v_consulta ||'WHERE t.'||p_cmp_key|| ' = '||p_id_table::varchar; 
          
          END IF;
      END IF;
     ---ejecutamos la consulta si esta por lo menos trae un registro 
      EXECUTE(v_consulta) into v_table;
     
     v_json = '['; 
     
     IF v_table is not null THEN   
         FOR v_table IN EXECUTE(
                    v_consulta
                )LOOP
          --Para los campos array en postgres los corchetes [] los reconoce como la asignacion de dimension en una matriz por esa 
          --razon se reemplazan con doble dieresis y llaves en los campos que llevan un arreglo de varcha[]  o arreglo de integer [] 
                v_table = REPLACE (v_table,'[','"{');
                v_table = REPLACE (v_table,']','}"');
                v_json = v_json||''||v_table||',';      
         END LOOP;
         --raise exception 'v_json %',v_json;
         v_json = SUBSTRING (v_json,1,length(v_json) - 1);
     
     END IF;
     --v_json = REPLACE (v_json,'(','');
     --v_json = REPLACE (v_json,')','');
     v_json = REPLACE(v_json,E'\n', '');
     --Se Reemplazan los ' por ´ para qu no haiga conflictos con la sintaxis 
     v_json = REPLACE(v_json,'''', '´');
     v_json = v_json||']';
     --raise exception 'v_json %',v_json;
   
return v_json::json;

EXCEPTION
                    
    WHEN OTHERS THEN
            v_resp='';
            v_resp = pxp.f_agrega_clave(v_resp,'p_table_name',p_table_name::varchar);
            v_resp = pxp.f_agrega_clave(v_resp,'id_table',p_id_table::varchar);
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
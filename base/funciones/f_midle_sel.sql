create  or replace function f_midle_sel(p_params json) returns json
    language plpgsql
as
$$
DECLARE


    v_params                         json;
    v_resp                           VARCHAR;
    v_resp_data                      json;
    v_tabla                          VARCHAR;
    v_procedure                      varchar DEFAULT p_params ->> 'procedure';
    v_transaction                    varchar DEFAULT p_params ->> 'transaction';
    v_user_id                        integer DEFAULT p_params ->> 'userId';
    v_create_parameters              json DEFAULT p_params ->> 'createParameters';
    v_is_admin                       integer DEFAULT p_params ->> 'isAdmin';
    v_parameters                     record;
    v_array_names                    varchar[];
    v_array_values                   varchar[];
    v_array_types                    varchar[];
    v_index_for                      integer;
    v_transaction_string_for_execute varchar;
    v_admin                          integer DEFAULT 0;

BEGIN



    --verify if the userId is admin or not
    IF v_is_admin is null then
        v_is_admin:= 1;   --TODO validacion de permisos
    END IF;

    v_index_for := 1;
    FOR v_parameters
        IN (
            SELECT *  FROM json_populate_recordset(NULL::record, v_create_parameters::json)  AS (   name varchar, value varchar, type varchar  )
        )
        LOOP

            IF v_parameters.value IS NOT NULL THEN
                v_array_names[v_index_for] := v_parameters.name;
                v_array_values[v_index_for] := v_parameters.value;
                v_array_types[v_index_for] := v_parameters.type;
                v_index_for := v_index_for + 1;
            end if;




        END LOOP;


    --RAISE EXCEPTION 'antes de crear parametro % , % , %', v_array_names , v_array_values , v_array_types;

    v_tabla = pxp.f_crear_parametro(v_array_names, v_array_values, v_array_types);



    v_transaction_string_for_execute := 'select ' || v_procedure || '('||v_is_admin||',' || coalesce(v_user_id, 0) || ',''' || v_tabla ||  ''',''' || v_transaction || ''')';

    RAISE notice '>>>>>>>>>>    % ', v_transaction_string_for_execute;

    EXECUTE v_transaction_string_for_execute INTO v_resp;



    raise notice ' XXXXXX ===> %' ,  v_resp;

    -- if exist ; in the query string then we need to remove
    /*v_resp := regexp_replace(v_resp, E'[\\n\\r\t]+', ' ', 'g');
    v_resp := trim(v_resp);
    IF right(v_resp, 1) = ';' THEN
        v_resp := substr(v_resp, 1, length(v_resp) - 1);
    END IF;*/

    --RAISE EXCEPTION '%',v_resp;
    EXECUTE 'select to_json(array_to_json(array_agg(jsonData)) :: text) #>> ''{}'' as json  FROM (' || v_resp || ') jsonData' INTO v_resp_data;

    -- RAISE EXCEPTION '%',v_resp_data;

    RETURN v_resp_data;

EXCEPTION

    WHEN OTHERS THEN
        SELECT json_strip_nulls(json_build_object(
                'SQLERRM', SQLERRM,
                'SQLSTATE', SQLSTATE,
                'PROCEDURE', v_procedure
            ))
        INTO v_params;
        --raise exception '%',v_resp;
        RETURN v_params;

END ;
$$;

alter function f_midle_sel(json) owner to dberpkplian_conexion;


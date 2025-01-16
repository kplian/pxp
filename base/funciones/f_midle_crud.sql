create or replace function f_midle_crud(p_params json) returns json
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
    v_create_parameters              json    DEFAULT p_params ->> 'createParameters';
    v_is_admin                       integer DEFAULT p_params ->> 'isAdmin';
    v_parameters                     record;
    v_array_names                    varchar[];
    v_array_values                   varchar[];
    v_array_types                    varchar[];
    v_index_for                      integer;
    v_transaction_string_for_execute varchar;
    v_admin                          integer DEFAULT 0;

    v_cadena_log		varchar;
    v_nombre_funcion    varchar;
    v_tipo_error varchar;

BEGIN

    v_nombre_funcion:='pxp.f_execute_transaction_from_pxp_nd_ime';



    --verify if the userId is admin or not
    IF v_is_admin is null then
        v_is_admin:= 0;
    END IF;

    v_index_for := 1;
    FOR v_parameters
        IN (
            SELECT *  FROM json_populate_recordset(NULL::record, v_create_parameters::json)  AS (   name varchar, value varchar, type varchar  )
        )
        LOOP

            v_array_names[v_index_for] := v_parameters.name;
            v_array_values[v_index_for] := v_parameters.value;
            v_array_types[v_index_for] := v_parameters.type;
            v_index_for := v_index_for + 1;


        END LOOP;


    --RAISE EXCEPTION 'antes de crear parametro % , % , %', v_array_names , v_array_values , v_array_types;

    v_tabla = pxp.f_crear_parametro(v_array_names, v_array_values, v_array_types);

    -- RAISE EXCEPTION 'LLEGA';

    raise notice 'v_procedure % ', v_procedure;
    raise notice 'v_is_admin % ', v_is_admin;
    raise notice 'v_user_id % ', v_user_id;
    raise notice 'v_tabla % ', v_tabla;
    raise notice 'v_transaction % ', v_transaction;

    v_transaction_string_for_execute := 'select ' || v_procedure || '('||v_is_admin||',' || coalesce(v_user_id, 0) || ',''' || v_tabla ||  ''',''' || v_transaction || ''')';
    EXECUTE v_transaction_string_for_execute INTO v_resp;



    RETURN   pxp.f_resp_to_json(v_resp);

EXCEPTION
    WHEN OTHERS THEN

        v_resp='';
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp,'tipo_respuesta','ERROR'::varchar);
        v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);


        return pxp.f_resp_to_json(v_resp);

END ;
$$;

alter function f_midle_crud(json) owner to dberpkplian_conexion;


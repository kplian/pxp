CREATE OR REPLACE FUNCTION param.f_obfuscation_phone(p_message varchar)
    RETURNS varchar
AS
$BODY$
/**************************************************************************
 SISTEMA:        Parametros
 FUNCION:         param.f_obfuscation_phone
 DESCRIPCION:   find numbers in the message and obfuscate
 AUTOR:          Favio Figueroa (Finguer)
 FECHA:            30-06-2020 16:17:47
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE                FECHA                AUTOR                DESCRIPCION
 #0                23-06-2020 16:17:47    Favio Figueroa             Creacion
 ***************************************************************************/
DECLARE
    v_resp           varchar;
    v_nombre_funcion text;
    arrayMessage     text[];
    messageLength    integer;
    index            integer;
    currentPosition  integer DEFAULT 1;
    message          varchar;
BEGIN

    v_nombre_funcion = 'param.f_obfuscation_phone';

    message := p_message;
    arrayMessage := REGEXP_SPLIT_TO_ARRAY(REGEXP_REPLACE(message, '\D', ',', 'g'), ',');
    messageLength := array_length(arrayMessage, 1);
    index := 1;
    WHILE messageLength >= index
        LOOP
            IF arrayMessage[index] ~ '^[0-9\.]+$' THEN
                IF length(arrayMessage[index]) > 4 THEN
                    currentPosition := index;
                    message := REGEXP_REPLACE(message, arrayMessage[index], '***');
                END IF;
            END IF;
            index := index + 1;
        END LOOP;

    RETURN message::varchar;


EXCEPTION
    WHEN OTHERS THEN
        v_resp = '';
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', 'f_obfuscation_phone');
        RAISE EXCEPTION '%', v_resp;


END;
$BODY$
    LANGUAGE plpgsql VOLATILE;
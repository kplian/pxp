--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_limpiar_cadena (
  p_cadena varchar,
  p_caracteres_a_limpiar varchar
)
RETURNS varchar AS
$body$
/***************************************************************************
 SISTEMA:        PXP
 FUNCION:        pxp.f_limpiar_cadena
 DESCRIPCION:    Funcion que limpia una cadena de un patrón de caracteres no válidos
 AUTOR:          RCM
 FECHA:          26-06-2018
 COMENTARIOS:   
***************************************************************************/
DECLARE

	v_array_caract_invalidos varchar[];
    v_cadena varchar;

BEGIN

	v_array_caract_invalidos = regexp_split_to_array(p_caracteres_a_limpiar, ',');
    v_cadena = p_cadena;
    
    for i in 1..array_upper(v_array_caract_invalidos, 1) loop
		raise notice 'caacter: %',v_array_caract_invalidos[i];
        v_cadena = replace(v_cadena,v_array_caract_invalidos[i],'');
	end loop;
    
    return v_cadena;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
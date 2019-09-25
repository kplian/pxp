CREATE OR REPLACE FUNCTION pxp.f_llenar_espacio_blanco (
  cadena varchar,
  espacios integer
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_llenar_espacio_blanco
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas 
 AUTOR: 		
 COMENTARIOS:	
***************************************************************************
    HISTORIAL DE MODIFICACIONES:
       
 ISSUE            FECHA:              AUTOR                 DESCRIPCION
   
 #66			  23.09.2019		MZM					Adicion de funcion para listado de abono en cuenta

*/
DECLARE
	v_largo_cad 		integer;
	v_cadena			text;
BEGIN
    v_cadena=text(cadena);
    v_largo_cad:=char_length(v_cadena);
    while (v_largo_cad<espacios) loop
        v_cadena:=v_cadena||' ';
        v_largo_cad:=char_length(v_cadena);
    end loop;
    return v_cadena;
END;
$body$
LANGUAGE 'plpgsql';
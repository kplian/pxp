-- Function: pxp.f_add_catalog(character varying, character varying, character varying)

-- DROP FUNCTION pxp.f_add_catalog(character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION pxp.f_add_catalog(p_codigo_subsistema character varying, p_catalogo_tipo character varying, p_catalogo character varying, p_codigo character varying = null, p_icono character varying = null)
  RETURNS character varying AS
$BODY$
/*
Author: RCM
Date: 03-12-2012
Description: Register the catalog for any system. (param.tcatalogo, param.tcatalogo_tipo)
*/
DECLARE

    v_cat_tipo varchar;
    v_id_catalogo_tipo integer;
    v_id_subsistema integer;

BEGIN

    --1. Verificar la existencia del Catálogo Tipo
    if not exists(select 1 from param.tcatalogo_tipo cattip
          inner join segu.tsubsistema subsis on subsis.id_subsistema = cattip.id_subsistema
          where subsis.codigo = p_codigo_subsistema
          and cattip.nombre = p_catalogo_tipo) then
    --1.1 Obtener el id_Subsistema
    select id_subsistema into v_id_subsistema
    from segu.tsubsistema
    where codigo = p_codigo_subsistema;
    
    --1.2 Validación de existencia del sistema
    if v_id_subsistema is null then
        raise exception 'Tipo de Catálogo no registrado: sistema inexistente';
    end if;
    
        --1.3 Registro del Tipo Catálogo
        insert into param.tcatalogo_tipo(
        id_usuario_reg, estado_reg, id_subsistema, nombre, tabla
        ) values(
        1,'activo',v_id_subsistema,p_catalogo_tipo,p_catalogo_tipo
        ) RETURNING id_catalogo_tipo into v_id_catalogo_tipo;
    else
    --1.4 Recupera el id del tipo de catálogo
    select cattip.id_catalogo_tipo
    into v_id_catalogo_tipo
    from param.tcatalogo_tipo cattip
    inner join segu.tsubsistema subsis on subsis.id_subsistema = cattip.id_subsistema
    where subsis.codigo = p_codigo_subsistema
    and cattip.nombre = p_catalogo_tipo;
    end if;
    
    --2. Registro del catálogo
    insert into param.tcatalogo(
    id_usuario_reg, estado_reg, descripcion, id_catalogo_tipo, codigo, icono
    ) values(
    1, 'activo', p_catalogo, v_id_catalogo_tipo, p_codigo, p_icono
    );

    return 'Catálogo registrado.';

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION pxp.f_add_catalog(character varying, character varying, character varying, character varying, character varying) OWNER TO postgres;

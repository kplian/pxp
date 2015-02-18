CREATE OR REPLACE FUNCTION param.f_get_datos_proveedor (
  p_id_proveedor integer,
  p_tipo varchar
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 10/04/2013
Propósito: Devuelve datos de contacto en una sola cadena en funcion de si es Correo o Telefonos
*/
DECLARE

  v_resp varchar;

BEGIN

  --Verifica existencia del proveedor
    if not exists(select 1
          from param.tproveedor
                where id_proveedor = p_id_proveedor) then
      raise exception 'Proveedor inexistente';
    end if;

  --Obtención del dato solicitado
  if p_tipo = 'correos' then
      select
        coalesce(inst.email1,'') ||', '||coalesce(inst.email2,'')
        into v_resp
        from param.tproveedor pro
        inner join param.tinstitucion inst
        on inst.id_institucion = pro.id_institucion
        where pro.id_proveedor = p_id_proveedor;
    elsif p_tipo = 'telefonos' then
      select
        coalesce(inst.telefono1,'') ||', '||coalesce(inst.telefono2,'')
        into v_resp
        from param.tproveedor pro
        inner join param.tinstitucion inst
        on inst.id_institucion = pro.id_institucion
        where pro.id_proveedor = p_id_proveedor;
    elsif p_tipo = 'items' then
      select
        pxp.list((ite.codigo ||' - ' ||ite.nombre)::text)::varchar
        into v_resp
        from param.tproveedor pro
        inner join param.tproveedor_item_servicio pits
        on pits.id_proveedor = pro.id_proveedor
        inner join alm.titem ite
        on ite.id_item = pits.id_item
        where pro.id_proveedor = p_id_proveedor;
    elsif p_tipo = 'servicios' then
      select
        pxp.list(serv.nombre::text)::varchar
        into v_resp
        from param.tproveedor pro
        inner join param.tproveedor_item_servicio pits
        on pits.id_proveedor = pro.id_proveedor
        inner join param.tservicio serv
        on serv.id_servicio = pits.id_servicio
        where pro.id_proveedor = p_id_proveedor;
    else
      raise exception 'El tipo no contiene un dato válido';
    end if;
    
    --Devuelve la respuesta
    return v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
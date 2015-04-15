CREATE OR REPLACE FUNCTION orga.f_tr_cargo (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
  if (OLD.id_escala_salarial != NEW.id_escala_salarial) then
  	raise exception 'No es posible modificar la escala salarial de un cargo';
  end if;
  if (NEW.nombre != OLD.nombre) then
    	INSERT INTO 
            orga.tcargo
          (
            id_usuario_reg,
            id_usuario_mod,
            fecha_reg,
            fecha_mod,
            estado_reg,
            id_usuario_ai,
            usuario_ai,            
            id_uo,
            id_tipo_contrato,
            id_escala_salarial,
            codigo,
            nombre,
            fecha_ini,
            fecha_fin,
            id_lugar,
            id_temporal_cargo,
            id_oficina,
            id_cargo_padre
          ) 
          VALUES (
            OLD.id_usuario_reg,
            OLD.id_usuario_mod,
            OLD.fecha_reg,
            OLD.fecha_mod,
            'inactivo',
            OLD.id_usuario_ai,
            OLD.usuario_ai,            
            OLD.id_uo,
            OLD.id_tipo_contrato,
            OLD.id_escala_salarial,
            OLD.codigo,
            OLD.nombre,
            OLD.fecha_ini,
            now() - interval '1 day',
          	OLD.id_lugar,
            OLD.id_temporal_cargo,
            OLD.id_oficina,
            OLD.id_cargo
          );
        
        update orga.tcargo set fecha_ini = now(),
        id_temporal_cargo = NEW.id_temporal_cargo,
        nombre = NEW.nombre,
        fecha_mod = now(),
        id_usuario_mod = NEW.id_usuario_mod,
        id_lugar = NEW.id_lugar,
        id_oficina = NEW.id_oficina,
        codigo = NEW.codigo,
        id_tipo_contrato = NEW.id_tipo_contrato
        where id_cargo = OLD.id_cargo;
                        
        RETURN NULL;
    else 
    	return NEW;    
    end if;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
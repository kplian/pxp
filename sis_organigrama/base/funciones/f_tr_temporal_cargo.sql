CREATE OR REPLACE FUNCTION orga.f_tr_temporal_cargo (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
	if (NEW.nombre != OLD.nombre) then
    	update orga.tcargo set nombre = NEW.nombre
        where id_temporal_cargo = OLD.id_temporal_cargo; 
    end if;  
    RETURN NEW;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;
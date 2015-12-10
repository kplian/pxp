CREATE OR REPLACE FUNCTION segu.ftrig_tfuncion (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
  	IF (TG_OP='UPDATE')then
	BEGIN
		IF (NEW.nombre != OLD.nombre) THEN
        	raise exception 'No es posible modificar el nombre de la funcion ya que es usado como un identificador';
        END IF;
    	NEW.modificado = NULL;
        return NEW;
    END;
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;
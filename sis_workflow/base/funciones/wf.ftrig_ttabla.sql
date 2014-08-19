CREATE OR REPLACE FUNCTION wf.ftrig_ttabla (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
  	IF (TG_OP='UPDATE')then
	BEGIN
		IF (NEW.bd_codigo_tabla != OLD.bd_codigo_tabla) THEN
        	raise exception 'No es posible modificar el código de la tabla ya que es usado como un identificador';
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
SECURITY INVOKER
COST 100;
CREATE OR REPLACE FUNCTION wf.ftrig_ttipo_columna (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
  	IF (TG_OP='UPDATE')then
	BEGIN
		IF (NEW.bd_nombre_columna != OLD.bd_nombre_columna) THEN
        	raise exception 'No es posible modificar el nombre de la columna ya que es usado como un identificador';
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
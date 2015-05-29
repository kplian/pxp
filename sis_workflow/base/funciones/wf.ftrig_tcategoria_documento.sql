
CREATE OR REPLACE FUNCTION wf.ftrig_tcategoria_documento (
)
RETURNS trigger AS
$body$
DECLARE
  
BEGIN
  	IF (TG_OP='UPDATE')then
	BEGIN
		IF (NEW.codigo != OLD.codigo) THEN
        	raise exception 'No es posible modificar el codigo de la categoria ya que es usado como un identificador';
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
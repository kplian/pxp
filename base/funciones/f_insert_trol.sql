--------------- SQL ---------------

CREATE OR REPLACE FUNCTION pxp.f_insert_trol (
  par_desc text,
  par_rol varchar,
  par_subsistema varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
   
BEGIN

	
    select id_subsistema into v_id_subsistema
    from segu.tsubsistema s
    where s.codigo = par_subsistema;


        
        INSERT INTO 
      segu.trol
    (
     
      descripcion,
      fecha_reg,
      estado_reg,
      rol,
      id_subsistema
    ) 
    VALUES (
     
      par_desc,
      now(),
      'activo',
      par_rol,
      v_id_subsistema
    );
    
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
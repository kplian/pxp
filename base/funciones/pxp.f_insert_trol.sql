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

	if (exists (select 1 from segu.trol where rol = par_rol and estado_reg = 'activo')) then
    	ALTER TABLE segu.trol DISABLE TRIGGER USER;
    	update segu.trol set
    		rol = par_rol, 
    		descripcion = par_desc,
    		modificado = 1
    	where rol = par_rol and estado_reg = 'activo';
    	ALTER TABLE segu.trol ENABLE TRIGGER USER;    
    else
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
	      id_subsistema, 
	      modificado
	    ) 
	    VALUES (
	     
	      par_desc,
	      now(),
	      'activo',
	      par_rol,
	      v_id_subsistema,
	      1
	    );
	end if;
    
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
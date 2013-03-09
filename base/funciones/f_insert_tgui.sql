CREATE OR REPLACE FUNCTION pxp.f_insert_tgui (
  par_nombre varchar,
  par_descripcion text,
  par_codigo_gui varchar,
  par_visible varchar,
  par_orden_logico integer,
  par_ruta_archivo text,
  par_nivel integer,
  par_icono varchar,
  par_clase_vista varchar,
  par_subsistema varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_subsistema integer;
BEGIN
	    
    if (exists (select 1 from segu.tgui where codigo_gui = par_codigo_gui and estado_reg = 'activo')) then
    	ALTER TABLE segu.tgui DISABLE TRIGGER USER;
    	update segu.tgui set
    		nombre = par_nombre, 
    		descripcion = par_descripcion, 
    		codigo_gui = par_codigo_gui, 
    		visible = par_visible, 
    		orden_logico = par_orden_logico, 
    		ruta_archivo = par_ruta_archivo, 
    		nivel = par_nivel, 
    		icono = par_icono, 
    		clase_vista = par_clase_vista, 
    		modificado = 1
    	where codigo_gui = par_codigo_gui and estado_reg = 'activo';
    	ALTER TABLE segu.tgui ENABLE TRIGGER USER;    
    else
    	select id_subsistema into v_id_subsistema
	    from segu.tsubsistema s
	    where s.codigo = par_subsistema;
        
    	insert into segu.tgui (	nombre, descripcion, codigo_gui, visible, orden_logico, ruta_archivo, 
    							nivel, icono, clase_vista, id_subsistema, modificado)
    	values (	par_nombre, par_descripcion, par_codigo_gui, par_visible, par_orden_logico, par_ruta_archivo, 
    			par_nivel, par_icono, par_clase_vista, v_id_subsistema, 1);
    
    end if;
                
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
CREATE OR REPLACE FUNCTION wf.f_registra_gui_tabla (
  p_codigo_proceso varchar,
  p_nombre_proceso varchar,
  p_codigo_estado varchar,
  p_nombre_estado varchar
)
RETURNS integer AS
$body$
DECLARE  
  v_codigo_estado varchar;
  v_ruta_archivo varchar;
  v_id_gui		integer;
  v_nombre_estado	varchar;
  v_clase_vista		varchar;
  v_parametros		varchar;
  v_id_subsistema	integer;
  v_id_gui_padre	integer;
  v_nivel			integer;
  v_resp			varchar;
  v_nombre_funcion	varchar;
BEGIN
	v_nombre_funcion = 'wf.f_registra_gui_tabla';
	select pm.id_subsistema into v_id_subsistema
    from wf.ttipo_proceso tp
    inner join wf.tproceso_macro pm on pm.id_proceso_macro = tp.id_proceso_macro
    where tp.codigo = p_codigo_proceso;
   
	if (p_codigo_estado is null) THEN
    	v_codigo_estado = '';
        v_ruta_archivo = NULL;
        v_nombre_estado = '';
        v_clase_vista = NULL;
        v_parametros = NULL;
        v_nivel = 2;
        
        /*Obtener el id_gui del padre*/
        select id_gui into v_id_gui_padre
        from segu.tgui 
        where id_subsistema = v_id_subsistema and estado_reg = 'activo' and nivel = 1 
        	and (ruta_archivo is null or ruta_archivo = ''); 
    else 
    	v_nivel = 3;
    	v_codigo_estado = '_'||p_codigo_estado;
        v_ruta_archivo = 'sis_workflow/vista/proceso_instancia/ProcesoInstancia.php';
    	v_nombre_estado = ' ' || p_nombre_estado;
        v_clase_vista = 'ProcesoInstancia';
        v_parametros = '{proceso:"' || p_codigo_proceso || '",estado:"' || p_codigo_estado || '"}';
        
        /*Obtener el id_gui del padre*/
        select id_gui into v_id_gui_padre
        from segu.tgui g
        where g.codigo_gui = 'WF_' || p_codigo_proceso and estado_reg = 'activo'; 
        
    end if;
    
    select id_gui into v_id_gui
    from segu.tgui 
    where codigo_gui='WF_'||p_codigo_proceso ||v_codigo_estado and estado_reg = 'activo';
    
	--si no existe insert y si existe update
	if (v_id_gui is not null)then
  		UPDATE segu.tgui 
        set nombre = p_nombre_proceso || v_nombre_estado,
        descripcion = p_nombre_proceso || v_nombre_estado
        where id_gui = v_id_gui; 
        
  	else
    	
        INSERT INTO segu.tgui 
        	( 	nombre, 			descripcion, 	codigo_gui, visible, 
            	orden_logico, 		ruta_archivo, 	nivel, 		icono, 
                id_subsistema, 		clase_vista, 	modificado, combo_trigger, 
                imagen, 			parametros, 	sw_mobile, 	orden_mobile, codigo_mobile)
        VALUES (p_nombre_proceso || v_nombre_estado,p_nombre_proceso || v_nombre_estado , 'WF_'||p_codigo_proceso ||v_codigo_estado, 'si',
        		1, 					v_ruta_archivo, v_nivel,	'', 
                v_id_subsistema,	v_clase_vista, 	NULL, 		NULL, 
                NULL, 				v_parametros, 	'no', 		0, 				NULL) RETURNING id_gui into v_id_gui;
        
        /*Insertar estructura_gui*/
        INSERT INTO segu.testructura_gui
        	(	id_gui,			fk_id_gui) VALUES
            (	v_id_gui,		v_id_gui_padre);
                
    end if;
    return v_id_gui;
EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
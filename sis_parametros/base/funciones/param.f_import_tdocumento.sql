--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tdocumento (
  p_accion varchar,
  p_codigo varchar,
  p_descripcion varchar,
  p_codigo_subsis varchar,
  p_tipo_numeracion varchar,
  p_periodo_gestion varchar,
  p_tipo varchar,
  p_formato varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_documento		integer;
    v_id_subsistema		integer;
BEGIN
	    
    
        select id_documento into v_id_documento
        from param.tdocumento d    
        where trim(lower(d.codigo)) = trim(lower(p_codigo));
        
        select 
          s.id_subsistema
        into
          v_id_subsistema
        from segu.tsubsistema s
        where s.codigo = p_codigo_subsis;
    
   
        if (v_id_documento is null)then
        
            INSERT INTO param.tdocumento(
                        codigo, 
                        descripcion, 
                        id_subsistema, 
                        estado_reg,
                        fecha_reg, 
                        id_usuario_reg, 
                        periodo_gestion, 
                        tipo, 
                        tipo_numeracion, 
                        formato)
                   values (
                        p_codigo, 
                        p_descripcion,
                        v_id_subsistema, 
                        'activo', 
                        now() ::date,
                        1, 
                        p_periodo_gestion, 
                        p_tipo, 
                        p_tipo_numeracion, 
                        p_formato);
           
              
        else            
            
            update param.tdocumento set
               codigo = p_codigo,
               descripcion = p_descripcion,
               id_subsistema = v_id_subsistema,
               id_usuario_mod=1,
               fecha_mod=now(),
               periodo_gestion = p_periodo_gestion,
               tipo = p_tipo,
               tipo_numeracion = p_tipo_numeracion  ,
               formato = p_formato
               where id_documento = v_id_documento;
             	
        end if;
    
	  
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
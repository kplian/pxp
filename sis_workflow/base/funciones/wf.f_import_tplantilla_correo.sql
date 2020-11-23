CREATE OR REPLACE FUNCTION wf.f_import_tplantilla_correo (
  p_accion varchar,
  p_codigo varchar,
  p_codigo_tipo_estado varchar,
  p_codigo_tipo_proceso varchar,
  p_regla text,
  p_plantilla text,
  p_correos text,
  p_asunto varchar,
  p_documentos text,
  p_requiere_acuse varchar,
  p_url_acuse varchar,
  p_mensaje_acuse varchar,
  p_mensaje_link_acuse varchar,
  p_mandar_automaticamente varchar,
  p_funcion_acuse_recibo varchar,
  p_funcion_creacion_correo varchar,
  p_cc text,
  p_bcc text
)
RETURNS varchar AS
$body$
DECLARE	   
    v_id_tipo_proceso			integer;    
    v_id_tipo_estado			integer;
    v_id_plantilla_correo		integer;       
BEGIN	 
        
    select id_tipo_proceso into v_id_tipo_proceso
    from wf.ttipo_proceso tp    
    where tp.codigo = p_codigo_tipo_proceso;    
    
        
    select id_tipo_estado into v_id_tipo_estado
    from wf.ttipo_estado te    
    where te.codigo = p_codigo_tipo_estado and
    	te.id_tipo_proceso = v_id_tipo_proceso;   
        
    select pco.id_plantilla_correo into v_id_plantilla_correo
    from wf.tplantilla_correo pco
    where pco.id_tipo_estado = v_id_tipo_estado and pco.codigo_plantilla = p_codigo;
      
        
    ALTER TABLE wf.tplantilla_correo DISABLE TRIGGER USER;
    if (p_accion = 'delete') then
    	update wf.tplantilla_correo set estado_reg = 'inactivo',modificado = 1 
    	where id_plantilla_correo = v_id_plantilla_correo;
    else
        if (v_id_plantilla_correo is null)then
           INSERT INTO wf.tplantilla_correo
            (
              id_usuario_reg,              
              id_tipo_estado,
              codigo_plantilla,             
              regla,
              plantilla,
              correos,
              modificado,
              asunto,
              documentos,
              requiere_acuse,
              url_acuse,
              mensaje_acuse,
              mensaje_link_acuse,
              mandar_automaticamente,
              funcion_acuse_recibo,
              funcion_creacion_correo,
              cc,
              bcc
            ) 
            VALUES (
              1, 
              v_id_tipo_estado,
              p_codigo,
              p_regla,
              p_plantilla,
              string_to_array(p_correos,','),
              1,
              p_asunto,
              string_to_array(p_documentos,','),
              p_requiere_acuse,
              p_url_acuse,
              p_mensaje_acuse,
              p_mensaje_link_acuse,
              p_mandar_automaticamente,
              p_funcion_acuse_recibo,
              p_funcion_creacion_correo,
              string_to_array(p_cc,','),
              string_to_array(p_bcc,',')
            );
        else            
           UPDATE wf.tplantilla_correo  
            SET               
              id_tipo_estado = v_id_tipo_estado,
              regla = p_regla,
              plantilla = p_plantilla,
              correos = string_to_array(p_correos,','),
              modificado = 1 ,
              asunto = p_asunto,
              documentos = string_to_array(p_documentos,','),
              requiere_acuse = p_requiere_acuse,
              url_acuse = p_url_acuse,
              mensaje_acuse = p_mensaje_acuse,
              mensaje_link_acuse = p_mensaje_link_acuse,
              mandar_automaticamente = p_mandar_automaticamente,
              funcion_acuse_recibo = p_funcion_acuse_recibo,
              funcion_creacion_correo = p_funcion_creacion_correo,
              cc = string_to_array(p_cc,','),
              bcc =	string_to_array(p_bcc,',')
           WHERE id_plantilla_correo = v_id_plantilla_correo;
        end if;
    
	end if; 
    
    ALTER TABLE wf.tplantilla_correo ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

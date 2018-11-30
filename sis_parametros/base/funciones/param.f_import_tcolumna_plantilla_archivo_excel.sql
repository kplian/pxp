--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_import_tcolumna_plantilla_archivo_excel (
  p_accion varchar,
  p_codigo varchar,
  p_codigo_plantilla varchar,
  p_sw_legible varchar,
  p_formato_fecha varchar,
  p_anio_fecha integer,
  p_numero_columna integer,
  p_nombre_columna varchar,
  p_nombre_columna_tabla varchar,
  p_tipo_valor varchar,
  p_punto_decimal varchar,
  p_estado_reg varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_import_tcolumna_plantilla_archivo_excel
 DESCRIPCION:   funcion para insertar la exportacion de columnas de la plantilla archivo excel
 AUTOR: 		EGS
 FECHA:	        21/11/2018
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 ISSUE		    FECHA    		AUTOR			DESCRIPCION

***************************************************************************/

DECLARE
	
    v_id_plantilla_archivo_excel		integer;
    v_id_columna_archivo_excel	integer;
    v_id_columna_archivo_excel_fk	integer;
    v_codigo	varchar;
BEGIN
	 


    select id_plantilla_archivo_excel into v_id_plantilla_archivo_excel
    from param.tplantilla_archivo_excel pc    
    where trim(lower(pc.codigo)) = trim(lower(p_codigo_plantilla));
    
    
    select id_columna_archivo_excel into v_id_columna_archivo_excel
    from param.tcolumnas_archivo_excel dpc    
    where trim(lower(dpc.codigo)) = trim(lower(p_codigo))
    and id_plantilla_archivo_excel = v_id_plantilla_archivo_excel;

  select id_columna_archivo_excel into v_id_columna_archivo_excel_fk
    from param.tcolumnas_archivo_excel dpc    
    where trim(lower(dpc.codigo_plantilla)) = trim(lower(p_codigo_plantilla))
          and id_plantilla_archivo_excel = v_id_plantilla_archivo_excel;       
   SELECT
     pae.codigo
    INTO
     v_codigo
     FROM param.tplantilla_archivo_excel pae
     WHERE pae.id_plantilla_archivo_excel = v_id_plantilla_archivo_excel;     
          
    
    
    if (p_accion = 'delete') then
    	
        update param.tcolumnas_archivo_excel set estado_reg = 'inactivo'
    	where id_columna_archivo_excel = v_id_columna_archivo_excel;
    
    else
        if (v_id_columna_archivo_excel is null)then
        		
            --Sentencia de la insercion
         insert into param.tcolumnas_archivo_excel(
			id_plantilla_archivo_excel,
			sw_legible,
            formato_fecha,
            anio_fecha,
			numero_columna,
			nombre_columna,
            nombre_columna_tabla,
			tipo_valor,
            punto_decimal,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			fecha_mod,
			id_usuario_mod,
            codigo_plantilla,
            codigo
          	) values(
			v_id_plantilla_archivo_excel,
			p_sw_legible,
            p_formato_fecha,
            p_anio_fecha,
			p_numero_columna,
			p_nombre_columna,
            p_nombre_columna_tabla,
			p_tipo_valor,
            p_punto_decimal,
			'activo',
			null,
			'1',
			now(),
			null,
			null,
			null,
            v_codigo,
            p_codigo
			);
           
                
        else            
       			--Sentencia de la modificacion
			update param.tcolumnas_archivo_excel set
			id_plantilla_archivo_excel = v_id_plantilla_archivo_excel,
			sw_legible = p_sw_legible,
            formato_fecha = p_formato_fecha,
            anio_fecha = p_anio_fecha,
			numero_columna = p_numero_columna,
			nombre_columna = p_nombre_columna,
            nombre_columna_tabla = p_nombre_columna_tabla,
			tipo_valor = p_tipo_valor,
            punto_decimal = p_punto_decimal,
			fecha_mod = now(),
            codigo_plantilla=p_codigo_plantilla,
            codigo=p_codigo
			where id_columna_archivo_excel = v_id_columna_archivo_excel;
         
                    	
        end if;
    
	end if; 
    
    ALTER TABLE wf.ttipo_proceso ENABLE TRIGGER USER;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

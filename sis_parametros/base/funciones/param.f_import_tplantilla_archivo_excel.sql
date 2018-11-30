--------------- SQL ---------------
CREATE OR REPLACE FUNCTION param.f_import_tplantilla_archivo_excel (
  p_accion varchar,
  p_codigo varchar,
  p_nombre varchar,
  p_estado_reg varchar,
  p_hoja_excel varchar,
  p_fila_inicio integer,
  p_fila_fin integer,
  p_filas_excluidas text,
  p_tipo_archivo varchar,
  p_delimitador varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Parametros Generales
 FUNCION: 		param.f_import_tplantilla_archivo_excel
 DESCRIPCION:   funcion para insertar la exportacion de plantilla
 AUTOR: 		EGS
 FECHA:	        21/11/2018
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
 ISSUE		    FECHA    		AUTOR			DESCRIPCION

***************************************************************************/


DECLARE
	v_id_plantilla_archivo_excel		integer;
BEGIN
	    
    
    select plt.id_plantilla_archivo_excel into v_id_plantilla_archivo_excel
    from param.tplantilla_archivo_excel plt    
    where trim(lower(plt.codigo)) = trim(lower(p_codigo));

    
    -- RAISE Exception 'v_id_plantilla_archivo_excel %',v_id_plantilla_archivo_excel;
    if (p_accion = 'delete') then
    	
        update param.tplantilla_archivo_excel set estado_reg = 'inactivo'
    	where id_plantilla_archivo_excel = v_id_plantilla_archivo_excel;
        
    else
        if (v_id_plantilla_archivo_excel is null)then
            --Sentencia de la insercion
             insert into param.tplantilla_archivo_excel(
                  nombre,
                  estado_reg,
                  codigo,
                  hoja_excel,
                  fila_inicio,
                  fila_fin,
                  filas_excluidas,
                  tipo_archivo,
                  delimitador,
                  id_usuario_reg,
                  usuario_ai,
                  fecha_reg,
                  id_usuario_ai,
                  fecha_mod,
                  id_usuario_mod
                  ) values(
                  p_nombre,
                  'activo',
                  p_codigo,
                  p_hoja_excel,
                  p_fila_inicio,
                  p_fila_fin,
                  p_filas_excluidas,
                  p_tipo_archivo,
                  p_delimitador,
                  '1',
                  NULL,
                  now(),
                  NULL,
                  null,
                  null
                  );
            
              
        else            
            	--Sentencia de la modificacion
			update param.tplantilla_archivo_excel set
			nombre = p_nombre,
			codigo =  p_codigo,
            hoja_excel =  p_hoja_excel,
            fila_inicio =  p_fila_inicio,
            fila_fin =  p_fila_fin,
            filas_excluidas =  p_filas_excluidas,
            tipo_archivo =  p_tipo_archivo,
            delimitador =  p_delimitador,
            id_usuario_mod = '1',
			fecha_mod = now()
			where id_plantilla_archivo_excel = v_id_plantilla_archivo_excel;
        end if;
    
	end if;   
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
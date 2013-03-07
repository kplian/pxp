--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_inserta_documento (
  p_codigo_sis varchar,
  p_codigo varchar,
  p_descripcion varchar,
  p_periodo_gestion varchar,
  p_tipo varchar,
  p_tipo_numeracion varchar,
  p_formato varchar
)
RETURNS varchar AS
$body$
/*

Description:  Esta funcion se utilizara para insertar documentos por defector en el script de restauracion
Autor: Rensi Arteaga Copari
Fecha: 24/02/2013
*/

DECLARE
  
v_id_sussistema integer;

BEGIN


      select 
      s.id_subsistema  into v_id_sussistema
      from segu.tsubsistema s where s.codigo = p_codigo_sis and s.estado_reg = 'activo'; 

      IF v_id_sussistema is not NULL THEN
        INSERT INTO 
            param.tdocumento
          (
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_subsistema,
            codigo,
            descripcion,
            periodo_gestion,
            tipo,
            tipo_numeracion,
            formato
          ) 
          VALUES (
             1,
             now(),
            'activo',
             v_id_sussistema,
             p_codigo,
             p_descripcion,
             p_periodo_gestion,
             p_tipo,
             p_tipo_numeracion,
             p_formato
          );
      ELSE
      		raise exception 'no existe el sistema %',p_codigo_sis; 

      END IF;


RETURN 'exito al insertar documento';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
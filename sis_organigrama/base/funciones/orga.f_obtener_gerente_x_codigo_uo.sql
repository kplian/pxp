--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_obtener_gerente_x_codigo_uo (
  p_desc varchar,
  p_fecha date = now()
)
RETURNS varchar [] AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE KARD
***************************************************************************
 SCRIPT:f_obtener_funcionarios_x_uo
 COMENTARIOS:
 AUTOR: MZM
 Fecha: 19-03-12
 
 MODIFICACIONES
 
 
 AUTOR: RAC
 DESCRIPCION:  Recupera el id del funcionario, enombre del funcionar io y el cargo
 p_desc  =   gerente_general, gerente_financiero, "CODIGO UO"

*/
DECLARE
v_respuesta 			varchar;
v_registros 			record;
v_id_uo     			integer;
v_filtro_fecha			varchar;
v_nombre_funcion		varchar;
v_resp					varchar;
v_retorno 				varchar[];
v_codigo_uo				varchar;


BEGIN
      --recupera el id_uo
      
       
       
      v_nombre_funcion = 'orga.f_obtener_gerente_x_codigo_uo';
      
      IF p_desc = 'gerente_general' THEN
         v_codigo_uo  = pxp.f_get_variable_global('orga_codigo_gerencia_general');
      ELSEIF p_desc = 'gerente_financiero' THEN
         v_codigo_uo = pxp.f_get_variable_global('orga_codigo_gerencia_financiera');
      ELSE
         v_codigo_uo = p_desc;
      END IF;
      
      select 
         uo.id_uo
      into
        v_id_uo 
      from orga.tuo uo
      where upper(uo.codigo) = upper(v_codigo_uo)
	  and uo.estado_reg='activo';  
      
      IF v_id_uo is null then
        raise exception 'No se encontro la unidad % para  %, verifique la variable global correspondiente ',v_codigo_uo , p_desc; 
      end if;
      --recuepra el funcionario    

      select 
          e.id_funcionario,
          e.desc_funcionario1 as nombre_completo,
          car.id_cargo,
          car.nombre as nombre_cargo 
      into 
         v_registros   
      from orga.vfuncionario e
      inner join orga.tuo_funcionario ha on ha.id_funcionario=e.id_funcionario
      inner join orga.tcargo car on car.id_cargo = ha.id_cargo 
      where ha.estado_reg='activo' and ha.id_uo=v_id_uo
               and (
                    ha.fecha_asignacion <=  p_fecha  
                    and (
                         ha.fecha_finalizacion >=  p_fecha  
                         or ha.fecha_finalizacion is NULL
                        )
                  ); 
                  
                  
      v_retorno[1] = v_registros.id_funcionario;
      v_retorno[2] = v_registros.id_cargo;
      v_retorno[3] = v_registros.nombre_completo;
      v_retorno[4] = v_registros.nombre_cargo;
                  
      RETURN v_retorno;             

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
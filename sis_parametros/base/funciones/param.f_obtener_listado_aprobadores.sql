--------------- SQL ---------------

CREATE OR REPLACE FUNCTION param.f_obtener_listado_aprobadores (
  p_id_uo integer,
  p_id_ep integer,
  p_id_centro_costo integer,
  p_id_subsistema integer,
  p_fecha date,
  p_monto numeric,
  p_id_usuario integer,
  p_id_proceso_macro integer = NULL::integer
)
RETURNS SETOF record AS
$body$
DECLARE

v_sw_aprobador boolean;

v_consulta varchar;

v_registros record;

v_id_uo integer;
v_id_ep integer;
v_prioridad integer;


v_fun_array integer[];

v_i integer;

v_resp varchar;
v_nombre_funcion varchar;

v_desc_funcionario varchar;
  
BEGIN


  /*
  Configuracion de aprobadores
  
  - 1) los parobadores son validos durante el lapso de fecha estipuladas,
      si la fecha_fin no esta presente significa que se encuentra vigente
    
    2) la configuracion de aprobaciones se realiza  segun las siguientes combinaciones
   
     Prioridad, id_uo  , id_ep,  id_centro_costo, id_proceso_macro 
         
       1        null     null         x       	x	->   configuracion mas especifica, con centro de costos, tiene mayor priorida
       2        null     null         x       null  ->   configuracion mas especifica, con centro de costos, tiene mayor priorida
       3		 x         x         null     		->   configuracion mas especifica
       4		 x		 null		 null     		->   por defecto para todas las uo  
       5     	null      x          null     		->   por defecto para las ep,  tine prioridad la configuracion por uo
            
       
       
 	   	-		x		null		x       	    -> 	   NO EXISTE, ERROR DE CONFIGURACION
        -       null     x          x       		->      NO EXISTE, ERROR DE CONFIGURACION
      	-		x		 x			x		 		->      NO EXISTE, ERROR DE CONFIGURACION
       	-	   null     null        null     		->      si no tiene es aprobador por defecto para cualquier caso
  
  */

    /*
    0)   crea una tabla temporal con los resultados


    1)  IF  centro de costo como parametros

        1.1)  IF exite configuracion especifica para el centro de costo
       
        1.2)  No existe confi para el centro de costo desglosa id_ep y el id_uo 
        
           1.2.0)  IF busca configuracion especifica para la combinacion  id_ep e id_uo y id_proceso_macro
           
           1.2.1)  IF busca onfiguracion especifica para la combinacion  id_ep e id_uo
           
           1.2.2)  ELSEIF busca configuracion con id_uo
           
           1.2.3)  ELSEIF busca configuracion con id_ep 
             

    2) ELSE   si existen parametros id_uo y id_ep
       

          2.1)  IF busca configuracion especifica para la combinacion id_uo y id_ep
          
          2.2)  ELSEIF busca configuracion con id_uo
           
          2.3)  ELSEIF busca configuracion con id_ep


   
       */
   
 
 v_sw_aprobador = false;
 
 v_nombre_funcion = 'param.f_obtener_listado_aprobadores';
 
 -- crea tabla temporal
    IF pxp.f_iftableexists('tt_aprobador') THEN
          delete from tt_aprobador;
       ELSE
          
        
         --Creación de tabla temporal
		 create temp table tt_aprobador(
                 id_aprobador integer,
			     id_funcionario integer,
			     desc_funcionario text,
                 fecha_ini date,
                 fecha_fin date,
                 prioridad int,
                 monto_min numeric,
                 monto_max numeric
			)on commit drop;
          
       END IF; 
       
 

 
 --buscar con id_proceso_macro especifico
 

 
 IF(p_id_centro_costo is not NULL) THEN
 
      FOR v_registros in(
          SELECT
           apro.id_aprobador,
           apro.id_funcionario,
           apro.fecha_ini,
           apro.fecha_fin,
           apro.monto_min,
           apro.monto_max,
           apro.id_ep,
           apro.id_uo,
           apro.id_centro_costo,
           apro.id_uo_cargo,
           apro.id_proceso_macro
                   
         FROM param.taprobador apro
         WHERE ( apro.id_centro_costo = p_id_centro_costo 
                 and ((apro.id_proceso_macro = p_id_proceso_macro) or (apro.id_proceso_macro is NULL))
                and apro.id_ep is null and apro.id_uo is null 
                 and apro.estado_reg = 'activo'
               ) 
                 and (  (apro.fecha_ini <= p_fecha  and apro.fecha_fin >=p_fecha )   
                      or 
                        (apro.fecha_ini <= p_fecha and apro.fecha_fin is null ))
                 and ((apro.monto_min <=  p_monto and apro.monto_max >= p_monto )
                      or
                      ( apro.monto_min <= p_monto and apro.monto_max is null ))
               
               ) LOOP
      
            
           
          
            
            --  si el cargo esta especificado
             
            IF v_registros.id_uo_cargo is not null THEN
               --  busca funcionario  para el cargo
               v_fun_array =  orga.f_obtener_funcionarios_x_uo_array(v_registros.id_uo_cargo, p_fecha);
               IF v_fun_array is NULL  THEN
                   raise exception 'No se encontraron funcionarios par el  cargo, revise la asignacion del cargo en el organigrama';
               END IF;
            
            ELSE
             --si el cargo no esta especificado tomamo directamente el funcionario  
             v_fun_array [1] = v_registros.id_funcionario;
            
            END IF;
            
            
            FOR v_i IN 1 .. array_upper(v_fun_array, 1)
            LOOP
            
                 select  
                 fun.desc_funcionario1 
                  into 
                  v_desc_funcionario  
                 from orga.vfuncionario fun where fun.id_funcionario = v_fun_array[v_i];
              
                 v_consulta=  'INSERT INTO table (
                                  id_aprobador,
                                  id_funcionario,
                                  fecha_ini,
                                  fecha_fin,
                                  desc_funcionario,
                                  monto_min,
                                  monto_max,
                                  prioridad
                                  )
                                  VALUES
                                  (
                                  '||v_registros.id_aprobador::varchar||',
                                  '||v_fun_array[v_i]::varchar||',
                                  '||COALESCE(''''||v_registros.fecha_ini::VARCHAR||'''','NULL')||',
                                  '||COALESCE(''''||v_registros.fecha_fin::varchar||'''','NULL')||',
                                  '''||COALESCE(v_desc_funcionario,'---')||''',
                                  '||COALESCE(v_registros.monto_min::varchar,'NULL')||',
                                  '||COALESCE(v_registros.monto_max::varchar,'NULL')||',
                                  1
                                  );';
             
          
                  execute(v_consulta);
            END LOOP;  
           
            
            v_sw_aprobador = true;
      
      END LOOP;
      
      raise exception 'TEST';
     -- si todavia no encontramos aprobador solo con el centro de costo
     -- desglosamos el CC y obtenemos su EP y UO 
     IF v_sw_aprobador =false THEN
     
          SELECT
            cc.id_ep,
            cc.id_uo
          into 
            v_id_ep,
            v_id_uo
             
          FROM param.tcentro_costo  cc
          WHERE  cc.id_centro_costo = p_id_centro_costo
                 and cc.estado_reg = 'activo';
     
     END IF;
     
 ELSE    
    v_id_ep =  p_id_ep;
    v_id_uo = p_id_uo;    
   
 END IF;
 
 
 --si no se encontro el aprobador
IF v_sw_aprobador =false THEN

        --  buscamos con la uo y ep especificas
         FOR v_registros in(SELECT
                   apro.id_aprobador,
                   apro.id_funcionario,
                   apro.fecha_ini,
                   apro.fecha_fin,
                   
                   apro.monto_min,
                   apro.monto_max,
                   apro.id_ep,
                   apro.id_uo,
                   apro.id_centro_costo,
                   apro.id_uo_cargo,
                   apro.id_proceso_macro
                           
                 FROM param.taprobador apro
                 WHERE ((
                 
                         (apro.id_ep = v_id_ep and apro.id_uo = v_id_uo and  apro.id_centro_costo is NULL and apro.id_proceso_macro = p_id_proceso_macro)
                       OR(apro.id_ep = v_id_ep and apro.id_uo = v_id_uo and  apro.id_centro_costo is NULL and apro.id_proceso_macro is NULL)
                         
                       OR(apro.id_ep = v_id_ep and apro.id_uo is null and  apro.id_centro_costo is NULL and apro.id_proceso_macro = p_id_proceso_macro)
                       OR(apro.id_ep = v_id_ep and apro.id_uo is null and  apro.id_centro_costo is NULL and apro.id_proceso_macro is NULL)
                       
                       
                       OR(apro.id_ep is null and apro.id_uo = v_id_uo  and  apro.id_centro_costo is NULL and apro.id_proceso_macro = p_id_proceso_macro)
                       OR(apro.id_ep is null and apro.id_uo = v_id_uo  and  apro.id_centro_costo is NULL and apro.id_proceso_macro is NULL)
                       
                       OR(apro.id_ep is null and apro.id_uo  is NULL  and  apro.id_centro_costo is NULL and apro.id_proceso_macro = p_id_proceso_macro)
                       OR(apro.id_proceso_macro is null and apro.id_uo  is NULL  and  apro.id_centro_costo is NULL and apro.id_proceso_macro is NULL))
                       
                       and apro.estado_reg = 'activo')
                       and (  (apro.fecha_ini <= p_fecha  and apro.fecha_fin >=p_fecha )   
                            or 
                              (apro.fecha_ini <= p_fecha and apro.fecha_fin is null ))
                       and ((apro.monto_min <=  p_monto and apro.monto_max >= p_monto )
                            or
                            ( apro.monto_min <= p_monto and apro.monto_max is null ))
                       
                       
                       )
                       
                       
                        LOOP
                       
                        
                       
                       IF (v_id_ep = v_registros.id_ep and v_id_uo = v_registros.id_uo and v_id_ep is not null and v_id_uo is not null )  THEN
                         
                             v_prioridad = 2;  
                       
                       ELSEIF  v_id_ep is null and v_id_uo = v_registros.id_uo  THEN
                          
                             v_prioridad = 3; 
                       
                       ELSE
                            v_prioridad = 4; 
                       
                       END IF;
                       
                       
                 v_sw_aprobador = TRUE;
                 
                 --  si el cargo esta especificado
                 
                 
                
             
         
                IF v_registros.id_uo_cargo is not null THEN
                   --  busca funcionario  para el cargo
                  
                    v_fun_array =  orga.f_obtener_funcionarios_x_uo_array(v_registros.id_uo_cargo, p_fecha);
                 
                   IF v_fun_array is NULL  THEN
                        raise exception 'No se encontraron funcionarios par el  cargo, revise la asignacion del cargo en el organigrama';
                   END IF;
                
                ELSE
                 --si el cargo no esta especificado tomamo directamente el funcionario  
                   v_fun_array[1] = v_registros.id_funcionario;
                
                END IF; 
                
                  
                
                
               
                --recorremos el array de funcionarios
                FOR v_i IN 1 .. array_upper(v_fun_array, 1)
                LOOP    
                
                  select  
                 fun.desc_funcionario1 
                  into 
                  v_desc_funcionario  
                 from orga.vfuncionario fun where fun.id_funcionario = v_fun_array[v_i];
                 
                   v_consulta=  'INSERT INTO  tt_aprobador(
                                      id_aprobador,
                                      id_funcionario,
                                      fecha_ini,
                                      fecha_fin,
                                      desc_funcionario,
                                      monto_min,
                                      monto_max,
                                      prioridad
                                      )
                                      VALUES
                                      (
                                      '||v_registros.id_aprobador::varchar||',
                                      '||v_fun_array[v_i]::varchar||',
                                      '||COALESCE(''''||v_registros.fecha_ini::VARCHAR||'''','NULL')||',
                                      '||COALESCE(''''||v_registros.fecha_fin::varchar||'''','NULL')||',
                                       '''||COALESCE(v_desc_funcionario,'---')||''',
                                      '||COALESCE(v_registros.monto_min::varchar,'NULL')||',
                                      '||COALESCE(v_registros.monto_max::varchar,'NULL')||',
                                      '||v_prioridad::varchar||'
                                      );';
                
               
                 execute(v_consulta);
               END LOOP;
                    
          END LOOP;             


END IF;




--RAC 10/07/2017 se coenta esta validacion ya que necesitamos respuesta validas
--  para la estategia de liberaciones

--IF v_sw_aprobador THEN

 --consulta de la tabla temporal, 

  FOR v_registros in  (SELECT 
                          id_aprobador,
                          id_funcionario,
                          fecha_ini,
                          fecha_fin,
                          desc_funcionario,
                          monto_min,
                          monto_max,
                          prioridad 
                        FROM tt_aprobador) LOOP
          RETURN NEXT v_registros;
  END LOOP;
 
 /* 
ELSE
    IF p_devolver_error THEN 
    		raise exception 'No existen aprobadores configurados, consulte con el administrador de sistema';
    END IF;
END IF;*/
 
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
COST 100 ROWS 1000;
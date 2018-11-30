CREATE OR REPLACE FUNCTION param.f_migrar_concepto_homologado()
 RETURNS character varying AS
$body$
DECLARE 

  v_registros record;
  v_id_gestion integer;
BEGIN
            
      --definir gestion inicia
      select 
         ges.id_gestion into v_id_gestion
      from param.tgestion ges
      where ges.gestion = '2018';  
      
       -- listar concepto de gasto para la gestion inicial,
       -- recuperar la partida relacionada 
       -- recuperar el concepto relacion para    la partida de la siguiente gestion
          
      FOR v_registros in (
                          select 
                              cp1.id_concepto_ingas as id_concepto_ingas_uno,
                              pi.id_partida_uno,
                              pi.id_partida_dos,
                              cp2.id_concepto_ingas as id_concepto_ingas_dos,
                              c1.version as version_ini,
                              c2.version as version_fin,
                              c1.tipo as tipo1,
                              c2.tipo as tipo2
                              
                          from pre.tconcepto_partida cp1
                          inner join param.tconcepto_ingas c1 on c1.id_concepto_ingas = cp1.id_concepto_ingas
                          inner join pre.tpartida par on par.id_partida = cp1.id_partida
                          inner join pre.tpartida_ids pi on pi.id_partida_uno = par.id_partida
                          inner join  pre.tconcepto_partida cp2 on pi.id_partida_dos = cp2.id_partida
                          inner join param.tconcepto_ingas c2 on c2.id_concepto_ingas = cp2.id_concepto_ingas
                          where     par.id_gestion = v_id_gestion   --partidas de la gestion de inicio 
                                and cp1.estado_reg = 'activo'
                          ) LOOP
                     
             --verificar si no esite al relacion
            if not exists ( select 1 from param.tconcepto_ingas_ids cgi
                            where     cgi.id_concepto_ingas_uno =  v_registros.id_concepto_ingas_uno 
                                   and cgi.id_concepto_ingas_dos =  v_registros.id_concepto_ingas_dos ) THEN
                                   
                  --  si no existe insertamos conceptos ids
                  INSERT INTO 
                      param.tconcepto_ingas_ids
                    (
                      id_concepto_ingas_uno,
                      id_concepto_ingas_dos,
                      obs
                    )
                    VALUES (
                      v_registros.id_concepto_ingas_uno,
                      v_registros.id_concepto_ingas_dos,
                      'homologado a travez de partidas: ver '||v_registros.version_ini||' -> ' || v_registros.version_fin
                    );
            ELSE
                update param.tconcepto_ingas set
                   tipo = v_registros.tipo1
                where id_concepto_ingas = v_registros.id_concepto_ingas_dos; 
               
            END IF;
             
            
        
       END LOOP;
      



-- raise exception 'llega al final';
 return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

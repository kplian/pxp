CREATE OR REPLACE FUNCTION segu.f_importar_menu (
  p_id_gui integer,
  p_cadena_nonexion character varying
)
RETURNS void
AS 
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE SSS
***************************************************************************
 SCRIPT: 		segu.f_importar_menu
 DESCRIPCIÓN: 	Esta funcion permite  importar el menu de otra base de datos

 AUTOR: 		RAC
 FECHA:			14/03/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			

***************************************************************************/

DECLARE
   objeto record;
   v_record record;
   x	varchar;
   consulta varchar;
   v_conjunto_esquemas varchar;
   v_sw integer;
   v_id_subsistema_equi integer;
   v_id_gui_equi integer;
   v_codigo varchar;
   v_id_subsistema integer;
   v_id_gui_padre_equi integer;
   v_id_procedimiento integer;
   v_id_procedimiento_gui integer;
   v_respuesta varchar;
   
   
BEGIN

    /*
     A) MIGRAR MENU
     
        1)  buscamos equivalencia del id_subsistema. 
            
        
        
        2)  crear tabla temporal de equivalencias
        3)  for para recorrer los resultados, 
            consulta con deblink toda la rama a partir del id del padre señalado
        
            3.1) si primer registro
             
             3.1.1 buscamos ei el codigo de gui ya existe recuperamos id
            
                 3.1.1.1)  insertar nuevo gui  y salvar id 
                 3.1.1.2)  inserta  nueva estructura gui con el id salvado y padre (mismo padre que tabla original)
             
             
          
            
            3.2) si no es el primer registro
            
                3.2.1) buscar equivalencia del padre 
            	3.2.2) insertar nuevo gui con equivalencia del padre  y salvar id 
                3.2.3) inserta  nueva estructura gui con el id salvado y padre equivalente
                
           3.3)  guardar equivalencia en la tabla temporal    
  
   B) MIGRAR metaprocesos 
       (PENDIENTE)        
             
        
        
        
    
    */
  

-- A) MIGRAR MENU
     
  --      1)  buscamos equivalencia del ide del subsistema
  		  v_sw = 0;
          
          
          --hostaddr=10.172.0.11 port=5432 dbname=bdweb_gv user=db_link password=db_link
          
           SELECT P.id_subsistema,P.codigo  into  v_id_subsistema, v_codigo
           FROM dblink(p_cadena_nonexion,
                       'select s.id_subsistema, s.codigo 
                        from segu.tsubsistema s          
                        inner join segu.tgui g on s.id_subsistema = g.id_subsistema
                        where g.id_gui = '||p_id_gui::varchar) AS P(id_subsistema integer , 
                                                            codigo varchar);
                                                            
             select s.id_subsistema into v_id_subsistema
             from  segu.tsubsistema s
             where s.codigo = v_codigo;                                                
  
  
  IF(v_id_subsistema is null) THEN
  
  		raise exception 'solo nodo de sistema pueden migrarse o el sistema con dodigo % no existe en el destino',v_codigo;
  
  END IF;
  
  
  --      2)  crear tabla temporal de equivalencias
  create 
  temporary 
  table t_gui_equivalencia_temp (id_gui_orig integer , 
                                 id_gui_dest integer) on commit drop;


  --      3)  for para recorrer los resultados
  
  raise notice 'inicia FOR';
  
  FOR objeto IN   (SELECT id_gui , 
                                        nombre , 
                                        descripcion , 
                                        fecha_reg , 
                                        codigo_gui , 
                                        visible , 
                                        orden_logico , 
                                        ruta_archivo , 
                                        nivel , 
                                        icono , 
                                        id_subsistema, 
                                        clase_vista,
                                        fk_id_gui
                               FROM dblink(p_cadena_nonexion,
                                          'WITH RECURSIVE recursegui( id_gui , 
                                        nombre , 
                                        descripcion , 
                                        fecha_reg , 
                                        codigo_gui , 
                                        visible , 
                                        orden_logico , 
                                        ruta_archivo , 
                                        nivel , 
                                        icono , 
                                        id_subsistema, 
                                        clase_vista,
                                        fk_id_gui ) AS (
                                          SELECT g.id_gui , 
                                                 g.nombre , 
                                                 g.descripcion , 
                                                 g.fecha_reg , 
                                                 g.codigo_gui , 
                                                 g.visible , 
                                                 g.orden_logico , 
                                                 g.ruta_archivo , 
                                                 g.nivel , 
                                                 g.icono , 
                                                 g.id_subsistema, 
                                                 g.clase_vista,
                                                 eg.fk_id_gui
                                          FROM segu.tgui g 
                                          join segu.testructura_gui eg 
                                               on g.id_gui = eg.id_gui
                                          WHERE  g.id_gui= '||p_id_gui::varchar||'
                                        UNION
                                          SELECT  g.id_gui , 
                                                 g.nombre , 
                                                 g.descripcion , 
                                                 g.fecha_reg , 
                                                 g.codigo_gui , 
                                                 g.visible , 
                                                 g.orden_logico , 
                                                 g.ruta_archivo , 
                                                 g.nivel , 
                                                 g.icono , 
                                                 g.id_subsistema, 
                                                 g.clase_vista,
                                                 eg.fk_id_gui
                                          FROM segu.tgui g 
                                          join segu.testructura_gui eg 
                                               on g.id_gui = eg.id_gui
                                          JOIN recursegui  rt ON rt.id_gui = eg.fk_id_gui
                                        )
                                      SELECT * FROM recursegui;') AS P(
                                                                         id_gui INTEGER, 
                                                                          nombre VARCHAR(50), 
                                                                          descripcion TEXT, 
                                                                          fecha_reg DATE , 
                                                                          codigo_gui VARCHAR, 
                                                                          visible VARCHAR, 
                                                                          orden_logico INTEGER, 
                                                                          ruta_archivo TEXT, 
                                                                          nivel INTEGER, 
                                                                          icono VARCHAR, 
                                                                          id_subsistema INTEGER, 
                                                                          clase_vista VARCHAR,  
                                                                          fk_id_gui integer))   LOOP
                                                                          
        
   --          3.1) si primer registro
               IF (v_sw = 0) THEN
               
         --          3.1.1 buscamos ei el codigo si ya existe recuperamos id
         
                     select g.id_gui  into v_id_gui_equi
                     from segu.tgui g 
                     where g.codigo_gui = objeto.codigo_gui;
                     
                     if(v_id_gui_equi is null) THEN
                     
         --         3.1.1.1)  insertar nuevo gui  y salvar id 
         
                  insert into  segu.tgui(
                                        codigo_gui,
                                        nombre, 
                                        descripcion, 
                                        visible,
                                        orden_logico,
                                        ruta_archivo,
                                        nivel,
                                        icono,
                                        id_subsistema,
                                        clase_vista)
                                 values(
                                      
                                        objeto.codigo_gui,
                                        objeto.nombre,
                                        objeto.descripcion,
                                        objeto.visible,
                                        objeto.orden_logico,
                                        objeto.ruta_archivo,
                                        objeto.nivel, 
                                        objeto.icono,
                                        v_id_subsistema,
                                        objeto.clase_vista)
                                 RETURNING id_gui into v_id_gui_equi;
         
         
         --         3.1.1.2)  inserta  nueva estructura gui con el id salvado y padre (mismo padre que tabla original)
         
                                  insert into segu.testructura_gui(
                                         id_gui,
                                         fk_id_gui
                                         )
                                  values(
                                         v_id_gui_equi,
                                         objeto.fk_id_gui);




                     END IF;
                     -- para indicar que la raiz ya fue procesada
                     v_sw=1;

                
               ELSE 
                
               
               
   --         3.2) si no es el primer registro
   
   
                select g.id_gui  into v_id_gui_equi
                from segu.tgui g 
                where g.codigo_gui = objeto.codigo_gui;
                
                 if(v_id_gui_equi is null) THEN
            
             --           3.2.1) buscar equivalencia del padre 
                          select id_gui_dest  into v_id_gui_padre_equi
                          from  t_gui_equivalencia_temp et 
                          where et.id_gui_orig = objeto.fk_id_gui; 
             
             --         	3.2.2) insertar nuevo gui con equivalencia del padre  y salvar id 
             
                          insert into  segu.tgui(
                                                  codigo_gui,
                                                  nombre, 
                                                  descripcion, 
                                                  visible,
                                                  orden_logico,
                                                  ruta_archivo,
                                                  nivel,
                                                  icono,
                                                  id_subsistema,
                                                  clase_vista)
                                           values(
                                                
                                                  objeto.codigo_gui,
                                                  objeto.nombre,
                                                  objeto.descripcion,
                                                  objeto.visible,
                                                  objeto.orden_logico,
                                                  objeto.ruta_archivo,
                                                  objeto.nivel, 
                                                  objeto.icono,
                                                  NULL,
                                                  objeto.clase_vista)
                                           RETURNING id_gui into v_id_gui_equi;
                   
                        
             
             
             --           3.2.3) inserta  nueva estructura gui con el id salvado y padre equivalente
                               insert into segu.testructura_gui(
                                                                     id_gui,
                                                                     fk_id_gui
                                                                     )
                                                              values(
                                                                     v_id_gui_equi,
                                                                     v_id_gui_padre_equi);
   				END IF;
              END IF;
              
          --3.3   guardar equivalencia en la tabla temporal
   
               insert into t_gui_equivalencia_temp(id_gui_orig, id_gui_dest)
               values(objeto.id_gui,v_id_gui_equi);
   
   
                            
   
  
   END LOOP;

  
   -- B) MIGRAR metaprocesos 
   --    (PENDIENTE) 
   
   
   -- 1) correr la funcion de sincronizacion para insertar los metaprocesos de las funciones del sistema a importar
   
    v_respuesta:=segu.f_sinc_funciones_subsistema(v_id_subsistema);
    
   -- 2) FOR del istado de las relaciones entre gui y procedimientos por 
   --    las funciones del sistema
   
   FOR objeto IN   (SELECT  P.id_gui, P.id_procedimiento, P.boton, P.nombre, P.codigo
                    FROM dblink(p_cadena_nonexion,
                                             'select  pg.id_gui, pg.id_procedimiento, pg.boton,f.nombre,p.codigo
                                              from  segu.tfuncion f
                                              inner join segu.tprocedimiento p on f.id_funcion = p.id_funcion
                                              inner join segu.tprocedimiento_gui pg on pg.id_procedimiento=p.id_procedimiento
                                              where f.id_subsistema ='||v_id_subsistema::varchar) AS P( id_gui integer, 
                                                                                                        id_procedimiento integer, 
                                                                                                        boton varchar,
                                                                                                        nombre varchar,
                                                                                                        codigo varchar)) LOOP 
   
   
           -- 2.1) buscamos el procedimeinto en el destino y guardamos el id equivalente   
           v_id_procedimiento =NULL;
            select id_procedimiento into v_id_procedimiento 
            FROM segu.tprocedimiento p where p.codigo = objeto.codigo;
           
           
           if (v_id_procedimiento is null) THEN
           -- 2.1.1)   si no existe lanzamos error  para que revisen las funcion y el codigo faltantes en el destino
              raise exception 'No existe el procedimiento % en la funcion % o la sincronizacion fallor por comentarios mal hechos',objeto.codigo,objeto.nombre;
           END IF;
           
           
           
           -- 2.2)  buscamos equivalencia de gui en la tabla temporal
           
           select id_gui_dest into v_id_gui_equi
           from  t_gui_equivalencia_temp et 
           where et.id_gui_orig = objeto.id_gui; 
   
   
   
           -- 2.5) buscamos si ya existe la relacion entre gui y procedimiento
           v_id_procedimiento_gui=NULL;
           select id_procedimiento_gui   into v_id_procedimiento_gui
           from segu.tprocedimiento_gui pg 
           where pg.id_gui=v_id_gui_equi 
           and pg.id_procedimiento=v_id_procedimiento;
       
           if(v_id_procedimiento_gui is NULL )THEN   
           -- 2.5.1) si no existe insertamos en gui_procedimiento con las equivalencias
           
                 INSERT INTO segu.tprocedimiento_gui(
                                   id_procedimiento, 
                                   id_gui,
                                   boton)
                 VALUES (v_id_procedimiento, 
                         v_id_gui_equi,
                         objeto.boton);
                         
              raise notice 'procedimiento insertado %',objeto.codigo;              
           ELSE
           
             raise notice 'procedimiento existiente %',objeto.codigo;
           
           END IF;
   
   END LOOP;

   
   
  
END;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_monitorear_recursos (OID = 305034) : 
--

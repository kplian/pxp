CREATE OR REPLACE FUNCTION orga.f_uo_arb_inicia (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/**************************************************************************
 SISTEMA ENDESIS - SISTEMA DE ...
***************************************************************************
 SCRIPT: 		kard.f_uo_arb_inicia
 DESCRIPCIÓN: 	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			19/03/2012
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

-- PARÁMETROS FIJOS
/*
pm_id_usuario                               integer (si))
pm_ip_origen                                varchar(40) (si)
pm_mac_maquina                              macaddr (si)
pm_log_error                                varchar -- log -- error //variable interna (si)
pm_codigo_procedimiento                     varchar  // valor que identifica el tipo
                                                        de operacion a realizar
                                                        insert  (insertar)
                                                        delete  (eliminar)
                                                        update  (actualizar)
                                                        select  (visualizar)
pm_proc_almacenado                          varchar  // para colocar el nombre del procedimiento en caso de ser llamado
                                                        por otro procedimiento
*/

/*
      0) Crea una tabla temporal con los datos que se utilizaran para generar el arbol JSON   
           v_tabla = organigrama_filtro;
      1) FOR Lista los registros en la tabla original que cumplen con el filtro 
         1.1) Listamos la tabla temporal vara verficar si el registro no este ya insertado
         1.2) IF  Si el  registro NO ESTA insertado 
            1.2.1) si el nodo buscasdo no es la raiz seguimos buscando padres
              1.2.1.1)  Inicia la llamada recursiva para obetener el nivel final 
                       (en el camino va insertando en la tabla temporal todos los padres del regisotro)
            1.2.2) inserta el registro con el nivel final ya obtenido
       END LOOP;
     2) lista la tabla temporal y devuelve el resultado
*/

DECLARE


	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;


v_sw integer;
v_sw2 integer;
v_count integer;
v_consulta varchar;
v_consulta2 varchar;
g_registros  record;  -- PARA ALMACENAR EL CONJUNTO DE DATOS RESULTADO DEL SELECT
v_tabla varchar;
v_valor_nivel varchar;
v_nivel varchar;
v_niveles_acsi varchar;

pm_criterio_filtro varchar;
v_id integer;
v_select_funcionarios	varchar;
v_activos		varchar;
v_select_cargos		varchar;

BEGIN


 -- 0) Crea una tabla temporal con los datos que se utilizaran para generar el arbol JSON   

    v_tabla = '"organigrama_filtro"';
--raise exception 'en mantenimeinto';

/*
  id_uo SERIAL, 
  nombre_unidad VARCHAR(100), 
  nombre_cargo VARCHAR(50), 
  cargo_individual VARCHAR(2), 
  descripcion VARCHAR(100), 
  presupuesta VARCHAR(2), 
  codigo VARCHAR(15), 
  nodo_base VARCHAR(2), 
  gerencia VARCHAR(2), 
  correspondencia VARCHAR(2), 
*/

raise notice '00000  RH_INIUOARB_SEL=%',p_transaccion;
 
  
  
    v_nombre_funcion = 'orga.f_uo_arb_inicia';
    v_parametros = pxp.f_get_record(p_tabla);
    pm_criterio_filtro= v_parametros.criterio_filtro_arb;
    if (pxp.f_existe_parametro(p_tabla,'p_activos')) THEN
    	v_activos = 'no';
    	v_select_funcionarios = '(orga.f_obtener_funcionarios_x_uo(UNIORG.id_uo, now()::date, ''no'')) as funcionarios,';
    else
    	v_activos = 'si';    	
    	v_select_funcionarios = '(orga.f_obtener_funcionarios_x_uo(UNIORG.id_uo)) as funcionarios,';
    end if;
    v_select_cargos = '(orga.f_obtener_cargos_x_uo(UNIORG.id_uo)) as cargos,';
--raise exception '%',pm_criterio_filtro;
	/*********************************    
 	#TRANSACCION:  'RH_INIUOARB_SEL'
 	#DESCRIPCION:	Filtro en organigrama
 	#AUTOR:		rac	
 	#FECHA:		16-03-2012 17:06:17
	***********************************/

	IF(p_transaccion='RH_INIUOARB_SEL')then
raise notice '11111111';
                    
   CREATE TEMPORARY TABLE organigrama_filtro (
                                  "niveles" varchar,
                                  "id_uo" INTEGER, 
                                  "nombre_unidad" VARCHAR, 
                                  "nombre_cargo" VARCHAR, 
                                  "cargo_individual" VARCHAR, 
                                  "descripcion" VARCHAR, 
                                  "presupuesta" VARCHAR, 
                                  "codigo" VARCHAR, 
                                  "nodo_base" VARCHAR, 
                                  "gerencia" VARCHAR, 
                                  "id_estructura_uo" INTEGER, 
                                  "correspondencia" VARCHAR,
                                  estado_reg varchar,
                                  funcionarios varchar,
                                  cargos VARCHAR[],
                                  resaltar varchar,
                                  id_uo_padre integer,
                                  id_nivel_organizacional integer,
                                  nombre_nivel varchar
                                 
                                  
                                ) ON COMMIT DROP;
                    

   --        0) Crea una tabla temporal con los datos que se utilizaran para generar el arbol JSON   

            v_consulta := 'SELECT * FROM (SELECT
                           UNIORG.id_uo,
                           UNIORG.nombre_unidad,
                           UNIORG.nombre_cargo,
                           UNIORG.cargo_individual,
                           UNIORG.descripcion,
                           ESTORG.id_estructura_uo,
                           ESTORG.id_uo_padre,
                           UNIORG.estado_reg,'
                           || v_select_funcionarios ||
                            v_select_cargos ||
                           'UNIORG.presupuesta,
                           UNIORG.correspondencia,
                           UNIORG.codigo, 
                           UNIORG.nodo_base, 
                           UNIORG.gerencia,
                           UNIORG.id_nivel_organizacional,
                           nivorg.nombre_nivel
                           FROM orga.testructura_uo ESTORG
                           INNER JOIN orga.tuo UNIORG
                           ON UNIORG.id_uo = ESTORG.id_uo_hijo
                           INNER JOIN orga.tnivel_organizacional nivorg
                           	on nivorg.id_nivel_organizacional = UNIORG.id_nivel_organizacional
                           WHERE UNIORG.estado_reg=''activo''  ORDER BY  UNIORG.id_uo asc) AS ORG WHERE  (codigo  ilike ''%'||pm_criterio_filtro||'%''  or funcionarios ilike ''%'||pm_criterio_filtro||'%'' or nombre_cargo ilike ''%'||pm_criterio_filtro||'%'' or '''||pm_criterio_filtro||''' = any(cargos))  ';
                           
          --raise exception '%',v_consulta;              
   
     --    1) FOR Lista los registros en la t_uotabla original que cumplen con el filtro 
raise notice '2222222222';
      FOR g_registros in EXECUTE(v_consulta) LOOP
      
      raise notice 'FOR --->';


     
     
       --       1.1) Listamos la tabla temporal vara verficar si el registro no este ya insertado
         
               SELECT  
                id_uo                 
                INTO 
                v_count
             
           FROM organigrama_filtro
           WHERE id_uo =g_registros.id_uo;
          
      --   1.2) IF  Si el  registro NO ESTA insertado 
          
          IF v_count is NULL THEN
                -- 1.2.1) si el nodo buscasdo no es la raiz seguimos buscando padres
                  IF(g_registros.nodo_base <> 'si') THEN
                  
                   --   1.2.1.1) Inicia la llamada recursiva para obetener el nivel final 
              --     (en el camino va insertando en la tabla temporal todos los padres del regisotro)
                            
                   v_nivel=orga.f_uo_arb_recursivo(g_registros.id_uo_padre,v_activos);
                   
                   v_nivel=v_nivel||g_registros.id_uo||'a';
                   
                  -- v_niveles_acsi = v_nivel||'_'||ascii(g_registros.id_uo);
                   
                  ELSE
                
                    v_nivel = g_registros.id_uo||'a';
                  --  v_niveles_acsi = ascii(g_registros.id_uo);
                  
                  END IF; 
                  
                           
      --    1.2.2) inserta el registro con el nivel final ya obtenido
                 
            INSERT  INTO organigrama_filtro 
                     (  niveles,
                        id_uo, 
                        nombre_unidad, 
                        nombre_cargo, 
                        cargo_individual, 
                        descripcion, 
                        presupuesta, 
                        codigo, 
                        nodo_base, 
                        gerencia, 
                        id_estructura_uo, 
                        correspondencia,
                        estado_reg,
                        funcionarios,
                        cargos,
                        resaltar,
                        id_uo_padre,
                        id_nivel_organizacional,
                        nombre_nivel
                     )
                     VALUES
                     (  v_nivel::varchar,
                        g_registros.id_uo, 
                        g_registros.nombre_unidad, 
                        g_registros.nombre_cargo, 
                        g_registros.cargo_individual, 
                        g_registros.descripcion, 
                        g_registros.presupuesta, 
                        g_registros.codigo, 
                        g_registros.nodo_base, 
                        g_registros.gerencia, 
                        g_registros.id_estructura_uo, 
                        g_registros.correspondencia,
                        g_registros.estado_reg,
                        g_registros.funcionarios,
                        g_registros.cargos,
                        'si', --RESALTA LOS REGISTRO QUE COINCIDEN CON EL FILTRO DE LA BUSQUEDA
                        g_registros.id_uo_padre,
                        g_registros.id_nivel_organizacional,
                        g_registros.nombre_nivel
                        );        
              END IF;        
       END LOOP;
       
       raise notice '33333333';

  --   2) lista la tabla temporal y devuelve el resultado
  
  FOR g_registros in (SELECT                                   
                        niveles,
                        id_uo, 
                        nombre_unidad, 
                        nombre_cargo, 
                        cargo_individual, 
                        descripcion, 
                        presupuesta, 
                        codigo, 
                        nodo_base, 
                        gerencia, 
                        id_estructura_uo, 
                        correspondencia,
                        estado_reg,
                        funcionarios,
                        resaltar,
                        id_uo_padre,
                        id_nivel_organizacional,
                        nombre_nivel
                      FROM organigrama_filtro
                      ORDER BY niveles asc ) LOOP
     RETURN NEXT g_registros;
   END LOOP;
   
   
  /* g_registros =(SELECT                                   
                        niveles,
                        id_uo, 
                        nombre_unidad, 
                        nombre_cargo, 
                        cargo_individual, 
                        descripcion, 
                        presupuesta, 
                        codigo, 
                        nodo_base, 
                        gerencia, 
                        id_estructura_uo, 
                        correspondencia,
                        estado_reg,
                        funcionarios,
                        resaltar
                      FROM organigrama_filtro
                      ORDER BY niveles asc);
                       
    RETURN next g_registros;*/
    
    
 END IF;


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
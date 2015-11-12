--------------- SQL ---------------

CREATE OR REPLACE FUNCTION orga.f_get_aprobadores_x_funcionario (
  par_fecha date,
  par_id_funcionario integer,
  par_filtro_presupuesto varchar = 'si'::character varying,
  par_filtro_gerencia varchar = 'todos'::character varying,
  par_lista_blanca_nivel varchar = 'todos'::character varying,
  par_lista_negra_nivel varchar = 'ninguno'::character varying
)
RETURNS SETOF record AS
$body$
/*

AUTOR: JRR alias 28 (de KPLIAN)
FECHA  28/2/2013
Descripcion filtra los usarios superior segun organigrama 

parametros
   par_id_funcionario        funcionario sobre el que se busca
   par_filtro_presupuesto    si, no o todos
   par_filtro_gerencia       si, no  o todos
   
  

*/


DECLARE
  	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    v_consulta				text;
    v_id_funcionario		integer;
    v_filtro_pre			varchar;
    v_filtro_gerencia       varchar;
    v_lista_blanca          varchar;
    v_lista_negra           varchar;
    v_count_funcionario_ope	integer;
BEGIN




  	v_nombre_funcion = 'orga.f_get_aprobadores_x_funcionario';
        
    
    --raise exception 'ssss';
    
        --chequea si es necsario agregar un filtr de presupuestos
        IF par_filtro_presupuesto = 'todos' THEN
         v_filtro_pre = '';
        ELSE
          v_filtro_pre = 'and presupuesta = '''||par_filtro_presupuesto||'''';
        END IF;
        
        --chequea si es necsario agregar un filtr de presupuestos
        IF par_filtro_gerencia = 'todos' THEN
         v_filtro_gerencia = '';
        ELSE
          v_filtro_gerencia = 'and gerencia = '''||par_filtro_gerencia||'''';
        END IF;
        
        
        
       
        --chequea que niveles de organigrama entran en la lista, viene separados por comas ejm,..  0,1,2 ...  es el numero de la tabla nivel olrganizacion
        IF par_lista_blanca_nivel = 'todos' THEN
         v_lista_blanca = '';
        ELSE
          v_lista_blanca = ' and numero_nivel  in ('||par_lista_blanca_nivel||')  ';
        END IF;
        
        --chequea que niveles de organizaci, viene septa n no entran en la lisarados por comas ejm,..  0,1,2 ...  es el numero de la tabla nivel olrganizacion
        IF par_lista_negra_nivel = 'ninguno' THEN
            v_lista_negra = '';
        ELSE
            v_lista_negra = '  and  numero_nivel not in ('||par_lista_negra_nivel||')  ';
        END IF;
        
        select
          count(ufo.id_uo_funcionario_ope)
        into
          v_count_funcionario_ope
        FROM  orga.tuo_funcionario_ope ufo
        WHERE id_funcionario = par_id_funcionario 
        and   par_fecha BETWEEN ufo.fecha_asignacion and ufo.fecha_finalizacion and ufo.estado_reg = 'activo';
        
        
        IF  v_count_funcionario_ope > 1 THEN
          raise exception 'el funcionario tiene mas de una asignacion de funcional en organigrama, consulte con el administrador de sistemas';
        ELSIF v_count_funcionario_ope = 1 THEN
             --si el funcioanrio tiene asginacion funcional
             --Obtener todos los empleados de la asignacion
              v_consulta := '
              WITH RECURSIVE path(id_funcionario,id_uo,presupuesta,gerencia,numero_nivel) AS (
                      SELECT 
                          uofun.id_funcionario,
                          uo.id_uo,
                          uo.presupuesta,
                          uo.gerencia, 
                          0
                      from orga.tuo_funcionario_ope uofun
                      inner join orga.tuo uo
                          on uo.id_uo = uofun.id_uo
                       where uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                      and uofun.estado_reg = ''activo'' and uofun.id_funcionario = ' || par_id_funcionario || '
                  UNION
                      SELECT uofun.id_funcionario,euo.id_uo_padre,uo.presupuesta,uo.gerencia,no.numero_nivel
                      from orga.testructura_uo euo
                      inner join orga.tuo uo
                          on uo.id_uo = euo.id_uo_padre
                      inner join orga.tnivel_organizacional no 
                                          on no.id_nivel_organizacional = uo.id_nivel_organizacional
                      inner join path hijo
                          on hijo.id_uo = euo.id_uo_hijo
                      left join orga.tuo_funcionario uofun
                          on uo.id_uo = uofun.id_uo and uofun.estado_reg = ''activo'' and
                              uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                                      
                  )
                   SELECT 
                      id_funcionario 
                   FROM path 
                   WHERE     id_funcionario is not null '||v_filtro_pre||' '||v_filtro_gerencia||' 
                         and id_funcionario != ' || par_id_funcionario||v_lista_blanca||v_lista_negra||'
             ORDER BY numero_nivel DESC';
             
        
        ELSE
              --si el funcioanrio no tiene asginacion funcional busca segun jerarquia
          
              --Obtener todos los empleados de la asignacion
              v_consulta := '
              WITH RECURSIVE path(id_funcionario,id_uo,presupuesta,gerencia,numero_nivel) AS (
                      SELECT uofun.id_funcionario,uo.id_uo,uo.presupuesta,uo.gerencia, no.numero_nivel
              
              
                 
                      from orga.tuo_funcionario uofun
                      inner join orga.tuo uo
                          on uo.id_uo = uofun.id_uo
                      inner join orga.tnivel_organizacional no 
                                          on no.id_nivel_organizacional = uo.id_nivel_organizacional
                       where uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                      and uofun.estado_reg = ''activo'' and uofun.id_funcionario = ' || par_id_funcionario || '
                  UNION
                      SELECT uofun.id_funcionario,euo.id_uo_padre,uo.presupuesta,uo.gerencia,no.numero_nivel
                      from orga.testructura_uo euo
                      inner join orga.tuo uo
                          on uo.id_uo = euo.id_uo_padre
                      inner join orga.tnivel_organizacional no 
                                          on no.id_nivel_organizacional = uo.id_nivel_organizacional
                      inner join path hijo
                          on hijo.id_uo = euo.id_uo_hijo
                      left join orga.tuo_funcionario uofun
                          on uo.id_uo = uofun.id_uo and uofun.estado_reg = ''activo'' and
                              uofun.fecha_asignacion <= ''' || par_fecha || ''' and (uofun.fecha_finalizacion is null or uofun.fecha_finalizacion >= ''' || par_fecha || ''')
                                      
                  )
                   SELECT 
                      id_funcionario 
                   FROM path 
                   WHERE     id_funcionario is not null '||v_filtro_pre||' '||v_filtro_gerencia||' 
                         and id_funcionario != ' || par_id_funcionario||v_lista_blanca||v_lista_negra||'
             ORDER BY numero_nivel DESC';
        END IF;     
                             
             
        raise notice '%',v_consulta;
        return query execute (v_consulta);
    
                     
               
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
STABLE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100 ROWS 1000;
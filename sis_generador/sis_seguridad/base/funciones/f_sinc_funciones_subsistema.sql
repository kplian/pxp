CREATE OR REPLACE FUNCTION segu.f_sinc_funciones_subsistema (
  par_id_subsistema integer
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.f_sinc_funciones_subsistema
 DESCRIPCIÓN:   sincronizacion de la funciones de un subsistema a partir de los metadatos der SGBD
        
 AUTOR: 		KPLIAN(RAC)
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	- actualizacion a nueva version xph
                - listado de ufnciones en vez de tablas
                - ahora tambien saca las descripcion de la transaccion a partir de
                  de los comentarios del programador                     
 AUTOR:		KPLIAN(RAC)	
 FECHA:		27/11/10
 ***************************************************************************
 DESCRIPCION:	- arreglo para omitir funciones bakup con barra baja por delante '_'
                - se hicieron unicos los nombre de funcion, los codigos de procedimientos y de gui
                   
 AUTOR:		KPLIAN(RAC)	
 FECHA:		15/03/12


***************************************************************************/

DECLARE
v_registros       record;
v_esquema         varchar;
v_mensaje_error   text;
v_nombre_funcion  varchar;

v_prefijo          varchar;
v_cant             integer;
v_bandera          boolean;
v_contenido        text;
v_codigo           varchar;
v_id_funcion       integer;
v_nombre_function          varchar;
v_nombre_tabla          varchar;
v_desc_transaccion varchar;
v_bandera_desc boolean;
v_nombre_fun   varchar;
v_resp			varchar;

BEGIN



v_nombre_funcion:='segu.f_sinc_funciones_subsistema';

     --  raise exception 'LLEGA';
     select lower(codigo), lower(prefijo)
     into v_esquema, v_prefijo
     from segu.tsubsistema
     where id_subsistema=par_id_subsistema;
     
     
    -- raise exception 'LLEGA %',v_esquema;
     
    
     --RAC 15032012  se incremente el NOT LIKE para que no se considere las copias de las funciones
     --estas se distinguen por que comienzan con una '_' por delante
     --si existe una funcion backup sin esta caracteristica podemos obtener un error
     --de codigos duplicados
     
     for v_registros in (  SELECT p.proname AS v_funcion
                           FROM pg_proc p
                              INNER JOIN pg_namespace n ON p.pronamespace = n.oid
                           WHERE n.nspname = v_esquema 
                             and  p.proname not like '\_%')
                         loop
                       
                       
                       v_nombre_function = v_esquema||'.'||v_registros.v_funcion; 
                       
                       raise notice ' listado funcion -> %',v_nombre_function;
                       
                       if(v_nombre_function not in ('segu.f_sinc_funciones_subsistema'))THEN
                         --
                         
                         -- verifica la existencia de la funcion tipo sel con prefijo ft
                         
                                   
                                   --raise exception '%',substr(v_nombre_tabla, 2);

                                   v_cant:=2;
                                   v_bandera:=true;

                                   if not exists(select 1
                                                  from segu.tfuncion
                                                  where nombre = v_nombre_function
                                                  and id_subsistema=par_id_subsistema and estado_reg='activo') then

                                         -- si no existe inserta una funcion 

                                          insert into segu.tfuncion(nombre,descripcion,id_subsistema,estado_reg)
                                          values(v_nombre_function,
                                          'Funcion para tabla     ',par_id_subsistema,'activo')
                                          returning id_funcion into v_id_funcion ;

                                   else
                                   
                                    --si existe recupera el id de la fucion
                                          v_id_funcion:=(select id_funcion
                                                     from segu.tfuncion
                                                     where nombre = v_nombre_function
                                                     and id_subsistema=par_id_subsistema
                                                     and estado_reg='activo');
                                   end if;
                                   
                                   --recupera el cuerpo de la funcion

                                   select prosrc
                                   into v_contenido
                                   from pg_proc 
                                   INNER JOIN pg_catalog.pg_namespace ON pronamespace = pg_catalog.pg_namespace.oid 
                                   where  lower(pg_catalog.pg_namespace.nspname) =  lower(v_esquema)
                                   and proname =v_registros.v_funcion;

                                

                                 
                                    raise notice '%   %',v_nombre_function,v_esquema; 
                                    
                                    
                                   while((v_bandera) or (v_cant<20)) loop
                                   
                                    
                                        
                                           
                                     --busca las transacciones en el cuerpo de la funcion       
                                    if(strpos(split_part(TRIM(v_contenido),'_transaccion=''',v_cant),''')')<1) then
                                                v_bandera:=false;
                                           else
                                           
                                           
                                            
                                               --Verifica si la trasanccion tiene descripcion    
                                               v_bandera_desc:=true;  
                                               v_desc_transaccion= 'CODIGO NO DOCUMENTADO';
                                            
                                              if(strpos(split_part(v_contenido,'#DESCRIPCION:',v_cant),'#AUTOR:')<1) then
                                                 
                                                   
                                                 v_bandera_desc:=false;
                                             
                                              else 
                                              
                                                 
                                                  v_desc_transaccion:=(select substr(split_part(v_contenido,'#DESCRIPCION:',v_cant),1,strpos(split_part(v_contenido,'#DESCRIPCION:',v_cant),'#AUTOR:')-1))::varchar;
                                                  v_desc_transaccion := TRIM(regexp_replace(v_desc_transaccion, '^[ \t\n\r]*', '', 'g'));
                                                  v_desc_transaccion := TRIM(regexp_replace(v_desc_transaccion, '[ \t\n\r]*$', '', 'g')); 
                                                   
                                              
                                              end IF;
                                            
                                            v_codigo:=(select substr(split_part(TRIM(v_contenido),'_transaccion=''',v_cant),1,strpos(split_part(TRIM(v_contenido),'_transaccion=''',v_cant),''')')-1))::varchar;

                                                     
                                            raise notice '% ---  %',v_codigo, v_desc_transaccion;   
                                            
                                             if(v_codigo is null or v_codigo='') then
                                                     v_bandera:=false;
                                                end if;


                                                if not exists(select 1 
                                                              from segu.tprocedimiento
                                                              where codigo =v_codigo 
                                                              and id_funcion=v_id_funcion and estado_reg='activo') then
                                                              -- and id_funcion=v_id_funcion) then
                                                               
                                                               
                                                           
                                                           if exists(select 1 
                                                              from segu.tprocedimiento
                                                              where codigo =v_codigo )then 
                                                              
                                                              
                                                                select  f.nombre into v_nombre_fun
                                                                from segu.tprocedimiento p
                                                                inner join segu.tfuncion f on f.id_funcion = p.id_funcion
                                                                where p.codigo =v_codigo ;
                                                                --OFFSET  START 0 LIMIT 1;
                                                              
                                                                raise exception 'El codigo % se duplica para la funcion  % y minimamente en %',v_codigo,v_nombre_function,v_nombre_fun;
                                                           
                                                           
                                                           END IF;   
                                                  


                                                
                                                   insert into segu.tprocedimiento(codigo,descripcion,id_funcion,estado_reg)
                                                   values(v_codigo,v_desc_transaccion, v_id_funcion,'activo');
                                                
                                                else
                                                	                                                	    
                                                        UPDATE segu.tprocedimiento 
                                                      		SET descripcion= v_desc_transaccion
                                                    	WHERE codigo =v_codigo 
                                                       		and id_funcion=v_id_funcion and 
                                                            trim(descripcion) != v_desc_transaccion;                                                   
                                                       
                                                end if;
                                                
                                                
                                                
                                                
                                                
                                           end if;
                                           v_cant=v_cant+1;
                                           
                                           -- busca los mensaje de descripcion en el cuerpo de la funcion 
                                           
                                           
                                           
                                   end loop;

                         
                      END IF; 

     end loop;

    return 'exito';
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
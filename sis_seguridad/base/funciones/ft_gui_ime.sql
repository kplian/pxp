--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.ft_gui_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 CAPA:          MODELO
 FUNCION: 		segu.ft_gui_ime
 DESCRIPCIÓN: 	Permite la gestion de interfaces 
                de usario con todas sus operaciones basicas                
 AUTOR: 		KPLIAN(rac)	
 FECHA:			19/07/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:
***************************************************************************/
DECLARE


v_parametros 				record;
v_respuesta           		varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id_gui                    integer;
v_id_subsistema             integer;
v_resp          			varchar;
v_cont_padre    			integer;
v_cont_hijo      			integer;
v_cont_prodecimiento_hijo 	integer;
v_cont_rol				  	integer;
v_nivel                 	integer;	
v_tipo_dato              	varchar;
v_orden_logico integer;
v_codigo					varchar;
v_numero					integer;

BEGIN

     v_nombre_funcion:='segu.ft_gui_ime';
     v_parametros:=pxp.f_get_record(par_tabla); 
     
 /*******************************    
 #TRANSACCION:	SEG_GUIDD_IME
 #DESCRIPCION:	Inserta interfaces en el arbol
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		02-03-2012
 #RESUMEN:		1) si point es igual append
                  1.1) eliminamos la relacion de dependecias con el anterior padre
                  1.2) verificamos orden_logico mayor de los hijos del nodo target
                  1.3) insertamos como nodo hijo del target 
                  1.4) modificamos el orden logico del nodo para que sea el ultimo en el listado
 				2) regresar error point no soportados
                
                
***********************************/

     if(par_transaccion='SEG_GUIDD_IME')then                
          BEGIN
           
        --  1) si point es igual append
        IF(v_parametros.punto='append')then 
        
        --raise exception '% % %',v_parametros.id_target,v_parametros.id_nodo,v_parametros.id_old_parent;
        --  1.1) eliminamos la relacion de dependecias con el anterior padre
               UPDATE segu.testructura_gui
               SET estado_reg = 'inactivo'
                      WHERE id_gui=v_parametros.id_nodo  
                      AND  fk_id_gui=v_parametros.id_old_parent and estado_reg = 'activo';
            --  1.2) verificamos orden_logico mayor de los hijos den nodo target
                    select orden_logico 
                    into v_orden_logico
                    FROM segu.tgui g 
                    inner join segu.testructura_gui eg on eg.id_gui = g.id_gui
                    WHERE eg.fk_id_gui = v_parametros.id_target
                    order by g.orden_logico desc
                    limit 1 offset 0;
            
            --  1.3) insertamos como nodo hijo del target
            
               insert into segu.testructura_gui(
                               id_gui,
                               fk_id_gui
                               )
                        values(
                               v_parametros.id_nodo,
                               v_parametros.id_target); 
            
             --  1.4) modificamos el orden logico del nodo para que sea el ultimo en el listado
             
                update segu.tgui set
                orden_logico=v_orden_logico+1
                where id_gui=v_parametros.id_nodo;
              
        ELSE
 		  --	2) regresar error point no soportados
          raise exception 'POINT no soportado %',v_parametros.punto;
        
        END IF;
          
        
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','DRANG AND DROP exitoso id_gui='||v_parametros.id_nodo||' id_target= '|| v_parametros.id_target||'  id_old_gui='|| v_parametros.id_old_parent); 
               --datos obligados a regresar para configurar el 
               --traslado del nodo si regargar el padre
               --v_resp = f_agrega_clave(v_resp,'id_gui',v_parametros.id_nodo::varchar);--nuevo ide del nodo
               v_resp = pxp.f_agrega_clave(v_resp,'id_p',v_parametros.id_target::varchar);--nuevo id del padre
               v_resp = pxp.f_agrega_clave(v_resp,'id_gui_padre',v_parametros.id_target::varchar);--nuevo id del padre
               v_resp = pxp.f_agrega_clave(v_resp,'orden_logico',v_orden_logico::varchar);--algun dato extra
               return v_resp;  
                    
        END;
     
     
/*******************************    
 #TRANSACCION:	SEG_GUI_INS
 #DESCRIPCION:	Inserta interfaces en el arbol
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		10-10-2010
 #RESUMEN:		1) inserta la intergace en la tabla t_gui
 				2) inserta la relacion con el padre y la interface recien
                creada en estructura_gui              
***********************************/
     elseif(par_transaccion='SEG_GUI_INS')then                
          BEGIN
          --0) calcula el nivel del nodo padre
            select g.nivel, g.id_subsistema into v_nivel, v_id_subsistema
               from segu.tgui g 
               where g.id_gui = v_parametros.id_gui_padre;                     
              
          -- 1) inserta la intergace en la tabla t_gui
          
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
                                clase_vista,
                                parametros,
                                sw_mobile,
                                codigo_mobile,
                                orden_mobile)
                         values(
                              
                                v_parametros.codigo_gui,
                                v_parametros.nombre,
                                v_parametros.descripcion,
                                v_parametros.visible,
                                v_parametros.orden_logico,
                                v_parametros.ruta_archivo,
                                v_nivel+1, 
                                v_parametros.icono,
                                v_id_subsistema,
                                v_parametros.clase_vista,
                                v_parametros.parametros,
                                v_parametros.sw_mobile,
                                v_parametros.codigo_mobile,
                                v_parametros.orden_mobile)
                         RETURNING id_gui into v_id_gui;
                            

          --  1) inserta la relacion con el padre y la interface recien creada en estructura_gui
              
             
          	--introcude la relacion con el nodo padre
          
               insert into segu.testructura_gui(
                           id_gui,
                           fk_id_gui
                           )
                    values(
                           v_id_gui,
                           v_parametros.id_gui_padre);
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','GUI insertada con exito '||v_id_gui); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_gui',v_id_gui::varchar);
               return v_resp;  
                    
        END;
        
 /*******************************    
 #TRANSACCION:  SEG_FUNCIO_MOD
 #DESCRIPCION:	Modifica la interfaz del arbol seleccionada 
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		10-10-2010
***********************************/
     elsif(par_transaccion='SEG_GUI_MOD')then        
          
          BEGIN
          if(v_parametros.ruta_archivo is null or v_parametros.ruta_archivo='') then
          v_tipo_dato:='carpeta';
          else
          v_tipo_dato:='interface';
          end if;
          

               IF v_tipo_dato='carpeta' THEN
               
                  update segu.tgui set

                       codigo_gui=v_parametros.codigo_gui,
                       visible=v_parametros.visible,
                       nombre=v_parametros.nombre,
                       descripcion=v_parametros.descripcion,
                       orden_logico=v_parametros.orden_logico,
                       icono=v_parametros.icono
                       --id_subsistema=v_parametros.id_subsistema

                 where id_gui=v_parametros.id_gui;
              
               ELSEIF v_tipo_dato='interface' THEN
                
                 update segu.tgui set

                       codigo_gui=v_parametros.codigo_gui,
                       visible=v_parametros.visible,
                       nombre=v_parametros.nombre,
                       descripcion=v_parametros.descripcion,
                       orden_logico=v_parametros.orden_logico,
                       ruta_archivo=v_parametros.ruta_archivo,                      
                       icono=v_parametros.icono,
                       --id_subsistema=v_parametros.id_subsistema,
                       clase_vista=v_parametros.clase_vista,
                       parametros=v_parametros.parametros,
                       sw_mobile = v_parametros.sw_mobile,
                       codigo_mobile = v_parametros.codigo_mobile,
                       orden_mobile = v_parametros.orden_mobile

                 where id_gui=v_parametros.id_gui;  
                 
               END IF;          
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','GUI modificada con exito '||v_parametros.id_gui);
               v_resp = pxp.f_agrega_clave(v_resp,'id_gui',v_parametros.id_gui::varchar);
               
               return 'GUI '||v_parametros.id_gui||' modificado con exito';
          END;
 
 /*******************************    
 #TRANSACCION:  SEG_GUISINC_IME
 #DESCRIPCION:	Inserta una interfaz desde la utilidad de soncronizacion 
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		28-01-2013
***********************************/
     elsif(par_transaccion='SEG_GUISINC_IME')then        
          
          BEGIN
          select h.id_gui
          into v_id_gui
          from segu.tgui p
          inner join segu.testructura_gui eg
          	on p.id_gui = eg.fk_id_gui and eg.estado_reg = 'activo'
          inner join segu.tgui h
          	on h.id_gui = eg.id_gui and h.estado_reg = 'activo' and h.ruta_archivo = v_parametros.ruta_archivo
          where p.id_gui = v_parametros.id_gui_padre;
          
          if (v_id_gui is null) then
          	select p.codigo_gui, p.nivel, p.id_subsistema
          	into v_codigo, v_nivel, v_id_subsistema
          	from segu.tgui p
          	where p.id_gui = v_parametros.id_gui_padre;
          
          	v_numero = 1;
          	--para obtener el codigo correspondiente
          	LOOP
    			if (exists (select 1 from segu.tgui where codigo_gui = v_codigo || '.' || v_numero::varchar 
    				and estado_reg = 'activo'))then
    				v_numero = v_numero + 1;
    			else
    				exit;
    			end if;
    				
			END LOOP;
			
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
                                clase_vista,
                                combo_trigger)
                         values(
                              
                                v_codigo || '.' || v_numero::varchar,
                                v_parametros.nombre,
                                v_parametros.descripcion,
                                'no',
                                0,
                                v_parametros.ruta_archivo,
                                v_nivel+1, 
                                NULL,
                                v_id_subsistema,
                                v_parametros.clase_vista,
                                v_parametros.combo_trigger)
                         RETURNING id_gui into v_id_gui;
              --introduce la relacion con el padre
              insert into segu.testructura_gui(
                           id_gui,
                           fk_id_gui
                           )
                    values(
                           v_id_gui,
                           v_parametros.id_gui_padre);
                    	
          end if;
                         
          v_resp = pxp.f_agrega_clave(v_resp,'mensaje','GUI sincronizada con exito '||v_id_gui);
          v_resp = pxp.f_agrega_clave(v_resp,'id_gui',v_id_gui::varchar);
               
          return v_resp;
          END;
          
          
          
 /*******************************    
 #TRANSACCION:  SEG_GUI_ELI
 #DESCRIPCION:	Inactiva la interfaz del arbol seleccionada 
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		03-10-2010
 #RESUMEN:		0) Verificamos que el uig no tenga roles asociados
 				1) Verificamos que el gui no tenga mas de un padre
                    
                2.1) IF si tiene mas de un padre 
                	2.1.1)  solamente eliminamos la relacion con el padre indicado 
                    en estructura_gui
                             
                2.2) ELSE si solo tiene un padre
                	2.2.0) Contamos cueantos gui hijos tiene el nodo que se quiere eliminar
                    2.2.1) Contamos cuantos procedimientos hijo tiene  el nodo que se quiere eliminar
                	2.2.2) IF si no tienen hijos eliminamos su relacion con el padre
                    en estructura_gui
                    	2.2.2.1) eliminamos el gui
                	2.2.3) ELSE Retornamos un error
***********************************/
    elsif(par_transaccion='SEG_GUI_ELI')then          
         
          BEGIN
                             
                v_cont_padre=0;                     
    
          --0) verificamos que el gui no tenga roles asociados
           v_cont_rol=0;
           SELECT 
               count(gr.id_gui_rol)
           INTO
                   v_cont_rol
           FROM segu.tgui_rol gr
           WHERE gr.id_gui=v_parametros.id_gui and gr.estado_reg='activo';
           
           IF  (v_cont_rol > 0) THEN
           
           raise exception 'La interface no puede eliminarce por que tiene roles relacionados';
           END IF;                  
                                             
          --1) verificamos que el gui no tenga mas de un padre
           SELECT 
               count(eg.fk_id_gui)
           INTO
                   v_cont_padre
           FROM segu.testructura_gui eg
           WHERE id_gui=v_parametros.id_gui;
          
             --2.1) IF si tiene mas de un padre 
            IF  (v_cont_padre > 1) THEN      
              
              -- 2.1.1)  solamente eliminamos la relacion con el padre indicado en estructura_gui
                    update segu.testructura_gui
                            set estado_reg='inactivo'
                    WHERE     id_gui=v_parametros.id_gui  
                       AND  fk_id_gui=v_parametros.id_gui_padre;
              
           -- 2.2) ELSEIF si solo tiene un padre
              
           ELSEIF v_cont_padre = 1 THEN
              
              -- 2.2.0) Contamos cueantos gui hijos tiene el nodo que se quiere eliminar                  SELECT 
                     
                      v_cont_hijo=0;
                      
                      SELECT
                        count(eg.id_gui)
                      INTO
                         v_cont_hijo
                      FROM segu.testructura_gui eg
                      WHERE fk_id_gui=v_parametros.id_gui and eg.estado_reg = 'activo';
                      
              -- 2.2.1) Contamos cuantos procedimientos hijo tiene  el nodo que se quiere eliminar
                      
                      v_cont_prodecimiento_hijo=0;
                      SELECT 
                         count(pg.id_procedimiento)
                      INTO
                         v_cont_prodecimiento_hijo
                      FROM segu.tprocedimiento_gui pg
                      WHERE pg.id_gui=v_parametros.id_gui and pg.estado_reg = 'activo';
                      
               
              -- 2.2.2) IF si no tienen hijos
                IF (v_cont_prodecimiento_hijo = 0 AND v_cont_hijo = 0) THEN 
                    
                    -- 2.2.2.1 eliminamos su relacion con el padre en estructura_gui
                    UPDATE segu.testructura_gui
                    set estado_reg = 'inactivo'
                    WHERE     id_gui=v_parametros.id_gui  
                         AND  fk_id_gui=v_parametros.id_gui_padre and estado_reg = 'activo';
                
                     -- 2.2.2.2) eliminamos el gui
                    
                    update segu.tgui set estado_reg='inactivo'
                    WHERE  id_gui=v_parametros.id_gui;
                    
                    -- 2.2.3) ELSE Retornamos un error 
                 
                 ELSE
              
                   raise exception 'La interfaz que quiera elimminar tiene nodos dependientes';
                   
                 END IF;
              
          -- 2.3) ELSEIF no tiene un padre
              
           ELSE
              --2.3.1 retornamos un error de consistencia todos los gui deberian tener padre
              --(excepto la raiz que no puede eliminarce)
            
                raise exception 'No puede eliminar la interfaz raiz';
              
           END IF;

             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','GUI eliminado con exito '||v_parametros.id_gui); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_gui',v_parametros.id_gui::varchar);

            return v_resp;
               
         END;

     else

         raise exception 'No existe la transaccion: %',par_transaccion;
     end if;

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
CREATE OR REPLACE FUNCTION segu.ft_subsistema_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_subsistema
 DESCRIPCIÓN: 	gestion de subsistemas
 AUTOR: 		KPLIAN(rac)
 FECHA:			16/9/2010
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:			
***************************************************************************/


DECLARE

v_consulta  				varchar;
v_parametros                record;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id                        integer;
v_esquema                   varchar;
v_resp 						varchar;
v_id_gui  					varchar;

BEGIN

     v_nombre_funcion:='segu.ft_subsistema_ime';
     v_parametros:=pxp.f_get_record(par_tabla);

 /*******************************    
 #TRANSACCION:  SEG_SUBSIS_INS
 #DESCRIPCION:	Inserta Subsistemas
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		16/9/2010
***********************************/
     if(par_transaccion='SEG_SUBSIS_INS')then

        
          BEGIN
            INSERT INTO segu.tsubsistema(
                      codigo,
                      nombre,
                      prefijo,
                      nombre_carpeta
                   )
             values(
                      v_parametros.codigo,
                      v_parametros.nombre,
                      v_parametros.prefijo,
                      v_parametros.nombre_carpeta)
             RETURNING id_subsistema into v_id;

               -- crear el esquema para el subsistema creado
               v_esquema:=v_parametros.codigo;
               if not exists(SELECT 1 from pg_namespace 
                             WHERE lower(nspname)=lower(v_parametros.codigo)) THEN
                  
                  v_consulta:='CREATE SCHEMA '||v_esquema||' ';--AUTHORIZATION postgres;
                  
                  execute(v_consulta);
               end if;
               
               --crear el metaproceso para el subsistema
               if not exists(SELECT 1 from segu.tgui 
                             WHERE lower(codigo_gui)=v_parametros.codigo 
                             AND id_subsistema=v_id) THEN
                             
                  INSERT INTO segu.tgui(
                            codigo_gui,
                            descripcion,
                            id_subsistema, 
                            nombre,
                            nivel
                            )
                  VALUES(
                           v_parametros.codigo,
                            '',
                           v_id,
                           upper(v_parametros.nombre),
                           1) returning  id_gui into v_id_gui;
                           
                  v_resp = (select pxp.f_insert_testructura_gui(v_parametros.codigo,'SISTEMA'));
               end if;

               --return 'Subsistema insertado con exito';
               
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema insertado con exito '||v_id_gui); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_id_gui::varchar);

               
         END;

 /*******************************    
 #TRANSACCION:  SEG_SUBSIS_MOD
 #DESCRIPCION:	Modifica el subsistema seleccionada 
 #AUTOR:		KPLIAN(rac)	
 #FECHA:			
***********************************/
     elsif(par_transaccion='SEG_SUBSIS_MOD')then  
          
          BEGIN
               
               UPDATE segu.tsubsistema SET
                      
                      codigo=v_parametros.codigo,
                      prefijo=v_parametros.prefijo,
                      nombre=v_parametros.nombre,
                      nombre_carpeta=v_parametros.nombre_carpeta
               WHERE id_subsistema=v_parametros.id_subsistema;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema modificado con exito '||v_parametros.id_subsistema); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);

               
          END;

/*******************************    
 #TRANSACCION:   SEG_SUBSIS_ELI
 #DESCRIPCION:	Inactiva el subsistema selecionado
 #AUTOR:		KPLIAN(rac)	
 #FECHA:		
***********************************/
    elsif(par_transaccion='SEG_SUBSIS_ELI')then

         
          BEGIN
               UPDATE segu.tsubsistema 
               SET estado_reg='inactivo'
               WHERE id_subsistema=v_parametros.id_subsistema;
             
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Subsistema eliminado con exito '||v_parametros.id_subsistema); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);

         END;

     else

         raise exception 'No existe la transaccion: %',par_transaccion;
     end if;
 
--retorna respuesta en formato JSON    
 return v_resp;      

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
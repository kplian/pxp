--------------- SQL ---------------

CREATE OR REPLACE FUNCTION segu.f_menu_json (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 CAPA:          MODELO
 FUNCION: 		segu.f_menu_json
 DESCRIPCIÓN: 	Listado de opcion para menu en formato json          
 AUTOR: 		KPLIAN(rac)	
 FECHA:			11/04/2020
 COMENTARIOS:	
*************************************************************************** 
 ISSUE            FECHA:            AUTOR               DESCRIPCION  
 #128          10/04/2020           RAC            CREACION
***************************************************************************/
DECLARE


v_parametros 				record;
v_respuesta           		varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_id_subsistema             integer;
v_resp          			varchar;
va_id_sistemas              INTEGER[];
v_menu_json                 JSONB;
v_mobile                    INTEGER;

BEGIN

     v_nombre_funcion:='segu.f_menu_json';
     v_parametros:=pxp.f_get_record(par_tabla); 
     
     /*******************************    
     #TRANSACCION:  SEG_GETMENU_JSON
     #DESCRIPCION:	Modifica la interfaz del arbol seleccionada 
     #AUTOR:		KPLIAN(rac)		
     #FECHA:		11-04-2020
    ***********************************/
     IF(par_transaccion='SEG_GETMENU_JSON')THEN
          BEGIN
          
            IF pxp.f_existe_parametro(par_tabla,'system') THEN
              
              --get array of systems 
              -- if va_id_sistemas is null return al systems           
              IF UPPER(COALESCE(v_parametros.system,'ALL')) != 'ALL' THEN
                 SELECT pxp.aggarray(s.id_subsistema)
                 INTO va_id_sistemas
                 FROM segu.tsubsistema s
                 WHERE UPPER(s.codigo) =ANY( string_to_array(v_parametros.system,','));
                 
                 IF va_id_sistemas is null  THEN
                    va_id_sistemas[1] = -1; 
                 END IF;
              
              END IF;
            END IF;
            
            IF pxp.f_existe_parametro(par_tabla,'mobile') THEN
              v_mobile := v_parametros.mobile;
            END IF;
            
            -- id_gui = 0 first menu option 
            v_menu_json := segu.f_get_menu(par_administrador, par_id_usuario, 0, va_id_sistemas, COALESCE(v_mobile,0)); 
            v_resp = pxp.f_agrega_clave(v_resp,'message','Exito en la ejecucion de la funcion'::VARCHAR);
            v_resp = pxp.f_agrega_clave(v_resp,'resp_json',v_menu_json::VARCHAR);
            RETURN v_resp;
          END;  
     ELSE
         raise exception 'No existe la transaccion: %',par_transaccion;
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
PARALLEL UNSAFE
COST 100;
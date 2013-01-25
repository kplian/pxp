CREATE OR REPLACE FUNCTION segu.ft_funcion_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla varchar,
  par_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 FUNCION: 		segu.ft_funcion_ime
 DESCRIPCIÓN:   modificaciones de funciones
 AUTOR: 		KPLIAN(rac)		
 FECHA:	        
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(rac)		
 FECHA:		27/11/10
***************************************************************************/
DECLARE


v_parametros                record;
v_resp                		varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_sinc_funcion_subsis       varchar;
v_id_funcion  				integer;

BEGIN

     v_nombre_funcion:='segu.ft_funcion_ime';
     v_parametros:=pxp.f_get_record(par_tabla);             
     
 /*******************************    
 #TRANSACCION:  SEG_FUNCIO_INS
 #DESCRIPCION:	Inserta Funciones
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		16-11-2010	
***********************************/
     if(par_transaccion='SEG_FUNCIO_INS')then

        
          BEGIN
          
          --insercion de nueva funcion
               INSERT INTO segu.tfuncion(nombre, descripcion,id_subsistema)
               values(v_parametros.nombre,v_parametros.descripcion,v_parametros.id_subsistema)
               returning  id_funcion into v_id_funcion;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcion insertada con exito '||v_id_funcion); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcion',v_id_funcion::varchar);


         END;     
         
 /*******************************    
 #TRANSACCION:  SEG_FUNCIO_MOD
 #DESCRIPCION:	Modifica la funcion seleccionada 
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		16-11-2010	
***********************************/
     elsif(par_transaccion='SEG_FUNCIO_MOD')then

          
          BEGIN
               --modificacion de funciones
               update segu.tfuncion set

                     nombre=v_parametros.id_gui,
                     descripcion=v_parametros.descripcion,
                     id_subsistema=v_parametros.id_subsistema

               where id_funcion=v_parametros.id_funcion;

               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcion modificada con exito '||v_parametros.id_funcion); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcion',v_parametros.id_funcion::varchar);

             
          END;
          
/*******************************    
 #TRANSACCION:   SEG_FUNCIO_ELI
 #DESCRIPCION:	Inactiva las funcion selecionada 
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		16-11-2010	
***********************************/

    elsif(par_transaccion='SEG_FUNCIO_ELI')then
        BEGIN
        
         --inactivacion de la funcion
               UPDATE segu.tfuncion
               set estado_reg = 'inactivo' 
               where id_funcion=v_parametros.id_funcion;
               return 'Funcion eliminada con exito';
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcion eliminada con exito: '||v_parametros.id_funcion); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_funcion',v_parametros.id_funcion::varchar);

               
        END;                    
        
/*******************************    
 #TRANSACCION:  SEG_SINCFUN_MOD
 #DESCRIPCION:	Este proceso busca todas las funciones de base de datos para el esquema seleccionado
                las  introduce en la tabla de fucniones luego revisa el cuerpo de la funcion 
                y saca los codigos de procedimiento y sus descripciones
 #AUTOR:		KPLIAN(rac)		
 #FECHA:		16-11-2010	
***********************************/
        
    elsif(par_transaccion='SEG_SINCFUN_MOD') then
        BEGIN
             --sincronizacion de la funciones de un subsistema a partir de los metadatos der SGBD
        
             v_sinc_funcion_subsis:=(select segu.f_sinc_funciones_subsistema(v_parametros.id_subsistema));
             
             v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Funcion sincronizadas con exito para el sistema '||v_parametros.id_subsistema); 
             v_resp = pxp.f_agrega_clave(v_resp,'id_subsistema',v_parametros.id_subsistema::varchar);
        END;
    else

         raise exception 'No existe la transaccion: %',par_transaccion;
    end if;
    
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
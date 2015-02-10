CREATE OR REPLACE FUNCTION segu.ft_estructura_dato_ime (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_estructura_dato_ime
 DESCRIPCION:   modificaciones de estructura_dato
 AUTOR: 		KPLIAN(jrr)	
 FECHA:	
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	actualizacion a nueva version xph
 AUTOR:		KPLIAN(jrr)		
 FECHA:		08/01/11
***************************************************************************/

DECLARE


v_parametros           record;
v_respuesta            varchar;
v_nombre_funcion            text;
v_mensaje_error             text;
v_resp                  varchar;
v_id_estructura_dato    integer;

BEGIN

     v_nombre_funcion:='segu.ft_estructura_dato_ime';
     v_parametros:=pxp.f_get_record(par_tabla);


 /*******************************
 #TRANSACCION:  SEG_ESTDAT_INS
 #DESCRIPCION:	Inserta Estructura Dato
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
     if(par_transaccion='SEG_ESTDAT_INS')then

        
          BEGIN
               insert into segu.testructura_dato(
                id_subsistema,              nombre,             descripcion,
                encripta,                   log,                tipo)
               values(
                v_parametros.id_subsistema, v_parametros.nombre,v_parametros.descripcion,
                v_parametros.encripta,      v_parametros.log,   v_parametros.tipo
               )RETURNING id_estructura_dato into v_id_estructura_dato;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Dato insertado con exito: '||v_id_estructura_dato);
                v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_dato',v_id_estructura_dato::varchar);


         END;

 /*******************************
 #TRANSACCION:  SEG_ESTDAT_MOD
 #DESCRIPCION:	Modifica Estructura Dato
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     elsif(par_transaccion='SEG_ESTDAT_MOD')then

          
          BEGIN
               
               update segu.testructura_dato set
                      id_subsistema=v_parametros.id_subsistema,
                     nombre=v_parametros.nombre,
                     descripcion=v_parametros.descripcion,
                     encripta=v_parametros.encripta,
                     log=v_parametros.log,
                     tipo=v_parametros.tipo

               where id_estructura_dato=v_parametros.id_estructura_dato;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Dato modificado con exito: '||v_parametros.id_estructura_dato);
                v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_dato',v_parametros.id_estructura_dato::varchar);


          END;

 /*******************************
 #TRANSACCION:  SEG_ESTDAT_ELI
 #DESCRIPCION:	Elimina Estructura Dato
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
    elsif(par_transaccion='SEG_ESTDAT_ELI')then

         
          BEGIN
               update segu.testructura_dato set estado_reg='inactivo'
               where id_estructura_dato=v_parametros.id_estructura_dato;

                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Estructura Dato eliminado con exito: '||v_parametros.id_estructura_dato);
                v_resp = pxp.f_agrega_clave(v_resp,'id_estructura_dato',v_parametros.id_estructura_dato::varchar);

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_estructura_dato_sel (OID = 305053) : 
--

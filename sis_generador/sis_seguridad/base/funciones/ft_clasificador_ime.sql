CREATE OR REPLACE FUNCTION segu.ft_clasificador_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_clasificador_ime
 DESCRIPCION:   modificaciones de clasificador
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
v_resp                 varchar;
v_nombre_funcion       text;
v_mensaje_error        text;
v_id_clasificador      integer;

BEGIN

     v_nombre_funcion:='segu.ft_clasificador_ime';
     v_parametros:=pxp.f_get_record(p_tabla);

 /*******************************
 #TRANSACCION:  SEG_CLASIF_INS
 #DESCRIPCION:	Inserta Actividades
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/

     if(p_transaccion='SEG_CLASIF_INS')then

        
          BEGIN
               insert into segu.tclasificador(
               codigo,              descripcion,                prioridad)
               values(
               v_parametros.codigo, v_parametros.descripcion,   v_parametros.prioridad
               )RETURNING id_clasificador into v_id_clasificador;


		      v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificador insertado con exito(id_clasificador'||v_id_clasificador||')');
              v_resp = pxp.f_agrega_clave(v_resp,'id_clasificador',v_id_clasificador::varchar);

         END;

 /*******************************
 #TRANSACCION:  SEG_CLASIF_MOD
 #DESCRIPCION:	Modifica Clasificacion
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     elsif(p_transaccion='SEG_CLASIF_MOD')then

          
          BEGIN
               
               update segu.tclasificador set

                     codigo=v_parametros.codigo,
                     descripcion=v_parametros.descripcion,
                     prioridad=v_parametros.prioridad

               where id_clasificador=v_parametros.id_clasificador;



               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificador modificado: '||v_parametros.id_clasificador);
               v_resp = pxp.f_agrega_clave(v_resp,'id_clasificador',v_parametros.id_clasificador::varchar);

          END;

 /*******************************
 #TRANSACCION:  SEG_CLASIF_ELI
 #DESCRIPCION:	Elimina Clasificacion
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif(p_transaccion='SEG_CLASIF_ELI')then

         
          BEGIN
               update segu.tclasificador set estado_reg='inactivo'
               where id_clasificador=v_parametros.id_clasificador;


               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Clasificador eliminado: '||v_parametros.id_clasificador);
               v_resp = pxp.f_agrega_clave(v_resp,'id_clasificador',v_parametros.id_clasificador::varchar);

         END;

     else

         raise exception 'No existe la transaccion: %',p_transaccion;
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
-- Definition for function ft_clasificador_sel (OID = 305047) : 
--

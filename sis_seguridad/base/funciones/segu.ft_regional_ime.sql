CREATE OR REPLACE FUNCTION segu.ft_regional_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla character varying,
  p_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_regional_ime
 DESCRIPCION:   modificaciones de regional
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

    v_nro_requerimiento    	integer;
    v_parametros           	record;
    v_id_requerimiento     	integer;
    v_resp		            varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_regional			integer;


/*

 id_proyecto
 denominacion 
 descripcion
 estado_reg 

*/

BEGIN

     v_nombre_funcion:='segu.ft_regional_ime';
     v_parametros:=pxp.f_get_record(p_tabla);
/*******************************
 #TRANSACCION:  SEG_REGION_INS
 #DESCRIPCION:	Inserta Regional
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     if(p_transaccion='SEG_REGION_INS')then

          BEGIN
               
               insert into segu.tregional(
		 nombre,
                 descripcion,
                 estado_reg
               ) values(
                v_parametros.nombre,
                v_parametros.descripcion,
                'activo'
               )RETURNING id_regional into v_id_regional;
               
               --v_mensaje_error = f1();

		v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Regional almacenada con exito (id_regional'||v_id_regional||')'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_regional',v_id_regional::varchar);

               return v_resp;

         END;
/*******************************
 #TRANSACCION:  SEG_REGION_MOD
 #DESCRIPCION:	Modifica Regional
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		08/01/11	
***********************************/
     elsif(p_transaccion='SEG_REGION_MOD')then

          BEGIN

               update segu.tregional set
               nombre=v_parametros.nombre,
               descripcion=v_parametros.descripcion
               where id_regional=v_parametros.id_regional;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Regional modificada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_regional',v_parametros.id_regional::varchar);
               
               return v_resp;
          END;
/*******************************
 #TRANSACCION:  SEG_REGION_ELI
 #DESCRIPCION:	Elimina Regional
 #AUTOR:		KPLIAN(jrr)		
 #FECHA:		08/01/11	
***********************************/
    elsif(p_transaccion='SEG_REGION_ELI')then

          --consulta:=';
          BEGIN
               --raise exception 'Error al eliminar';
               delete from segu.tregional
               where id_regional=v_parametros.id_regional;
               
               v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Regional eliminada'); 
               v_resp = pxp.f_agrega_clave(v_resp,'id_regional',v_parametros.id_regional::varchar);
              
               return v_resp;
         END;
         
     else
     
         raise exception 'Transacción inexistente: %',p_transaccion;

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
    LANGUAGE plpgsql;
--
-- Definition for function ft_regional_sel (OID = 305088) : 
--

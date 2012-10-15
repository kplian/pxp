CREATE OR REPLACE FUNCTION pxp.f_get_mensaje_exi (
  par_mensaje text,
  par_funcion text,
  par_transaccion character varying
)
RETURNS text
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_mensaje_exi
 DESCRIPCION:
 AUTOR: 	    KPLIAN (rcm)	
 FECHA:	        02/06/2011
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:		
 FECHA:		
 ***************************************************************************/
declare
       v_separador_error     varchar;
       v_separador_inicial   varchar;
       v_separador_funcion   varchar;
       v_mensaje_nuevo       text;

begin
     select valor into v_separador_inicial from pxp.variable_global vg where vg.variable='separador_inicial';
     select valor into v_separador_error from pxp.variable_global vg where vg.variable='separador_error';

     select valor into v_separador_funcion from pxp.variable_global vg where vg.variable='separador_funcion';

     v_mensaje_nuevo:=(v_separador_inicial||'t'||v_separador_error||'0'||v_separador_error||coalesce(par_mensaje,'')||v_separador_error||par_funcion)::text;
     if(par_transaccion is not null)then
         v_mensaje_nuevo:=(v_mensaje_nuevo||v_separador_error||par_transaccion)::text;
     end if;
     
    return v_mensaje_nuevo;



end;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_get_parametro (OID = 304230) : 
--

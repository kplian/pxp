CREATE OR REPLACE FUNCTION pxp.f_get_mensaje_err2 (
  p_procedimientos character varying,
  p_codigo_error character varying,
  p_mensaje_error character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		pxp.f_get_mensaje_err2
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

     /*if(split_part(par_mensaje,v_separador_error,3) ='')then

         v_mensaje_nuevo:=(v_separador_inicial||'f'||v_separador_error||par_codigo_sql||v_separador_error||coalesce(par_mensaje,' ')||v_separador_error||par_funcion)::text;
         --raise exception 'entra%',par_funcion;
         if(par_transaccion is not null)then
            v_mensaje_nuevo:=(v_mensaje_nuevo||v_separador_error||par_transaccion)::text;
         end if;
         if(par_linea is not null)then
            v_mensaje_nuevo:=(v_mensaje_nuevo||v_separador_error||par_linea)::text;
         end if;
     
     else
         v_mensaje_nuevo:=(coalesce(par_mensaje,'')||v_separador_funcion||par_funcion)::text;
         if(par_transaccion is not null)then
            v_mensaje_nuevo:=(v_mensaje_nuevo||v_separador_error||par_transaccion)::text;
         end if;
         if(par_linea is not null)then
            v_mensaje_nuevo:=(v_mensaje_nuevo||v_separador_error||par_linea)::text;
         end if;
     end if;*/
     
     
     v_mensaje_nuevo = p_procedimientos || v_separador_error || p_codigo_error || v_separador_error || p_mensaje_error;

     return v_mensaje_nuevo;



end;
$body$
    LANGUAGE plpgsql;
--
-- Definition for function f_get_mensaje_exi (OID = 304229) : 
--

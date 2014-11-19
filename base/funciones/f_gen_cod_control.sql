CREATE OR REPLACE FUNCTION pxp.f_gen_cod_control (
  llave_dosificacion varchar,
  autorizacion varchar,
  nro_factura varchar,
  nit varchar,
  fecha_emision varchar,
  monto_facturado numeric
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:		PXP
 FUNCION: 		pxp.f_gen_cod_control
 DESCRIPCION:   Genera codigo de control para los datos recibidos de acuerdo a algoritmo 
 definido por impuestos nacionales en Bolivia
 AUTOR: 		 (jrivera)
 FECHA:	        05-11-2014 21:58:35
 COMENTARIOS:	La fecha_emision debe estar en formato 'YYYYMMDD' y el monto_facturado debe
 				estar redondeado sin decimales
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/


DECLARE

    g_nro_factura		text;
    g_autorizacion		text;
    g_nit				text;
    g_fecha_emision		text;
    g_monto_facturado	text;
    g_llave_dosificacion text;
    g_suma_int			int8;
    g_suma_cad			text;
    dig_ver				text;
    nro_dig				integer;
    inicio				integer;
    g_cadena_res		text;
    st					int8;  
    sp1					int8;
    sp2					int8;
    sp3					int8;
    sp4					int8;
    sp5					int8;
    sumab64				int8;
    base64				text;
    control_rc4			text;
    cod_control			text;
    v_fecha_emision		varchar;
    v_monto_facturado  text;
    v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
    
    

BEGIN
	v_nombre_funcion = 'pxp.f_gen_cod_control';
--v_monto_facturado:=text(round(numeric(monto_facturado)));
	v_monto_facturado:=text(round(monto_facturado));
   	v_fecha_emision:=fecha_emision;
    
    --v_fecha_emision:=SUBSTRING(fecha_emision,1,4)||SUBSTRING(fecha_emision,6,2)||SUBSTRING(fecha_emision,9,2);
   	--raise notice '%',v_fecha_emision;
    g_nro_factura=nro_factura || pxp.f_verhoeff(nro_factura) ||pxp.f_verhoeff(nro_factura || pxp.f_verhoeff(nro_factura));		
  	g_nit=nit || pxp.f_verhoeff(nit)||pxp.f_verhoeff(nit || pxp.f_verhoeff(nit));					
    g_fecha_emision=v_fecha_emision || pxp.f_verhoeff(v_fecha_emision) || pxp.f_verhoeff(v_fecha_emision || pxp.f_verhoeff(v_fecha_emision));			
    g_monto_facturado=v_monto_facturado || pxp.f_verhoeff(v_monto_facturado) ||	pxp.f_verhoeff(v_monto_facturado || pxp.f_verhoeff(v_monto_facturado));	
    g_suma_int=int8(g_nro_factura)+ int8(g_nit)+  int8(g_fecha_emision)+int8(g_monto_facturado);
    g_suma_cad=text(g_suma_int);
    for I in 1..5 Loop
    	g_suma_cad=g_suma_cad || pxp.f_verhoeff(g_suma_cad);
    end loop;
     dig_ver=substring(g_suma_cad,char_length(g_suma_cad)-4);
     inicio=1;
     nro_dig=int4(substring(dig_ver,1,1))+1;
	 g_autorizacion=autorizacion || SUBSTRING(llave_dosificacion,inicio,nro_dig); 
     inicio=inicio+nro_dig;
     nro_dig=int4(substring(dig_ver,2,1))+1;
	 g_nro_factura=g_nro_factura || SUBSTRING(llave_dosificacion,inicio,nro_dig);
     
     inicio=inicio+nro_dig;
     nro_dig=int4(substring(dig_ver,3,1))+1;
	 g_nit=g_nit || SUBSTRING(llave_dosificacion,inicio,nro_dig);
     
     inicio=inicio+nro_dig;
     nro_dig=int4(substring(dig_ver,4,1))+1;
	 g_fecha_emision=g_fecha_emision || SUBSTRING(llave_dosificacion,inicio,nro_dig); 
     
     inicio=inicio+nro_dig;
     nro_dig=int4(substring(dig_ver,5,1))+1;
	 g_monto_facturado=g_monto_facturado || SUBSTRING(llave_dosificacion,inicio,nro_dig);
     
     g_cadena_res= pxp.f_rc4(g_autorizacion || g_nro_factura || g_nit || g_fecha_emision || g_monto_facturado,llave_dosificacion || dig_ver);
    st=0;	sp1=0;	sp2=0;	sp3=0;	sp4=0;	sp5=0;
     for I in 1..char_length(g_cadena_res)loop
     		st=st+ascii(substring(g_cadena_res,I,1));
            if((i-1)%5=0)THEN
              sp1=sp1+ascii(substring(g_cadena_res,I,1));
            
            elsif((i-2)%5=0)THEN
              sp2=sp2+ascii(substring(g_cadena_res,I,1));
            elsif((i-3)%5=0)then
	            sp3=sp3+ascii(substring(g_cadena_res,I,1));
            elsif((i-4)%5=0)then
            	sp4=sp4+ascii(substring(g_cadena_res,I,1));
            elsif(i%5=0)THEN                              

            	sp5=sp5+ascii(substring(g_cadena_res,I,1));
            end if;            
     end loop;
     
     sumab64=0;
     nro_dig=int4(substring(dig_ver,1,1))+1;
     sumab64=sumab64+((st*sp1)/nro_dig );
     nro_dig=int4(substring(dig_ver,2,1))+1; 
     sumab64=sumab64+((st*sp2)/nro_dig );  
     nro_dig=int4(substring(dig_ver,3,1))+1;
     sumab64=sumab64+((st*sp3)/nro_dig );         
     nro_dig=int4(substring(dig_ver,4,1))+1;
     sumab64=sumab64+((st*sp4)/nro_dig );         
     nro_dig=int4(substring(dig_ver,5,1))+1;
     sumab64=sumab64+((st*sp5)/nro_dig ); 
     
     base64=pxp.f_base64(sumab64);
     
     control_rc4=pxp.f_rc4(base64,llave_dosificacion || dig_ver);
     cod_control=SUBSTRING(control_rc4,1,2) || '-' || SUBSTRING(control_rc4,3,2) || '-' || SUBSTRING(control_rc4,5,2) || '-' || SUBSTRING(control_rc4,7,2) ;
     if (char_length(control_rc4)>9)then
     	cod_control=cod_control || '-' || SUBSTRING(control_rc4,9,2);
     end if;
     return cod_control;
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
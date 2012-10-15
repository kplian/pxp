CREATE OR REPLACE FUNCTION segu.ft_primo_sel (
  par_administrador integer,
  par_id_usuario integer,
  par_tabla character varying,
  par_transaccion character varying
)
RETURNS varchar
AS 
$body$
/**************************************************************************
 FUNCION: 		segu.ft_primo_sel
 DESCRIPCIÓN: 	manejo de consultas en a tabla primo
 AUTOR: 		KPLIAN(jrr)		
 FECHA:		    28/02/2008
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR: 		Rensi Arteaga Copari
 FECHA:			16/11/2010			
***************************************************************************/

DECLARE


v_consulta    varchar;
v_parametros  record;
v_nombre_funcion   text;
v_mensaje_error    text;
v_resp varchar;

/*

'filtro'
'ordenacion'
'dir_ordenacion'
'puntero'
'cantidad'

*/

BEGIN

     v_parametros:=pxp.f_get_record(par_tabla);
     v_nombre_funcion:='segu.f_t_primo_sel';
     
 /*******************************    
 #TRANSACCION:  SEG_FUNCIO_INS
 #DESCRIPCION:	Obtienen un numero primo segun indice
                el indice se obtiene en el servidor web randomicamente
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2008	
***********************************/


     if(par_transaccion='SEG_OBTEPRI_SEL')then
     
          --consulta:=';
          BEGIN
          
               v_consulta:='SELECT numero 
                            from segu.tprimo u 
                            where id_primo='||v_parametros.id_primo;
                            
               return v_consulta;
               
               
         END;
    
/*******************************    
 #TRANSACCION:  SEG_FUNCIO_INS
 #DESCRIPCION:	listado de numeros primo
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2008	
***********************************/     
     elsif(par_transaccion='SEG_PRIMO_SEL')then
     
          --consulta:=';
          BEGIN
               --raise exception 'entra';
               v_consulta:='select * from segu.tprimo p where '|| v_parametros.filtro ||'
               order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' OFFSET ' || v_parametros.puntero;
               return v_consulta;

         END;
/*******************************    
 #TRANSACCION:  SEG_FUNCIO_INS
 #DESCRIPCION:	cuenta el listado de numeros primos
 #AUTOR:		KPLIAN(jrr)	
 #FECHA:		28-02-2008	
***********************************/
     elsif(par_transaccion='SEG_PRIMO_CONT')then

          --consulta:=';
          BEGIN
               v_consulta:='select count(*) 
                            from segu.primo p 
                            where '|| v_parametros.filtro;
               return v_consulta;


         END;
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
-- Definition for function ft_procedimiento_gui_ime (OID = 305079) : 
--
